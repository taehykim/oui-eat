import React from 'react';

function Navbar(props) {
  function handleHomeClick() {
    props.setView('home', {});
  }

  function handleSearchClick() {
    props.setView('categories', {});
  }

  function handleOrderClick() {
    props.setView('orders', {});
  }

  function handleAccountClick() {
    props.setView('account', {});
  }

  return (
    <div className="row navbar">
      <div className="col-3 d-flex justify-content-center" onClick={handleHomeClick}><i className="fas fa-home"></i></div>
      <div className="col-3 d-flex justify-content-center" onClick={handleSearchClick}><i className="fas fa-search"></i></div>
      <div className="col-3 d-flex justify-content-center" onClick={handleOrderClick}><i className="fas fa-receipt"></i></div>
      <div className="col-3 d-flex justify-content-center" onClick={handleAccountClick}><i className="fas fa-user-circle"></i></div>
    </div>
  );
}

export default Navbar;
