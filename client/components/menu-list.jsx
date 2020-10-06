import React from 'react';
import MenuItem from './menu-item';

class MenuList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { menu: [] };
    this.getMenuItems = this.getMenuItems.bind(this);
  }

  getMenuItems() {
    fetch(`/api/restaurant/${this.props.restaurant.restaurantId}`)
      .then(res => res.json())
      .then(data => {
        this.setState({ menu: data });
      })
      .catch(err => console.error('Error:', err));
  }

  componentDidMount() {
    this.getMenuItems();
  }

  render() {
    return (
      <>
        <div className="border-bottom mb-2 mt-5">
          <img
            id={this.props.restaurant.restaurantId}
            src={this.props.restaurant.image}
            alt={this.props.restaurant.name}
            className="col-12 p-2"
          />
          <div className="h4">{this.props.restaurant.name}</div>
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
            <MenuItem key={menuItem.menuItemId} menuItem={menuItem} />
          ))}
        </div>
      </>
    );
  }
}

export default MenuList;
