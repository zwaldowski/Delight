//
//  ArrayBuilder.swift
//  Delight
//

@_functionBuilder
struct ArrayBuilder<Element> {
    static func buildBlock(_ elements: Element...) -> [Element] {
        return elements
    }

    static func buildBlock(_ elements: [Element]...) -> [Element] {
        return elements.flatMap { $0 }
    }

    static func buildIf(_ element: [Element]?) -> [Element] {
        element ?? []
    }
}
