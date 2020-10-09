import React from 'react';
import CartSummaryItem from './cart-summary-item';

class CartSummary extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      cvv: '',
      billingAddress: '',
      address: '',
      creditCard: '',
      items: {}
    };

    this.getSubTotal = this.getSubTotal.bind(this);
    this.getDeliveryFee = this.getDeliveryFee.bind(this);
    this.getTotal = this.getTotal.bind(this);
    this.placeOrder = this.placeOrder.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.getEachItemCount = this.getEachItemCount.bind(this);
  }

  getEachItemCount() {
    const itemCount = {};
    const menuIds = [];
    for (let j = 0; j < this.props.cartItems.length; j++) {
      menuIds.push(this.props.cartItems[j].menuItemId);
    }

    const uniqueMenuIds = [...new Set(menuIds)];

    for (let k = 0; k < uniqueMenuIds.length; k++) {
      itemCount[uniqueMenuIds[k]] = { count: 0, name: null };
    }

    for (let m = 0; m < this.props.cartItems.length; m++) {
      itemCount[this.props.cartItems[m].menuItemId].count++;
      itemCount[this.props.cartItems[m].menuItemId].name = this.props.cartItems[
        m
      ].name;
    }

    this.setState({ items: itemCount });
  }

  placeOrder(event) {
    event.preventDefault();
    this.props.setView('checkout', {});
    this.props.placeOrder(this.state);
  }

  getSubTotal() {
    let subTotal = 0;
    for (let i = 0; i < this.props.cartItems.length; i++) {
      subTotal += parseInt(this.props.cartItems[i].price);
    }
    return subTotal;
  }

  getDeliveryFee() {
    let subTotal = 0;
    for (let i = 0; i < this.props.cartItems.length; i++) {
      subTotal += parseInt(this.props.cartItems[i].price);
    }
    if (subTotal * 0.05 < 5) {
      return 5;
    }
    return subTotal * 0.05;
  }

  getTotal() {
    let subTotal = 0;
    for (let i = 0; i < this.props.cartItems.length; i++) {
      subTotal += parseInt(this.props.cartItems[i].price);
    }
    if (subTotal * 0.05 < 5) {
      return 5 + subTotal;
    }
    return subTotal * 0.05 + subTotal;
  }

  handleChange(event) {
    const name = event.target.name;
    const value = event.target.value;
    this.setState({
      [name]: value
    });
  }

  componentDidMount() {
    this.getEachItemCount();
  }

  render() {
    return (
      <>
        <div className="h5 mt-5">Billing Information</div>
        <form onSubmit={this.placeOrder} className="w-100">
          <label htmlFor="name">Name</label>
          <div className="input-group mb-3 w-100">
            <input
              type="text"
              className="form-control"
              id="name"
              name="name"
              value={this.state.name}
              onChange={this.handleChange}
            />
          </div>
          <label htmlFor="billingAddress">Billing Address</label>
          <div className="input-group mb-3">
            <input
              type="text"
              className="form-control"
              id="billingAddress"
              name="billingAddress"
              value={this.state.billingAddress}
              onChange={this.handleChange}
            />
          </div>
          <label htmlFor="creditCard">Credit Card</label>
          <div className="input-group mb-3">
            <input
              type="text"
              className="form-control"
              id="creditCard"
              name="creditCard"
              value={this.state.creditCard}
              onChange={this.handleChange}
            />
          </div>
          <label htmlFor="cvv">CVV</label>
          <div className="input-group mb-3 w-25">
            <input
              type="text"
              className="form-control"
              id="cvv"
              name="cvv"
              value={this.state.cvv}
              onChange={this.handleChange}
            />
          </div>
          <hr />

          <div className="h5">Delivery Information</div>
          <label htmlFor="address">Delivery Address</label>
          <div className="input-group mb-3">
            <input
              type="text"
              className="form-control"
              id="address"
              name="address"
              value={this.state.address}
              onChange={this.handleChange}
            />
          </div>

          <h5 className="mt-4">Your Order</h5>

          <div className="pb-2 border-bottom">
            {Object.keys(this.state.items).map(menuId => (
              <CartSummaryItem key={menuId} item={this.state.items[menuId]} />
            ))}
          </div>

          <div className="mt-2 h6 font-weight-light">
            Subtotal ${this.getSubTotal()}
          </div>
          <div className="h6 font-weight-light">
            Delivery Fee ${this.getDeliveryFee()}
          </div>
          <div className="h5">Total ${this.getTotal()}</div>

          <div className="d-flex justify-content-center w-100">
            <button type="submit" className="btn btn-secondary h5 w-100">
              Place an Order
            </button>
          </div>
        </form>
      </>
    );
  }
}

export default CartSummary;
