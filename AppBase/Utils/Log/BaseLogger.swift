import Foundation
import OSLog

public class BaseLogger {
    private let logger: Logger
    
    public init(subsystem: String, category: String) {
        self.logger = Logger(subsystem: subsystem, category: category)
    }
    
    public func log(_ messages: String...) {
        self.logger.log("\(messages.joined(separator: " "), privacy: .public)")
    }
    
    public static func responseDescription(
        data: Data?, statusCode: Int?
    ) -> String {
        return "\n" +
        "RESPONSE\n" +
        "Code: \(statusCode ?? -1)\n" +
        "DATA\n\(String(data: data ?? Data(), encoding: .utf8).debugDescription)\n"
    }
}
