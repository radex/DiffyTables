import WatchKit

//
// Updatable WatchKit interface objects
//

extension WKInterfaceImage {
    func updateImageName(from old: String?, to new: String) {
        if old != new {
            setImageNamed(new)
        }
    }
}

extension WKInterfaceLabel {
    func updateText(from old: String?, to new: String) {
        if old != new {
            setText(new)
        }
    }
}

class WKUpdatableButton {
    private(set) var button: WKInterfaceButton
    private(set) var hidden: Bool
    
    init(_ button: WKInterfaceButton, defaultHidden: Bool) {
        self.button = button
        self.hidden = defaultHidden
    }
    
    func updateHidden(_ hidden: Bool) {
        if hidden != self.hidden {
            button.setHidden(hidden)
            self.hidden = hidden
        }
    }
}
