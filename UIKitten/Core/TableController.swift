//
//  TableController.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 13/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

open class TableController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CellDelegate {
    // TODO: use a more solid approach
    var selectedCellIndex : IndexPath?
    
    open var columns : Int = 1
    
    public func redraw(cell: Cell) {
        /*
         guard let _ = collectionView?.indexPath(for: cell) else { return }
         
         layout.invalidateLayout()
         
         collectionView?.performBatchUpdates({
         
         }, completion: { (completed) in
         
         })
         */
    }
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    fileprivate var initialTargetPosition = CGPoint(x: 0, y: 0)
    fileprivate var reordering : Bool = false
    
    fileprivate var sizes = [Int : CGSize]()
    fileprivate let sizePadding = 1_000_000_000
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 320), collectionViewLayout: self.layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        self.layout.scrollDirection = .vertical
        self.layout.minimumLineSpacing = 0
        self.layout.minimumInteritemSpacing = 0
        
        collectionView.setCollectionViewLayout(self.layout, animated: false)
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.alwaysBounceVertical = true

        self.longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(TableController.handleLongGesture(_:)))
        collectionView.addGestureRecognizer(self.longPressGesture)
        
        return collectionView
    }()
    
    public func reloadData() {
         sizes.removeAll()
         collectionView.reloadData()
         layout.invalidateLayout()
    }
    
    @objc func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case .began:
            reordering = true
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            if let cell = collectionView.cellForItem(at: selectedIndexPath) {
                let locationInCell = gesture.location(in: cell)
                initialTargetPosition = CGPoint(x: locationInCell.x - cell.bounds.size.width / 2, y: locationInCell.y - cell.bounds.size.height / 2)
            }
            
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            let gestureLocation = gesture.location(in: gesture.view!)
            let point = CGPoint(x: gestureLocation.x - initialTargetPosition.x, y: gestureLocation.y - initialTargetPosition.y)
            collectionView.updateInteractiveMovementTargetPosition(point)
        case .ended:
            reordering = false
            collectionView.endInteractiveMovement()
        default:
            reordering = false
            collectionView.cancelInteractiveMovement()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard items != nil else { return }
        
        if reordering == false {
            let item = items![sourceIndexPath.section].remove(at: sourceIndexPath.item)
            items![destinationIndexPath.section].insert(item, at: destinationIndexPath.item)
            return
        }
        
        let itemSize = sizes[sizePosition(indexPath: sourceIndexPath)]
        let destinationItemSize = sizes[sizePosition(indexPath: destinationIndexPath)]
        sizes[sizePosition(indexPath: sourceIndexPath)] = destinationItemSize
        sizes[sizePosition(indexPath: destinationIndexPath)] = itemSize
    }
    
    public var items : [[ListItem]]? {
        didSet {
            guard let items = items else {
                collectionView.reloadData()
                return
            }
            for section in items {
                for item in section {
                    guard let cellType = item.cellType().cellClass as? UICollectionViewCell.Type else { continue }
                    collectionView.register(cellType, forCellWithReuseIdentifier: item.cellType().identifier)
                }
            }
            // sizes.removeAll()
            // collectionView.reloadData()
            // layout.invalidateLayout()
        }
    }
    
    var nextSize : CGSize?
    var nextSizeWidthOffset : CGFloat?
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        collectionView.frame = view.bounds
        view.addSubview(collectionView)

        if #available(iOS 10, *) { } else {
            // Only for iOS and 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layout.itemSize = CGSize(width: view.bounds.width / CGFloat(columns), height: view.bounds.height)
        
        deselectAll()
    }
    
    func deselectAll() {
        guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
        for indexPath in indexPaths {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func contentSizeDidChange(notification: Notification) {
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
    
    var desiredCellWidth : CGFloat {
        var width = collectionView.bounds.size.width / CGFloat(columns)
        if let nextSize = nextSize {
            width = nextSize.width / CGFloat(columns)
        }
        return floor(width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = item(indexPath) else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellType().identifier, for: indexPath) as! Cell
        cell.populate(item: item, width: desiredCellWidth)

        assert((cell as? UICollectionViewCell) != nil, "\(cell.self) must be a UICollectionViewCell subclass")
        
        return cell as! UICollectionViewCell
    }
    
    fileprivate func sizePosition(indexPath: IndexPath) -> Int {
        let sizeIndex = indexPath.section * sizePadding + indexPath.item
        return sizeIndex
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var _item : ListItem?
        
        if let __item = item(indexPath) {
            _item = __item
        } else if reordering == true {
            var previousIndexPath = indexPath
            previousIndexPath.item -= 1
            if let __item = item(previousIndexPath) {
                _item = __item
            }
        }
        
        guard let item = _item else {
            return CGSize(width: desiredCellWidth, height: 44)
        }
        
        
        if let size = sizes[sizePosition(indexPath: indexPath)] {
            return size
        }
        
        var cell : Cell?
        
        var previousContainer : UIView?
        var cellIsAlreadyVisible = false
        if let existingCell = collectionView.cellForItem(at: indexPath) as? Cell {
            cellIsAlreadyVisible = true
            cell = existingCell
        } else {
            cell = item.cellType().cellClass.init(frame: CGRect(x: 0, y: 0, width: desiredCellWidth, height: 2048))
            
            if let container = item.itemView()?.superview {
                previousContainer = container
            }
        }
        guard var tempCell = cell else {
            return CGSize(width: desiredCellWidth, height: 44)
        }
        
        if cellIsAlreadyVisible == false {
            tempCell.populate(item: item, width: desiredCellWidth)
        } else {
            tempCell.desiredSize = CGSize(width: desiredCellWidth, height: 44)
        }
        
        let size = tempCell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority:UILayoutPriority.defaultLow, verticalFittingPriority: UILayoutPriority.defaultLow)

        if cellIsAlreadyVisible == false {
            if let container = previousContainer {
                if let itemView = item.itemView() {
                    container.addSubview(itemView)
                    itemView.configureAlignConstraints()
                }
            }
        }
        
        sizes[sizePosition(indexPath: indexPath)] = size
        
        return size
    }
    
    open override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        sizes.removeAll()
        collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        sizes.removeAll()
        
        nextSize = size
        if let nextSizeWidthOffset = nextSizeWidthOffset {
            nextSize!.width = nextSize!.width + nextSizeWidthOffset
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func item(_ indexPath: IndexPath) -> ListItem? {
        guard let items = items else { return nil }
        guard items.count > indexPath.section else { return nil }
        let itemsInSection = items[indexPath.section]
        guard itemsInSection.count > indexPath.item else { return nil }
        let item = itemsInSection[indexPath.item]
        return item
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath
        guard let item = item(indexPath) else { return }
        if let action = item.itemAction() {
            guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else {
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
            guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else {
                action(nil, false)
                return
            }
            redraw(cell: cell)
            action(cell, false)
        } else {
            
        }
    }
}

extension UICollectionViewFlowLayout {
    
    open override func invalidationContext(forInteractivelyMovingItems targetIndexPaths: [IndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [IndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContext(forInteractivelyMovingItems: targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        
        guard let collectionView = collectionView else { return context }
        collectionView.dataSource?.collectionView!(collectionView, moveItemAt: previousIndexPaths[0], to: targetIndexPaths[0])
        
        return context
    }
    
    override open func invalidationContextForEndingInteractiveMovementOfItems(toFinalIndexPaths indexPaths: [IndexPath], previousIndexPaths: [IndexPath], movementCancelled: Bool) -> UICollectionViewLayoutInvalidationContext {

        let context = super.invalidationContextForEndingInteractiveMovementOfItems(toFinalIndexPaths: indexPaths, previousIndexPaths: previousIndexPaths, movementCancelled: movementCancelled)
        
        guard let collectionView = collectionView else { return context }
        collectionView.dataSource?.collectionView!(collectionView, moveItemAt: previousIndexPaths[0], to: indexPaths[0])
        
        return context
    }
}

