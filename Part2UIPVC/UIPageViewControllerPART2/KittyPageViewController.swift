//
//  ViewController.swift
//  UIPageViewControllerPART2
//
//  Created by Akshansh on 17/06/18.
//  Copyright © 2018 Akshansh. All rights reserved.
//

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
