//
//  CellModel.swift
//  DiffableDataSourceDemo
//
//  Created by Tim Korotky on 23/3/21.
//

import Foundation

final class CellModel: Hashable {
    let id = UUID()
    var text: String
    var count: Int = 0

    init(text: String) {
        self.text = text
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(text)
        hasher.combine(count)
    }

    static func == (lhs: CellModel, rhs: CellModel) -> Bool {
        lhs.id == rhs.id
            && lhs.text == rhs.text
            && lhs.count == rhs.count
    }
}
