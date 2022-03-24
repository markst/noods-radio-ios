import Foundation
import Moya

enum PanelApi {
  case home
  case shows
  case collections
  case donate
  case info
  case latest
  case guests
  case residents
  case featured(page: Int)
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
    case .home:
      return "home.json"
    case .collections:
      return "collectionsjson"
    case .donate:
      return "donate.json"
    case .info:
      return "info.json"
    case .latest:
      return "latest.json"
    case .guests:
      return "guests.json"
    case .residents:
      return "residents.json"
    case .featured(let page):
      return "shows/featured.json/page:\(page)"
    case .show(let id):
      return "shows/\(id).json"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .home, .shows, .collections, .donate, .info, .latest, .guests, .residents, .featured, .show:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case .home, .shows, .collections, .donate, .info, .latest, .guests, .residents, .featured, .show:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .home, .shows, .collections, .donate, .info, .latest, .guests, .residents, .featured, .show:
      return ["Content-type": "application/json"]
    }
  }
}
