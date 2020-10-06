import React from 'react';
import Header from './header';
import RestaurantList from './restaurant-list';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      view: { name: 'home', params: {} },
      cart: [],
      currentCategory: { categoryId: 2, name: 'Fast Food', image: 'https://www.verdictfoodservice.com/wp-content/uploads/sites/31/2018/07/McDonaldsLunch_Dinner.jpg' }
      // change currentCategory back to empty obj
    };
  }

  render() {
    return (
      <>
        <Header cart={this.state.cart} view={this.state.view} />
        <RestaurantList category={this.state.currentCategory} />
      </>
    );
  }
}
