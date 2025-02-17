//
//  Tab.swift
//  FloatingTabBar
//
//  Created by Sean Veal on 10/28/24.
//

import Foundation

enum TabModel: String, CaseIterable {
    case home = "house"
    case search = "magnifyingglass"
    case notifications = "bell"
    case settings = "gearshape"
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .notifications: return "Notifications"
        case .settings: return "Settings"
        }
    }
}
