//
//  ContentView.swift
//  FloatingTabBar
//
//  Created by Sean Veal on 10/28/24.
//

import SwiftUI

struct ContentView: View {
    // View Properties
    @State private var activeTab: TabModel = .home
    @State private var isTabBarHidden: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if #available(iOS 18, *) {
                    TabView(selection: $activeTab) {
                        Tab.init(value: .home) {
                            Text("Home")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        
                        Tab.init(value: .search) {
                            Text("Search")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        
                        Tab.init(value: .notifications) {
                            Text("Notifications")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        
                        Tab.init(value: .settings) {
                            Text("Settings")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                } else {
                    TabView(selection: $activeTab) {
                        Text("Home")
                            .tag(TabModel.home)
                            .background {
                                if !isTabBarHidden {
                                    HideTabBar {
                                        print("Hidden")
                                        isTabBarHidden = true
                                    }
                                }
                            }
                        
                        Text("Search")
                            .tag(TabModel.search)
                        
                        Text("Notifications")
                            .tag(TabModel.notifications)
                        
                        Text("Settings")
                            .tag(TabModel.settings)
                    }
                }
            }
            CustomTabBar(activeTab: $activeTab)
        }
    }
}

struct HideTabBar: UIViewRepresentable {
    var result: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let tabBarController = view.tabBarController {
                tabBarController.tabBar.isHidden = true
                result()
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

extension UIView {
    var tabBarController: UITabBarController? {
        if let controller = sequence(first: self, next: {
            $0.next
        }).first(where: { $0 is UITabBarController }) as? UITabBarController {
            return controller
        }
        
        return nil
    }
}

#Preview {
    ContentView()
}
