import React from 'react';

function CartSummaryItem(props) {
  return (
    <div>
      <p className="card-text">{props.item.name}</p>
    </div>

  );
}

export default CartSummaryItem;
