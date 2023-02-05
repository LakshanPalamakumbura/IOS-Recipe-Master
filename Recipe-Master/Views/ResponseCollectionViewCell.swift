//
//  ResponseCollectionViewCell.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2023-01-29.
//

import UIKit
import SDWebImage

class ResponseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ResponseCollectionViewCell"
    
    private let posterImageView: UIView = {
    let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {

//        print(model)
        
        guard let url = URL(string: model) else {
            return
        }
        posterImageView.sd_internalSetImage(with: url, placeholderImage: .none, context: .none, setImageBlock: nil, progress: .none)

    }
}
