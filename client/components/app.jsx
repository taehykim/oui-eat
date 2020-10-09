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
    this.getAllCategories = this.getAllCategories.bind(this);
    this.addToCart = this.addToCart.bind(this);
    this.getCartItems = this.getCartItems.bind(this);
    this.addToFavorites = this.addToFavorites.bind(this);
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
    })
      .catch(err => console.error(err));
  }

  getLogin() {
    fetch('/api/login')
      .catch(err => console.error(err));
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
    if (prevState.view.name !== this.state.view.name) {
      this.setState({ prevView: prevState.view });
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
        />
      );
    } else if (this.state.view.name === 'menu') {
      viewing = (
        <MenuList
          restaurant={this.state.view.params}
          addToCart={this.addToCart}
          setView={this.setView}
          prevView={this.state.prevView}
          addToFavorites={this.addToFavorites}
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
        <CartSummary setView={this.setView} cartItems={this.state.cart} />
      );
    } else if (this.state.view.name === 'account') {
      viewing = <Account setView={this.setView} />;
    }

    return (
      <>
        <Header
          cart={this.state.cart}
          view={this.state.view}
          setView={this.setView}
        />
        <div className="row p-3">{viewing}</div>
        <Navbar setView={this.setView} />
      </>
    );
  }
}
