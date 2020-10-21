# oui-eat
A full stack food-ordering web application

## Technologies Used

- Javascript (ES5, ES6)
- React.js
- Node.js
- Express
- PostgreSQL
- npm
- Webpack
- Babel
- AWS EC2
- CSS3
- HTML5
- Bootstrap 4

## Live Demo

+ Best in mobile view
+ Try the application live at [https://ouieat.taehykim.com/](https://ouieat.taehykim.com/)

## Features

- Users can view the top 5 restaurants near them.
- Users can view restaurants by category.
- Users can click on categories card and view a list of restaurants of the selected category.
- Users can view a restaurant and their menu.
- Users can add an item to their cart.
- Users can remove an item to their cart.
- Users can place an order.
- Users can view delivered orders.
- Users can view upcoming orders.
- Users can save and unsave their favorite restaurants.
- Users can view their saved favorite restaurants.
- Users can view and interact with navbar.

## Preview

![OUI EAT APP DEMO](assets/oui-eat-demo.gif)

## Development

### Getting Started

1. Clone the repository.

    ```shell
    git clone https://github.com/taehykim/oui-eat.git
    cd oui-eat
    ```

2. Install all dependencies
    ```shell
    npm install
    ```
    
3. Make a .env file and customize its settings
    ```shell
    PORT=3001
    DEV_SERVER_PORT=3000
    DATABASE_URL=postgres://{user}:{password}@localhost/{database-name}
    SESSION_SECRET=secret
    ```
 
4. Start PostgreSQL and import existing database
    ```shell
    sudo service postgresql start
    createdb {database-name}
    npm run db:import
    ```
    
5. Compile project
    ```shell
    npm run dev
    ```
    
6. Access application at [http://localhost:3000](http://localhost:3000) in your browser.
    


