//
//  ExpenseDetails.swift
//  Delight
//

import SwiftUI
import CoreData

struct ExpenseDetails: View {

    @ObservedObject var expense: Expense
    @Environment(\.managedObjectContext) var context

    let currencyFormatter = NumberFormatter()
    let dateFormatter = DateFormatter()

    init(expense: Expense) {
        self.expense = expense

        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = "USD"
        currencyFormatter.generatesDecimalNumbers = true

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.formattingContext = .standalone
    }

    var nameRow: some View {
        HStack {
            Text("Name")
                .fontWeight(.bold)
            Spacer()
            TextField("Name", text: $expense.name.orEmpty)
                .multilineTextAlignment(.trailing)
        }
    }

    var valueRow: some View {
        HStack {
            Text("Value")
                .fontWeight(.bold)
            Spacer()
            TextField("$0.00", value: $expense.valueInUSD, formatter: currencyFormatter)
                .multilineTextAlignment(.trailing)
        }
    }

    var createdAtRow: some View {
        DatePicker(selection: $expense.createdAt.orNow) {
            Text("Date Recorded")
                .fontWeight(.bold)
        }
    }

    var notesRow: some View {
        TextView(text: $expense.notes.orEmpty)
            .frame(minHeight: 200, alignment: .top)
    }

    var imageRow: some View {
        ImageWell(image: $expense.image)
    }

    var body: some View {
        Form {
            Section {
                nameRow
                valueRow
                createdAtRow
            }

            Section(header: Text("NOTES")) {
                notesRow
            }

            Section(header: Text("PHOTO")) {
                imageRow
            }
        }
        .onDisappear(perform: save)
        .navigationBarTitle("Expense Details", displayMode: .inline)
    }

    func save() {
        guard context.hasChanges else { return }
        try! context.save()
    }

}
