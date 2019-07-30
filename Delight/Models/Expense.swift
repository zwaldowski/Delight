//
//  Expense.swift
//  Delight
//

import CoreData

extension Expense {

    override public func awakeFromInsert() {
        super.awakeFromInsert()

        let adjectives = ["Fluffy", "Rusty", "Shiny"]
        let randomAdjective = adjectives.randomElement()!
        let nouns = ["Bear", "Spork", "Mac"]
        let randomNoun = nouns.randomElement()!

        name = "\(randomAdjective) \(randomNoun)"
        createdAt = Date()
        valueInUSD = NSDecimalNumber(value: Int.random(in: 0 ..< 100))
    }

}
