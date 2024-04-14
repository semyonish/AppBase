import Foundation

public struct ErrorResponseDefault: Decodable {
}

public enum ApiError<ErrorDescription: Decodable>: Error {
    case urlInvalid
    case apiError(errorDescription: ErrorDescription?)
    
    
    public static func checkStatusCode(_ statusCode: Int?, responseData: Data) throws {
        guard let statusCode = statusCode else {
            throw ApiError.apiError(errorDescription: nil)
        }

        if (statusCode == 200) {
            return
        }
        
        let errorData = try? ApiSettings.jsonDecoder
            .decode(ErrorDescription.self, from: responseData)
        throw ApiError.apiError(errorDescription: errorData)
    }
}

typealias ApiErrorDefault = ApiError<ErrorResponseDefault>
