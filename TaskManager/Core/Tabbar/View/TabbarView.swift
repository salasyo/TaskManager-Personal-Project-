//
//  TabbarView.swift
//  TaskManager
//
//  Created by Obi on 9/23/23.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var showSignInView: Bool
    
    @State private var activeTab: Tab = .home
    /// All Tab's
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                TabView(selection: $activeTab) {
                    
                    // HOME
                    NavigationStack {
                    Home(showSignInView: $showSignInView, activeTab: $activeTab)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.BG))
                        .preferredColorScheme(.light)
                        .onTapGesture { activeTab = .home }
                    }
                    .setUpTab(.home)
                    .tag(Tab.home)
                    
                    // EXPENSES
                    NavigationStack {
                    ExpensesView(activeTab: $activeTab)
                        .onTapGesture { activeTab = .expenses }
                    }
                    .setUpTab(.expenses)
                    .tag(Tab.expenses)
                    
                    // CATEGORIES
                    NavigationStack {
                     CategoriesView()
                        .onTapGesture { activeTab = .categories }
                    }
                    .setUpTab(.categories)
                    .tag(Tab.categories)
                
                    // FAVORITES
                    NavigationStack {
                    FavoriteView()
                        .onTapGesture { activeTab = .favorites }
                    }
                    .setUpTab(.favorites)
                    .tag(Tab.favorites)
                    
                    // PROFILE
                    NavigationStack {
                        ProfileView(showSignInView: $showSignInView)
                            .onTapGesture { activeTab = .profile }
                    }
                    .setUpTab(.profile)
                    .tag(Tab.profile)
                
                }
                .edgesIgnoringSafeArea(.bottom)
            
                CustomTabBar()
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 30)
            }
        }
    }
        
        @ViewBuilder
        func CustomTabBar() -> some View {
            HStack(spacing: 0) {
                ForEach($allTabs) { $animatedTab in
                    let tab = animatedTab.tab
                    
                    VStack(spacing: 4) {
                        Image(systemName: activeTab == tab ? "\(tab.rawValue).fill" : tab.rawValue)
                            .font(.title)
                            .fontWeight(.light)
                            .contentTransition(
                                .symbolEffect(.replace.offUp.wholeSymbol, options: .speed(2)))
                        
                        Text(tab.title)
                            .font(.caption2)
                            .textScale(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(activeTab == tab ? Color(.darkPurple) : Color(.darkPurple).opacity(0.5))
                    .padding(.top, 15)
                    .padding(.bottom, 10)
                    .contentShape(.rect)
                    /// you can also use button if you choose to
                    .onTapGesture {
                        withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                            activeTab = tab
                            animatedTab.isAnimating = true
                        }, completion: {
                            var transaction = Transaction()
                            transaction.disablesAnimations = true
                            withTransaction(transaction) {
                                animatedTab.isAnimating = nil
                            }
                        })
                    }
                }
            }
            .background(.bar)
        }
    }

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(showSignInView: .constant(false))
    }
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
