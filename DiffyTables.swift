import WatchKit

//
// WatchKit extensions for diffing-based table updates
//


// _TableRowModel is workaround to Swift crashing on circular typealiases.
// https://github.com/practicalswift/swift-compiler-crashes/blob/master/crashes/23409-circular-typealias.swift

public protocol _TableRowModel { }

public protocol TableRowModel: _TableRowModel {
    typealias RowController: UpdatableRowController
    static var tableRowType: String { get }
    var objectId: String { get }
}

public protocol UpdatableRowController {
    typealias RowModel: _TableRowModel

    func update(from old: RowModel?, to new: RowModel)
}

public extension WKInterfaceTable {
    public func updateViewModels<T: TableRowModel where T.RowController.RowModel == T>(from old: [T], to new: [T]) {
        // Represents view models displayed on screen.
        // Same as `old`, but corrected with rows
        // inserted/deleted on screen
        var displayed: [T?]

        // Remove and insert rows on screen to align currently
        // displayed data with `new` data as closely as possible
        // (Or just set up new rows if table is empty)
        if old.count == 0 {
            displayed = Array(count: new.count, repeatedValue: nil)
            setNumberOfRows(new.count, withRowType: T.tableRowType)
        } else {
            let changes = diffToAlign(old.map { $0.objectId }, new.map { $0.objectId })
            displayed = applyChangesToArray(changes, array: old)
            applyChanges(changes, insertedRowType: T.tableRowType)
        }

        // Update rows with fresh data

        for (i, (displayedModel, newModel)) in enumerate(zip(displayed, new)) {
            let row = rowControllerAtIndex(i) as! T.RowController
            row.update(from: displayedModel, to: newModel)
        }
    }

    private func applyChanges(changes: [AlignmentDiffChange], insertedRowType: String) {
        for change in changes {
            switch change {
            case .Insertion(let pos, let len):
                let rows = NSIndexSet(indexesInRange: NSMakeRange(pos, len))
                insertRowsAtIndexes(rows, withRowType: insertedRowType)
            case .Deletion(let pos, let len):
                let rows = NSIndexSet(indexesInRange: NSMakeRange(pos, len))
                removeRowsAtIndexes(rows)
            }
        }
    }

    private func applyChangesToArray<T>(changes: [AlignmentDiffChange], array: [T]) -> [T?] {
        var working: [T?] = array.map { $0 }

        for change in changes {
            switch change {
            case .Insertion(let pos, let len):
                for _ in (0..<len) {
                    working.insert(nil, atIndex: pos)
                }
            case .Deletion(let pos, let len):
                working.removeRange(Range(start: pos, end: pos + len))
            }
        }

        return working
    }
}
