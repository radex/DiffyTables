import Foundation

//
// Data model & related utilities
//

struct ShoppingItem {
    let id: String
    var name: String
    var completed: Bool
}

extension ShoppingItem: Printable {
    var description: String {
        let completion = completed ? "Done: " : ""
        return "ShoppingItem(\(completion)\(name))"
    }
}

func sampleShoppingList() -> [ShoppingItem] {
    return [
        ShoppingItem(id: "1", name: "Milk", completed: false),
        ShoppingItem(id: "2", name: "Bread", completed: false),
        ShoppingItem(id: "3", name: "Chocolate", completed: false),
        ShoppingItem(id: "4", name: "Ice cream", completed: true),
        ShoppingItem(id: "5", name: "Cookies", completed: false),
    ]
}

func shoppingListVariation(var list: [ShoppingItem]) -> [ShoppingItem] {
    let rand = { random(list.count) }
    
    // reorder a random element
    var i = rand()
    var el = list[i]
    list.removeAtIndex(i)
    list.insert(el, atIndex: rand())
    
    // toggle `completed` for a random element
    i = rand()
    el = list[i]
    el.completed = !el.completed
    list[i] = el
    
    // add a variation to random element's name
    list[i].name += "!"
    
    return list
}

func sampleShoppingItem() -> ShoppingItem {
    let names = ["Veggies", "Apples", "Mayo", "Ketchup", "Cheese", "Coffee"]
    
    return ShoppingItem(
        id: "\(random(10000))",
        name: names[random(names.count)],
        completed: random(3) == 0)
}