# ai_brainstorm

## Overview 
  This is the **BrainBots Brainstorm**  app project repository handled by **Team BrainBots_**, written with pure [Flutter](https://flutter.dev/).
  
  NB: Always contact Team leads before attempting any task **except** assigned to.
  
  - _All team members must adhere to the following instructions while working on this project._
  - _Make sure you understand the project architecture before proceeding with any task._
  
  ## Project Description
  BrainStorm AI is a mobile application that provides a service where its users can have productive moments, come up with new ideas, Ideate....


  ## Design 
   The figma design that will be implemented for this project can be found [here](https://www.figma.com/file/dkg5qBWoJI8YSXcxal5wxN/TalkMate---Ai-Chat-App-(Community)?node-id=1%3A2&mode=dev).

   ## Hosted App Link
   _N.B Once there is a stable build, it would be hosted on appetize and the link would be appended_
   [Here]()

 ## Code Style
  **i. Naming Convention:**

|Naming Convention|Effective Style|Example|   
|-----------------|---------------|-------|
|Classes, enum types,typedefs,and type parameters,etensions|PascalCase|An example is HomeScreen|
|Libraries, packages, directories, and source files, import prefixes|snake_case|An example is home_screen|
|Class members, top-level definitions, variables, parameters, and named parameters, constants|camelCase|An example is verifiedUser|


   
  **ii. Style Rule**
   * Always declare return types in your methods.
   * Put required named parameters first.
   * Always require non-null named parameters (required).
   * All reusable components. should start with Afm meaning (**BrainStorm**) to ensure code uniformity. e.g Evn.bigSpacing(),
   * Use absoulute imports for external packages and use relative imports for files in project.[Here's Why](https://dart-lang.github.io/linter/lints/prefer_relative_imports.html)
   * Indent your code where appropriate `(e.g Use two-space indentation.)`
       Click [Here](https://medium.com/@chukwuemeka.ezeokwelume/2-vs-4-spaces-or-tabs-for-writing-code-e82da3aa5b8d) to know more
   
 
  ## Contribution Guide
  **_Steps to collaborate on the repository for team members._**
  ### Cloning Repo
  * Clone the project.  
  * Click on the "Code" button on the Repo page.
  * Copy the URL for the forked Repo "https://github.com/your-github-username/zc_app.git"
  * Open your Code Editor and  run `git clone` "https://github.com/your-github-username/zc_app.git"
  
  ### _Add "Remote To" and "Pull From" Upstream_
  * Add a Remote to Upstream to your Repo:
      Using the command : `git remote add upstream` ` "https://github.com/foo/foobar" ` 
  * Pull from upstream to download all changes in the project using `git pull upstream develop`


  ### _Complete assigned task/issue_
  * Open the project in your IDE or Code Editor.
  * Complete your assigned task.


  ### _Create and Commit Changes to a New Branch_
  When your task is completed:
  * Create a new branch with your task name e.g "feat- UserSignUP". 
  * run: `git checkout -b feat/yourTask`
  **Push to github;**
  * `git add .`
  * `git commit -m "feat(BE): Inplemented yourTask"`
  
  ### Push New Branch to "Origin" Repository
  * To make sure there are no conflict, Pull from upstream using `git pull upstream develop`
  * Push your branch changes to the Repo using `git push origin "feat/yourTask"` note how it end with a branch.

  ### Creating Pull Request
  **When making a PR, your PR is expected to have the following comments"**
  * What is the task/issue completed?
  * What does the PR actually do?
  * How can the PR be manually tested?
  * Screenshots(of your implementation - A mobile screen or an APi payload). 


## Project Architecture and State Management
This project will follow a [Provider Pattern](https://pub.dev/packages/provider) with a slight variation due to the peculiarities of the Flutter Framework. This project will follow the [Provider State Management](https://pub.dev/packages/provider), for flutter. The state management to be used with this project is provider, Mainly because it is the recommended state management to be used with simple projects.


  ### Directory stucture and usecases

|Project Folders|Effective Style|Example|   
|-----------------|---------------|-------|
|App|Should contain only the configuration of the app|app.dart.|
|Core||An example is home_screen|
|Class members, top-level definitions, variables, parameters, and named parameters, constants|camelCase|An example is verifiedUser|

lib                     
├─ app                  
│  └─ app.dart  
   -     Should contain only the configuration of the app
   -     Note: This file is where all the view and dependencies should be declared.
├─ core                 
│  ├─ constants  
-     This folder will contain on static const members, e.g AppStrings, AppImagesPath, LocalStorageKeys, ApiKeys.       
│  ├─ extensions
-     This folder should contain extension method such as DateFormatter, StringExtension, ValidationExtension. 
-     Note: Any method that has the tendensy to be used repeatedly in different views should be converted to extension methods. 
│  ├─ hooks
-     This folder should contain custom hooks. 
-     Note: Any package that that would require turning a stateless widget into stateful widget should be converted into a hook. e.g Youtube Player view should be converted to a hook and its lifecycle should be properly managed. "https://www.turing.com/kb/code-reuse-maximization-with-flutter-hooks" is a link to learn how to create custom hooks.             
 
│  ├─ mixins
-     This folder should contain mixin methods.
│  ├─ theme 
-    This folder should contain all things theming and colors of this project.
│  └─ utilities   
-     This folder should only contain utility methods such as generateUniqueId, generateReferCode.    
├─ services  
-     This folder will contain the necessary repositories and  service files, such as NetworkService, UserService.  
-     Note: Any logic that needs to use external apis(e.g SharePlus library uses ACTION_SEND Intent on Android and UIActivityViewController on iOS to display respective platform's share dialog or ImagePicker library which enables the app to select images from the platform file system) or method channels should be classified as a service.     
├─ ui 
-     Here each feature of this project will be create folder which would contain the view and viewmodel of each feature.  
-     Note: On no account should viewmodels know about eachother. Every View should have its viewmodel. e.g. home/home_view && home_viewmodel.                 
│  └─ shared            
│     ├─ dumb_widgets   
-    This should contain reusable widgets that have no state and only helps in reducing code repeation.
│     └─ smart_widgets
-       This should contain reusable widgets that have a state and only helps in reducing code repeation.
-       Note: Special reuseable like this should have its own viewmodel.
└─ main.dart  
-     This is where a minimal config is done to get the app running.          


  ### Contact us on our socials(Slack Name).
  **ImmaDominion**
  **KiCodes**
  **Olasunkanmi Beckley**
