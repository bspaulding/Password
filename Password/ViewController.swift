import UIKit

class ViewController: UIViewController {
  let musicPlayer = MusicPlayer()
  let narrator = Narrator()

  @IBOutlet weak var currentWordLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(newWord))
    self.view.addGestureRecognizer(tapRecognizer)
    
    musicPlayer.play({
      self.newWord()
    })
  }
  
  func newWord() {
    currentWordLabel.text = ""
    let word = WordStore().random().uppercased()
    print(word)
    self.currentWordLabel.text = word
    self.musicPlayer.duck({ done in
    self.narrator.introNewPassword({
//        done()
      })
    })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

