import React from 'react';

function CategoryItem(props) {
  return (
    <>
      <div className=" category-item mt-5" style={{ backgroundImage: `linear-gradient(rgba(255, 255, 255, 0.1), rgba(255, 255, 250, 0.1)), url(${props.image})` }}>
        <p className="h6 text-center text-white align-middle pt-5">{props.name}</p>
      </div>
    </>
  );
}
export default CategoryItem;
