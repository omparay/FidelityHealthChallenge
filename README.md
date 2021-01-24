# FidelityHealth Challenge

## Overview:
This is a simple SwiftUI app that can be used to search an Anime Library API from MyAnimeList.
It is architected as two projects: a Framework and an iOS App that is intended to work on an iPhone and iPad.
The major design is done MVVM style with the App having the views and the one viewmodel: SearchViewModel.
The model and service/client is kept in a separate Framework.

## Notes For Reviewers:
* **YES:** the app uses _**SwiftUI**_ and does not use _*RxSwift*_ or _*ReSwift*_. This is because I am implementing the viewmodel using ObservableObject and it is part of the Apple [Combine Framework](https://developer.apple.com/documentation/combine/observableobject) . At this point adding bindings using something other than Combine would be unnecessary and irrelevant. I might try to implement unidirectional data flow as described in [_*ReSwift*_](https://github.com/ReSwift/ReSwift), but not for such a simple app as I am against adding more code complexity for a simple task. 
* **YES:** the simple HTTP client I wrote does not support multi-part form submissions. This was not a stated requirement and if it is a sore spot in your review then pay me to add the feature, otherwise stay irrelevant.
* **YES:** the model consists of structs that use *var* instead of *let* for its properties. I have worked with other devs before that prefer them to be *let* and I disagree especially in the case where you might want to edit the data. So unless specifically specified for in a requirement: all data should be editable.
* **YES:** if you view the timeline for this repo you should notice that the Framework took about 4-6 hours to build and test and the app itself took about 8+. If you are looking for someone faster: stay irrelevant.
* **NO:** this app is *NOT* perfect. Since nothing is perfect, then perfection itself is irrelevant. If you are looking for perfection: stay irrelevant.
