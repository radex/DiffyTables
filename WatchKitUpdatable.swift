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