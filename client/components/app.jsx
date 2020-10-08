import React from 'react';
import Header from './header';
import RestaurantList from './restaurant-list';
import Home from './home';
import Categories from './categories';
import MenuList from './menu-list';
import Navbar from './navbar';
import Account from './account';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      view: {
        name: 'account',
        params: {},
        currentCategory: null
      },
      cart: []
    };
    this.setView = this.setView.bind(this);
    this.getAllCategories = this.getAllCategories.bind(this);
    this.addToCart = this.addToCart.bind(this);
  }

  getAllCategories() {
    fetch('/api/category')
      .then(res => res.json())
      .then(data => {
        this.setState({ categories: data });
      });
  }

  componentDidMount() {
    this.getAllCategories();
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
    } else if (this.state.view.name === 'account') {
      viewing = <Account setView={this.setView} />;
    }

    return (
      <>
        <Header cart={this.state.cart} view={this.state.view} />
        <div className="row p-3">{viewing}</div>
        <Navbar setView={this.setView} />
      </>
    );
  }
}
