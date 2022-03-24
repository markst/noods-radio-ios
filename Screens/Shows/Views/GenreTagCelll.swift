import UIKitPlus

class GenreTagCell: UView {
  let genre: String
  
  init (_ genre: String) {
    self.genre = genre
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func buildView() {
    super.buildView()
    body {
      UView() {
        UText(genre)
          .color(0x828282)
          .edgesToSuperview(4)
          .font(.hkGroteskSemiBold, 10)
      }
      .corners(2, [])
      .border(0.5, 0x828282)
      .edgesToSuperview()
    }
  }
}
