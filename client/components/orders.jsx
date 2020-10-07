import React from 'react';
// import OrderItems from './order-items';

class Orders extends React.Component {
  constructor(props) {
    super(props);
    this.state = { status: 'delivered', delivered: [], pending: [] };
    this.getPastOrders = this.getPastOrders.bind(this);
    this.getCurrentOrders = this.getCurrentOrders.bind(this);
  }

  componentDidMount() {
    this.getPastOrders();
    this.getCurrentOrders();
  }

  componentDidUpdate(prevProps) {
    if (prevProps.status !== this.props.status) {
      this.setState({ status: this.props.status });
    }
  }

  getPastOrders() {
    // this function will make a get request to get the past orders and save the data to our state's delivered prop.
  }

  getCurrentOrders() {
    // this function will make a get request to get the current orders and save the data to our state's pending prop.
  }

  render() {
    if (this.state.status === 'delivered') {
      return (
        <div className="mt-5">
          <div>delivered</div>
          {/* {this.state.delivered.map(deliveredOrder => (
            <OrderItems />
          ))} */}
        </div>
      );
    } else if (this.state.status === 'pending') {
      return (
        <div className="mt-5">
          <div>pending</div>
          {/* {this.state.pending.map(pendingOrder => (
            <OrderItems />
          ))} */}
        </div>
      );
    }
  }
}

export default Orders;
