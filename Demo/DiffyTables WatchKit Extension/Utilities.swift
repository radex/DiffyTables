import Foundation

func random(n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
}