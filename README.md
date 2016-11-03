# Findr

[![CI Status](http://img.shields.io/travis/Pedro Fabrino/Findr.svg?style=flat)](https://travis-ci.org/Pedro Fabrino/Findr)
[![Version](https://img.shields.io/cocoapods/v/Findr.svg?style=flat)](http://cocoapods.org/pods/Findr)
[![License](https://img.shields.io/cocoapods/l/Findr.svg?style=flat)](http://cocoapods.org/pods/Findr)
[![Platform](https://img.shields.io/cocoapods/p/Findr.svg?style=flat)](http://cocoapods.org/pods/Findr)

## Requirements

## Installation

Findr is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Findr" , :git => 'https://github.com/fatalhck/findr/releases/tag/0.2'
```

## Author

Lucas Neves, Pedro Fabrino, Jonathan Nobre

## How to use

1. Create a Capture Session with FindrViewController and verify if result don't have any error

  ```swift
  let result = FindrViewController.createCaptureSession()
  if result.error != nil {
    // present alert error
    return
  }
  ```
2. Create an empty FindrAnottation array
3. Create an FindrAnottation and seed this with location, title and active then

  ```swift
  let annotation = FindrAnnotation()
  annotation.location = some CLLocation object
  annotation.title = some title
  annotation.active = true
  ```
4. Append annotation to empty FindrAnnotations array
5. Init FindrViewController and set the data source to self

  ```swift
  let arViewController = FindrViewController()
  arViewController.dataSource = self
  ```
6. Set the FindrAnottations array to instanciated FindrViewController

  ```swift
  arViewController.setAnnotations(annotations)
  ```

7. Present then

  ```swift
  self.present(arViewController, animated: true, completion: nil)
  ```

8. Make an extension of ARDataSource and implements this method:

  ```swift
  func ar(_ findrViewController: FindrViewController, viewForAnnotation: FindrAnnotation) -> FindrAnnotationView {

		let annotation = FindrAnnotationView(frame: YOUR FRAME CONFIGURATION)
		annotation.backgroundColor = UIColor.red
		annotation.annotation = viewForAnnotation

		return annotation
	}
  ```

## License

Findr is available under the MIT license. See the LICENSE file for more info.
