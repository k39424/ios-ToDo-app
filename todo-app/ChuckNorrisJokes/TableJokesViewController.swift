//
//  TableJokesViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 23/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit
import IGListKit

class TableJokesViewController: UIViewController {
//IGListCollectionView has been renamed to ListCollectionView
    @IBOutlet weak var collectionView: ListCollectionView!
  var jokes: [Joke] = []
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    
//    lazy var adapter: IGListAdapter = {
//        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
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


extension TableJokesViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.jokes
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        print((object as! Joke).value)
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
    
    
}
