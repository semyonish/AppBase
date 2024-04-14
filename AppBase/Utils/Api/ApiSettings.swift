import Foundation

final class ApiSettings {
    public static var jsonEncoder: JSONEncoder {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        return jsonEncoder
    }

    public static var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }
}
