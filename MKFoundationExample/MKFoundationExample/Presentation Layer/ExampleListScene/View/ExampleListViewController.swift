// 
// ExampleListViewController.swift
// 

import UIKit

class ExampleListViewController: BaseViewController<ExampleListViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self) - viewDidLoad")
        self.setUI()
        self.bindViewModel()
        self.viewModel.viewDidLoad()
        self.bindEvent()

    }

    deinit {
        print("\(self) - deinit")
    }
}

extension ExampleListViewController {
    private func setUI() {

    }
}

extension ExampleListViewController {
    private func bindViewModel() {
        
    }
}

extension ExampleListViewController {
    private func bindEvent() {

    }
}


