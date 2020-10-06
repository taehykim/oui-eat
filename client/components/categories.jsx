import React from 'react';
import CategoryItem from './category-item';

class Categories extends React.Component {
  constructor(props){
    super(props);
    this.getAllCategories = this.getAllCategories.bind(this);
    this.state ={categories: []}
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
console.log(this.props)
    return (
      <>
          {this.state.categories.map(category => <CategoryItem key={category.categoryId} name={category.name}/>)}
      </>
    );
  }
}

export default Categories;

// view: { name: 'restaurants', params: { categoryId: 2, name: 'Fast Food' } }
