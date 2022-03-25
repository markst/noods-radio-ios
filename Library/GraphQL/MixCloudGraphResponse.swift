import Foundation

struct MixCloudGraphResponse: Decodable {
  struct MixCloudGraphData: Decodable {
    struct Cloudcast: Decodable {
      struct StreamInfo: Decodable {
        var dashUrl: Data?
        var hlsUrl: Data?
        var url: Data?
      }
      struct Picture: Decodable {
        var urlRoot: String?
      }
      
      var streamInfo: StreamInfo
      var picture: Picture
      var audioLength: Int?
    }
    var cloudcastLookup: Cloudcast
  }
  var data: MixCloudGraphData
}

struct MixCloudQuery {
  static let cloudcastLookupQuery: String = """
  query CodaPlayerItem($username: String!, $slug: String!) {
    cloudcastLookup(lookup: {username: $username, slug: $slug}) {
      __typename
      id
      audioLength
      streamInfo {
        __typename
        dashUrl
        hlsUrl
        url
      }
      picture {
        __typename
        urlRoot
      }
    }
  }
  """
}
