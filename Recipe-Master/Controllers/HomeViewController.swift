//
//  HomeViewController.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import UIKit

enum Sections: Int {
    case breakfast = 0
    case Main = 1
    case Dessert = 2
    
}

class HomeViewController: UIViewController {
    
    
    let sectionTitles: [String] = ["breakfast", "Main Dish", "Dessert"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
//        homeFeedTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        
        configureNavBar()
        
        let headerView = FoodHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "foodLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
//        let label = UILabel()
//        label.text = "Food Recipies"
//        label.textColor = .systemBlue
        navigationItem.title = "Food Recipies"
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(presentLoginVC)),
            UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(presentLogoutVC))
        ]
        navigationController?.navigationBar.tintColor = .blue
        
    }
    
    @objc func presentLoginVC() {
        
        let vc = loginUiViewController()
        vc.nav = self.navigationController
        vc.view.backgroundColor = .systemBackground
        navigationController?.pushViewController(vc, animated: true)
//        present(loginUiViewController(), animated: true)
         }
    
    @objc func presentLogoutVC() {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
         }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
      
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.breakfast.rawValue:
            
            APICaller.shared.getBreakfast { result in
                switch result {
                case .success(let response):
                    cell.configure(with: response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Main.rawValue:
            APICaller.shared.getMain { result in
                switch result {
                case .success(let response):
                    cell.configure(with: response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Dessert.rawValue:
            APICaller.shared.getDessart { result in
                switch result {
                case .success(let response):
                    cell.configure(with: response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        default:
            return UITableViewCell()
        }

        return cell
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "hello world"
//        cell.backgroundColor = .red
//        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.midY, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(_cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }      
    }
}
