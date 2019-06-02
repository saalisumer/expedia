# expedia assignment
Problem Statement : https://github.com/homeaway/iOS-Coding-Challenge
Architecture: 
* Use of URLSession for Networking
* In memory caching of search result(model)
* Favorites persisted in memory and on disk(using user defaults)
* Design Patterns used: MVC, Delegation, Observer, Protocol Oriented Programming
* Unit Tests: Model, One View Controller, Basic API Mocking(There is scope of increasing test coverage)

Future Improvements:
* Use of Core Data to persist the Model
* Better Unit Test Coverage of Networking, UI and other parts of the application
* UI Unit Test Coverage for basic navigation and sanity checks
* Use of Bond or RxSwift for observable pattern to observe Favorite changes, search keyword typing etc.
* Use of Router layer for routing between different screens (inspired from RIBs architecture)
* Use of Presenter layer for UI presentation (inspired from RIBs architecture)
