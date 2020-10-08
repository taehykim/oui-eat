import React from 'react';
import { render } from 'react-dom';

class Header extends React.Component {
  constructor(props) {
    super(props);
    this.handleCartClick = this.handleCartClick.bind(this);
    this.handleLogoClick = this.handleLogoClick.bind(this);
  }

  handleCartClick() {
    this.props.setView('cartSummary', {});
  }

  handleLogoClick() {
    this.props.setView('home', {});
  }

  render() {
    return (
      <header className="row justify-content-between align-items-center p-2">
        {this.props.view.name === 'cart' ? <i className="ml-2 fas fa-times"></i> : <h2 className="mb-0" onClick={this.handleLogoClick}>Oui<span className="logo">Eat</span></h2>}
        <div className="cart-icon mr-1" onClick={this.handleCartClick}>{this.props.cart.length} items <i className="fas fa-shopping-cart"></i></div>
      </header>
    );
  }
}

export default Header;
