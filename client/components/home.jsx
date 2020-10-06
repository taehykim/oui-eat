import React from 'react';
import RestaurantItem from './restaurant-item';

class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = { topFive: [] };
    this.getTopFive = this.getTopFive.bind(this);
  }

  getTopFive() {
    fetch('/api/rating')
      .then(res => res.json())
      .then(data => {
        this.setState({ topFive: data });
      });
  }

  componentDidMount() {
    this.getTopFive();
  }

  render() {
    return (
      <div className="d-flex flex-column justify-content-center mt-5">
        <p className="h4">Restaurants Near Me</p>
        {this.state.topFive.map(restaurant => (
          <RestaurantItem
            setView={this.props.setView}
            key={restaurant.restaurantId}
            restaurant={restaurant}
            setView={this.props.setView}
          />
        ))}
      </div>
    );
  }
}

export default Home;
