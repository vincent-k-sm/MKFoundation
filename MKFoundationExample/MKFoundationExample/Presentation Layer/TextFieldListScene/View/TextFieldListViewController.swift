// 
// TextFieldListViewController.swift
// 

import Combine
import UIKit
import MKFoundation
import SnapKit

class TextFieldListViewController: BaseViewController<TextFieldListViewModel> {
    
    var cancelables: Set<AnyCancellable> = []
    var isOutLine: Bool = true
    
    lazy var navRightButton: UIButton = {
        let v = UIButton(type: .custom)
        v.setImage(UIImage(systemName: "square.slash"), for: .normal)
        v.setImage(UIImage(systemName: "square.fill"), for: .selected)
        v.tintColor = UIColor.setColorSet(.text_secondary)
        
        v.sizeToFit()
        return v
    }()
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.backgroundColor = .clear
        v.tableFooterView = UITableViewHeaderFooterView()
        v.isScrollEnabled = true
        v.alwaysBounceVertical = true
        v.rowHeight = UITableView.automaticDimension
        v.separatorStyle = .singleLine
        v.removeEventDelay()
        v.registerCell(type: TextFieldListCell.self)
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
        print("\(self) - deinit")
    }
}

extension TextFieldListViewController {
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
        
        self.setNavigationBarButton()
    
    }
    
    private func setNavigationBarButton() {
        self.navRightButton.publisher(for: .touchUpInside)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.rightButtonTapped()
            })
            .store(in: &self.cancelables)
        
        let rightButton = UIBarButtonItem(customView: self.navRightButton)
        self.navigationItem.rightBarButtonItems = [rightButton]
    }
    
    private func rightButtonTapped() {
        self.navRightButton.isSelected.toggle()
        self.isOutLine.toggle()
        self.tableView.reloadData()
    }
}

extension TextFieldListViewController {
    private func bindViewModel() {
        self.viewModel.dataSource = TextFieldListDiffableDataSource(
            tableView: self.tableView,
            cellProvider: { [weak self] (tableView, _, item) in
                guard let self = self else { return UITableViewCell() }
                let cell: UITableViewCell
                let customCell = self.tableView.dequeueCell(withType: TextFieldListCell.self) as! TextFieldListCell
                
                switch item {
                    case let .item(option, status):
                        var op = option
                        op.inputType = self.isOutLine ? .outLine : .fill
                        
                        customCell.mkTextField.configure(option: op)
                        
                        customCell.mkTextField.setTextfieldStatus(status: status)
                }
                cell = customCell
                
                return cell
            })
    }
}

extension TextFieldListViewController {
    private func bindEvent() {

    }
}

extension TextFieldListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView?
        guard let section = SelectBoxStatus(rawValue: section) else { return UIView() }
        let customView = self.tableView.dequeueCell(withType: CommonListHeaderView.self) as! CommonListHeaderView
        customView.titleLabel.text = "\(section.self)"
        view = customView
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = self.viewModel.dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TextFieldListViewController {
    private struct Appearance {
        static let title = "TextField"
    }
}
