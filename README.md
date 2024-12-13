# poc_image

A new Flutter project.

## Files' functionality:
- lib\api\image_detail_api.dart: to connect with external apis

- lib\cubit\image_cubit.dart: to maintain the states while fetching the image data

- lib\utils\urls.dart: to list down all the urls

- lib\provider\image_detail_provider.dart: to store the data related to image tapped to pass it over to next screen

## Features added
- Added scrollcontroller to check if user has reached to the end of the list to load next 10 images
- Added circular progressIndicator when list is empty and added and Text widget with reload button when there is an api error

## Scope of improvement
- testing
- dependency injection for flexibilty and ease in testing
- remote config to handle URL dynamically
- config file to manage themes
- add circular progressIndicator, when new data is loading, at the bottom
- customscrollview can help to add aditional widget adjacent to listview
- can add proper messages for general error status code
- add separator in listview to separate each pair of image-title 
