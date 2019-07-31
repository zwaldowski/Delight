//
//  ExpenseRow.swift
//  Delight
//

import SwiftUI

struct ExpenseRow: View {

    @ObservedObject var expense: Expense

    let dateFormatter = DateFormatter()

    init(expense: Expense) {
        self.expense = expense

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.formattingContext = .standalone
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(expense.name ?? "Unknown name")")
                    .font(.headline)

                Text("\(expense.createdAt.orNow, formatter: dateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
    }

}

#if DEBUG
struct ExpenseRow_Previews: PreviewProvider {

    static var previews: some View {
        let context = AppStorage.forPreviewing.viewContext
        let previewExpense = Expense(context: context)
        return ExpenseRow(expense: previewExpense)
            .environment(\.managedObjectContext, context)
            .padding()
            .previewLayout(.fixed(width: 440, height: 48))
    }

}
#endif
