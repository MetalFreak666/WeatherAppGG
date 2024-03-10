# WeatherAppGG

## About
This project was part of the code challenge.  

Time spent on the project: around 26H

## Architecture and project structure
This project uses the MVVM architecture. Moreover, the following project structure was used:
- DataStorage: This folder includes all the classes related to CoreData objects.
- View: This folder stores all the UIViews used in the application.
- ViewModels: This folder includes all the ViewModels.
- ViewControllers: This folder stores all the ViewControllers used in the application.
- Repository: This folder stores all the API logic.
- Models: This folder stores DTOs and data models.
- SupportFiles: This folder stores supporting files.

## Design decisions
- CoreData was used for storing the requested weather reports and the airport locations.
- SwiftUI was used for presenting the 'ForecastConditions' in the DetailView.

## Third party libraries
- Alamofire: Used for the API calls.
- AlamofireNetworkActityLogger: Used for the logging of the requests and debugging.
- SnapKit: Used for the UIKit layouts.
- SwiftyJSON: Used for for Alamofire logging extension. 

## Known issues
- Loading indicator not working when fetching data on the main screen.
- UIScrollView in the DetailView is not working properly.
- Missing implementation regarding CoreData saved locations. Users will experience duplicates of the locations
- Missing implementation of automatically fetching the reports at regular intervals.
