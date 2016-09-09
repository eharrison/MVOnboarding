//
//  MVOnboardingViewController.swift
//  Micro Learning App
//
//  Created by Evandro Harrison Hoffmann on 14/07/2016.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

open class MVOnboardingViewController: UIViewController {

    @IBOutlet weak open var mvOnboardingCollectionView: MVOnboardingCollectionView!
    @IBOutlet weak open var pageControl: UIPageControl!
    
    open var hidesPagingForLastScreen = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        mvOnboardingCollectionView.mvOnboardingCollectionViewDelegate = self
        
        pageControl.addTarget(self, action: #selector(MVOnboardingViewController.didUpdatePageControl(_:)), for: .valueChanged)
    }
    
    open func setCellIdentifiers(_ cellIdentifiers: [String]){
        mvOnboardingCollectionView.configWithCellIdentifiers(cellIdentifiers)
        pageControl.numberOfPages = cellIdentifiers.count
    }
    
    open func didUpdatePageControl(_ sender: AnyObject?){
        mvOnboardingCollectionView.scrollToItem(pageControl.currentPage)
    }
}

extension MVOnboardingViewController: MVOnboardingCollectionViewDelegate {
    
    public func mvOnboardingCollectionViewDidScroll(_ fromItem: Int, toItem: Int) {
        pageControl.currentPage = toItem
        
        if hidesPagingForLastScreen && pageControl.currentPage == pageControl.numberOfPages-1{
            pageControl.isHidden = true
        }else{
            pageControl.isHidden = false
        }
    }
    
}
