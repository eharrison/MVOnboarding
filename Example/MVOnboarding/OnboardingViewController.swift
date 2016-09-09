//
//  OnboardingViewController.swift
//  Micro Learning App
//
//  Created by Evandro Harrison Hoffmann on 14/07/2016.
//  Copyright © 2016 Mindvalley. All rights reserved.
//

import MVOnboarding

class OnboardingViewController: MVOnboardingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidesPagingForLastScreen = true
        setCellIdentifiers(["onboarding1", "onboarding2", "onboarding3"])
    }

}
