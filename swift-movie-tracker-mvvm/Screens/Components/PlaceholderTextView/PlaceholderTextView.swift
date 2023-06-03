//
//  PlaceholderTextView.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 3.06.2023.
//

import UIKit

class PlaceholderTextView: UIView {
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        let xibView = Bundle.main.loadNibNamed("PlaceholderTextView", owner: self)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
    
    func setup(text: String, image: String? = "info.circle") {
        self.textLabel.text = text
        guard let imageName = image else { return }
        iconImage.image = UIImage(systemName: imageName)
    }
}
