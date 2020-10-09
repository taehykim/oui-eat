import React from 'react';

class CartSummaryItem extends React.Component {
  render() {
    return (
      <div className="d-flex align-items-center">
        <span className="badge badge-light mr-1 h5">
          {this.props.item.count}
        </span>
        <p className="h5 font-weight-light">{this.props.item.name}</p>
      </div>
    );
  }
}

export default CartSummaryItem;
