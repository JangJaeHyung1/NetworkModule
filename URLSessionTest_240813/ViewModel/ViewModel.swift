//
//  ViewModel.swift
//  URLSessionTest_240813
//
//  Created by jh on 8/14/24.
//

import Foundation

class NetworkViewModel {
    private var apiService: APIService
    var data: DataModel?

    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func loadData(numOfRows: Int, pageNo: Int) async {
        guard let decodedKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            print("API Key is not found.")
            return
        }
        
        let queryItems = [
            URLQueryItem(name: "ServiceKey", value: decodedKey),
            URLQueryItem(name: "numOfRows", value: "\(numOfRows)"),
            URLQueryItem(name: "pageNo", value: "\(pageNo)"),
            URLQueryItem(name: "resultType", value: "json")
        ]
        
        let endpoint = Endpoint(path: "6260000/SocialWelfareCenterProgramsService/getProgramInfoList", method: .get, queryItems: queryItems)
        
        do {
            let data: DataModel = try await apiService.fetchData(from: endpoint)
            DispatchQueue.main.async {
                self.data = data
                print("Data loaded successfully: \(data)")
            }
        } catch {
            DispatchQueue.main.async {
                print("Failed to load data: \(error)")
            }
        }
    }
}




class ExampleViewModel {
    private var userService: APIService
    var userData: DataModel?

    init(userService: APIService) {
        self.userService = userService
    }

    func loadUserData() async {
        let endpoint = Endpoint(path: "/users/me", method: .get)
        do {
            let data: DataModel = try await userService.fetchData(from: endpoint)
            self.userData = data
        } catch {
            print("Failed to load user data: \(error)")
        }
    }
}
