EVERYTHING ABOUT PAGEVIEWCONTROLLERS.
====

PART 2
===

---

Background
---

This article documents Part 2 of the multi-part series that implements exhaustive and in-depth concepts about PageViewControllers in iOS.

In the first part of this series, we developed a simple UIPageViewController app. We did not use delegate or data source implementations to enable pagination/ data population.

Instead we used a tap gesture recogniser to trigger an objective-C (@objc func) powered method and then used setViewControllers method of UIPageViewController class to populate the User Interface.

We specified that the spine location could be min or max and our double sided property was set to false.

In this article, we will look at the implementation of the same but with double sided property set to true.

---

Repository Specification
---



**Details about UIPageViewController for this Part**   
* Transition Style is Page Curl (Interface builder)
* Double sided propery is true (Interface builder)
* Spine location can be min or max (Interface builder)


**How to Use**

The document has useful content in Main storyboard file and in KittyPageViewController.swift file.  
Below is the implementation that is used to provide content to PageViewController.  

---

```
import UIKit

class KittyPageViewController: UIPageViewController {
    
    var currentViewControllerIndex = 0

    lazy var contentViewControllers = {
       return ["MyFirstViewController", "MySecondViewController", "MyThirdViewController", "MyFourthViewController", "MyFifthViewController", "MySixthViewController"].map({self.storyboard!.instantiateViewController(withIdentifier: $0)})
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        setViewControllers([contentViewControllers[currentViewControllerIndex]], direction: .forward, animated: true, completion: {
            print("Initial setup finished with \($0) status")
        })
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextKittyAction))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func nextKittyAction() {
        currentViewControllerIndex += 1
        
        if currentViewControllerIndex == contentViewControllers.count {
            currentViewControllerIndex = 0
        }
        
        setViewControllers([contentViewControllers[currentViewControllerIndex], UIViewController()], direction: .forward, animated: true, completion: {
            print("Setup Finished with \($0) status")
        })
    }

}
```

---

Summary
---

In this example, we are paging through pictures of cats.

We will achieve this through a tap gesture recogniser. And we will only support tap to transition to other View Controllers. Gesture based navigation will be discussed in later parts of this series.

In the viewDidLoad function, we add a tap gesture recogniser to our PageViewController's view. This will track touches for all its child view controllers as it is the 'container view controller' and incorporates its childrens' root views into its own root view.

The target for the gesture will be self (Page View Controller) and the action will be an objective C function. (nextKittyAction function in this case). From Apple's documentation, in case of spine location min or max and double sided true property, we have to provide two view controllers.

The first View Controller is the one we want to display next (as a result of user tapping).
The second View Controller represents the backside of the current View Controller. We need to provide this because now double-sided property is true, so we need to have content behind the current page.

So, in our setViewControllers method inside nextKittyAction method, we provided the contentViewControllers[currentViewControllerIndex] and UIViewController(). (An empty view for the backside of our current view :) )

---

