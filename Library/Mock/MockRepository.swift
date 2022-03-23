import RxSwift

struct MockRepository: NoodsRepository {
    func shows() -> Single<[Show]> {
      .just([ Show.mock ])
    }
}
