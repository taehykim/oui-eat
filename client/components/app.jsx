import React from 'react';
import Header from './header';
import RestaurantList from './restaurant-list';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.setView = this.setView.bind(this);
    this.state = {
      view: { name: 'restaurants', params: { categoryId: 2, name: 'Fast Food' } },
      cart: []
    };
  }

  setView(name, params) {
    this.setState({ view: { name: name, params: params } });
  }

  render() {
    let viewing = null;
    if (this.state.view.name === 'restaurants') {
      viewing = <RestaurantList setView={this.setView} category={this.state.view.params} />;
    }
    return (
      <>
        <Header cart={this.state.cart} view={this.state.view} />
        { viewing }
      </>
    );
  }
}
