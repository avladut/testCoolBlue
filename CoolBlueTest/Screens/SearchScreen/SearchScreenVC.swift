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
    
    @IBOutlet weak var lblSearchStatus: UILabel!
    private let searchTableVM = SearchTableVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableVM.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return cell
    }
    
}

extension SearchScreenVC : UITableViewDelegate {
    
}

extension SearchScreenVC : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.searchTableVM.searchFor(searchString: text)
            searchBar.resignFirstResponder()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
}

extension SearchScreenVC : DatasourceUpdateDelegate {
    func updateDatasource(){
        self.tblProducts.reloadData()
        self.lblSearchStatus.text = self.searchTableVM.getSearchDetails()
    }
    func updateDatasourceFailed(errorMessage:String) {
        ErrorHandlerManager.sharedInstance.showError(message: errorMessage, parentVC: self)
    }
}

