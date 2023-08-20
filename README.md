# RickAndMortyTestTask

## First Screen:
* Character List Screen was created with UIKit. 
* I used VIPER architecture to clearly seperate app's concerns and make the app's logic obvious.
* Dependency injection allows testing. (for example, it is easy to replace the networking module)
* Implemented in-memory cahcing for efficient presentation of cell images.
* CollectionView Cells get images loaded individually. Cells Don't know anything about the model, Data is passed into cell.
* Infinite scroll is realised via scrollViewDidScroll method.
* Diffable data source allows smooth scrolling (no need to reload collection each time new cells are fetched, otherwise batch updates could be used)

## Second Screen: 
* Although my main strength is UIKit, I used SwiftUI, as per requirements.
* Views don't know anyhting about the model. ViewModel is only passed into main View.
* Before passing the module into First screen router, it is assembled via a seperate method (same as First Screen)
* Episodes are downloaded as a group task - this allows to load multiple episodes at once.
* In origin field - name of origin does not include dimension, as per Figma requirements
* Episodes are formatted

## Other notes:
* Normally, I use swiftGen to generate Constants and Assets. I usually don't include generated files (including .xcodeproj) into my repositories.
* To make it easy to check the project, I included the files mentioned above.
* My preference is to use SnapKit when working with UIKit layouts.

## Opportunities for improvement:
* Errors are not handled. For instance, it would be good to show alerts to users when they are offline.
* Tests could be written.
* Although it was the aim to get the padding exactly how it is in figma, my SwiftUI headers have slightly different alligment.
* Accessibility features could be provided. (For instance, dynamic fonts).
* Cutom fonts could be used (was not a requirement for the task).
* The case with user scrolling to the very end of CharacterList is not handled.
* Modules could be saved as SPM packages to make modularity more obvious, however it's not that important for such small project.

I would love your feedback on this assignment. 
Please contact me at any convinient time.
Thank you for the opportunity :)
