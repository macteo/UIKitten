//
//  ButtonsTableViewController.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 10/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import Afflato

class ButtonsTableViewController: UITableViewController {
    let types : [ButtonType] = [.normal, .info, .warning, .success, .danger, .primary, .clean]
    let styles : [Style] = [.normal, .rounded, .dropShadow, .glass]
    let sizes : [Size] = [.extraSmall, .small, .normal, .large]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return types.count
        case 1:
            return styles.count
        case 2:
            return sizes.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Types"
        case 1:
            return "Styles"
        case 2:
            return "Sizes"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // FIXME: this won't work for multiline buttons
        guard let button = button(indexPath: indexPath) else { return 0 }
        return button.bounds.size.height + 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        guard let button = button(indexPath: indexPath) else { return cell }
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.contentView.addSubview(button)
        cell.addConstraint(NSLayoutConstraint(item: cell.contentView, attribute: .top, relatedBy: .equal, toItem: button, attribute: .top, multiplier: 1, constant: -4))
        cell.addConstraint(NSLayoutConstraint(item: cell.contentView, attribute: .leading, relatedBy: .equal, toItem: button, attribute: .leading, multiplier: 1, constant: -20))
        cell.addConstraint(NSLayoutConstraint(item: cell.contentView, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: button, attribute: .trailing, multiplier: 1, constant: 20))
        return cell
    }
    
    func button(indexPath: IndexPath) -> Button? {
        let button = Button(frame: CGRect(x: 20, y: 4, width: 100, height: 20))
        
        switch indexPath.section {
        case 0:
            button.type = types[indexPath.row]
            button.setTitle("\(button.type.rawValue.capitalized)", for: .normal)
            break
        case 1:
            button.style = styles[indexPath.row]
            button.type = types[indexPath.row]
            button.setTitle("\(button.style.rawValue.capitalized)", for: .normal)
            if indexPath.row == 0 {
                button.multiline = true
                button.setTitle("\(button.style.rawValue.capitalized) and also a multiline button is supported that will adapt automatically whenever is needed", for: .normal)
            }
            break
        case 2:
            button.size = sizes[indexPath.row]
            button.setTitle("\(button.size.rawValue.uppercased())", for: .normal)
            break
        default:
            break
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
}
