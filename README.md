# MovieDatatbaseCompanion
Example client for [The Movie Database](https://www.themoviedb.org/) on GitHub for educational purposes.


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
