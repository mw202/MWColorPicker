//
//  MWColorPickerItemCollectionViewCell.swift
//  MWColorPicker
//
//  Created by LiYing on 2024/5/30.
//

import UIKit

public class MWColorPickerItemCollectionViewCell: UICollectionViewCell {

    public static let cellIdentifier = String(describing: MWColorPickerItemCollectionViewCell.self)
    
    private lazy var imageViewCheck: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    // MARK: -
    
    public func setupUI() {
        contentView.addSubview(imageViewCheck)
        
        imageViewCheck.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: imageViewCheck, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 4))
        contentView.addConstraint(NSLayoutConstraint(item: imageViewCheck, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -4))
        contentView.addConstraint(NSLayoutConstraint(item: imageViewCheck, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 4))
        contentView.addConstraint(NSLayoutConstraint(item: imageViewCheck, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -4))
    }
    
    public func setCell(_ color: UIColor?, _ selected: Bool, _ box: MWColorPickerSelectBoxStyle?) {
        contentView.backgroundColor = color
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = box?.cornerRadius ?? 0

        if let bx = box {
            imageViewCheck.image = nil
            if selected {
                var image: UIImage? = box?.icon
                image = box?.icon ?? UIImage.resourceUrl(forClass: MWColorPickerView.self, forBundle: "MWColorPickerImages", forResource: "check", withExtension: "")
                
                var _color = UIColor.white
                switch bx.iconColor {
                case .auto:
                    if (color?.isLight ?? false) {
                        _color = .black
                    }
                case .color(let c): _color = c
                }
                
                imageViewCheck.tintColor = _color
                imageViewCheck.image = image?.withRenderingMode(.alwaysTemplate)
            }
        } else {
            // box 为nil，隐藏 
        }
    }
}
