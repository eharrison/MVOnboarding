//
//  MVOnboardingCollectionView.swift
//  Micro Learning App
//
//  Created by Evandro Harrison Hoffmann on 14/07/2016.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

public protocol MVOnboardingCollectionViewDelegate {
    func mvOnboardingCollectionViewDidScroll(_ fromItem: Int, toItem: Int)
}

open class MVOnboardingCollectionView: UICollectionView {
    
    open var mvOnboardingCollectionViewDelegate: MVOnboardingCollectionViewDelegate?
    
    open var mvOnboardingViewModel = MVOnboardingViewModel()
    
    open var currentPage = 0
    
    open func configWithCellIdentifiers(_ cellIdentifiers: [String]) {
        self.delegate = self
        self.dataSource = self
        
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        mvOnboardingViewModel = MVOnboardingViewModel()
        mvOnboardingViewModel.updateData(cellIdentifiers)
        mvOnboardingViewModel.delegate = self
    }
}

extension MVOnboardingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mvOnboardingViewModel.numberOfItems()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return mvOnboardingViewModel.cell(collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: self.frame.size.height)
    }
}

extension MVOnboardingCollectionView: UIScrollViewDelegate {
    
//    public func scrollViewDidScroll(scrollView: UIScrollView) {
//        updatePage(contentOffset.x)
//    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePage(contentOffset.x)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        updatePage(targetContentOffset.pointee.x)
    }
    
    public func updatePage(_ offsetX: CGFloat){
        let page = Int(offsetX / self.frame.size.width)
        if page != currentPage {
            mvOnboardingCollectionViewDelegate?.mvOnboardingCollectionViewDidScroll(currentPage, toItem: page)
            currentPage = page
        }
    }
    
    public func scrollToItem(_ item: Int){
        self.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension MVOnboardingCollectionView: MVOnboardingViewModelDelegate {
    
    public func onboardingCellIdentifiersWasUpdated() {
        self.reloadData()
    }
}
