extension ShowViewModel {
  init(error: Error) {
    self.init(
      identity: "",
      title: error.localizedDescription,
      date: nil,
      genres: []
    )
  }
}
