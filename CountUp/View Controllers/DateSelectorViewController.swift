//
//  CounterViewController.swift
//  CountUp
//
//  Created by Alexander Griswold on 8/22/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit

class DateSelectorViewController: UIViewController, SubmitButtonDelegate {
    
    //MARK: Views
    let dateSelectorView = DateSelectorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateSelectorView.frame = self.view.frame
        self.view.addSubview(dateSelectorView)
        dateSelectorView.delegate = self
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func didTapSubmit(compareDate: Date) {
        let counterViewController = CounterViewController(compareDate: compareDate)
        navigationController?.pushViewController(counterViewController, animated: true)
    }
}

extension DateSelectorViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return DateSelectorAnimationController(presenting: true)
        } else {
            return DateSelectorAnimationController(presenting: false)
        }
    }
}
