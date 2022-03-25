import Foundation
import RxSwift

extension ShowDetailViewModel {

  enum CloudcastError: Error {
    case badURL
    case failedURL
  }

  func cloudcast(with url: URL) throws -> Observable<MixCloudGraphResponse.MixCloudGraphData.Cloudcast?> {
    guard let pathComponents = URLComponents(
      url: url,
      resolvingAgainstBaseURL: false
    )?.path
      .components(separatedBy: "/"), pathComponents.count > 1 else {
      return .error(CloudcastError.badURL)
    }
    guard var newComponents = URLComponents(string: "https://m.mixcloud.com") else {
      return .error(CloudcastError.failedURL)
    }

    newComponents.path = "/graphql"
    newComponents.queryItems = [
      .init(name: "operationName", value: "CodaPlayerItem"),
      .init(name: "query", value: MixCloudQuery.cloudcastLookupQuery),
      .init(name: "variables", value: String(data: try JSONSerialization.data(withJSONObject: [
        "username":(pathComponents[1]),
        "slug":(pathComponents[2])
      ], options: []), encoding: .utf8))
    ]

    return URLSession.shared.rx
      .data(request: .init(url: newComponents.url!))
      .debug()
      .map({ try JSONDecoder().decode(MixCloudGraphResponse.self, from: $0) })
      .map({ $0.data.cloudcastLookup })
  }
}
