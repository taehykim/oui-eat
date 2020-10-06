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
  db.query('select \'successfully connected\' as "message"')
    .then(result => res.json(result.rows[0]))
    .catch(err => next(err));
});

app.get('/api/category/:categoryId', (req, res, next) => {
  const id = parseInt(req.params.categoryId, 10);
  if (!id || id < 1) {
    return next(new ClientError('The categoryId must be a positive integer', 400));
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
