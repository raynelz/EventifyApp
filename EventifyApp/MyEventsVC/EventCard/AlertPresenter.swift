//
//  AlertPresenter.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.05.2024.
//

import UIKit

public final class AlertPresenter {
    public static let shared = AlertPresenter()

    private init() {}

    public func makeAlert(
        title: String,
        message: String,
        @ActionBuilder _ instructions: () -> [AlertAction] = { return [] }
    ) {
        guard let viewController = topViewController() else {
            print("Не удалось найти текущий контроллер для отображения алерта")
            return
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let actions = instructions()
        for action in actions {
            alert.addAction(action.toUIAlertAction())
        }

        viewController.present(alert, animated: true, completion: nil)
    }

    private func topViewController(base: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }

        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }

        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        return base
    }
}

public final class AlertAction {
    private let title: String
    private let style: UIAlertAction.Style
    private let handler: (() -> Void)?

    init(title: String, style: UIAlertAction.Style, handler: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }

    func toUIAlertAction() -> UIAlertAction {
        return UIAlertAction(title: title, style: style) { _ in
            self.handler?()
        }
    }

    public static func `default`(title: String, action: @escaping () -> Void) -> AlertAction {
        return AlertAction(title: title, style: .default, handler: action)
    }

    public static func cancel(title: String, action: (() -> Void)? = nil) -> AlertAction {
        return AlertAction(title: title, style: .cancel, handler: action)
    }

    public static func destructive(title: String, action: @escaping () -> Void) -> AlertAction {
        return AlertAction(title: title, style: .destructive, handler: action)
    }
}

@resultBuilder
public struct ActionBuilder {
    public typealias Component = [AlertAction]

    public static func buildBlock(_ children: Component...) -> Component {
        return children.flatMap { $0 }
    }

    public static func buildExpression(_ expression: AlertAction) -> Component {
        return [expression]
    }

    public static func buildIf(_ component: Component?) -> Component {
        return component ?? []
    }

    public static func buildEither(first component: Component) -> Component {
        return component
    }

    public static func buildEither(second component: Component) -> Component {
        return component
    }
}
