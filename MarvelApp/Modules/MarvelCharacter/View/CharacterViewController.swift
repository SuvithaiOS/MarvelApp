//
//  CharacterViewController.swift
//  MarvelComics
//
//  Created by admin on 3/10/22.
//

import UIKit

class CharacterViewController: UIViewController {
    
    @IBOutlet weak var characterTableView: UITableView!
    var charcterViewModel = CharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Characters"
        
        charcterViewModel.delegate = self
        charcterViewModel.getCharacterList()
    }
    
}

//MARK:- Using UITableViewDelegate,UITableViewDataSource
extension CharacterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charcterViewModel.characterDataModel?.data?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardUtils.CellIdentifier.characterCardCell) as? CharacterTableViewCell {
            cell.renderDataToCell(self.charcterViewModel.characterDataModel?.data?.results?[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewControllerInstance = StoryboardUtils.getCharacterDetailViewController() {
            viewControllerInstance.characterModel = self.charcterViewModel.characterDataModel?.data?.results?[indexPath.row]
            viewControllerInstance.detailViewModel = CharacterDetailViewModel.init(id: "\(self.charcterViewModel.characterDataModel?.data?.results?[indexPath.row].id ?? 0)")
            self.navigationController?.present(viewControllerInstance, animated: true, completion: nil)
            
        }
    }
}


//MARK:- Use ViewModel Protocols
extension CharacterViewController: characterViewModelProtocol {
    
    func fetchListOfMarvelCharacters() {
        self.characterTableView.reloadData()
    }
    
    func getErrorFrom(_ error: String) {
        Utils().showAlertView(title: "Error", messsage: error)
    }
    
    func getErrorCodeFromAPIResponse() {
        Utils().showAlertView(title: ErrorString.error.rawValue, messsage: ErrorString.serverMsg.rawValue)
    }
    
}
