import React from 'react';
import RestaurantItem from './restaurant-item';

class SavedRestaurants extends React.Component {
  constructor(props) {
    super(props);
    this.getSavedRestaurants = this.getSavedRestaurants.bind(this);
    this.handleBackClick = this.handleBackClick.bind(this);
    this.state = { savedRestaurants: [] };
  }

  handleBackClick() {
    this.props.setView('account', {});
  }

  getSavedRestaurants() {
    fetch('/api/favorites/')
      .then(res => res.json())
      .then(savedRestaurants => this.setState({ savedRestaurants: savedRestaurants }))
      .catch(err => console.error(err));
  }

  componentDidMount() {
    this.getSavedRestaurants();
  }

  render() {
    if (this.state.savedRestaurants.length === 0) {
      return (
        <>
          <div
            className="col-12 text-muted font-weight-light mb-2 back mt-5 pl-0"
            onClick={this.handleBackClick}
          >
            <i className="fas fa-chevron-left"></i> Back
          </div>
          <div className="col-12 modal-container2 d-flex justify-content-center align-items-center">
            <p className="col-10 p-3 rounded modal1 d-flex justify-content-center position-fixed">
              You have no favorites yet!
            </p>
          </div>
        </>
      );
    }
    return (
      <div className="d-flex flex-column justify-content-center mt-5">
        <div
          className="col-12 text-muted font-weight-light back pl-0"
          onClick={this.handleBackClick}
        >
          <i className="fas fa-chevron-left"></i> Back
        </div>
        <p className="h4">Favortite Restaurants</p>
        {this.state.savedRestaurants.map(restaurant => (
          <RestaurantItem
            setView={this.props.setView}
            key={restaurant.restaurantId}
            restaurant={restaurant}
            addToFavorites={this.props.addToFavorites}
            removeFromFavorites={this.props.removeFromFavorites}
          />
        ))}
      </div>
    );
  }
}

export default SavedRestaurants;
