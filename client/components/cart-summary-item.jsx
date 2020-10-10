import React from 'react';

class CartSummaryItem extends React.Component {
  constructor(props) {
    super(props);
    this.onRemoveClick = this.onRemoveClick.bind(this);
    this.getCartId = this.getCartId.bind(this);
  }

  onRemoveClick(event) {
    const cartItemId = this.getCartId();

    fetch(`/api/cart/${cartItemId}`, {
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' }
    })
      .then()
      .then(data => {
        this.props.updateCart();
      })
      .catch(err => console.error(err));
  }

  getCartId() {
    const keys = Object.keys(this.props.cartItems);

    for (let i = 0; i < keys.length; i++) {
      if (this.props.cartItems[i].name === this.props.item.name) {
        return this.props.cartItems[i].cartItemId;
      }
    }
    return null;
  }

  render() {
    return (
      <div className="d-flex align-items-center justify-content-between mb-1">
        <div className="d-flex align-items-center">
          <span className="badge badge-light mr-1 h5">
            {this.props.item.count}
          </span>
          <p className="h5 font-weight-light">{this.props.item.name}</p>
        </div>
        <div>
          <button
            type="button"
            className="btn btn-danger px-2 py-1"
            onClick={this.onRemoveClick}
          >
            Remove
          </button>
        </div>
      </div>
    );
  }
}

export default CartSummaryItem;
