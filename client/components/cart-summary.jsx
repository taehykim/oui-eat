import React from 'react';
import CartSummaryItem from './cart-summary-item';

class CartSummary extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      address: '',
      billingAddress: '',
      creditCard: '',
      CVV: ''
    };

    this.getSubTotal = this.getSubTotal.bind(this);
    this.getDeliveryFee = this.getDeliveryFee.bind(this);
    this.getTotal = this.getTotal.bind(this);
    this.placeOrder = this.placeOrder.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  placeOrder() {
    this.props.setView('checkout', {});
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
    } return subTotal * 0.05;
  }

  getTotal() {
    let subTotal = 0;
    for (let i = 0; i < this.props.cartItems.length; i++) {
      subTotal += parseInt(this.props.cartItems[i].price);
    }
    if (subTotal * 0.05 < 5) {
      return 5 + subTotal;
    } return subTotal * 0.05 + subTotal;
  }

  handleChange(event) {
    this.setState({
      name: event.target.name,
      address: event.target.address,
      billingAddress: event.target.billingAddress,
      creditCard: event.target.creditCard,
      CVV: event.target.CVV
    });
  }

  render() {
    return (
      <form onSubmit={this.placeOrder} className="mt-5">
        <label>Name</label><br></br>
        <input className="cart-input" type="text" value={this.state.name} onChange={this.handleChange}></input><br></br>
        <label className="mt-2">Address</label><br></br>
        <input className="cart-input" type="text" value={this.state.address} onChange={this.handleChange}></input><br></br>
        <label className="mt-2">Billing Address</label><br></br>
        <input className="cart-input" type="text" value={this.state.billingAddress} onChange={this.handleChange}></input><br></br>
        <label className="mt-2">Credit Card</label><br></br>
        <input className="cart-input" type="text" value={this.state.creditCard} onChange={this.handleChange}></input><br></br>
        <label className="mt-2">CVV</label><br></br>
        <input className="cart-input" type="text" value={this.state.CVV} onChange={this.handleChange}></input><br></br>

        <h5 className="mt-4">Your Order</h5>

        <div>
          {this.props.cartItems.map(item => (
            <CartSummaryItem item={item} key={item.cartItemId} />
          ))}
        </div>

        <p className="ml-3 mt-3">subTotal ${this.getSubTotal()}</p>
        <p className="ml-3 mt-3">Delivery Fee ${this.getDeliveryFee()}</p>
        <h5 className="ml-5 mt-3">Total ${this.getTotal()}</h5>

        <button type="button" className="btn btn-secondary mt-5">
          Place an Order
        </button>
      </form>
    );
  }
}

export default CartSummary;
