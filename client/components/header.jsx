import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
    this.onDeliveredClick = this.onDeliveredClick.bind(this);
    this.onPendingClick = this.onPendingClick.bind(this);
    this.handleCartClick = this.handleCartClick.bind(this);
    this.handleLogoClick = this.handleLogoClick.bind(this);
  }

  onDeliveredClick() {
    this.props.setView('orders', { status: 'delivered' });
  }

  onPendingClick() {
    this.props.setView('orders', { status: 'pending' });
  }

  handleCartClick() {
    this.props.setView('cartSummary', {});
  }

  handleLogoClick() {
    this.props.setView('home', {});
  }

  render() {
    if (this.props.view.name === 'orders') {
      return (
        <header className="row justify-content-around align-items-center">
          <div className="h5 m-0" onClick={this.onDeliveredClick}>
            Delivered
          </div>
          <div className="h5 m-0" onClick={this.onPendingClick}>
            Pending
          </div>
        </header>
      );
    } else {
      return (
        <header className="row justify-content-between align-items-center p-2">
          {this.props.view.name === 'cart' ? (
            <i className="ml-2 fas fa-times"></i>
          ) : (
            <h2 className="mb-0" onClick={this.handleLogoClick}>
              Oui<span className="logo">Eat</span>
            </h2>
          )}
          <div className="cart-icon mr-1">
            {this.props.cart.length} items{' '}
            <i className="fas fa-shopping-cart" onClick={this.handleCartClick}></i>
          </div>
        </header>
      );
    }
  }
}

export default Header;
