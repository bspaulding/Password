import Foundation

class WordStore {
  func all() -> [String] {
    let path = Bundle.main.path(forResource: "words", ofType:"txt")
    if let text = try? NSString(contentsOfFile:path!, encoding:String.Encoding.utf8.rawValue) {
      return text.components(separatedBy: CharacterSet.newlines) as [String]
    }
    
    return []
  }
  
  func random() -> String {
    let words = all()
    let randomIndex = arc4random() % UInt32(words.count)
    return words[Int(randomIndex)]
  }
}
