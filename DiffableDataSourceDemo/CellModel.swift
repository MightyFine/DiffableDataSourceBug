//
//  CellModel.swift
//  DiffableDataSourceDemo
//
//  Created by Tim Korotky on 23/3/21.
//

import Foundation

struct CellModel: Hashable {
    let id = UUID()
    let text: String
    var count: Int = 0

    init(text: String) {
        self.text = text
    }

    var identifier: String {
        return id.uuidString + text + "\(count)"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: CellModel, rhs: CellModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
