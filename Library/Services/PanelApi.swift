import Foundation
import Moya

enum PanelApi {
  case shows
  case show(id: String)
}

extension PanelApi: TargetType {
  var baseURL: URL {
    URL(string: "https://panel.noodsradio.com")!
  }

  var path: String {
    switch self {
    case .shows:
      return "shows.json"
    case .show(let id):
      return "\(id).json"
    }
  }

  var method: Moya.Method {
    switch self {
    case .shows, .show:
      return .get
    }
  }

  var task: Task {
    switch self {
    case .shows, .show:
      return .requestPlain
    }
  }

  var headers: [String : String]? {
    switch self {
    case .shows, .show:
      return ["Content-type": "application/json"]
    }
  }
}
