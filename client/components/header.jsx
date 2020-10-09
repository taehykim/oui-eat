import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
    this.onDeliveredClick = this.onDeliveredClick.bind(this);
    this.onPendingClick = this.onPendingClick.bind(this);
    this.handleCartClick = this.handleCartClick.bind(this);
    this.handleLogoClick = this.handleLogoClick.bind(this);
    this.onBackClick = this.onBackClick.bind(this);
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

  onBackClick() {
    this.props.setView(this.props.prevView.name, this.props.prevView.params);
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
    } else if (this.props.view.name === 'cartSummary') {
      return (
        <header className="row justify-content-between align-items-center p-2">
          <div className="h5 mb-0" onClick={this.onBackClick}>
            <i className="fas fa-times"></i> Your Cart
          </div>
          <div className="cart-icon mr-1">
            {this.props.cart.length} items
            <i
              className="fas fa-shopping-cart"
              onClick={this.handleCartClick}
            ></i>
          </div>
        </header>
      );
    } else {
      return (
        <header className="row justify-content-between align-items-center p-2">
          <h2 className="mb-0" onClick={this.handleLogoClick}>
            Oui<span className="logo">Eat</span>
          </h2>
          <div className="cart-icon mr-1">
            {this.props.cart.length} items
            <i
              className="fas fa-shopping-cart"
              onClick={this.handleCartClick}
            ></i>
          </div>
        </header>
      );
    }
  }
}

export default Header;
