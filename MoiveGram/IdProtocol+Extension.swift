//
//  IdProtocol+Extension.swift
//  MoiveGram
//
//  Created by 김상규 on 6/10/24.
//

import UIKit

protocol IdProtocol {
    static var id: String { get }
}

extension UIView: IdProtocol {
    static var id: String {
        String(describing: self)
    }
}
