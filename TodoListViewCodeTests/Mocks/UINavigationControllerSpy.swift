//
//  SpyNavigationController.swift
//  TodoListViewCodeTests
//
//  Created by user on 21/07/22.
//

import UIKit

class UINavigationControllerSpy: UINavigationController {
    
    var wasPushViewControllerCalled = false
    var wasPresentCalled = false
    var pushViewControllerCompletionHandler: ((_ viewController: UIViewController, _ animated: Bool) -> Void)?
    var presentCompletionHandler: ((_ viewControllerToPresent: UIViewController, _ animated: Bool, _ completion: (() -> Void)? ) -> Void)?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        wasPushViewControllerCalled = true
        pushViewControllerCompletionHandler?(viewController, animated)
    }
    
}
