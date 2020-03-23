import UIKit
import Foundation

class Moment: Codable {
	let created_at : String
	let id : Int
	let text : String
	let reposts_count : Int
	let comments_count : Int

	enum CodingKeys: String, CodingKey {
    case created_at = "created_at"
    case id = "id"
    case text = "text"
    case reposts_count = "reposts_count"
    case comments_count = "comments_count"
	}
}

extension Moment {

  init(data: Data) throws {
    self = try JSONDecoder().decode(Moment.self, from: data)
  }

  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
        throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }

  init(fromURL url: URL) throws {
    try self.init(data: try Data(contentsOf: url))
  }

  func jsonData() throws -> Data {
    return try JSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

extension DataRequest {
  fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, response, data, error in
      guard error == nil else { return .failure(error!) }

      guard let data = data else {
        return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
      }

      return Result { try JSONDecoder().decode(T.self, from: data) }
    }
  }

  @discardableResult
  fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
    return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
  }

  @discardableResult
  func responseMoment(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Moment>) -> Void) -> Self {
    return responseDecodable(queue: queue, completionHandler: completionHandler)
  }
}
