//
//  TableController.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 13/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

open class TableController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BaseCollectionViewCellDelegate {
    // TODO: use a more solid approach
    var selectedCellIndex : IndexPath?
    
    internal func redraw(cell: BaseCollectionViewCell) {
        /*
        guard let _ = collectionView?.indexPath(for: cell) else { return }
        
        layout.invalidateLayout()
        
        collectionView?.performBatchUpdates({
            
        }, completion: { (completed) in
            
        })
         */
    }

    let layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView?
    
    public var items : [[ListItem]]?
    
    var nextSize : CGSize?
    var nextSizeWidthOffset : CGFloat?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        collectionView.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        if #available(iOS 10, *) { } else {
            // Only for iOS 8 and 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.invalidateLayout()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = items else { return 0 }
        guard items.count > section else { return 0 }
        let itemsInSection = items[section]
        return itemsInSection.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let items = items else { return 0 }
        let sections =  items.count
        return sections
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = item(indexPath) else { return UICollectionViewCell() }
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ThumbnailCollectionViewCell
        var width = collectionView.bounds.size.width
        if let nextSize = nextSize {
            width = nextSize.width
        }
        cell = populate(cell: cell, item: item, indexPath: indexPath, width: width)

        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = item(indexPath) else { return CGSize(width: 0, height: 0) }
        
        var cell = ThumbnailCollectionViewCell(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: 100))
        
        var width = collectionView.bounds.size.width
        if let nextSize = nextSize {
            width = nextSize.width
        }

        var previousContainer : UIView?
        if let container = item.itemView()?.superview {
            previousContainer = container
        }
        
        cell = populate(cell: cell, item: item, indexPath: indexPath, width: width)
        let size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize, withHorizontalFittingPriority:UILayoutPriorityDefaultLow, verticalFittingPriority: UILayoutPriorityDefaultLow)
        
        if let container = previousContainer {
            if let itemView = item.itemView() {
                container.addSubview(itemView)
                itemView.configureAlignConstraints()
            }
        }
        return size
    }
    
    func populate(cell: ThumbnailCollectionViewCell, item: ListItem, indexPath: IndexPath, width: CGFloat) -> ThumbnailCollectionViewCell {
        cell.title = item.itemTitle()
        cell.subtitle = item.itemSubtitle()
        cell.thumbnail = item.itemImage()
        cell.desiredSize = CGSize(width: width, height: 44)
        
        cell.delegate = self
        
        if indexPath == selectedCellIndex {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        
        // TODO: show accessory view if an action is present in the Item
        if indexPath.section % 2 == 0 {
            cell.accessoryViewIsVisible = true
        }

        cell.containedView = item.itemView()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        nextSize = size
        if let nextSizeWidthOffset = nextSizeWidthOffset {
            nextSize!.width = nextSize!.width + nextSizeWidthOffset
        }
        guard let collectionView = collectionView else { return }
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func item(_ indexPath: IndexPath) -> ListItem? {
        guard let items = items else { return nil }
        guard items.count > indexPath.section else { return nil }
        let itemsInSection = items[indexPath.section]
        guard itemsInSection.count > indexPath.row else { return nil }
        let item = itemsInSection[indexPath.row]
        return item
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath
        guard let item = item(indexPath) else { return }
        if let action = item.itemAction() {
            guard let cell = collectionView.cellForItem(at: indexPath) as? BaseCollectionViewCell else {
                action(nil, true)
                return
            }
            redraw(cell: cell)
            action(cell, true)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedCellIndex = nil
        guard let item = item(indexPath) else { return }
        if let action = item.itemAction() {
            guard let cell = collectionView.cellForItem(at: indexPath) as? BaseCollectionViewCell else {
                action(nil, false)
                return
            }
            redraw(cell: cell)
            action(cell, false)
        } else {
            
        }
    }
}
