// 
// CheckBoxListViewController.swift
// 

import Combine
import UIKit
import MKFoundation
import SnapKit

class CheckBoxListViewController: BaseViewController<CheckBoxListViewModel> {

    var cancelables: Set<AnyCancellable> = []
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.backgroundColor = .clear
        v.tableFooterView = UITableViewHeaderFooterView()
        v.isScrollEnabled = true
        v.alwaysBounceVertical = true
        v.rowHeight = UITableView.automaticDimension
        v.separatorStyle = .singleLine
        v.removeEventDelay()
        v.registerCell(type: CheckBoxListCell.self)
        v.registerCell(type: CommonListHeaderView.self)
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.bindViewModel()
        self.viewModel.viewDidLoad()
        self.bindEvent()

    }

    deinit {
        print("\(self) -- deinit")
    }
}

extension CheckBoxListViewController {
    private func setUI() {
        self.view.backgroundColor = UIColor.setColorSet(.background)
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.setNavigationBar()
    }
    
    private func setNavigationBar() {
        let color = UIColor.setColorSet(.background_elevated)
        let tintColor = UIColor.setColorSet(.background_tint)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [.foregroundColor: tintColor]
        
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        
        self.navigationController?.navigationBar.backgroundColor = color
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
        
        self.title = Appearance.title
        
    }
}

extension CheckBoxListViewController {
    private func bindViewModel() {
        self.viewModel.dataSource = CheckBoxListDiffableDataSource(
            tableView: self.tableView,
            cellProvider: { [weak self] (tableView, _, item) in
                guard let self = self else { return UITableViewCell() }
                let cell: UITableViewCell
                let customCell = self.tableView.dequeueCell(withType: CheckBoxListCell.self) as! CheckBoxListCell
                
                switch item {
                    case let .item(option):
                        let op = option
                        customCell.mkCheckBox.configure(option: op)
                    
                }
                cell = customCell
                
                return cell
            })
    }
}

extension CheckBoxListViewController {
    private func bindEvent() {

    }
}

extension CheckBoxListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = self.viewModel.dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CheckBoxListViewController {
    private struct Appearance {
        static let title = "Check Box"
    }
}
