import React from 'react';
import Header from './header';
import RestaurantList from './restaurant-list';
import Home from './home';
import Categories from './categories';
import MenuList from './menu-list';
import Navbar from './navbar';
import CartSummary from './cart-summary';
import Account from './account';
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
      cart: []
    };
    this.setView = this.setView.bind(this);
    this.getAllCategories = this.getAllCategories.bind(this);
    this.addToCart = this.addToCart.bind(this);
    this.getCartItems = this.getCartItems.bind(this);
    this.placeOrder = this.placeOrder.bind(this);
    this.getLogin = this.getLogin.bind(this);
  }

  getAllCategories() {
    fetch('/api/category')
      .then(res => res.json())
      .then(data => {
        this.setState({ categories: data });
      });
  }

  componentDidMount() {
    this.getLogin().then(user => {
      this.getAllCategories();
      this.getCartItems();
    });
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

  getLogin() {
    return fetch('/api/login')
      .then(res => res.json());
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

  render() {
    let viewing = null;
    if (this.state.view.name === 'restaurants') {
      viewing = (
        <RestaurantList
          setView={this.setView}
          category={this.state.view.params}
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
      viewing = <Home setView={this.setView} />;
    } else if (this.state.view.name === 'menu') {
      viewing = (
        <MenuList
          restaurant={this.state.view.params}
          addToCart={this.addToCart}
        />
      );
    } else if (this.state.view.name === 'cartSummary') {
      viewing = <CartSummary setView={this.setView} cartItems={this.state.cart} placeOrder={this.placeOrder} />;
    } else if (this.state.view.name === 'account') {
      viewing = <Account setView={this.setView} />;
    } else if (this.state.view.name === 'checkout') {
      viewing = <Checkout setView={this.setView} />;
    }

    return (
      <>
        <Header setView={this.setView} cart={this.state.cart} view={this.state.view} />
        <div className="row p-3">{viewing}</div>
        <Navbar setView={this.setView} />
      </>
    );
  }
}
