//
//  APIService.swift
//  URLSessionTest_240813
//
//  Created by jh on 8/14/24.
//

import Foundation

protocol APIService {
    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T
    func postData<T: Decodable, U: Encodable>(to endpoint: Endpoint, body: U) async throws -> T
    // func deleteData(from endpoint: Endpoint) async throws
}
