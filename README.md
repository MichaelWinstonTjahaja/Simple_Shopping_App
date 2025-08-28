# Food Ordering App

This repository contains the source code for a simple food ordering application built with Flutter. The app allows users to browse a menu, add items to a cart, and proceed to a dummy checkout process.

-----

### Features

  * **Menu Browsing**: View a list of available food items with their prices.
  * **Quantity Management**: Adjust the quantity of each item directly from the menu list.
  * **Shopping Cart**: The app maintains a dynamic shopping cart that updates as items are added or removed.
  * **Total Calculation**: Automatically calculates the total price of all items in the cart.
  * **Item Removal**: Remove items from the cart individually.
  * **Dummy Checkout**: A checkout button with a confirmation dialog and a placeholder for a checkout process.
  * **Loading Indicator**: A custom navigator function shows a loading indicator when transitioning between the menu and cart pages.

-----

### File Structure

  * `main.dart`: The entry point of the application. It manages the app's state, including the list of menu items and the shopping cart. It also defines the application's routes and custom navigation logic.
  * `menu_list_page.dart`: Defines the `MenuListPage` widget, which displays the menu and allows users to modify item quantities. It also contains the "View Cart" button.
  * `cart_page.dart`: Defines the `CartPage` widget, which displays the contents of the shopping cart, calculates the total price, and handles item removal and the checkout process.

-----

### How It Works

The app's state is managed in `main.dart`. The `_MyAppState` class holds the `menuItems` list and the `cart` map.

  * `menuItems`: A `List<Map<String, dynamic>>` that stores the details of each food item, including its `id`, `name`, `price`, and `quantity`.
  * `cart`: A `Map<int, Map<String, dynamic>>` that holds the items currently in the cart. The key is the item's `id`, and the value is a map containing the item's `name`, `price`, and `quantity`.

The `_updateQuantity` function modifies the quantity of an item in the `menuItems` list and updates the `cart` accordingly. If the quantity is set to zero, the item is removed from the cart. The `_removeItemFromCart` function removes an item from the cart and resets its quantity in the `menuItems` list to zero.

-----

### How to Run the App

To run this application, you must have the Flutter SDK installed on your machine.

1.  **Clone the repository or set up the project files**: Place the provided files (`main.dart`, `menu_list_page.dart`, and `cart_page.dart`) into the `lib` folder of a new Flutter project.
2.  **Connect a device**: Ensure you have an Android emulator, iOS simulator, or a physical device connected and ready to run the app. You can check for connected devices by running `flutter devices` in your terminal.
3.  **Run the application**: Open your terminal, navigate to the root directory of your project, and execute the following command:
    ```
    flutter run
    ```
    This command will build and launch the app on your connected device. Alternatively, you can run the app directly from your IDE (e.g., VS Code or Android Studio) using the "Run" or "Debug" option.
