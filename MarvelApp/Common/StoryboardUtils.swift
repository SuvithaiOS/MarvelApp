//
//  StoryboardUtils.swift
//  MarvelApp
//
//  Created by admin on 3/11/22.
//

import UIKit

class StoryboardUtils {
    
    enum CellIdentifier {
        static let characterCardCell = "CharacterCellIdentifier"
        static let comicCardCell = "ComicCellIdentifier"
    }
    
    enum ViewControllerIdentifier {
        static let navigationController = "NavigationController"
        static let characterListController = "CharacterViewController"
        static let characterDetailController = "CharacterDetailViewController"
    }
    
    class func getStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
    class func getCharacterViewController() -> CharacterViewController? {
        return getStoryboard().instantiateViewController(withIdentifier: ViewControllerIdentifier.characterListController) as? CharacterViewController
    }
    
    class func getCharacterDetailViewController() -> CharacterDetailViewController? {
        return getStoryboard().instantiateViewController(withIdentifier: ViewControllerIdentifier.characterDetailController) as? CharacterDetailViewController
    }
    
    class func getNavigationController() -> UINavigationController? {
        return getStoryboard().instantiateViewController(withIdentifier: ViewControllerIdentifier.navigationController) as? UINavigationController
    }
    
}
