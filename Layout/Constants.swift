//
//  Constants.swift
//  Layout
//
//  Created by Andrew on 03/10/23.
//

import Foundation
import UIKit

let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning{
    let cell : TableViewCell
    var operation : UINavigationController.Operation = .none
    init(cell:TableViewCell) {
        self.cell = cell
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVc = transitionContext.viewController(forKey: .from) as! ViewController
        
        let toVc = transitionContext.viewController(forKey: .to) as! SecondViewController
        
        toVc.view.layoutIfNeeded()
        let snapShotView = UIView()
        snapShotView.backgroundColor = cell.userView.backgroundColor
        snapShotView.frame = containerView.convert(cell.userView.frame, from: cell)
        snapShotView.layer.cornerRadius = cell.userView.layer.cornerRadius
        
        let snapShotLabel = UILabel()
        snapShotLabel.text =  toVc.userName.text
        snapShotLabel.font = UIFont.systemFont(ofSize: 19.0, weight: .semibold)
        snapShotLabel.frame = containerView.convert(fromVc.appTitle.frame, from: fromVc.view)
        
        let maskView = UIView()
        maskView.frame = containerView.convert(fromVc.view.frame, from: fromVc.view)
        maskView.backgroundColor = .white
//        maskView.alpha = 0
        
        let button = UIView()
        button.backgroundColor = .systemGreen
        button.frame = containerView.convert(cell.button.frame, from: cell)
        button.layer.cornerRadius = 25
        
        containerView.addSubview(toVc.view)
        containerView.addSubview(maskView)
        containerView.addSubview(snapShotView)
        containerView.addSubview(snapShotLabel)
        containerView.addSubview(button)
        

        containerView.backgroundColor = .blue
        toVc.view.isHidden = true
        
        UIView.animate(withDuration: 0.5) {
            snapShotView.frame = containerView.convert(toVc.userView.frame, from: toVc.view)
            
            snapShotLabel.frame = containerView.convert(toVc.userName.frame, to: toVc.view)
            button.frame = containerView.convert(toVc.button.frame, to: toVc.view)
        } completion: { _ in
            
            toVc.view.isHidden = false
            maskView.removeFromSuperview()
            snapShotView.removeFromSuperview()
            snapShotLabel.removeFromSuperview()
            button.removeFromSuperview()
            transitionContext.completeTransition(true)
            toVc.descriptionLbl.alpha = 0
            toVc.readmoreLbl.alpha = 0
            UIView.animate(withDuration: 0.4) {
                toVc.descriptionLbl.alpha = 1
            }completion: { _ in
                UIView.animate(withDuration: 0.4) {
                    toVc.readmoreLbl.alpha = 1
                }
            }
        }
}
    
    
}

extension CustomTransition : UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        return self
    }
}
