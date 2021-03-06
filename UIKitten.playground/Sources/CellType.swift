//
//  CellType.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import Foundation

public enum CellType {
    case base
    case title
    case subtitle
    case thumbnail
    case view
    case value
    case custom(identifier: String, type: Cell.Type)
    
    var cellClass : Cell.Type {
        switch self {
        case .base:
            return BaseCell.self
        case .value:
            return CounterCell.self
        case .title, .subtitle, .thumbnail, .view:
            return SubtitleCell.self
        case .custom( _, let type):
            return type
        }
    }
    
    var identifier : String {
        switch self {
        case .base:
            return "baseCell"
        case .value:
            return "valueCell"
        case .title, .subtitle, .thumbnail, .view:
            return "subtitleCell"
        case .custom(let identifier, _):
            return identifier
        }
    }
}
