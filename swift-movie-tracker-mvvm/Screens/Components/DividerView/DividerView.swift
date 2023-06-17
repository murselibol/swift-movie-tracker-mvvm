//
//  DividerView.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 17.06.2023.
//

import UIKit

final class DividerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        let xibView = Bundle.main.loadNibNamed("DividerView", owner: self)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
}
