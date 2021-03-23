//
//  ViewController.swift
//  DiffableDataSourceDemo
//
//  Created by Tim Korotky on 23/3/21.
//

import UIKit

enum Section {
    case section
}

class ViewController: UIViewController {
    private var models = [
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
        CellModel(text: "Text"),
        CellModel(text: "Text text text text text text text text text text text text text text text"),
    ]
    private let reuseIdentifier = "reuseIdentifier"

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, CellModel>!

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        prepareDataSource()
        updateUI()
    }

    private func updateUI() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellModel>()
        snapshot.appendSections([.section])
        snapshot.appendItems(models, toSection: .section)

        // If this is changed to `true`, it works, but if it's `false` there is a jump in content
        // offset when the snapshot is applied. The jump size appears to be directly correlated to
        // the estimated height and is likely due to the collection view not doing any diff and
        // applying the state in its entirety.
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ViewController {
    func prepareUI() {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let estimatedHeight = CGFloat(100)
            let layoutSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(estimatedHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: layoutSize,
                subitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 16,
                leading: 16,
                bottom: 0,
                trailing: 16
            )
            section.interGroupSpacing = 16

            return section
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            UINib(nibName: "CollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier
        )

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func prepareDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [unowned self] collectionView, indexPath, model -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: reuseIdentifier,
                    for: indexPath
                ) as! CollectionViewCell

                cell.delegate = self
                cell.prepare(with: model)

                return cell
            }
        )
    }
}

extension ViewController: CollectionViewCellDelegate {
    func cellDidTapIncrement(_ cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }

        models[indexPath.row].count += 1
        updateUI()
    }
}
