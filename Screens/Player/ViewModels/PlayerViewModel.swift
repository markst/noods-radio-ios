import RxSwift
import RxMusicPlayer
import Foundation

class PlayerViewModel {
  
  private let player = RxMusicPlayer()
  
  // MARK: Init
  
  init() { }
  
  deinit { }
  
  var disposable: Disposable?
  
  func playStream(url: URL, meta: RxMusicPlayerItem.Meta = .init()) {
    player?.queuedItems.enumerated().forEach({ try? player?.remove(at: $0.offset) })
    player?.append(items: [.init(url: url, meta: meta)])
    
    disposable = player?.run(cmd: .just(.play).asDriver()).drive()
  }
  
  func pause() {
    disposable = player?.run(cmd: .just(.pause).asDriver()).drive()
  }
  
  func resume() {
    disposable = player?.run(cmd: .just(.play).asDriver()).drive()
  }
  
  func stop() {
    disposable = player?.run(cmd: .just(.stop).asDriver()).drive()
  }
  
  func togglePlaying() {
    disposable = player?.run(cmd: .just(.pause).asDriver()).drive()
  }
  
  func seek(toTime: Double) {
    disposable = player?.run(cmd: .just(.seek(seconds: Int(toTime), shouldPlay: true)).asDriver()).drive()
  }
}
