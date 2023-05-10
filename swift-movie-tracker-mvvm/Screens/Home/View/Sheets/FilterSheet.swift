//
//  FiterSheet.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 8.05.2023.
//

import UIKit

protocol FilterSheetInterface: AnyObject {
    func configureTableView()
}

final class FilterSheet: UIViewController {

    @IBOutlet private weak var filterTableView: UITableView!
    
    lazy var viewModel = FilterVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension FilterSheet: FilterSheetInterface {
    func configureTableView() {
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.registerCell(type: FilterTableCell.self)
    }
}

//MARK: - TableViewDelegate
extension FilterSheet: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filterItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilterTableCell = filterTableView.dequeueCell(for: indexPath)
        let filterItem = viewModel.filterItems[indexPath.row]
        cell.setup(item: filterItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            self?.viewModel.tableDidSelectRow(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}

