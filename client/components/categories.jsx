import React from 'react';
import CategoryItem from './category-item';

class Categories extends React.Component {
  constructor(props) {
    super(props);
    this.state = { categories: [] };
    this.getAllCategories = this.getAllCategories.bind(this);
  }

  getAllCategories() {
    fetch('/api/category')
      .then(res => res.json())
      .then(data => {
        this.setState({ categories: data });
      });
  }

  componentDidMount() {
    this.getAllCategories();
  }

  render() {
    const categoriesArray = this.state.categories;
    return (
      <div className="row justify-content-center mt-5">
        {categoriesArray.map(category => (
          <CategoryItem
            key={category.categoryId}
            name={category.name}
            image={category.imageUrl}
            categoryInfo={category}
            setView={this.props.setView}
          />
        ))}
      </div>
    );
  }
}
export default Categories;
