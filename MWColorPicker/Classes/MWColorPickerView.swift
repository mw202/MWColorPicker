//
//  MWColorPickerView.swift
//  MWColorPicker_Example
//
//  Created by LiYing on 2024/5/29.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public protocol MWColorPickerViewDataSource: NSObjectProtocol {
    
    /// 显示选择框
    /// - Parameter view: MWColorPickerView
    func colorPickerViewShowSelectBox(_ view: MWColorPickerView) -> MWColorPickerSelectBoxStyle?
}

public protocol MWColorPickerViewDelegate: NSObjectProtocol {
    
    /// 选择了项目
    /// - Parameters:
    ///   - view: MWColorPickerView
    ///   - didSelectAt: Int
    ///   - color: String
    func colorPickerView(_ view: MWColorPickerView, didSelectAt index: Int, color: String)
}

// MARK: -

public class MWColorPickerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public typealias Block = (_ view: MWColorPickerView, _ selected: Int, _ color: String) -> Void
    
    public weak var dataSource: MWColorPickerViewDataSource?
    public weak var delegate: MWColorPickerViewDelegate?
    
    private let column: CGFloat = 10
    
    private var _datas: [String]? = []
    public private (set) var selectedIndex: Int = -1
    public private (set) var selectedColor: String?
    private var _block: Block?
    
    private lazy var collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = .zero
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        
        return collection
    }()
    
    // MARK: -
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = self.bounds
    }
    
    // MARK: -
    
    func setupUI() {
        if let file = Bundle.resourceUrl(forClass: Self.self, forBundle: "MWColorPicker", forResource: "colors", withExtension: "plist") {
            _datas = NSArray(contentsOf: file) as? [String]
        }
        
        collectionView.register(MWColorPickerItemCollectionViewCell.self, forCellWithReuseIdentifier: MWColorPickerItemCollectionViewCell.cellIdentifier)
        
        addSubview(collectionView)
    }
    
    public func bindBlock(selected index: Int, block: Block? = nil) {
        selectedIndex = index
        _block = block
    }
    
    
    // MARK: - Collection view data source
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _datas?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWColorPickerItemCollectionViewCell.cellIdentifier, for: indexPath) as? MWColorPickerItemCollectionViewCell {
            let selected = indexPath.row == selectedIndex
            let style = dataSource?.colorPickerViewShowSelectBox(self)
            cell.setCell(UIColor.hex(_datas?[indexPath.row] ?? "#"), selected, style)
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Collection view delegate
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        selectedIndex = indexPath.row
        
        collectionView.reloadData()
        
        selectedColor = _datas?[indexPath.row] ?? "#"
        delegate?.colorPickerView(self, didSelectAt: indexPath.row, color: selectedColor!)
        
        _block?(self, indexPath.row, selectedColor!)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        let sectionInset = layout?.sectionInset ?? .zero
        let size = collectionView.frame.size
        var width: CGFloat = (size.width - sectionInset.left - sectionInset.right)
        width = width - (column - 1) * (layout?.minimumInteritemSpacing ?? 0)
        width = (width / column).truncate(places: 2)
        let row = ceil(CGFloat(_datas?.count ?? 0) / column)
        var height = (size.height - sectionInset.top - sectionInset.bottom)
        height = height - CGFloat(row - 1) * (layout?.minimumLineSpacing ?? 0)
        height = (height / row).truncate(places: 2)
        
        return CGSize(width: width, height: height)
    }
}
