import Foundation
import SwiftUI

/// The NavigationViewCoordinator is used to represent a coordinator with a NavigationView
public class NavigationViewCoordinator<T: Coordinatable>: ViewWrapperCoordinator<T, AnyView> {
    public init(_ childCoordinator: T) {
        super.init(childCoordinator) { view in
            #if os(macOS)
            AnyView(
                SwiftUI.NavigationStack {
                    view
                }
            )
            #else
            if #available(iOS 16.4, *) {
                AnyView(
                    SwiftUI.NavigationView {
                        view
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                )
            } else if #available(iOS 16.0, *) {
                AnyView(
                    SwiftUI.NavigationStack {
                        view
                    }
                    .navigationViewStyle(.stack)
                )
            } else {
                AnyView(
                    SwiftUI.NavigationView {
                        view
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                )
            }
            #endif
        }
    }
    
    @available(*, unavailable)
    public override init(_ childCoordinator: T, _ view: @escaping (AnyView) -> AnyView) {
        fatalError("view cannot be customized")
    }
    
    @available(*, unavailable)
    public override init(_ childCoordinator: T, _ view: @escaping (any Coordinatable) -> (AnyView) -> AnyView) {
        fatalError("view cannot be customized")
    }
}
