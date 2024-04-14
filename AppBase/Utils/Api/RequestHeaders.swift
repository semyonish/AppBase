import Foundation

public class RequestHeaders {
    private let headers: Dictionary<String, String>;
    
    public init(headers: Dictionary<String, String>) {
        self.headers = headers
    }
    
    public func addHeaders(to request: inout URLRequest) {
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
}
