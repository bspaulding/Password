import Foundation
import AVFoundation

class Narrator : NSObject, AVSpeechSynthesizerDelegate {
  let synthesizer = AVSpeechSynthesizer()
  let voice = AVSpeechSynthesisVoice(language: "en-GB")
  let callbacks : Queue<() -> ()> = Queue()
  
  func introNewPassword(_ then: @escaping () -> ()) {
    say(utterance("the password is..."), then: then)
  }
  
  fileprivate func say(_ utterance: AVSpeechUtterance, then: @escaping () -> ()) {
    synthesizer.delegate = self
    callbacks.enqueue(then)
    synthesizer.speak(utterance)
  }
  
  fileprivate func utterance(_ string: String) -> AVSpeechUtterance {
    let utterance = AVSpeechUtterance(string: string)
    utterance.rate = 0.35
    utterance.voice = voice
    utterance.volume = 0.5
    return utterance
  }
  
  // delegate stuff
  
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    print("[Narrator] utterance finished")
    if let fn = callbacks.dequeue() {
      print("[Narrator] calling callback")
      fn()
    } else {
      print("[Narrator] no callback to call")
    }
  }
}
