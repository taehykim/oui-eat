require('dotenv/config');
const express = require('express');

const db = require('./database');
const ClientError = require('./client-error');
const staticMiddleware = require('./static-middleware');
const sessionMiddleware = require('./session-middleware');

const app = express();

app.use(staticMiddleware);
app.use(sessionMiddleware);

app.use(express.json());

app.get('/api/health-check', (req, res, next) => {
  db.query("select 'successfully connected' as \"message\"")
    .then(result => res.json(result.rows[0]))
    .catch(err => next(err));
});

app.get('/api/restaurant/:restaurantId', (req, res, next) => {
  const id = parseInt(req.params.restaurantId, 10);
  if (!id || id < 1) {
    return next(
      new ClientError('The restaurantId must be a positive integer', 400)
    );
  }
  const selectRestaurant = `
    select *
      from "menuItems"
     where "restaurantId" = $1;
  `;
  db.query(selectRestaurant, [id])
    .then(result => {
      if (result.rows.length === 0) {
        return next(new ClientError('The restaurantId cannot be found', 404));
      }
      return res.json(result.rows);
    })
    .catch(err => next(err));
});

app.get('/api/category', (req, res, next) => {
  const query = 'select * from "categories"';

  db.query(query)
    .then(result => res.status(200).json(result.rows))
    .catch(err => next(err));
});

app.get('/api/category/:categoryId', (req, res, next) => {
  const id = parseInt(req.params.categoryId, 10);
  if (!id || id < 1) {
    return next(
      new ClientError('The categoryId must be a positive integer', 400)
    );
  }
  const selectRestaurants = `
    select *
      from "restaurants"
     where "categoryId" = $1;
  `;
  db.query(selectRestaurants, [id])
    .then(result => {
      if (result.rows.length === 0) {
        return next(new ClientError('The categoryId cannot be found', 404));
      }
      return res.json(result.rows);
    })
    .catch(err => next(err));
});

app.get('/api/rating', (req, res, next) => {
  const selectRestByRating = `
    select *
      from "restaurants"
  order by "rating" desc
     limit 5;
  `;
  db.query(selectRestByRating)
    .then(result => res.json(result.rows))
    .catch(err => next(err));
});

app.get('/api/cart', (req, res, next) => {
  if (!req.session.cartId) {
    res.json([]);
  } else {
    const getCart = `
      select "c"."cartItemId",
             "c"."price",
             "m"."menuItemId",
             "m"."name",
             "m"."description"
        from "cartItems" as "c"
        join "menuItems" as "m" using ("menuItemId")
       where "c"."cartId" = $1;
    `;
    db.query(getCart, [req.session.cartId])
      .then(result => res.json(result.rows))
      .catch(err => next(err));
  }
});

app.post('/api/cart', express.json(), (req, res, next) => {
  const menuItemId = parseInt(req.body.menuItemId, 10);
  if (!menuItemId || menuItemId < 0) {
    return next(
      new ClientError('The menuItemId must be a positive integer', 400)
    );
  }
  const selectMenuPrice = `
    select "price"
      from "menuItems"
     where "menuItemId" = $1;
  `;
  db.query(selectMenuPrice, [menuItemId])
    .then(result => {
      if (!result.rows[0]) {
        throw new ClientError('The menuItemId does not exist', 404);
      }
      const price = result.rows[0];
      if (req.session.cartId) {
        const selectCartId = `
        select "cartId"
          from "cart"
          where "cartId" = $1;
      `;
        return db
          .query(selectCartId, [req.session.cartId])
          .then(result => Object.assign(price, result.rows[0]));
      } else {
        const insertCart = `
        insert into "cart" ("cartId")
              values (default)
          returning "cartId";
      `;
        return db
          .query(insertCart)
          .then(result => Object.assign(price, result.rows[0]));
      }
    })
    .then(cart => {
      req.session.cartId = cart.cartId;
      const insertItem = `
        insert into "cartItems" ("cartId", "menuItemId", "price")
                        values ($1, $2, $3)
                     returning "cartItemId";
      `;
      return db
        .query(insertItem, [cart.cartId, menuItemId, cart.price])
        .then(result => result.rows[0].cartItemId);
    })
    .then(cartItemId => {
      const select = `
        select "c"."cartItemId",
               "c"."price",
               "m"."menuItemId",
               "m"."name",
               "m"."description"
          from "cartItems" as "c"
          join "menuItems" as "m" using ("menuItemId")
         where "c"."cartItemId" = $1;
      `;
      return db
        .query(select, [cartItemId])
        .then(result => res.status(201).json(result.rows[0]));
    })
    .catch(err => next(err));
});

app.delete('/api/cart/:cartItemId', (req, res, next) => {
  const cartItemId = parseInt(req.params.cartItemId, 10);
  if (!req.session.cartId) {
    next(new ClientError('There must be a cartId in session', 400));
  } else if (!cartItemId || cartItemId < 1) {
    next(new ClientError('The cartItemId must be a positive integer', 400));
  } else {
    const deleteCartItem = `
      delete from "cartItems"
            where "cartItemId" = $1
              and "cartId" = $2
        returning *;
    `;
    db.query(deleteCartItem, [cartItemId, req.session.cartId])
      .then(result => {
        return result.rows[0]
          ? res.sendStatus(204)
          : next(
            new ClientError(
              'The cartItemId does not exist in the cartItems table',
              400
            )
          );
      })
      .catch(err => console.error(err));
  }
});

app.get('/api/login', (req, res) => {
  req.session.userId = 1;
  res.json({ userId: req.session.userId });
});

app.get('/api/orders', (req, res, next) => {
  const selectAllOrders = `select
      "r"."restaurantId",
      "r"."name" as "restaurantName",
      "r"."image" as "restaurantImage",
      "mi"."menuItemId",
      "mi"."name" as "menuItemName",
      "mi"."price" as "menuItemPrice",
      "mi"."description",
      "ci"."cartId",
      "o"."orderId",
      "o"."userId",
      "o"."orderedAt"
    from "orders" as "o"
    join "cartItems" as "ci" using ("cartId")
    join "menuItems" as "mi" using ("menuItemId")
    join "restaurants" as "r" using ("restaurantId")
    `;
  db.query(selectAllOrders)
    .then(result => res.json(result.rows))
    .catch(err => next(err));
});

app.post('/api/orders', express.json(), (req, res, next) => {
  if (!req.session.cartId) {
    throw new ClientError('There must be a cartId in session', 400);
  } else if (!req.session.userId) {
    throw new ClientError('There must be a userId in session', 400);
  } else if (!req.body.creditCardNumber) {
    throw new ClientError('There must be a creditCardNumber included', 400);
  } else if (!req.body.address) {
    throw new ClientError('There must be an address included', 400);
  } else if (!req.body.billingAddress) {
    throw new ClientError('There must be a billingAddress included', 400);
  } else if (!req.body.name) {
    throw new ClientError('There must be a name included', 400);
  } else if (!Number(req.body.cvv)) {
    throw new ClientError('There must be a cvv included', 400);
  }
  const insertAddress = `
    insert into "address" ("address", "userId")
          values ($1, $2);
  `;
  db.query(insertAddress, [req.body.address, req.session.userId]).catch(err =>
    next(err)
  );
  const insertCredit = `
    insert into "creditCard" ("name", "creditCardNumber", "cvv", "billingAddress")
         values ($1, $2, $3, $4)
      returning "creditCardId";
  `;
  const params = [
    req.body.name,
    req.body.creditCardNumber,
    req.body.cvv,
    req.body.billingAddress
  ];
  db.query(insertCredit, params)
    .then(result => result.rows[0].creditCardId)
    .then(creditCardId => {
      const insertOrder = `
        insert into "orders" ("creditCardId", "cartId", "userId")
         values ($1, $2, $3)
      returning "creditCardId",
                "userId",
                "orderId",
                "orderedAt";
      `;
      db.query(insertOrder, [
        creditCardId,
        req.session.cartId,
        req.session.userId
      ]).then(result => {
        result.rows[0].name = req.body.name;
        result.rows[0].creditCardNumber = req.body.creditCardNumber;
        result.rows[0].cvv = req.body.cvv;
        result.rows[0].billingAddress = req.body.billingAddress;
        result.rows[0].address = req.body.address;
        delete req.session.cartId;
        return res.status(201).json(result.rows[0]);
      });
    })
    .catch(err => next(err));
});

app.post('/api/favorites', (req, res, next) => {
  const restaurantId = req.body.restaurantId;
  const userId = req.session.userId;
  if (!restaurantId) {
    res.status(400).json({ error: 'Input Incorrect Values' });
    return;
  }
  const sql = `insert into "favoriteRestaurants" ("restaurantId", "userId")
    values ($1, $2)
    returning *`;
  const values = [restaurantId, userId];
  db.query(sql, values)
    .then(data => {
      res.status(201).json(data.rows[0]);
    })
    .catch(err => next(err));
});

app.get('/api/favorites/:restaurantId', (req, res, next) => {
  const restaurantId = parseInt(req.params.restaurantId, 10);
  if (!restaurantId || restaurantId < 1) {
    next(new ClientError('The restaurantId must be a positive integer', 400));
  } else {
    const selectFav = `
      select "restaurantId"
        from "favoriteRestaurants"
       where "restaurantId" = $1;
    `;
    db.query(selectFav, [restaurantId])
      .then(result => {
        return result.rows[0] ? res.send(true) : res.send(false);
      })
      .catch(err => next(err));
  }
});

app.delete('/api/favorites/:restaurantId', (req, res, next) => {
  const restaurantId = parseInt(req.params.restaurantId, 10);
  if (!restaurantId || restaurantId < 1) {
    next(new ClientError('The restaurantId must be a positive integer', 400));
  } else {
    const deleteFav = `
      delete from "favoriteRestaurants"
            where "restaurantId" = $1
        returning *;
    `;
    db.query(deleteFav, [restaurantId])
      .then(result => {
        return result.rows[0]
          ? res.sendStatus(204)
          : next(
            new ClientError(
              'The restaurantId does not exist in the favoriteRestaurants table',
              400
            )
          );
      })
      .catch(err => next(err));
  }
});

app.use('/api', (req, res, next) => {
  next(new ClientError(`cannot ${req.method} ${req.originalUrl}`, 404));
});

app.use((err, req, res, next) => {
  if (err instanceof ClientError) {
    res.status(err.status).json({ error: err.message });
  } else {
    console.error(err);
    res.status(500).json({
      error: 'an unexpected error occurred'
    });
  }
});

app.listen(process.env.PORT, () => {
  // eslint-disable-next-line no-console
  console.log('Listening on port', process.env.PORT);
});
