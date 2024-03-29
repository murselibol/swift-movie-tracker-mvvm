//
//  FilterTableCell.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 8.05.2023.
//

import UIKit

final class FilterTableCell: UITableViewCell, NibProtocol, ReuseProtocol {
    @IBOutlet private weak var filterItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(item: FilterModel) {
        filterItemLabel.text = item.title
    }
}
