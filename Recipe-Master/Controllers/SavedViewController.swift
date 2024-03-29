//
//  SavedViewController.swift
//  Food and Recipe
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//
//
//import UIKit
//import CoreData
//
//class SavedViewController: UIViewController {
//
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    let tableView = UITableView()
//    var foodRecipes: [FoodRecipe] = []
//
//    override func loadView() {
//        super.loadView()
//        setupView()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = false
//        setupFetchRequest()
//    }
//
//    private func setupFetchRequest() {
//        let fetchRequest: NSFetchRequest<FoodRecipe> = FoodRecipe.fetchRequest()
//        fetchRequest.sortDescriptors = []
//        if let result = try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest) {
//            foodRecipes = result
//            tableView.reloadData()
//        }
//    }
//
//    //MARK: - Setup View
//
//    private func setupView() {
//        view.backgroundColor = .white
//        self.title = "Saved"
//        setupTableView()
//    }
//
//    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        view.addSubview(tableView)
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//        tableView.register(RecipeSearchCell.self, forCellReuseIdentifier: "cellid")
//    }
//
//}
//
//extension SavedViewController : UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if foodRecipes.count == 0{
//            tableView.setEmptyView(title: "You don't have any saved recipes", message: "Your saved recipes will be in here")
//        } else {
//            tableView.restore()
//        }
//        return foodRecipes.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! RecipeSearchCell
//        let foodRecipe = foodRecipes[indexPath.row]
//        cell.titleLabel.text = foodRecipe.title
//        cell.recipeImageView.image = UIImage(data: foodRecipe.image!)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let foodRecipe = foodRecipes[indexPath.row]
//        if foodRecipe.ingredients!.count == 0 {
//            if let url = URL(string: foodRecipe.sourceURL ?? "") {
//                if UIApplication.shared.canOpenURL(url) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                } else {
//                    self.presentAlert(title: "Recipe Unavailable", message: "")
//                }
//            } else {
//                self.presentAlert(title: "Recipe Unavailable", message: "")
//            }
//        } else {
//            let detailVC = DetailViewController()
//            detailVC.foodRecipe = foodRecipes[indexPath.row]
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
//            let recipeToDelete = self.foodRecipes[indexPath.row]
//            self.appDelegate.persistentContainer.viewContext.delete(recipeToDelete)
//            try? self.appDelegate.persistentContainer.viewContext.save()
//            self.foodRecipes.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            completionHandler(true)
//        }
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
//
//}


//
//  DownloadsViewController.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import UIKit

class SavedViewController: UIViewController {

    private var responses: [FavouriteResponse] = [FavouriteResponse]()
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourite"
        view.backgroundColor = .systemRed
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        
        fetchUpComing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        
        fetchUpComing()
    }
    
    private func fetchUpComing() {
        let token = UserDefaults.standard.string(forKey: "token")
                  if (token == nil) {
                      let loginViewController = loginUiViewController()
                      present(loginViewController, animated: true, completion: nil)
        
                  }else{ //use get API
                      APICaller.shared.getFavourite { [weak self] result in
                          switch result {
                          case .success(let responses):
                              self?.responses = responses
                              DispatchQueue.main.async {
                                  self?.upcomingTable.reloadData()
                              }
                              
                          case .failure(let error):
                              print(error.localizedDescription)
                          }
                          
                      }
                  }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
}


extension SavedViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown"
//            return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
        let responses = responses[indexPath.row].food
//        let foodName = responses.name
        cell.configure(with: FavouriteViewModel(name: responses.name ?? "Unknown Title Name", image: responses.image ?? ""))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
