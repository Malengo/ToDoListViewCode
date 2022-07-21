//
//  SpyNavigationController.swift
//  TodoListViewCodeTests
//
//  Created by user on 21/07/22.
//

import UIKit

class SpyNavigationController: UINavigationController {

    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushedViewController = viewController
    }

}
