# Technical challenge: MovieDatatbaseCompanion
iOS application using an universal framework taking care of the communication with [The Movie Database](https://www.themoviedb.org/). Result of a 40 hour technical coding challenge for the company 2coders.


### API Documentation
The documentation of API can be found [here](https://developer.themoviedb.org/reference/intro/getting-started).


### API Key
To access the API the individual API Key for Bearer authentication needs to be registered with the core client before first use. 
For privacy reasons the API-Key is not checked-in but placed in a file called 'apikey.secret' that needs to be created on a individual basis for each checked out project. The 'apikey.secret' should not be commited and is excluded via .gitignore file.
The project itself and also library's Unit Tests define a global constant 'let apiKey: String' that reads the value from file.


### 3rd Party Libraries
Pinterest's [PINCache](https://github.com/pinterest/PINCache) is used to achieve caching for downloaded images.
By default it's running in memory but can also be connfigured for using a on-disk cache.


### Show-case

* [x] load and display of movies and series
* [x] details for movies and series
* [x] load and display of trending movies
* [x] search for movies and series (search input throttled)
* [x] TMDB-API interaction is handled by a multiplatform core framework
* [x] framework with 90+ code coverage (Swift Test)
* [x] adaptive grid layout for content
* [x] progressive image loading (low-res first, hi-res second)
* [x] necessary image size gets determined depending on the device size class
* [x] Image caching (in memory) to prevent unneccesary requests of resources
* [x] simple local favorite list (Swift Data)
* [x] offline mode allowing to browse favorites
* [x] dark / light mode adaptive design
* [x] rotation independent multi-device layout (iPad/ iPhone)
* [x] shared Xcode schemes with different build configurations
* [x] code linting with swiftlint


### Given challenge PDF exerpt

The test will require building different screens based on “The Movie Db” service.
Reference: https://developers.themoviedb.org

1) Main Screen - Trending Movies:
a) Must show a list of movies within a collection view within a custom
layout.
b) Must be paginated through infinite scrolling.
c) The entity must show a title, an image*
, and a short description.
2) Details Screen: Once you pick a movie, the application must open a new
screen with the details of the selected movie.
a) The screen must show extended content apart from the standard
information, such as ratings, votes, authors - feel free to add as much
information as you want. (Scrollable)
3) Search screen: Search content. The app must be able to search for different
movies and series, selecting which one in advance. The search feature must
be throttleable.

* all images should be fetched based on the view size

####Bonus features:
- Ability to have a favorite list (locally), but also indication on the entity itself
- Offline mode (storage of choice)
- Pre-cached via concurrent/queue download of content for immediate access
- Low-res images before accessing the final version
- Image caching mechanism
- Build a .xcframework core within the model to be consumed for tvOS, iOS,
iPadOS & macOS

####Technical details:
➢ Usage of more advanced architectures like MVVM , TCA or some similar.
➢ Free to use SwiftUI but must show some knowledge of UIKit or vice-versa.
➢ Use SPM/Cocoapods for any dependency that might be required apart from
networking, that should be native
➢ Design, style, and animations as you prefer
➢ Test code coverage.
➢ Integrate SwiftLint within XCode (introduce some rules)
➢ The interface must work on iPad and iOS in landscape and portrait mode. Feel
free to adapt the design to look better based on the screen size.
➢ Environment (i.e. Prod/Dev)t selection via scheme within its configuration
➢ The assignment must be delivered via Git repository, containing commit
history
➢ English might drive the development of the exercise, files, comments, classes,
etc.

####Goals:
❖ Prove mastery of advanced programming swift skills and concepts on
different Apple platforms.
➢ Good knowledge of advanced architectures.
➢ Protocol-oriented programming.
➢ Object-oriented programming.
➢ Classes, objects and management of access control levels.
➢ Generics
➢ Working with Rest API & JSON data
➢ Native networking management in Swift
➢ Different request management: Queue and concurrency.
❖ Xcode environments, schemes & applications capabilities:
➢ Shared schemes
➢ Environment variables from the Xcode env when running a target in
debug.

❖ Knowledge and experience with writing code to support cross-platform
(iOS/iPadOS/tvOS/visionOS), as well as handling older OS version (deprecating
APIs)
❖ Experience with advanced Interface-builder concepts, including:
➢ Strategies for proper sourcing & instantiation of interface builder .xib &
.storyboard.
➢ Variable auto layout traits for universal applications (iOS & iPadOS) that
support all device classes & device orientations
❖ Clean code practices:
➢ Avoidance of overly complex code and common pitfalls such as
cyclomatic dependencies, repeated code, large function signatures,
very long lines of code, etc.
❖ Advanced experience using Xcode’s XCTest Suite, including:
➢ 80+% code coverage in XCTests for the framework target
➢ Writing XCTests with expectations to succeed/fail
➢ Tests that cover asynchronous code.
➢ Recording & running UITests
