import Alamofire
import Foundation

struct MomentService {
	static let shared = MomentService()

  let endpoint = "http://localhost:3000"

  func requestFetchMoments(completion: @escaping (Moment?, Error?) -> ()) {
    Alamofire.request("\(endpoint)/moments").responseMoment { response in
      if let error = response.error {
        completion(nil, error)
        return
      }
      if let moment = response.result.value {
        completion(moment, nil)
        return
      }
    }
  }

  func requestFetchMomentsById(with id: Int, completion: @escaping (Moment?, Error?) -> ()) {
    Alamofire.request("\(endpoint)/moments/\(id)").responseMoment { response in
      if let error = response.error {
        completion(nil, error)
        return
      }
      if let moment = response.result.value {
        completion(moment, nil)
        return
      }
    }
  }
}
