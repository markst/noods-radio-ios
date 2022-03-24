import Foundation

struct Resident : Codable {
  let id : String?
  let title : String?
  let residenttag : String?
  let about : Description?
  let aboutSanitized : String?
  let image : String?
}
