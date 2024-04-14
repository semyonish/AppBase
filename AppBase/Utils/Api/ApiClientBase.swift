import Foundation
import OSLog


@MainActor
open class ApiClientBase {
    private let baseUrl: URL
    private let encoder = ApiSettings.jsonEncoder
    private let decoder = ApiSettings.jsonDecoder
    
    private var logger = BaseLogger(subsystem: "baseApp", category: "api")

    public init(baseUrl baseUrlString: String) throws {
        guard let baseUrl = URL(string: baseUrlString) else {
            throw ApiErrorDefault.urlInvalid
        }
        self.baseUrl = baseUrl
    }

    public func post<Request: Encodable, Response: Decodable>(
        route: RequestRoute,
        headers: RequestHeaders,
        request: Request
    ) async throws -> Response {
        return try await sendRequestWithResponse(route: route,
                                                 headers: headers,
                                                 request: request,
                                                 httpMethod: "POST")
    }
    
    public func post<Request: Encodable>(
        route: RequestRoute,
        headers: RequestHeaders,
        request: Request
    ) async throws {
        try await sendRequest(route: route,
                              headers: headers,
                              request: request,
                              httpMethod: "POST")
    }

    public func put<Request: Encodable, Response: Decodable>(
        route: RequestRoute,
        headers: RequestHeaders,
        request: Request
    ) async throws -> Response {
        return try await sendRequestWithResponse(route: route,
                                                 headers: headers,
                                                 request: request,
                                                 httpMethod: "PUT")
    }
    
    public func put<Request: Encodable>(
        route: RequestRoute,
        headers: RequestHeaders,
        request: Request
    ) async throws {
        try await sendRequest(route: route,
                              headers: headers,
                              request: request,
                              httpMethod: "PUT")
    }
    
    public func get<Response: Decodable>(
        route: RequestRoute,
        headers: RequestHeaders
    ) async throws -> Response {
        let request = createRequest(
            url: baseUrl.appendingPathComponent(route.path),
            headers: headers,
            httpMethod: "GET")

        let responseData = try await sendRequest(request)

        return try decoder.decode(Response.self, from: responseData)
    }
    
    public func delete<Request: Encodable>(
        route: RequestRoute,
        headers: RequestHeaders,
        request: Request
    ) async throws {
        try await sendRequest(route: route,
                              headers: headers,
                              request: request,
                              httpMethod: "DELETE")
    }
    
    private func sendRequest<Request: Encodable>(
        route: RequestRoute,
        headers: RequestHeaders,
        request: Request,
        httpMethod: String
    ) async throws {
        let requestData = try encoder.encode(request)
        let request = createRequest(
            url: baseUrl.appendingPathComponent(route.path),
            headers: headers,
            httpMethod: httpMethod,
            httpBody: requestData)

        try await sendRequest(request)
    }
    
    private func sendRequestWithResponse<
        Request: Encodable,
        Response: Decodable
    >(
        route: RequestRoute,
        headers: RequestHeaders,
        request: Request,
        httpMethod: String
    ) async throws -> Response {
        let requestData = try encoder.encode(request)
        let request = createRequest(
            url: baseUrl.appendingPathComponent(route.path),
            headers: headers,
            httpMethod: httpMethod,
            httpBody: requestData)

        let responseData = try await sendRequest(request)

        return try decoder.decode(Response.self, from: responseData)
    }

    private func createRequest(url: URL,
                               headers: RequestHeaders,
                               httpMethod: String,
                               httpBody: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        headers.addHeaders(to: &request)
        return request
    }

    @discardableResult
    private func sendRequest(_ request: URLRequest) async throws -> Data {
        logger.log(request.logDescription())
        
        let (responseData, response) = try await URLSession.shared.data(for: request)
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        
        logger.log(BaseLogger.responseDescription(data: responseData,
                                                  statusCode: statusCode))
        
        try ApiErrorDefault.checkStatusCode(statusCode,
                                            responseData: responseData)

        return responseData
    }
}
