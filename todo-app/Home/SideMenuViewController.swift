//
//  SideMenuViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 20/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    var presenter : HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(delegate: self)
    }
    
    @IBAction func onlineTasksTapped(_ sender: Any) {
//        showOnlineJokes()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        logout()
    }
    
    private func showOnlineJokes() {
        print("jokes Tapped")
        let storyBoard = UIStoryboard(name: "ChuckNorrisJokes", bundle: nil).instantiateViewController(withIdentifier: "ChuckNorrisJokesTableViewController")
        
        let nav = UINavigationController.init(rootViewController: storyBoard)
        
//        self.present(nav, animated: true, completion: nil)
        self.navigationController?.present(nav, animated: true, completion: nil)
        
//        if let selectServicesController = self.storyboard?.instantiateInitialViewController() {
//            self.navigationController?.presentViewController(selectServicesController, animated: true, completion: nil)
//        }
    }
    
    private func logout() {
        //show dialog for logout confirmation
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) {(UIAlertAction) in
            NSLog("Yes", [])
            
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController, animated: true, completion: nil)
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) {(UIAlertAction) in
            NSLog("No", [])
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SideMenuViewController: HomeDelegate {
    func operationResult(message: String) {
        
    }
}
