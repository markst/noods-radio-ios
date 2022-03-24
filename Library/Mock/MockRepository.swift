import RxSwift

struct MockRepository: NoodsRepository {
  func shows() -> Single<[Show]> {
    .just([ Show.mock ])
  }
  func showDetail(id: String) -> Single<ShowDetail> {
    .just(ShowDetail.mock)
  }
}
