# RickAndMortyTestTask

## First Screen:
* Character List Screen was created with UIKit. I used VIPER architecture to clearly seperate app's concerns and make the app's logic obvious.
* Dependency injection allows testing. (for example, it is easy to replace the networking module)
* Implemented in-memory cahcing for efficient presentation of cell images.
* CollectionView Cells get images loaded individually. Cells Don't know anything about the model, Data is passed into cell.
* Infinite scroll is realised via scrollViewDidScroll method.
* Diffable data source allows smooth scrolling (no need to reload collection each time new cells are fetched, otherwise batch updates could be used)

## Second Screen: 
* Although my main strength is UIKit, I used SwiftUI, as per requirements.
* Views don't know anyhting about the model. ViewModel is only passed into main View.
* Before passing the module into Firs't screen router, it is assembled via a seperate method (same as First Screen)
* Episodes are downloaaded as a group task
* In origin field - name of origin does not include dimension, as per Figma requirements
* Episodes are formatted

  ## Other notes:
  * Normally, I use swiftGen to generate Constants and Assets. I usually don't include generated files (including .xcodeproj) into my repositories.
  * To make it easy to check the project, I included the files mentioned above.

## Opportunities for improvement:
* Errors are not handled. For instance, it would be good to show alerts to users when they are offline.
* Tests could be written.
* Although it was the aim to get the padding exactly how it is in figma, my SwiftUI headers have slightly different alligment.
* Accessibility features could be provided. (For instance, dynamic fonts).
* Cutom fonts could be used (was not a requirement for the task).

I would love your feedback on this assignment. 
Please contact me at any convinient time.
Thank you for the opportunity :)
