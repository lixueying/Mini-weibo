import Foundation

class MomentViewModel {

	private var moment: Moment? {
    didSet {
      guard let m = moment else { return }
      self.setupText(with: m)
      self.didFinishFetch?()
    }
	}
  var error: Error? {
    didSet { self.showAlertClosure?() }
  }
  var isLoading: Bool = false {
    didSet { self.updateLoadingStatus?() }
  }

  var createdAtString: String?
  var idString: Int?
  var textString: String?

  private var momentService: MomentService?

  var showAlertClosure: (() -> ())?
  var updateLoadingStatus: (() -> ())?
  var didFinishFetch: (() -> ())?

  init(momentService: MomentService) {
    self.momentService = momentService
  }

  func fetchMoments() {
    self.momentService?.requestFetchMoments(completion: { (moment, error) in
      if let error = error {
        self.error = error
        self.isLoading = false
        return
      }
      self.error = nil
      self.isLoading = false
      self.moment = moment
    })
  }

  private func setupText(with moment: Moment) {
    if let created_at = moment.created_at, let id = photo.id, let text = photo.text {
      self.createdAtString = "Created_at: \(created_at)"
      self.idString = "Moment ID : \(id)"
      self.text = text
    }
  }
}
