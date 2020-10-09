import React from 'react';
import MenuItem from './menu-item';

class MenuList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { menu: [], isFavorited: false };
    this.getMenuItems = this.getMenuItems.bind(this);
    this.handleBackClick = this.handleBackClick.bind(this);
    this.handleHeartClick = this.handleHeartClick.bind(this);
  }

  getMenuItems() {
    fetch(`/api/restaurant/${this.props.restaurant.restaurantId}`)
      .then(res => res.json())
      .then(data => {
        this.setState({ menu: data });
      })
      .catch(err => console.error('Error:', err));
  }

  handleBackClick() {
    this.props.setView(this.props.prevView.name, this.props.prevView.params);
  }

  handleHeartClick() {
    if (!this.state.isFavorited) {
      this.props.addToFavorites({ restaurantId: this.props.restaurant.restaurantId });
      this.setState({ isFavorited: true });
    }
  }

  checkFavoriteRestaurants() {
    fetch(`/api/favorites/${this.props.restaurant.restaurantId}`)
      .then(res => res.json())
      .then(boolean => boolean ? this.setState({ isFavorited: true }) : null)
      .catch(err => console.error(err));
  }

  componentDidMount() {
    this.getMenuItems();
    this.checkFavoriteRestaurants();
  }

  render() {
    return (
      <>
        <div
          className="col-12 text-muted font-weight-light mb-2 back mt-5"
          onClick={this.handleBackClick}
        >
          <i className="fas fa-chevron-left"></i> Back
        </div>
        <div className="border-bottom mb-2">
          <img
            id={this.props.restaurant.restaurantId}
            src={this.props.restaurant.image}
            alt={this.props.restaurant.name}
            className="col-12 p-2"
          />
          <div className="d-flex justify-content-between align-items-center">
            <div className="h4 mb-0">{this.props.restaurant.name}</div>
            {this.state.isFavorited ? <i className="fas fa-heart text-danger" onClick={this.handleHeartClick}></i> : <i className="far fa-heart text-danger" onClick={this.handleHeartClick}></i>}
          </div>
          <div className="d-flex h6">
            <div className="bg-light py-1 px-2 mr-2">
              {this.props.restaurant.rating}
              <i className="fas fa-star"></i>
            </div>
            <div className="bg-light py-1 px-2">
              &#36;{Number(this.props.restaurant.deliveryFee).toFixed(2)}{' '}
              Delivery Fee
            </div>
          </div>
        </div>
        <div className="border-bottom mb-2 w-100">
          <p className="h5">Restaurant Info</p>
          <p>{this.props.restaurant.address}</p>
        </div>
        <div className="w-100">
          <p className="h5">Menu</p>
          {this.state.menu.map(menuItem => (
            <MenuItem
              key={menuItem.menuItemId}
              menuItem={menuItem}
              addToCart={this.props.addToCart}
            />
          ))}
        </div>
      </>
    );
  }
}

export default MenuList;
