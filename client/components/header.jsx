import React from 'react';

function Header(props) {
  return (
    <header className="row justify-content-between align-items-center p-2">
      {props.view.name === 'cart' ? <i className="ml-2 fas fa-times"></i> : <h2 className="mb-0">Oui<span className="logo">Eat</span></h2>}
      <div className="cart-icon mr-1">{props.cart.length} items <i className="fas fa-shopping-cart"></i></div>
    </header>
  );
}

export default Header;
