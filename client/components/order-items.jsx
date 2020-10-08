import React from 'react';

class OrderItems extends React.Component {
  constructor(props) {
    super(props);
    this.state = { items: {} };
    this.getTotal = this.getTotal.bind(this);
    this.getEachItemCount = this.getEachItemCount.bind(this);
  }

  getTotal() {
    let total = 0;
    for (let i = 0; i < this.props.orderItems.length; i++) {
      total += Number(this.props.orderItems[i].menuItemPrice);
    }

    return total.toFixed(2);
  }

  getEachItemCount() {
    const itemCount = {};
    const menuIds = [];
    for (let j = 0; j < this.props.orderItems.length; j++) {
      menuIds.push(this.props.orderItems[j].menuItemId);
    }

    const uniqueMenuIds = [...new Set(menuIds)];

    for (let k = 0; k < uniqueMenuIds.length; k++) {
      itemCount[uniqueMenuIds[k]] = { count: 0, name: null };
    }

    for (let m = 0; m < this.props.orderItems.length; m++) {
      itemCount[this.props.orderItems[m].menuItemId].count++;
      itemCount[
        this.props.orderItems[m].menuItemId
      ].name = this.props.orderItems[m].menuItemName;
    }

    this.setState({ items: itemCount });
  }

  componentDidMount() {
    this.getEachItemCount();
  }

  render() {
    return (
      <div className="card mb-1">
        <div className="card-body">
          <img
            src={this.props.orderItems[0].restaurantImage}
            alt={this.props.orderItems[0].restaurantName}
            className="col-12 p-2"
          />
          <h5 className="card-title">
            {this.props.orderItems[0].restaurantName}
          </h5>
          <div className="card-text">
            <div className="mb-2">Order Completed</div>
            <div className="font-weight-light mb-2">
              {new Date(this.props.orderItems[0].orderedAt).toLocaleString(
                'en-US'
              )}
            </div>
            <div>
              {Object.keys(this.state.items).map(menuItemId => (
                <p
                  className="d-flex justify-content-start align-items-center"
                  key={menuItemId}
                >
                  <span className="badge badge-light mr-1">
                    {this.state.items[menuItemId].count}
                  </span>
                  {this.state.items[menuItemId].name}
                </p>
              ))}
            </div>
            <div className="border-top pt-2 font-weight-bold">
              Total: ${this.getTotal()}
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default OrderItems;
