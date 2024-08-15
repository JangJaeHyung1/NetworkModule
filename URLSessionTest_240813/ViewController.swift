//
//  ViewController.swift
//  URLSessionTest_240813
//
//  Created by jh on 8/13/24.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: NetworkViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            viewModel = NetworkViewModel(apiService: NetworkService())
            await viewModel.loadData(numOfRows: 5, pageNo: 1) // 필요한 파라미터 값으로 호출
        }
    }
}

