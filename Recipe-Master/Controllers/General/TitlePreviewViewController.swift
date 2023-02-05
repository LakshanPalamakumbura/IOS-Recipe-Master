//
//  TitlePreviewViewController.swift
//  Netflix One
//
//  Created by Lakshan Palamakumbura on 2022-12-21.
//

import UIKit
//import WebKit

class TitlePreviewViewController: UIViewController {
    
    var foodId: Int?
    
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Kiribath"
        return label
    }()
    
    private let overviewLable: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0 //multiple Line
        label.text = "this is shows us food ingredient"
        return label
    }()
    
    private let statusLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .red
        label.text = "this is very good food"
        return label
    }()
    
    private let addFavouriteButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Add Favourite ♡", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(favButtonTapped), for: .primaryActionTriggered)
        return button
    }()
    
    private let posterImageView: UIView = {
    let imageView = UIImageView()
//        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLable)
        view.addSubview(statusLabel)
        view.addSubview(addFavouriteButton)
      
        
        configureConstraints()
    }
    
    func configureConstraints() {
        
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let overViewLabelConstraints = [
            overviewLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            overviewLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let statusLabelConstraints = [
            statusLabel.topAnchor.constraint(equalTo: overviewLable.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let addFavouriteButtonButtonConstraints = [
            addFavouriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addFavouriteButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 25),
            addFavouriteButton.widthAnchor.constraint(equalToConstant: 160),
            addFavouriteButton.heightAnchor.constraint(equalToConstant: 40)
            
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        NSLayoutConstraint.activate(statusLabelConstraints)
        NSLayoutConstraint.activate(addFavouriteButtonButtonConstraints)
        
    }
    
    
    func configure(with model: TitlePreviewViewModel) {
        
//        print(model.id)
        self.foodId = model.id
        titleLabel.text = model.name
        overviewLable.text = model.ingredients
        statusLabel.text = model.status
        
        guard let url = URL(string: model.image) else {
            return
        }
    
        posterImageView.sd_internalSetImage(with: url, placeholderImage: .none, context: .none, setImageBlock: nil, progress: .none)

        
    }
    
}

extension TitlePreviewViewController {
    
    @objc func favButtonTapped() {
    
        let foodId=(self.foodId!)
        let token = UserDefaults.standard.string(forKey: "token")
        guard let url = URL(string: "http://127.0.0.1:8000/api/userfavourite/add/\(foodId)") else { return }
        print(url)
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           let session = URLSession.shared
           session.dataTask(with: request){data, response, error in
                   if let error = error {
                       print("Error: \(error)")
                       return
                   }
                   guard let data = data else {
                       print("No data")
                       return
                   }
                   do{
                       let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                       let message = json?["message"] as? String
                       
                       let alert = UIAlertController(title: "Favourite", message: message, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                          alert.addAction(okAction)
                                          DispatchQueue.main.async {
                                              self.present(alert, animated: true, completion: nil)
                                          }
                   
                   }catch let error{
                       print("Error serializing JSON: \(error)")
                   }
               }.resume()

    }
 
}
