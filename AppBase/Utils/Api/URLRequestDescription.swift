import Foundation

extension URLRequest {
    public func logDescription() -> String {
        return "\n" +
        "URL REQUEST\n" +
        "METHOD: \(httpMethod.debugDescription)\n" +
        "URL: \(url?.debugDescription ?? "-")\n" +
        "HEADERS \n\(allHTTPHeaderFields?.debugDescription ?? "")\n" +
        "BODY \n\(String(decoding: httpBody ?? Data(), as: UTF8.self))\n"
    }
}
