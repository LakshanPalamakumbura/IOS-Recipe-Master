//
//  TitleTableViewCell.swift
//  Netflix One
//
//  Created by Lakshan Palamakumbura on 2022-12-18.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

   static let identifier = "FavouriteTableViewCell"
    
    private let titlesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlesPosterUIImageView: UIImageView = {
       
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        return imageview
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(titlesLabel)
        
        applyConstraints()
    }
    
    
    private func applyConstraints() {
        
        let titlesPosterUIImageViewConstrains = [
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15 ),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titlesLabelConstraints = [
            titlesLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            titlesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor )
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstrains)
        NSLayoutConstraint.activate(titlesLabelConstraints)
    }
    
    public func configure(with model: FavouriteViewModel) {
        
        titlesLabel.text = model.name
        titlesLabel.font = .systemFont(ofSize: 18, weight: .bold)
        guard let url = URL(string: model.image) else {
            return
        }
        titlesPosterUIImageView.sd_internalSetImage(with: url, placeholderImage: .none, context: .none, setImageBlock: nil, progress: .none)
//        titlesPosterUIImageView.sd_setImage(with: url, completed: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
