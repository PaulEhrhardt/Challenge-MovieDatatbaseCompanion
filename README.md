# MovieDatatbaseCompanion
Example client for [The Movie Database](https://www.themoviedb.org/) on GitHub for educational purposes.


### API Documentation
The documentation of API can be found [here](https://developer.themoviedb.org/reference/intro/getting-started).


### API Key
To access the API the individual API Key for Bearer authentication needs to be registered with the core client before first use. 
For privacy reasons the API-Key is not checked in but placed in a file called 'apikey.secret' that needs to be created on a individual basis for each checked out project. The 'apikey.secret' should not be commited and is excluded via .gitignore file.
See the core client library's Unit Tests for details on how to read the key in from file.