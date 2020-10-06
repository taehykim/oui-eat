import React from 'react';
import RestaurantItem from './restaurant-item';

class RestaurantList extends React.Component {
  constructor(props) {
    super(props);
    this.getRestaurants = this.getRestaurants.bind(this);
    this.state = { restaurants: [] };
  }

  getRestaurants() {
    fetch(`/api/category/${this.props.category.categoryId}`)
      .then(res => res.json())
      .then(restaurants => this.setState({ restaurants: restaurants }))
      .catch(err => console.error(err));
  }

  componentDidMount() {
    this.getRestaurants();
  }

  render() {
    return (
      <div className="row flex-wrap">
        <p>{this.state.restaurants.length} Results for &#34;{this.props.category.name}&#34;</p>
        { this.state.restaurants.map(restaurant => <RestaurantItem key={restaurant.restaurantId} restaurant={restaurant} />) }
      </div>
    );
  }
}

export default RestaurantList;
