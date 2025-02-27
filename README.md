# KGK Diamond

KGK Diamond is a Flutter application for managing diamond products and a shopping cart. This document provides an overview of the project structure, state management logic, and persistent storage usage.

## Project Structure

The project is organized into the following main directories:

- `lib/`
  - `app/`
    - `application.dart`: The main application file that sets up the `MultiBlocProvider` for state management and initializes the app with necessary configurations.
  - `core/`
    - `data/`
      - `products_data.dart`: Contains the static product data used throughout the application.
    - `db/`
      - `hive_helper.dart`: Helper class for managing persistent storage using Hive, providing methods to interact with the local database.
    - `routes/`
      - `app_routes.dart`: Defines the application routes and handles navigation within the app.
  - `features/`
    - `products/`
      - `cubit/`
        - `products_cubit.dart`: Manages the state of the products, including fetching, filtering, and sorting the product list.
      - `models/`
        - `product_model.dart`: Defines the product model, representing the structure of a product entity.
        - `filter_model.dart`: Defines the filter model, used to filter the products based on various criteria such as lab, clarity, color, shape, and carat range.
      - `screens/`
        - `filters_screen.dart`: Displays the filter selection view, allowing users to apply filters to the product list.
        - `products_screen.dart`: Shows the product listing based on the applied filters and sorting criteria, displaying products with details such as final price and carat.
      - `widgets/`
        - `product_tile.dart`: Defines the widget used to display individual product details in a tile format.
        - `products_list_view.dart`: Defines the widget for displaying a list of products, utilizing the `product_tile.dart` widget for each product.

## State Management Logic

The application uses the `flutter_bloc` package for state management. The main state management logic is handled by two cubits:

- `ProductsCubit`: Manages the state of the products, including filtering and sorting.
  - `getProducts()`: Filters the products based on the selected filter criteria and updates the state with the filtered product list.
  - `setSortCriteria(String? criteria)`: Sets the sorting criteria for the products and updates the state.
  - `sortProducts({required bool ascending})`: Sorts the products based on the selected criteria and order (ascending or descending) and updates the state.

- `CartCubit`: Manages the state of the shopping cart.
  - `addToCart(ProductModel product)`: Adds a product to the cart and updates the state.
  - `removeFromCart(ProductModel product)`: Removes a product from the cart and updates the state.
  - `getCartItems()`: Retrieves the items in the cart from persistent storage and updates the state.
  - `clearCart()`: Clears all items from the cart and updates the state.
  - `isProductInCart(ProductModel product)`: Checks if a product is in the cart and returns a boolean value.
  - `getCartCount()`: Returns the number of items in the cart.
  - `getTotalCarat()`: Calculates the total carat of all items in the cart.
  - `getTotalPrice()`: Calculates the total price of all items in the cart.
  - `getAveragePrice()`: Calculates the average price of all items in the cart.
  - `getAverageDiscount()`: Calculates the average discount of all items in the cart.

## Persistent Storage Usage

The application uses Hive for persistent storage. Hive is a lightweight and fast key-value database that is well-suited for Flutter applications.

- `hive_helper.dart`: Contains the `HiveDBHelper` class, which provides methods for managing the cart data in Hive.
  - `addToCart(Map<String, dynamic> product)`: Adds a product to the cart in Hive.
  - `removeFromCart(String productId)`: Removes a product from the cart in Hive.
  - `getCartItems()`: Retrieves the items in the cart from Hive.
  - `clearCart()`: Clears all items from the cart in Hive.

## Getting Started

To get started with the project, follow these steps:

1. **Clone the repository**:
   ```sh
   git clone https://github.com/jenisnavadiya/diamond-shopping.git
   cd diamond-shopping