//
//  MVOnboardingViewModel.swift
//  Micro Learning App
//
//  Created by Evandro Harrison Hoffmann on 14/07/2016.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

public protocol MVOnboardingViewModelDelegate {
    func onboardingCellIdentifiersWasUpdated()
}

open class MVOnboardingViewModel: NSObject {

    open var delegate: MVOnboardingViewModelDelegate?
    
    open var cellIdentifiers = [String]()
    
    open func updateData(_ cellIdentifiers: [String]){
        self.cellIdentifiers.removeAll()
        self.cellIdentifiers.append(contentsOf: cellIdentifiers)
        
        delegate?.onboardingCellIdentifiersWasUpdated()
    }
    
    open func numberOfItems() -> Int{
        return cellIdentifiers.count
    }
    
    open func cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers[(indexPath as NSIndexPath).row], for: indexPath) as! MVOnboardingCollectionViewCell
        
        cell.addsBackgroundVideoIfAny()
        
        return cell
    }
}
