# DiffableDataSourceBug
A demo project to reproduce and showcase a bug with the diffable data source and automatic height collection view cells.

There seems to be an issue when applying snapshots that have content above the visible cells where if you apply without animations the collection view discards any cached heights and lays out the content based on the estimated heights of the off screen content. The `contentOffset` itself doesn't change, but the content moves since the bounds changed based on the estimated heights.

Reproduction steps:
1. Scroll down about halfway.
2. Tap the increment button on a cell.
3. Note that the offset changes.

If you change line 61 in `ViewController.swift` to `dataSource.apply(snapshot, animatingDifferences: true)` there are no issues with the offset, but we're now forced to use animations.
