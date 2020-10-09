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
      creditCardNumber: '',
      minDeliveryFee: 0,
      items: {}
    };

    this.getSubTotal = this.getSubTotal.bind(this);
    this.getDeliveryFee = this.getDeliveryFee.bind(this);
    this.placeOrder = this.placeOrder.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.getEachItemCount = this.getEachItemCount.bind(this);
    this.getMinimumDeliveryFee = this.getMinimumDeliveryFee.bind(this);
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

    const init = {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(this.state)
    };

    fetch('/api/orders', init)
      .then(res => res.json())
      .then(data => {
        this.props.resetCart();
        this.props.setView('checkout', {});
      })
      .catch(err => console.error(err));
  }

  getSubTotal() {
    let subTotal = 0;
    for (let i = 0; i < this.props.cartItems.length; i++) {
      subTotal += Number(this.props.cartItems[i].price);
    }
    return Number(subTotal).toFixed(2);
  }

  getDeliveryFee() {
    let subTotal = 0;
    for (let i = 0; i < this.props.cartItems.length; i++) {
      subTotal += Number(this.props.cartItems[i].price);
    }
    if (subTotal * 0.05 < 5) {
      return Number(5).toFixed(2);
    }

    return Number(subTotal * 0.05).toFixed(2);
  }

  handleChange(event) {
    const name = event.target.name;
    const value = event.target.value;
    this.setState({
      [name]: value
    });
  }

  getMinimumDeliveryFee(cartItems) {
    if (cartItems) {
      let minDeliveryFee = Number(cartItems[0].deliveryFee);
      for (let i = 1; i < cartItems.length; i++) {
        if (Number(cartItems[i].deliveryFee) < minDeliveryFee) {
          minDeliveryFee = Number(cartItems[i].deliveryFee);
        }
      }
      return Number(minDeliveryFee).toFixed(2);
    } else return 0;
  }

  componentDidMount() {
    this.getEachItemCount();
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    if (Number(this.state.minDeliveryFee) === 0) {
      this.setState({
        minDeliveryFee: this.getMinimumDeliveryFee(this.props.cartItems)
      });
    }
  }

  render() {
    if (this.props.cartItems.length === 0) {
      return (
        <div className="col-12 modal-container1 d-flex justify-content-center align-items-center">
          <p className="col-10 p-3 rounded modal1 d-flex justify-content-center position-fixed">
            Your cart is empty!
          </p>
        </div>
      );
    }
    return (
      <>
        <form onSubmit={this.placeOrder} className="w-100">
          <div className="h5 mt-5">Billing Information</div>
          <label htmlFor="name">Name</label>
          <div className="input-group mb-3 w-100">
            <input
              type="text"
              className="form-control"
              id="name"
              name="name"
              autoComplete="off"
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
              autoComplete="off"
              value={this.state.billingAddress}
              onChange={this.handleChange}
            />
          </div>
          <label htmlFor="creditCardNumber">Credit Card</label>
          <div className="input-group mb-3">
            <input
              type="text"
              className="form-control"
              id="creditCardNumber"
              name="creditCardNumber"
              autoComplete="off"
              value={this.state.creditCardNumber}
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
              autoComplete="off"
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
              autoComplete="off"
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
            Delivery Fee $
            {(
              Number(this.getDeliveryFee()) + Number(this.state.minDeliveryFee)
            ).toFixed(2)}
          </div>
          <div className="h5">
            Total $
            {Number(
              Number(this.getSubTotal()) +
                Number(this.getDeliveryFee()) +
                Number(this.state.minDeliveryFee)
            ).toFixed(2)}
          </div>

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
