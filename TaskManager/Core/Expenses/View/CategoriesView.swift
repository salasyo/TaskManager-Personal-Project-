//
//  CategoriesView.swift
//  ExpenseTracker
//
//  Created by Obi on 9/24/23.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Query(animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    // View Properties
    @State private var addCategory: Bool = false
    @State private var categoryName: String = ""
    /// Category Delete Request
    @State private var deleteRequest: Bool = false
    @State private var requestedCategory: Category?
    /// Search Text
    @State private var searchTextCat: String = ""
   
    var body: some View {
        NavigationStack {
            List {
                ForEach(allCategories.filter { category in
                    searchTextCat.isEmpty || category.categoryName.lowercased().contains(searchTextCat.lowercased())
                }.sorted(by: {
                    ($0.expenses?.count ?? 0) > ($1.expenses?.count ?? 0)
                })) { category in
                    DisclosureGroup {
                        if let expenses = category.expenses, !expenses.isEmpty {
                            ForEach(expenses) { expense in
                                ExpenseCardView(expense: expense, displayTag: true)
                            }
                        } else {
                            ContentUnavailableView {
                                Label("No Categories", systemImage: "tray.fill")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.darkPurple))
                                    .padding(.bottom, 20)
                            }
                        }
                    } label: {
                        Text(category.categoryName)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            deleteRequest.toggle()
                            requestedCategory = category
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("Categories")
            .searchable(text: $searchTextCat, placement: .navigationBarDrawer, prompt: Text("Search"))
            .overlay {
                if allCategories.isEmpty {
                    ContentUnavailableView {
                        Label("No Categories 😱", systemImage: "tray.fill")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.darkPurple))
                            .padding(.bottom, 20)
                    }
                }
            }
            /// NEW CATEGORY ADD BUTTON
            .overlay(alignment: .bottomTrailing, content: {
                Button(action: {
                    addCategory.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 55, height: 55)
                        .background(Color(.darkPurple).shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10)), in: .circle)
                })
                .padding(15)
                .padding(.bottom, 70)
            })
            .sheet(isPresented: $addCategory) {
                categoryName = ""
            } content: {
                NavigationStack {
                    List {
                        Section("Title") {
                            TextField("General", text: $categoryName)
                        }
                    }
                    .navigationTitle("Category Name")
                    .navigationBarTitleDisplayMode(.inline)
                    /// Add & Cancel Button
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                              addCategory = false
                            }
                            .tint(.red)
                        }
                        
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Add") {
                                /// Adding New Category
                                let category = Category(categoryName: categoryName)
                                context.insert(category)
                                /// Closing View
                                categoryName = ""
                                addCategory = false
                            }
                            .disabled(categoryName.isEmpty)
                        }
                    }
                }
                .presentationDetents([.height(180)])
                .presentationCornerRadius(20)
                .interactiveDismissDisabled()
            }
        }
        .alert("If you delete a category, all the associated expenses will be deleted too.", isPresented: $deleteRequest) {
            Button(role: .destructive) {
                /// Deleting Category
                if let requestedCategory {
                    context.delete(requestedCategory)
                    self.requestedCategory = nil
                }
            } label: {
                Text("Delete")
            }

            Button(role: .cancel) {
                requestedCategory = nil
            } label: {
                Text("Cancel")
            }
        }
    }
}

#Preview {
    RootView()
}
