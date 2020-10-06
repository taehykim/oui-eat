import React from 'react';

function RestaurantItem(props) {
  return (
    <>
      <img src={props.restaurant.image} alt={props.restaurant.name} className="col-11" />
      <h4 className="col p-0">{props.restaurant.name}</h4>
      <div className="col-11 d-flex justify-content-between"><span>{props.restaurant.rating}<i className="fas fa-star"></i></span><span>{props.restaurant.deliveryFee} Delivery Fee</span></div>
    </>
  );
}

export default RestaurantItem;
