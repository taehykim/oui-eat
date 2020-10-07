import React from 'react';
import Header from './header';
import RestaurantList from './restaurant-list';
import Categories from './categories';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      view: {
        name: 'categories',
        params: {},
        currentCategory: null
      },
      cart: []
    };
    this.setView = this.setView.bind(this);

  }

  setView(inputName, inputParams) {
    this.setState({ view: { name: inputName, params: inputParams } });
  }

  render() {
    let viewing = null;
    if (this.state.view.name === 'restaurants') {
      viewing =
        <RestaurantList
          setView={this.setView}
          category={this.state.view.params}
        />;
    } else if (this.state.view.name === 'categories') {
      viewing =
      <Categories
        setView={this.setView}
      />;
    }

    return (
      <>
        <Header cart={this.state.cart} view={this.state.view} />
        { viewing }
      </>
    );
  }
}
