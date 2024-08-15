import Foundation

class APIClient {
    static let shared = APIClient()

    private init() {}

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.httpResponseNotOK(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch {
            throw NetworkError.requestFailed(description: error.localizedDescription)
        }
    }
    
    func postRequest<T: Decodable, U: Encodable>(to endpoint: Endpoint, body: U) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        urlRequest.httpBody = try JSONEncoder().encode(body)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.httpResponseNotOK(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch {
            throw NetworkError.requestFailed(description: error.localizedDescription)
        }
    }
}
