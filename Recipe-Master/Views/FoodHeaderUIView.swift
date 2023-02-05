//
//  FoodHeaderUIView.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import UIKit

class FoodHeaderUIView: UIView {

    var timer: Timer!
    var Headerfoods: [UIImage] = [UIImage(named: "foodImage")!, UIImage(named: "foodImage2")!, UIImage(named: "foodImage3")!, UIImage(named: "foodImage4")!, UIImage(named: "foodImage5")!]
       
    private let appTitle: UILabel = {
       
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.text = "Your Most Healthy Food Maker Is Here!"
        titleLable.font = .systemFont(ofSize: 20, weight: .bold)
        titleLable.shadowColor = .white
        titleLable.textColor = .black
        titleLable.textAlignment = .center
        titleLable.numberOfLines = 0
        return titleLable
        
    }()
    
    
    private let foodImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showRandomImage), userInfo: nil, repeats: true)
    }
    
    @objc func showRandomImage() {
        foodImageView.image = Headerfoods.randomElement() ?? UIImage(named: "foodImage")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(foodImageView)
        addGradient()
//        addSubview(playButton)
//        addSubview(downloadButton)
        addSubview(appTitle)
        applyConstraints()
        
        startTimer()
    }
    
    private func applyConstraints() {

                NSLayoutConstraint.activate([
                    
                    appTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
                    appTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
                    appTitle.widthAnchor.constraint(equalToConstant: 250),
                    appTitle.heightAnchor.constraint(equalToConstant: 50)
        
                ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        foodImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
