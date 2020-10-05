# HSWellcomePage

## Description
You can build an intro page with this repository.

## Requirements
  - Swift 5
  - iOS 14
  - Xcode 12
  
  ## Installation
  ### Swift Package Manager
  Follow [Apple doc](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app)
  
  ## Usage

  ```swift
  let hs = HSWellcomePage()
  let v1 = View1()
  let v2 = View2()
  let v3 = View3()
  hs.addViews([v1,v2,v3])
  hs.doneButtonTapped {
      print("DONE")
  }
  ```
  
  ## You can also use these methods
  ### Prev Button Methods
  ```swift
  setPrevButton(title:)
  
  setPrevButton(titleColor:)
  
  setPrevButton(icon:withTintColor:)
  ```
  
  ### Next Button Methods
  ```swift
  setNextButton(title:)
  
  setNextButton(titleColor:)
  
  setNextButton(icon:withTintColor:)
  ```
  
  ### Done Button Methods
  ```swift
  setDoneButton(title:)
  
  setDoneButton(titleColor:)
  
  setDoneButton(icon:withTintColor:)
  ```
  
  ### PageControl Methods
  ```swift
  setPageControl(indicatorPrefferedImage:)
  
  setPageControl(currentPageIndicatorTintColor:)
  
  setPageControl(pageIndicatorTintColor:)
  
  doneButtonTapped(clouser:)
  ```
  
  ### Example
  ```swift
  let hs = HSWellcomePage()
  let v1 = View1()
  let v2 = View2()
  let v3 = UIView()
  hs.addViews([v1,v2,v3])
  hs.setPrevButton(title: "ÖNCEKİ")
  hs.setNextButton(title: "SONRAKİ")
  hs.setPrevButton(titleColor: .blue)
  hs.setNextButton(titleColor: .black)
  hs.setDoneButton(title: "DEVAM")
  hs.setDoneButton(titleColor: .red)
  hs.setPageControl(indicatorPrefferedImage: UIImage(systemName: "staroflife.fill") ?? UIImage())
  hs.doneButtonTapped {
      print("DONE")
  }
  ```
  
  ## Author

hakansilek, silekhakan@gmail.com

## License

HSWellcomePage is available under the MIT license. See the LICENSE file for more info.

