import React from 'react';
import RestaurantItem from './restaurant-item';

class RestaurantList extends React.Component {
  constructor(props) {
    super(props);
    this.getRestaurants = this.getRestaurants.bind(this);
    this.handleBackClick = this.handleBackClick.bind(this);
    this.state = { restaurants: [] };
  }

  getRestaurants() {
    fetch(`/api/category/${this.props.category.categoryId}`)
      .then(res => res.json())
      .then(restaurants => this.setState({ restaurants: restaurants }))
      .catch(err => console.error(err));
  }

  handleBackClick() {
    this.props.setView('categories', {});
  }

  componentDidMount() {
    this.getRestaurants();
  }

  render() {
    return (
      <div className="row mt-2">
        <div className="col-12 text-muted font-weight-light mb-2 back" onClick={this.handleBackClick}>&lt; Categories</div>
        <p className="col-12">{this.state.restaurants.length} Results for &#34;{this.props.category.name}&#34;</p>
        { this.state.restaurants.map(restaurant => <RestaurantItem setView={this.props.setView} key={restaurant.restaurantId} restaurant={restaurant} />) }
      </div>
    );
  }
}

export default RestaurantList;
