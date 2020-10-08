import React from 'react';

class RestaurantItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleRestaurantClick = this.handleRestaurantClick.bind(this);
    this.handleHeartClick = this.handleHeartClick.bind(this);
    this.state = { isFavorited: false };
  }

  handleRestaurantClick() {
    this.props.setView('menu', this.props.restaurant);
  }

  handleHeartClick() {
    if (!this.state.isFavorited) {
      this.props.addToFavorites(this.props.restaurant.restaurantId);
      this.setState({ isFavorited: true });
    }
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
          <div className="d-flex justify-content-between">
            <h4 className="card-title">{this.props.restaurant.name}</h4>
            {this.state.isFavorited ? <i className="fas fa-heart text-danger" onClick={this.handleHeartClick}></i> : <i className="far fa-heart text-danger" onClick={this.handleHeartClick}></i>}
          </div>
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
