
# BIMM Interview

## Setup
To setup this application you will need to wait for the SPM (Swift package manager) to resolve the graph and pull the libraries

### Enviroment

The project asked to resolve show a list of cats from a JSON. Since there were some issues with the gif/images of id's in the provided in the initial JSON another list of cats was used and stored in the `cats.json` file inside Support.bundle.

The `Envirnoment.xcconfig` serves as the enviroment file for the application here we will store API KEYS (if needed to interact with other APIS), enpoints and configuration overall.


## Implementation

Apart from the basic requirements this application also implements:
- Filtering from tag selection
- Allowing a cat to talk by typing in the detail and the talk tab and tapping the checkmark to show the view with the typed text

### IMPORTANT NOTE
When running the application from XCode the debugger is attached to the application affecting the performance. This is most notable in the textfields where the first responder is very slow to show the keybooard the first time.

To see how it would behave normaly just kill the application after installing it with xcode and rerun the application to have in without the debugger attached.

## Tests

The application currently focuses strongly on covering unit tests and integrations tests since they are the most reliable ones.

### Unit tests
The list of files corresponding to the unit tests.
- CatResponseTest
- CatHomeViewModelTest
- CatHomeFilterStateTest
- CatDetailViewModelTest

### Integration tests
For the integration tests the library ViewInspetor was used and also relied on protocol oriented implementations for faking scenarios.

- CatCardViewIntegrationTest
- CatImageViewIntegrationTest
- CatHomeViewIntegrationTest
- CatHomeFilterBottomSheetViewIntegrationTest
- CatDetailViewIntegrationTest
- CatDetailInformationViewIntegrationTest
- CaatasNavigationResolverViewTest

## UITests

- BIMMUITestNavigation
    - Focus on testing that the navigation is working properly when interacting with the app

## Architecture
### Clean architecture
For this demo clean architecture was used isolating the logic of domain, data and presentation layers.

### Domain
Contains all the classes and domains describing the application. This includes also the services protocols

### Data
Contains all the files related to how to interact with remote and local data.
In this folder we also make the implementations of the different services declared in our domain
### Important files
- NetworkManager
    - This file handles how http operations should be handled.
    - Provides different imlementations on how to send a http request based on the generic API that conforms to Api
- Api
    - Protocol describing a Api endpoint with its information.
    - Allows us to have and ordered and consisted way to declare endpoints

### Presentation
In this layer we will contain all of our views, components, view modifiers, view models, states and everything related to describing our views.

A pattern you will find in this layer is when declaring a view depending on a state object most of times there will be an inner content view hoisting all of the logic and actions to have a stateless view to test.

### Important files
- CaatasNavigationResolverView
    - This class resolves how the CaatasNavigation should be resolved based on the current destination
- Router
    - An observable objects that publishes the nav path to subcribe for navigation changes. 
    - Receives a generic Destination that must conform to the hashable protocol
- BIMMTheme
    - Contains the basic implementation of a theme for the application.

