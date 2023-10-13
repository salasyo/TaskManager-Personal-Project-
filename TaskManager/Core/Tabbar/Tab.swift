//
//  Tab.swift
//  AnimatedSFTabBar
//
//  Created by Obi on 9/24/23.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "house"
    case expenses = "creditcard"
    case categories = "list.clipboard"
//    case favorites = "star"
    case settings = "gearshape"
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .expenses:
            return "Expenses"
        case .categories:
            return "Categories"
//        case .favorites:
//            return "Favorites"
        case .settings:
            return "Settings"
        }
    }
}

// Animated SF Tab Model
struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tab
    var isAnimating: Bool?
}
