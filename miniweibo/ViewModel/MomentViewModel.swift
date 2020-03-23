struct MomentViewModel {
    weak var dataSource : GenericDataSource<Moment>?

    init(dataSource:  GenericDataSource<Moment>?) {
        self.dataSource = dataSource
    }

    func fetchMoments() {
        MomentService.shared.fetchMoments { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let moment) :
                    self.dataSource?.data.value = moment.data
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    break
                }
            }
        }
    }
}
