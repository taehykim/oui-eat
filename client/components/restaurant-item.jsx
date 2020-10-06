import React from 'react';

function RestaurantItem(props) {
  function handleRestaurantClick() {
    props.setView('menu', props.restaurant);
  }
  return (
    <>
      <img onClick={handleRestaurantClick} id={props.restaurant.restaurantId} src={props.restaurant.image} alt={props.restaurant.name} className="col-12 mb-1" />
      <h4 className="col-11">{props.restaurant.name}</h4>
      <div className="col-11 mb-5 d-flex justify-content-between"><span>{props.restaurant.rating} <i className="fas fa-star"></i></span><span>&#36;{Number(props.restaurant.deliveryFee).toFixed(2)} Delivery Fee</span></div>
    </>
  );
}

export default RestaurantItem;
