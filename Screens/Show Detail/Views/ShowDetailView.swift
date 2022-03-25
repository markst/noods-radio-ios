import UIKitPlus

class ShowDetailView: UView {
  
  var refreshControl: URefreshControl = URefreshControl()
  var viewModel: ShowDetailProtocol?
  let playButton = LoadingButton()
  
  @UState var show: ShowViewModel?
  
  override func buildView() {
    super.buildView()
    
    body {
      UScrollView() {
        UVStack {
          UView() {
            UImage(url: $show.map({ $0?.image }))
              .background(.gray)
              .mode(.scaleAspectFill)
              .edgesToSuperview()
            UView() {
              UHStack() {
                UView() {
                  playButton
                    .image(.play)
                    .centerInSuperview(x: 4, y: 0)
                }
                .aspectRatio()
                .circle()
                .background(.black)
                .height(60)
                UVStack {
                  UText($show.map({ $0?.title ?? "" }))
                    .font(.hkGroteskBold, 18)
                    .multiline()
                    .alignment(.left)
                    .color(0x000000)
                    .compressionResistance(y: .required)
                  UText($show.map({ $0?.date ?? "" }))
                    .font(.hkGroteskBold, 14)
                    .lines(1)
                    .alignment(.left)
                    .color(0x828282)
                    .compressionResistance(y: .required)
                  UCollection(LeftAlignedCollectionViewFlowLayout()
                    .estimatedItemSize(18, 18)
                    .scrollDirection(.vertical)
                    .minimumLineSpacing(4)
                    .minimumInteritemSpacing(6)
                    .sectionInset(0)) {
                      UForEach($show.map({ $0?.genres ?? [] })) {
                        GenreTagCell($0)
                      }
                    }
                    .scrollEnabled(false)
                    .height(>=30)
                }
                .spacing(6)
              }
              .spacing(10)
              .edgesToSuperview(10)
              .alignment(.center)
            }
            .background(.white)
            .corners(4, [.topLeft, .topRight])
            .shadow(.black, opacity: 0.2, x: 0, y: 0, radius: 6)
            .height(>=96)
            .edgesToSuperview(leading: 20, trailing: -20, bottom: 0)
          }
          .compressionResistance(y: .required)
          .masksToBounds()
          .aspectRatio()
          // Description
          UView() {
            UText($show.map { $0?.descriptio ?? "No Description" })
              .color(.black)
              .font(.hkGroteskRegular, 16)
              .multiline()
              .alignment(.left)
              .compressionResistance(y: .required)
              .edgesToSuperview(top: 20, leading: 20, trailing: -20, bottom: -30)
            UView()
              .height(1)
              .background(.black)
              .edgesToSuperview(leading: 20, trailing: -20, bottom: 0)
          }
          .hidden($show.map { $0?.descriptio?.string.isEmpty == true })
          // Tracklist:
          UView() {
            UVStack() {
              UText("Artist — Track Name")
                .font(.neueMachinaLight, 18)
                .compressionResistance(y: .required)
              UText($show.map { $0?.tracklist ?? .init(string: "No Tracklist :(") })
                .color(0x666666)
                .font(.hkGroteskRegular, 14)
                .multiline()
                .alignment(.left)
                .compressionResistance(y: .required)
              UView()
                .height(1)
                .background(.black)
            }
            .spacing(20)
            .edgesToSuperview(20)
          }
          .hidden($show.map { $0?.tracklist?.string.isEmpty == true })
        }
        .spacing(10)
        .widthToSuperview(multipliedBy: 1.0, priority: .defaultHigh)
        .edgesToSuperview()
      }
      .background(.white)
      .refreshControl(refreshControl.onRefresh { [unowned self] in
        viewModel?.refresh.accept(())
      })
      .edgesToSuperview()
    }
  }
  
  // MARK: Functions

  func display(_ error: Error) {
    body {
      UText(error.localizedDescription)
        .centerInSuperview()
    }
  }
}

#if canImport(SwiftUI)

import SwiftUI

extension ShowDetailView: Then { }

@available(iOS 13.0, *)
struct ShowDetailView_Preview: PreviewProvider, DeclarativePreview {
  static var preview: Preview {
    Preview {
      ShowDetailView(frame: .init(x: 0, y: 0, width: 320, height: 320))
        .do({ $0.show = .init(show: ShowDetail.mock) })
        .background(.red)
        .edgesToSuperview()
    }
    .colorScheme(.light)
    .device(.iPhoneX)
    .language(.en)
  }
}

#endif
