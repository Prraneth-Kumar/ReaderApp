Reader App

An iOS news reader app that fetches and displays news articles using the NewsAPI. The app supports offline caching, pull-to-refresh, search functionality with debounce, and bookmarking. It is designed to be flexible, allowing fetching news from different countries or categories (e.g., automobiles).

Features
    •    Fetches news articles from any country or category using NewsAPI.
    •    Displays article title, author, and thumbnail image.
    •    Supports offline viewing using Realm to cache fetched articles.
    •    Users can search articles by country, category, or keywords.
    •    Search is debounced using DispatchWorkItem to delay API calls until 1 second after the user stops typing.
    •    Users can bookmark articles for later reading.
    •    Pull-to-refresh to update the news list.
    •    Light and Dark mode support.

Architecture
    •    Built using MVVM architecture for clean separation of concerns.
    •    View: Displays articles and bookmarks in table views.
    •    ViewModel: Handles data fetching, caching, bookmarks, and debounced search.
    •    Service Layer: Handles API requests.
    •    Realm: Stores articles and bookmarks for offline access.

Libraries Used
    •    UIKit: For building the user interface.
    •    RealmSwift: For offline caching and bookmark persistence.
    •    SDWebImage: For asynchronous image loading.

Notes
    •    The app uses custom UITableViewCells via XIB for precise layout control.
    •    The debounced search ensures that the API is only called after 1 second of inactivity, improving performance.
    •    Offline support ensures that the last fetched articles are always available using Realm.
    •    Bookmarks persist across offline and online sessions.
    •    Flexible API setup allows changing the query to fetch news about different countries or topics, such as automobiles.
    •    Demonstrates clean architecture principles, thread-safe Realm usage, and adaptive UI for different screen sizes.
