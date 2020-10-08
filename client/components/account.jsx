import React from 'react';

function Account(props) {
  return (
    <div className="row mt-5">
      <div className="col d-flex align-items-center border-bottom my-2">
        <div className="d-flex col-1 justify-content-center"><i className="fas fa-bookmark"></i></div>
        <h4 className="col-11">Saved Addresses</h4>
      </div>
      <div className="col d-flex align-items-center border-bottom my-2">
        <div className="d-flex col-1 justify-content-center"><i className="fas fa-heart"></i></div>
        <h4 className="col-11">Favorite Restaurants</h4>
      </div>
      <div className="col d-flex align-items-center my-2">
        <div className="d-flex col-1 justify-content-center"><i className="fas fa-tag"></i></div>
        <h4 className="col-11">Promotions</h4>
      </div>
    </div>
  );
}

export default Account;
