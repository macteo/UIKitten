# UIKitten

Bootstrap your iOS app.

[![License MIT](https://img.shields.io/cocoapods/l/UIKitten.svg)](https://raw.githubusercontent.com/macteo/uikitten/master/LICENSE) [![Version](https://img.shields.io/cocoapods/v/UIKitten.svg)](https://cocoapods.org/?q=marklight) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![travis-ci](https://travis-ci.org/macteo/UIKitten.svg?branch=master)](https://travis-ci.org/macteo/UIKitten) [![codecov.io](https://codecov.io/github/macteo/UIKitten/coverage.svg?branch=master)](https://codecov.io/github/macteo/UIKitten?branch=master) ![Swift 3](https://img.shields.io/badge/language-Swift%203-EB7943.svg) ![iOS 9+](https://img.shields.io/badge/iOS-9+-EB7943.svg)

![UIKitten Logo](https://raw.githubusercontent.com/macteo/UIKitten/develop/Assets/logo/uikitten-1024%402x.png?token=AAj41DnApg0tGOJNY08NAe0u8CODao0Iks5Y2W2uwA%3D%3D)

## Goal

UIKitten aims to let any developer include most of the boilerplate features required by a well designed iOS app, with few lines of code and a single main dependancy.

Simple and coherent design is a key component for inclusion.

It's intended to be used developers with any level of experience, but it definitely makes of the ease of use and integration one of its primary goals, so it leans toward junior developers. It can be used to bootstrap complex projects to speed up development, moving further customizations down the road.

UIKitten includes an opinionated selection of dependencies to don't reinvent the wheel, but whenever it's possible it will use the frameworks provided directly by Apple included in iOS.

### Components

#### Buttons
  - [x] Dynamic Size
  - [x] Colors
  - [x] Multiline text
  - [x] Styles
  - [x] Sizes
  - [x] Icons
  - [x] Grouped (still some issues on animations)

#### Forms
  - [x] Text field design
  - [x] Username field
  - [x] Password field
  - [x] Email field
  - [x] Validations with regexes and error messages
  - [x] Icons
  - [ ] Styles
  - [ ] Sizes
  - [ ] Text area, autoresizable, markdown syntax highlight
  - [ ] Toggle
  - [ ] Color picker
  - [ ] Time picker
  - [ ] Date time picker
  - [ ] Date picker
  - [ ] Interval picker
  - [ ] Select
  - [ ] Date selection
  - [ ] Photo selection
  - [ ] Slider

#### Charts
  - [ ] Line.
  - [ ] Multiline.
  - [ ] Bars.
  - [ ] Pie.
  - [ ] Scatter.
  - [ ] Animations.

#### Table Controller
A modern `UITableViewController` replacement based on `UICollectionViewController` and auto layout.

- [ ] Edit mode (reorder, delete).
- [ ] Drag to reorder.
- [ ] Delete button.
- [ ] Swipe actions
- [x] Dynamic footer expansion on tap.
- [x] Simplified data source.

#### Cells
- [x] Title.
- [x] Title and subtitle.
- [x] Title and image.
- [x] Title, subtitle and image.
- [x] Disclosure indicator.
- [x] Footer.

#### Cards
- [ ] Map.
- [ ] Calendar.
- [ ] Image.
- [ ] Text.
- [ ] Header.
- [ ] Footer.
- [ ] Chart.

#### Sample view controller
- [ ] Login form with validation.
- [ ] Signup.
- [ ] Profile.
- [ ] Menu.
- [ ] Timeline.

### Simplified APIs

UIKitten also aims to provide simplified method signatures and to let people approach `UIKit` and other frameworks in an easyer way.
Playgrounds are a great tool to experiment, iPad Playground Books are a great way to teach, backed by the immense power of iOS frameworks that are not designed to teach and to learn.

Take for example how you create a button and connect the `touchUpInside` gesture with the desired action. That's a realive easy task when performed on interface builder, a boring one when accomplished by code for an experienced developer, a hard one for a newby. When developing a Swift playground you don't have interface builder at your disposal.

This is whan you'll be able to do

```swift
let _ = Button(icon: .arrowRight).add(self.view).tap {
  print("Next Button Tapped")
}
```

to obtain this result

### Catalog

In this repo you can find a subfolder called _Catalog_ that contains a separate project with a comprehensive collection of controls and sample code to learn how to use UIKitten.

### Dependencies

* [FontAwesome.swift](https://github.com/thii/FontAwesome.swift) - Use Font Awesome in your Swift projects.

### License

* MIT for the original classes and contents.
* Specific ones for each dependency.

### Acknowledgements

* [Matteo Gavagnin](https://macteo.it) - Dolomate - [@macteo](https://twitter.com/macteo)
