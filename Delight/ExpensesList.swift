//
//  ExpensesList.swift
//  Delight
//

import SwiftUI
import CoreData

struct ExpensesList: View {

    static let sortDescriptors = [
        NSSortDescriptor(key: #keyPath(Expense.createdAt), ascending: false),
        NSSortDescriptor(key: #keyPath(Expense.name), ascending: true)
    ]

    @FetchRequest<Expense>(sortDescriptors: sortDescriptors) var expenses
    @Environment(\.managedObjectContext) var context

    var body: some View {
        List {
            ForEach(expenses, id: \.objectID) { (expense) in
                NavigationLink(destination: ExpenseDetails(expense: expense)) {
                    ExpenseRow(expense: expense)
                }
            }
        }
        .navigationBarTitle("Expenses")
        .navigationBarItems(
            leading: EditButton(),
            trailing: Button(action: add) {
                Image(systemName: "plus")
            })
    }

    func delete(at indexes: IndexSet) {
        let objects = indexes.map { expenses[$0] }
        objects.forEach(context.delete)
        try! context.save()
    }

    func add() {
        _ = Expense(context: context)
        try! context.save()
    }

}
