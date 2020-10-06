import React from 'react';
import Header from './header';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      view: { name: 'home', params: {}, currentCategory: null },
      cart: []
    };
  }

  render() {
    return (
      <Header cart={this.state.cart} view={this.state.view} />
    );
  }
}
