# Afflato

Bootstrap your iOS app.

## Goal

Afflato aims to let any developer include most of the boilerplate features required by a well designed iOS app, with few lines of code and a single main dependancy.

Simple and coherent design is a key component for inclusion.

It's intended to be used developers with any level of experience, but it definitely makes of the ease of use and integration one of its primary goals, so it leans toward junior developers. It can be used to bootstrap complex projects to speed up development, moving further customizations down the road.

Afflato includes an opinionated selection of dependencies to don't reinvent the wheel, but whenever it's possible it will use the frameworks provided directly by Apple included in iOS.

### Components

#### Buttons
  - [x] Dynamic Size
  - [x] Colors
  - [x] Multiline text
  - [x] Styles
  - [x] Sizes
  - [x] Icons
  - [ ] Grouped

#### Forms
  - [x] Text field design
  - [x] Username field
  - [x] Password field
  - [x] Email field
  - [x] Validations with regexes and error messages
  - [ ] Text area, autoresizable, markdown syntax highlight
  - [ ] Toggle
  - [ ] Color picker
  - [ ] Time picker
  - [ ] Date time picker
  - [ ] Date picker
  - [ ] Interval picker
  - [ ] Styles
  - [ ] Sizes
  - [ ] Select
  - [ ] Date selection
  - [ ] Icons
  - [ ] Photo selection
  - [ ] Slider

#### Charts
  - [ ] Line
  - [ ] Multiline
  - [ ] Bars
  - [ ] Pie
  - [ ] Scatter

#### Cards
  - [ ] Map
  - [ ] Calendar
  - [ ] Image
  - [ ] Text
  - [ ] Header
  - [ ] Footer
  - [ ] Chart

#### Cells
  - [x] Title
  - [ ] Title and subtitle
  - [x] Title and image
  - [ ] Title, subtitle and image
  - [ ] Rounded colorful image like healthkit
  - [x] Disclosure indicator
  - [x] Disclosure indicator

#### Notifications
  - [ ] Toast
  - [ ] Push

#### Controllers
  - [ ] Login
  - [ ] Signup
  - [ ] Profile
  - [ ] Menu
  - [ ] Timeline
  - [ ] `UITableViewController` replacement using `UICollectionViewController`
  - [ ] Edit mode (reorder, delete)
  - [ ] Swipe actions
  - [ ] Dynamic expand
  - [ ] Simplified data source 

#### Presentations
  - [ ] Modal and semi modal

#### Requests
  - [ ] Synchronous
  - [ ] Asynchronous
  - [ ] Spinner
  - [ ] Autoload
  
### Simplified APIs

Afflato also aims to provide simplified method signatures and to let people approach `UIKit` and other frameworks in an easyer way.
Playgrounds are a great tool to experiment, iPad Playground Books are a great way to teach, backed by the immense power of iOS frameworks that are not designed to teach and to learn.

Take for example how you create a button and connect the `touchUpInside` gesture with the desired action. That's a realive easy task when performed on interface builder, a boring one when accomplished by code for an experienced developer, a hard one for a newby. When developing a Swift playground you don't have interface builder at your disposal.

This is whan you'll be able to do

```swift
let _ = Button(image: .arrowRight).add(self.view).tap {
  print("Next Button Tapped")
}
```

to obtain this result

### Catalog

In this repo you can find a subfolder called _Catalog_ that contains a separate project with a comprehensive collection of controls and sample code to learn how to use Afflato.

### Dependencies

* [FontAwesome.swift](https://github.com/thii/FontAwesome.swift) - Use Font Awesome in your Swift projects.

### License

* MIT for the original classes and contents.
* Specific ones for each dependency.

### Acknowledgements

* [Matteo Gavagnin](https://macteo.it) - Dolomate - [@macteo](https://twitter.com/macteo)