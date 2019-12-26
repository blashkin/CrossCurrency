//
//  CurrencyRouter.swift
//  Revolut
//
//  Created by George Blashkin on 25.12.2019.
//  Copyright © 2019 Blashkin Georgiy. All rights reserved.
//

import UIKit

class CurrencyRouter {

	// MARK: - Properties

	private let rootController: UINavigationController

	var toPresent: UIViewController? {
		return rootController
	}

	// MARK: - Construction

	convenience init() {
		self.init(rootController: nil)
	}

	init(rootController: UINavigationController?) {
		self.rootController = rootController ?? UINavigationController()
	}

	deinit {
		print("CurrencyRouter")
	}
}

extension CurrencyRouter: Routable {
	func present(_ module: Presentable?, animated: Bool) {
		guard let controller = module?.toPresent else { return }
		rootController.present(controller, animated: animated, completion: nil)
	}

	func dismissModule(animated: Bool, completion: (() -> Void)?) {
		rootController.dismiss(animated: animated, completion: completion)
	}

	func push(_ module: Presentable?, animated: Bool) {
		guard let controller = module?.toPresent else { return }

		if controller is UINavigationController == false {
			rootController.pushViewController(controller, animated: animated)
		}
	}

	func popModule(animated: Bool) {
		rootController.popViewController(animated: animated)
	}

	func setRootModule(_ module: Presentable?, animated: Bool) {
		guard let controller = module?.toPresent else {
			rootController.viewControllers = []
			return
		}
		controller.modalTransitionStyle = .crossDissolve
		rootController.setViewControllers([controller], animated: animated)
	}
}