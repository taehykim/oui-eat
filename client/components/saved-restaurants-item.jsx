import React from 'react';

class SavedRestaurantItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleRestaurantClick = this.handleRestaurantClick.bind(this);
  }

  handleRestaurantClick() {
    this.props.setView('menu', this.props.savedRestaurant);
  }

  render() {
    return (
      <div className="card m-3">
        <img
          onClick={this.handleRestaurantClick}
          id={this.props.savedRestaurant.restaurantId}
          src={this.props.savedRestaurant.image}
          alt={this.props.savedRestaurant.name}
          className="col-12 p-2"
        />

        <div className="card-body">
          <div className="d-flex justify-content-between">
            <h4 className="card-title">{this.props.savedRestaurant.name}</h4>
          </div>
          <div className="card-text d-flex">
            <div className="h6 bg-light py-1 px-2 mr-2">
              {this.props.savedRestaurant.rating} <i className="fas fa-star"></i>
            </div>
            <div className="h6 bg-light py-1 px-2">
              &#36;{Number(this.props.savedRestaurant.deliveryFee).toFixed(2)}{' '}
              Delivery Fee
            </div>
          </div>
        </div>

        <button onClick={this.props.removeFromFavorites(this.props.savedRestaurant.restaurantId)}>Remove</button>
      </div>
    );
  }
}

export default SavedRestaurantItem;
