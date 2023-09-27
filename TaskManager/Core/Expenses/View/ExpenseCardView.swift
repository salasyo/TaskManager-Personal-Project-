//
//  ExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Obi on 9/24/23.
//

import SwiftUI

struct ExpenseCardView: View {
    @Bindable var expense: Expense
    var displayTag: Bool = true
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.title)
                
                Text(expense.subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                if let categoryName = expense.category?.categoryName, displayTag {
                    Text(categoryName)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.red.gradient, in: .capsule)
                }
            }
            .lineLimit(1)
            
            Spacer(minLength: 5)
            
            /// Current String
            Text(expense.currencyString)
                .font(.title3.bold())
        }
    }
}
