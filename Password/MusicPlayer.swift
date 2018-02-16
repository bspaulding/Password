import Foundation
import AVFoundation

class MusicPlayer {
  let player : AVAudioPlayer
  
  init() {
    do {
      let url = Bundle.main.url(forResource: "Password Thinking Song", withExtension: "aif")
      if let _url = url {
        player = try AVAudioPlayer(contentsOf: _url)
        player.numberOfLoops = -1 // loop forever
      } else {
        print("no url for resource")
        player = AVAudioPlayer()
      }
    } catch {
      print("Couldn't load song")
      player = AVAudioPlayer()
    }
  }
  
  func play(_ then: @escaping () -> ()) {
    let _volume = player.volume
    player.volume = 0
    player.play()
    fadeTo(_volume, then: then)
  }
  
  func duck(_ fn: @escaping (() -> ()) -> ()) {
    let volume = player.volume
//    fadeTo(0.3, then: {
//      fn({
//        self.fadeTo(volume, then: {})
//      })
//    })
  }
  
  fileprivate func fadeTo(_ volume: Float, then: @escaping () -> ()) {
    print("[fadeTo] volume: \(volume), player.volume: \(player.volume)")
    if abs(player.volume - volume) > 0.01 {
      print("[fadeTo] adjusting volume")
      if player.volume > volume {
        player.volume -= 0.1
      } else {
        player.volume += 0.1
      }
      
      delay(0.1, closure: { self.fadeTo(volume, then: then) })
    } else {
      print("[fadeTo] done, calling then")
      then()
    }
  }
}
