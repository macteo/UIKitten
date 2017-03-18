//
//  TableController.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 13/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public protocol ListItem {
    var title: String? { get }
    var subtitle: String? { get }
    var image: UIImage? { get }
    var imageUrl : URL? { get }
    var action : ((_ selected: Bool) -> Void)? { get }
}

public class Title : ListItem {
    public init(_ title: String) {
        self.title = title
    }
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var imageUrl: URL?
    public var action : ((_ selected: Bool) -> Void)?
}

public class TitleAction : ListItem {
    public init(_ title: String, action: @escaping ((_ selected: Bool) -> Void)) {
        self.title = title
        self.action = action
    }
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var imageUrl: URL?
    public var action : ((_ selected: Bool) -> Void)?
}

public class ImageTitleAction : ListItem {
    public init(_ title: String, image: UIImage?, action: @escaping ((_ selected: Bool) -> Void)) {
        self.title = title
        self.image = image
        self.action = action
    }
    
    public init(_ title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }

    public init(_ title: String, subtitle: String, image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }

    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var imageUrl: URL?
    public var action : ((_ selected: Bool) -> Void)?
}

public class TableController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView?
    
    public var items : [[ListItem]]?
    
    var nextSize : CGSize?
    var nextSizeWidthOffset : CGFloat?
    
    override public func viewDidLoad() {
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
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        
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
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        cell.title = item.title
        cell.subtitle = item.subtitle
        cell.image = item.image
        
        if indexPath.section % 2 == 0 {
            cell.accessoryViewIsVisible = true
        }

        return cell
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
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
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.size.width
        if let nextSize = nextSize {
            width = nextSize.width
        }
        var size  = CGSize(width: 10, height: 0)
        guard let item = item(indexPath) else { return size}
        
        let cell = ImageCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        cell.image = item.image
        // FIXME: At the moment is important to use this order
        cell.subtitle = item.subtitle
        cell.title = item.title
        
        if indexPath.section % 2 == 0 {
            cell.accessoryViewIsVisible = true
        }
        
        size = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize, withHorizontalFittingPriority:UILayoutPriorityDefaultLow, verticalFittingPriority: UILayoutPriorityDefaultLow)
        
        return CGSize(width: width, height: size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = item(indexPath) else { return }
        if let action = item.action {
            action(true)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let item = item(indexPath) else { return }
        if let action = item.action {
            action(false)
        }
    }
}
