//
//  CollectionViewCell.swift
//  DiffableDataSourceDemo
//
//  Created by Tim Korotky on 23/3/21.
//

import Foundation
import UIKit

protocol CollectionViewCellDelegate: class {
    func cellDidTapIncrement(_ cell: UICollectionViewCell)
}

final class CollectionViewCell: UICollectionViewCell {
    weak var delegate: CollectionViewCellDelegate?

    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor

        textLabel.numberOfLines = 0

        button.setTitle("Increment", for: .normal)
    }

    func prepare(with model: CellModel) {
        textLabel.text = model.text
        countLabel.text = "Count: \(model.count)"
    }

    @IBAction func buttonTouchUpInside() {
        delegate?.cellDidTapIncrement(self)
    }
}
