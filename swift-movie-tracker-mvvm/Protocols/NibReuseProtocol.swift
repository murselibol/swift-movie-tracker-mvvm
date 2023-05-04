//
//  NibReuseProtocol.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import UIKit

public protocol NibProtocol: AnyObject {
    static var nib: UINib { get }
}

public extension NibProtocol {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

public protocol ReuseProtocol {
    static var reuseIdentifier: String { get }
    var reuseIdentifier: String { get }
}

public extension ReuseProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    var reuseIdentifier: String {
        return type(of: self).reuseIdentifier
    }
}


