// 
// ExampleListViewModel.swift
// 

import Combine
import Foundation

struct ExampleListViewModelInput {
    
}

struct ExampleListViewModelAction {
    let moveToFoundationList: (_ type: FoundationTypes) -> Void
}

class ExampleListViewModel: BaseViewModel<ExampleListViewModelInput, ExampleListViewModelAction> {
 
    // MARK: - Private Properties
    var cancellable: Set<AnyCancellable> = []
    var dataSource: ExampleListDiffableDataSource!
    
    
    // MARK: - Publish
    let didSelectedItem = PassthroughSubject<ExampleListCellTypes, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViewModel()
        self.setEvent()
        self.setData()
        
    }
    
    private func prepareViewModel() {
     
    }
    
    deinit {
        print("\(self) - deinit")
    }
}

// MARK: - Event
extension ExampleListViewModel {
    private func setEvent() {
        self.didSelectedItem
            .sink(receiveValue: { [weak self] item in
                guard let self = self else { return }
                switch item {
                    case let .item(foundation):
                        self.actions.moveToFoundationList(foundation)
                        
                }
            })
            .store(in: &self.cancellable)
    }
}

// MARK: - Data
extension ExampleListViewModel {
    private func setData() {
        self.fetchItems()
    }
    
    private func fetchItems() {
        self.dataSource.initSnapShot()
        self.dataSource.snapshot.appendSections([.default])
        self.addItems()
        self.dataSource.apply(animated: false)
    }
    
    private func addItems() {
        var cells: [ExampleListCellTypes] = []
        FoundationTypes.allCases.forEach {
            cells.append(.item(foundation: $0))
        }
        self.dataSource.snapshot.appendItems(cells, toSection: .default)
    }
}

