extension ShowViewModel {
  internal init(error: Error) {
    self.init(
      identity: "",
      title: error.localizedDescription,
      date: nil,
      genres: []
    )
  }
}
