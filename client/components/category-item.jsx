import React from 'react';
import Categories from './categories';

function CategoryItem(props) {

  // function handleCategoryClick() {
  //   props.setView('restaurants', {categoryId: props.category.categoryId, name: props.category.name});

  // }
  console.log(props)
  return (
    <>
    <div className="card-container">
        <div className="card" >{props.name} </div>
    </div>

    </>
  );
}
export default CategoryItem;
