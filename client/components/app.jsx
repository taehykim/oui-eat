import React from 'react';
import Header from './header';
import Categories from './categories';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      view: { name: 'home', params: {}, currentCategory: null },
      cart: [],
      categories: []
    };

    this.getAllCategories = this.getAllCategories.bind(this);
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

  render() {
    return (
      <div className="container-fluid p-0">
        <Header cart={this.state.cart} view={this.state.view} />
        <Categories allCategories={this.state.categories} />
      </div>
    );
  }
}
