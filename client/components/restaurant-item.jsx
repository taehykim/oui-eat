import React from 'react';

class RestaurantItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleRestaurantClick = this.handleRestaurantClick.bind(this);
  }

  handleRestaurantClick() {
    this.props.setView('menu', this.props.restaurant);
  }

  render() {
    return (
      <div className="card m-3">
        <img
          onClick={this.handleRestaurantClick}
          id={this.props.restaurant.restaurantId}
          src={this.props.restaurant.image}
          alt={this.props.restaurant.name}
          className="col-12 p-2"
        />

        <div className="card-body">
          <h4 className="card-title">{this.props.restaurant.name}</h4>
          <div className="card-text d-flex">
            <div className="h6 bg-light py-1 px-2 mr-2">
              {this.props.restaurant.rating} <i className="fas fa-star"></i>
            </div>
            <div className="h6 bg-light py-1 px-2">
              &#36;{Number(this.props.restaurant.deliveryFee).toFixed(2)}{' '}
              Delivery Fee
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default RestaurantItem;
