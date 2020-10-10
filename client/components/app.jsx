import React from 'react';
import Header from './header';
import RestaurantList from './restaurant-list';
import Home from './home';
import Categories from './categories';
import MenuList from './menu-list';
import Orders from './orders';
import Navbar from './navbar';
import LandingPage from './landing-page';
import CartSummary from './cart-summary';
import Account from './account';
import SavedRestaurants from './saved-restaurants-list';
import Checkout from './checkout';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      view: {
        name: 'home',
        params: {},
        currentCategory: null
      },
      cart: [],
      isLoading: true
    };
    this.setView = this.setView.bind(this);
    this.resetCart = this.resetCart.bind(this);
    this.getAllCategories = this.getAllCategories.bind(this);
    this.addToCart = this.addToCart.bind(this);
    this.getCartItems = this.getCartItems.bind(this);
    this.placeOrder = this.placeOrder.bind(this);
    this.addToFavorites = this.addToFavorites.bind(this);
    this.removeFromFavorites = this.removeFromFavorites.bind(this);
  }

  resetCart() {
    this.setState({ cart: [] });
  }

  getAllCategories() {
    fetch('/api/category')
      .then(res => res.json())
      .then(data => {
        this.setState({ categories: data });
      })
      .catch(err => console.error(err));
  }

  addToFavorites(id) {
    fetch('/api/favorites', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(id)
    }).catch(err => console.error(err));
  }

  removeFromFavorites(id) {
    fetch(`/api/favorites/${id}`, {
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' }
    }).catch(err => console.error(err));
  }

  getLogin() {
    fetch('/api/login').catch(err => console.error(err));
  }

  componentDidMount() {
    this.getLogin();
    this.getAllCategories();
    setTimeout(() => {
      this.setState({ isLoading: false });
    }, 3500);
    this.getCartItems();
  }

  setView(inputName, inputParams) {
    this.setState({ view: { name: inputName, params: inputParams } });
  }

  addToCart(menuItem) {
    const init = {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(menuItem)
    };

    fetch('/api/cart', init)
      .then(res => res.json())
      .then(data => {
        const newCart = [...this.state.cart];
        newCart.push(data);
        this.setState({ cart: newCart });
      })
      .catch(err => console.error(err));
  }

  placeOrder(order) {
    const init = {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(order)
    };

    fetch('/api/orders', init).then(res => {
      this.setState({ cart: [], view: { name: 'checkout', params: {} } });
      return res.json();
    });
  }

  getCartItems() {
    fetch('/api/cart')
      .then(res => res.json())
      .then(data => {
        this.setState({
          cart: data
        });
      })
      .catch(err => console.error(err));
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    if (prevState.cart.length !== this.state.cart.length) {
      this.getCartItems();
    }

    if (prevState.view.name !== this.state.view.name) {
      if (this.state.view.name === 'menu' && !this.state.prevMenuView) {
        this.setState({
          prevView: prevState.view,
          prevMenuView: prevState.view
        });
      } else if (
        this.state.view.name === 'menu' &&
        this.state.prevView.name === 'cartSummary'
      ) {
        this.setState({
          prevView: prevState.view,
          prevMenuView: prevState.view
        });
      } else if (
        this.state.view.name === 'categories' ||
        this.state.view.name === 'account'
      ) {
        this.setState({ prevMenuView: null });
      } else {
        this.setState({ prevView: prevState.view });
      }
    }
  }

  render() {
    let viewing = null;
    if (this.state.isLoading) {
      return (
        <>
          <LandingPage />
        </>
      );
    } else if (this.state.view.name === 'restaurants') {
      viewing = (
        <RestaurantList
          setView={this.setView}
          category={this.state.view.params}
          addToFavorites={this.addToFavorites}
          removeFromFavorites={this.removeFromFavorites}
        />
      );
    } else if (this.state.view.name === 'categories') {
      viewing = (
        <Categories
          allCategories={this.state.categories}
          setView={this.setView}
        />
      );
    } else if (this.state.view.name === 'home') {
      viewing = (
        <Home
          setView={this.setView}
          addToFavorites={this.addToFavorites}
          removeFromFavorites={this.removeFromFavorites}
        />
      );
    } else if (this.state.view.name === 'menu') {
      viewing = (
        <MenuList
          restaurant={this.state.view.params}
          addToCart={this.addToCart}
          setView={this.setView}
          currView={this.state.view}
          prevMenuView={this.state.prevMenuView}
          prevView={this.state.prevView}
          addToFavorites={this.addToFavorites}
          removeFromFavorites={this.removeFromFavorites}
        />
      );
    } else if (this.state.view.name === 'orders') {
      viewing = (
        <Orders
          status={
            Object.keys(this.state.view.params).length !== 0
              ? this.state.view.params.status
              : null
          }
        />
      );
    } else if (this.state.view.name === 'cartSummary') {
      viewing = (
        <CartSummary
          setView={this.setView}
          cartItems={this.state.cart}
          placeOrder={this.placeOrder}
          resetCart={this.resetCart}
        />
      );
    } else if (this.state.view.name === 'account') {
      viewing = <Account setView={this.setView} />;
    } else if (this.state.view.name === 'favoriteRestaurants') {
      viewing = <SavedRestaurants setView={this.setView} />;
    } else if (this.state.view.name === 'checkout') {
      viewing = <Checkout setView={this.setView} />;
    }

    return (
      <>
        <Header
          cart={this.state.cart}
          view={this.state.view}
          setView={this.setView}
          prevView={this.state.prevView}
        />
        <div className="row p-3 justify-content-center">{viewing}</div>
        <Navbar setView={this.setView} />
      </>
    );
  }
}
