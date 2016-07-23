import WatchKit

//
// Our main interface controller
//

class ShoppingListApp: WKInterfaceController {
    @IBOutlet weak var table: WKInterfaceTable!
    var items = sampleShoppingList()
    
// MARK: Initialization
    
    override func awake(withContext context: AnyObject?) {
        updateView()
    }
    
    var firstActivation = true
    
    override func willActivate() {
        if firstActivation {
            DispatchQueue.main.async {
                self.loadMore()
            }
        }
        
        firstActivation = false
    }
    
// MARK: Data manipulation
    
    @IBAction func add() {
        items.insert(sampleShoppingItem(), at: random(items.count))
        rowLimit += 1
        updateView()
    }
    
    @IBAction func changeUp() {
        items = shoppingListVariation(items)
        updateView()
    }
    
// MARK: Rendering
    
    var displayedRows: [ShoppingItemRowModel] = []
    
    func updateView() {
        let newRows = items.limit(rowLimit).map { ShoppingItemRowModel($0) }
        table.updateViewModels(from: displayedRows, to: newRows)
        displayedRows = newRows
        
        updateLoadMoreButton()
    }
    
// MARK: Lazy loading
    
    @IBOutlet weak var _loadMoreButton: WKInterfaceButton!
    lazy var loadMoreButton: WKUpdatableButton = WKUpdatableButton(self._loadMoreButton, defaultHidden: false)
    
    // This is a tiny number for demonstration only. You'd probably want the initial row limit
    // to be ~4 (enough to fit one screen), and in loadMore() — double that number.
    var rowLimit = 1
    
    @IBAction func loadMore() {
        rowLimit += 1
        updateView()
    }
    
    func updateLoadMoreButton() {
        let moreToLoad = items.count > rowLimit
        loadMoreButton.updateHidden(!moreToLoad)
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
        checkbox.updateImageName(from: (old?.completed).map(checkboxImage) ?? "checkbox",
                                   to: checkboxImage(new.completed))
        name.updateText(from: old?.name, to: new.name)
    }
    
    func checkboxImage(_ completed: Bool) -> String {
        return completed ? "checkbox-completed" : "checkbox"
    }
}
