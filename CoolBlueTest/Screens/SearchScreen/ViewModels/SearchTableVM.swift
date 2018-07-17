//
//  SearchTableVM.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 15/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation


class SearchTableVM {
    private var arrItems:[ProductViewModel] = []
    private var intLastSearchedPage:Int = 0
    private var intPageLimit:Int = 1
    private var strSearchQuery:String? {
        willSet(incomingQuery) {
            self.resetSearch()
        }
    }
    public weak var delegate:DatasourceUpdateDelegate?
    
    public func searchFor(searchString:String){
        if strSearchQuery != searchString {
            strSearchQuery = searchString
        }
        self.search()
    }
    
    public func search() {
        guard let searchQueryUnwr = strSearchQuery else {
            return
        }
        if intLastSearchedPage >= intPageLimit {
            return
        }
        intLastSearchedPage += 1
        NetworkRequestManager.sharedInstance.searchFor(searchQueryUnwr, page: intLastSearchedPage) {[weak self] (dictResponse, error) in
            //do something with results that does not require the UI
            
            self?.intLastSearchedPage = 1
            if let maximumPageNumber = dictResponse?[Constants.JsonKeyNames.pageCount] as? Int {
                self?.intPageLimit = maximumPageNumber
            }
            if let maximumPageNumber = dictResponse?[Constants.JsonKeyNames.currentPage] as? Int {
                self?.intLastSearchedPage = maximumPageNumber
            }
            if let productsArray = dictResponse?["products"] as? Array<Dictionary<String, Any>> {
                for productDict in productsArray {
                    //the product model is not used in this project. Normally it should be saved in the db or whatever
                    let product = ProductBasic(dict: productDict)
                    let productVM = ProductViewModel(product: product)
                    self?.arrItems.append(productVM)
                }
                //task complete, notify the View to update data
                self?.delegate?.updateDatasource()
            } else {
                //something failed, send a message
                self?.delegate?.updateDatasourceFailed(errorMessage: "Something really bad happened")
            }
        }
    }
    
    private func resetSearch () {
        intPageLimit = 1
        intLastSearchedPage = 0
        arrItems = []
    }
    
    public func getNumberOfSections() -> Int {
        return 0
    }
    
    public func getNumberOfRowsForSectionIndex(_ sectionIndex:Int) -> Int {
        return arrItems.count
    }
    
    public func getProductViewModelAtIndexPath(index:IndexPath) -> ProductViewModel? {
        if (index.row < arrItems.count) {
            return arrItems[index.row]
        } else {
            return nil
        }
    }
    
    public func getSearchDetails() -> String {
        return "number of results: \(arrItems.count) pages loaded \(intLastSearchedPage) of \(intPageLimit)"
    }
}
