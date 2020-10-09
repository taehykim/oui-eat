import React from 'react';

class CategoryItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleCategoryClick = this.handleCategoryClick.bind(this);
  }

  handleCategoryClick() {
    this.props.setView('restaurants', this.props.categoryInfo);
  }

  render() {
    return (
      <>
        <div
          className="col-5 category-item m-2 rounded"
          style={{
            backgroundImage: `linear-gradient(rgba(255, 255, 255, 0.13), rgba(255, 255, 250, 0.13)), url(${this.props.image})`
          }}
          onClick={this.handleCategoryClick}
        >
          <p className="h6 text-center text-white align-middle pt-5">
            {this.props.name}
          </p>
        </div>
      </>
    );
  }
}
export default CategoryItem;
