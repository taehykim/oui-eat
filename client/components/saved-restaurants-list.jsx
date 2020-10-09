import React from 'react';
import SavedRestaurantItem from './saved-restaurants-item';

class SavedRestaurants extends React.Component {
  constructor(props) {
    super(props);
    this.getSavedRestaurants = this.getSavedRestaurants.bind(this);
    this.removeFromFavorites = this.removeFromFavorites.bind(this);
    this.state = { savedRestaurants: [] };
  }

  getSavedRestaurants() {
    fetch('/api/favorites/')
      .then(res => res.json())
      .then(savedRestaurants => this.setState({ savedRestaurants: savedRestaurants }))
      .catch(err => console.error(err));
  }

  componentDidMount() {
    this.getSavedRestaurants();
  }

  removeFromFavorites(id) {
    fetch(`/api/favorites/${id}`, {
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' }
    })
      .catch(err => console.error(err));
  }

  render() {
    return (
      <div>
        {this.state.savedRestaurants.map(savedRestaurant => (
          <SavedRestaurantItem
            setView={this.props.setView}
            key={savedRestaurant.restaurantId}
            savedRestaurant={savedRestaurant}
            removeFromFavorites={this.removeFromFavorites}
          />
        ))}
      </div>
    );
  }
}

export default SavedRestaurants;
