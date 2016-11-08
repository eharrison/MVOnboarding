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
    @IBOutlet weak var nextButton: UIButton?
    @IBOutlet weak var skipButton: UIButton?
    
    open var hidesPagingForLastScreen = true
    open var hidesSkipAfterFirstScreen = true
    open var hidesNextButtonForLastScreen = true
    
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
    
    // MARK: - Events
    
    @IBAction open func skipButtonPressed(_ sender: Any) {
    }
    
    @IBAction open func nextButtonPressed(_ sender: Any) {
        self.mvOnboardingCollectionView.scrollToItem(self.mvOnboardingCollectionView.currentPage+1)
    }
}

extension MVOnboardingViewController: MVOnboardingCollectionViewDelegate {
    
    public func mvOnboardingCollectionViewDidScroll(_ fromItem: Int, toItem: Int) {
        pageControl.currentPage = toItem
        
        pageControl.isHidden = hidesPagingForLastScreen && pageControl.currentPage == pageControl.numberOfPages-1
        
        nextButton?.isHidden = hidesNextButtonForLastScreen && pageControl.currentPage == pageControl.numberOfPages-1
        
        skipButton?.isHidden = hidesSkipAfterFirstScreen && pageControl.currentPage > 0
    }
    
}
