//
//  NetworkService.swift
//  URLSessionTest_240813
//
//  Created by jh on 8/14/24.
//

import Foundation


class NetworkService: APIService {
    func fetchData<T>(from endpoint: Endpoint) async throws -> T where T : Decodable {
        try await APIClient.shared.request(endpoint)
    }
    func postData<T: Decodable, U: Encodable>(to endpoint: Endpoint, body: U) async throws -> T {
            try await APIClient.shared.postRequest(to: endpoint, body: body)
        }
}

