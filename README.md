# Recipes-app
SwiftUI app to fetch and display product list and their images from demo recipes backend database hosted locally.

## How it works
- App fetches recipes list from locally hosted database.
- Recipes list is displayed on initial page.
- From initial page, user can add new items.
- From initial page, user can delete recipes, by swiping the cell.
- User can tap on recipe and it will navigate to recipe's details page.
- On recipe details page all the active properties recipe are displayed.
- On recipe's details page, user can edit recipe's active fields.
- Images are cached temporarily after downloading.

## Development
- App architecture is MVVM
- App UI is implemented using SwiftUI.
- Networking and ViewModels are implemented using Combine framework.
- Data is fetched using from locally hosted database, thus using local ip address. IP address can be easily edited in URLRepository file.
