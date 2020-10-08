import React from 'react';
import OrderItems from './order-items';

class Orders extends React.Component {
  constructor(props) {
    super(props);
    this.state = { status: 'delivered', all: [], delivered: {}, pending: {} };
    this.getAllOrders = this.getAllOrders.bind(this);
  }

  componentDidMount() {
    this.getAllOrders();
  }

  componentDidUpdate(prevProps) {
    if (prevProps.status !== this.props.status) {
      this.setState({ status: this.props.status });
    }
  }

  getAllOrders() {
    fetch('/api/orders')
      .then(res => res.json())
      .then(data => {
        const deliveredOrderIds = [];
        const pendingOrderIds = [];
        const orderIds = [];
        const delivered = [];
        const deliveredByOrderId = {};
        const pending = [];
        const pendingByOrderId = {};

        for (let i = 0; i < data.length; i++) {
          orderIds.push(data[i].orderId);
          if (
            Number(Date.now()) - Number(Date.parse(data[i].orderedAt)) <
            600000
          ) {
            pending.push(data[i]);
            pendingOrderIds.push(data[i].orderId);
          } else {
            delivered.push(data[i]);
            deliveredOrderIds.push(data[i].orderId);
          }
        }

        const uniqueDeliverOrderIds = [...new Set(deliveredOrderIds)];
        const uniquePendingOrderIds = [...new Set(pendingOrderIds)];

        for (let j = 0; j < uniqueDeliverOrderIds.length; j++) {
          deliveredByOrderId[uniqueDeliverOrderIds[j]] = [];
        }
        for (let k = 0; k < delivered.length; k++) {
          deliveredByOrderId[delivered[k].orderId].push(delivered[k]);
        }

        for (let a = 0; a < uniquePendingOrderIds.length; a++) {
          pendingByOrderId[uniquePendingOrderIds[a]] = [];
        }
        for (let b = 0; b < pending.length; b++) {
          pendingByOrderId[pending[b].orderId].push(pending[b]);
        }

        this.setState({
          all: data,
          delivered: deliveredByOrderId,
          pending: pendingByOrderId
        });
      });
  }

  render() {
    if (this.state.status === 'delivered') {
      return (
        <div className="mt-5">
          {Object.keys(this.state.delivered).map(orderId => (
            <OrderItems
              key={orderId}
              orderItems={this.state.delivered[orderId]}
            />
          ))}
        </div>
      );
    } else if (this.state.status === 'pending') {
      return (
        <div className="mt-5 w-100">
          {Object.keys(this.state.pending).length !== 0 ? (
            Object.keys(this.state.pending).map(orderId => (
              <OrderItems
                key={orderId}
                orderItems={this.state.pending[orderId]}
              />
            ))
          ) : (
            <div className="row justify-content-center align-items-center w-100">
              <div className="h5 font-weight-light">No Upcoming Orders</div>
            </div>
          )}
        </div>
      );
    }
  }
}

export default Orders;
