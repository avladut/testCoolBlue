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
    private let productsViewModel = ProductListViewModel(httpManager: HTTPRequestManager(baseUrlString: Constants.URLS.baseURLString))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsViewModel.delegate = self
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
            self.productsViewModel.searchFor(searchString: queryUnwr)
        } else {
             productsViewModel.search()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productDetailsVC = segue.destination as? ProductDetailsVC, let productID = sender as? String {
            productDetailsVC.productID = productID
        }
    }
    

}

extension SearchScreenVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsViewModel.getNumberOfRowsForSectionIndex(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productViewModel = productsViewModel.getProductViewModelAtIndexPath(index: indexPath)  else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCellReuseID", for: indexPath) as! ProductCell
        cell.config(productVM: productViewModel)
        
        //if the last cell is loaded, load more data
        if indexPath.row == (productsViewModel.getNumberOfRowsForSectionIndex(indexPath.section) - 1) {
            //load more pages of a previous query
            startSearchAction(query: nil)
        }
        
        return cell
    }
    
}

extension SearchScreenVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product = self.productsViewModel.getProductViewModelAtIndexPath(index: indexPath) {
            self.performSegue(withIdentifier: "toProductDetails", sender: product.productID)
        }
    }
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
        self.lblSearchStatus.text = self.productsViewModel.getSearchDetails()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    func updateDatasourceFailed(errorMessage:String) {
        ErrorHandlerManager.sharedInstance.showError(message: errorMessage, parentVC: self)
    }
}

