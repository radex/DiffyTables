import WatchKit

//
// Our main interface controller
//

class ShoppingListApp: WKInterfaceController {
    @IBOutlet weak var table: WKInterfaceTable!
    var items = sampleShoppingList()
    
    override func awakeWithContext(context: AnyObject?) {
        update(items)
    }
    
    @IBAction func add() {
        items.insert(sampleShoppingItem(), atIndex: random(items.count))
        update(items)
    }
    
    @IBAction func changeUp() {
        items = shoppingListVariation(items)
        update(items)
    }
    
    var displayedRows: [ShoppingItemRowModel] = []
    
    func update(items: [ShoppingItem]) {
        let newRows = items.map { ShoppingItemRowModel($0) }
        table.updateViewModels(from: displayedRows, to: newRows)
        displayedRows = newRows
    }
}

//
// The view model that describes table row
//

struct ShoppingItemRowModel: TableRowModel {
    typealias RowController = ShoppingItemRow
    static let tableRowType = "item"
    
    let objectId: String
    var name: String
    var completed: Bool
    
    init(_ item: ShoppingItem) {
        objectId = item.id
        name = item.name
        completed = item.completed
    }
}

//
// The table row controller
//

class ShoppingItemRow: NSObject, UpdatableRowController {
    @IBOutlet weak var checkbox: WKInterfaceImage!
    @IBOutlet weak var name: WKInterfaceLabel!
    
    func update(from old: ShoppingItemRowModel?, to new: ShoppingItemRowModel) {
        checkbox.updateImageName(from: map(old?.completed, checkboxImage) ?? "checkbox",
                                   to: checkboxImage(new.completed))
        name.updateText(from: old?.name, to: new.name)
    }
    
    func checkboxImage(completed: Bool) -> String {
        return completed ? "checkbox-completed" : "checkbox"
    }
}