//
// DiffyTables
//
// Copyright (c) 2015 Radosław Pietruszewski
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

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

        for (i, (displayedModel, newModel)) in zip(displayed, new).enumerate() {
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
                working.removeRange(pos..<(pos + len))
            }
        }

        return working
    }
}
