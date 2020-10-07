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
      <div>
        <div
          className=" category-item mt-5"
          style={{
            backgroundImage: `linear-gradient(rgba(255, 255, 255, 0.1), rgba(255, 255, 250, 0.1)), url(${this.props.image})`
          }}
          onClick={this.handleCategoryClick}
        >
          <p className="h6 text-center text-white align-middle pt-5">
            {this.props.name}
          </p>
        </div>
      </div>
    );
  }
}
export default CategoryItem;
