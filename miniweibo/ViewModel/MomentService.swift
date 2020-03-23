import Alamofire

protocol MomentServiceProtocol: class {
    func fetchMoments()
    func fetchMomentDetail(_ id: String)
}

final class MomentService: MomentServiceProtocol {
    let endpoint = "http://localhost:3000"

    func fetchMoments() {
        AF.request("\(endpoint)/moments").response {
            response in print(response)
        }
    }

    func fetchMomentDetail(_ id: String) {
        AF.request("\(endpoint)/moments/\(id)").response {
            response in print(response)
        }
    }
}
