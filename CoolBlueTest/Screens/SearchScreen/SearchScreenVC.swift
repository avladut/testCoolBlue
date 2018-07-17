//
//  SearchScreenVC.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 15/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import UIKit

class SearchScreenVC: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblProducts: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblSearchStatus: UILabel!
    private let searchTableVM = SearchTableVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableVM.delegate = self
        initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initUI() {
        self.tblProducts.tableFooterView = UIView()
        self.activityIndicator.isHidden = true
    }
    
    private func startSearchAction(query:String?){
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.lblSearchStatus.text = "Loading results"
        if let queryUnwr = query {
            self.searchTableVM.searchFor(searchString: queryUnwr)
        } else {
             searchTableVM.search()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchScreenVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTableVM.getNumberOfRowsForSectionIndex(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productViewModel = searchTableVM.getProductViewModelAtIndexPath(index: indexPath)  else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCellReuseID", for: indexPath) as! ProductCell
        cell.config(productVM: productViewModel)
        
        //if the last cell is loaded, load more data
        if indexPath.row == (searchTableVM.getNumberOfRowsForSectionIndex(indexPath.section) - 1) {
            //load more pages of a previous query
            startSearchAction(query: nil)
        }
        
        return cell
    }
    
}

extension SearchScreenVC : UITableViewDelegate {
    
}

extension SearchScreenVC : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            startSearchAction(query: text)
            searchBar.resignFirstResponder()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
}

extension SearchScreenVC : DatasourceUpdateDelegate {

    func dataRetrieved(shouldUpdate: Bool) {
        if shouldUpdate {
            self.tblProducts.reloadData()
        }
        self.lblSearchStatus.text = self.searchTableVM.getSearchDetails()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    func updateDatasourceFailed(errorMessage:String) {
        ErrorHandlerManager.sharedInstance.showError(message: errorMessage, parentVC: self)
    }
}

