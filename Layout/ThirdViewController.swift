//
//  ThirdViewController.swift
//  Layout
//
//  Created by Andrew on 05/10/23.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var topCustomView: UIView!
    
    @IBOutlet weak var circleConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var circleStackView: UIStackView!
    
    @IBOutlet weak var secondStackView: UIStackView!
    
    
    @IBOutlet weak var secondStackViewConst: NSLayoutConstraint!
    
    @IBOutlet weak var thirdConst: NSLayoutConstraint!
    
    @IBOutlet weak var thirdStackView: UIStackView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var secondPageView: UIView!
    
    
    @IBOutlet weak var topSECCustomView: UIView!
    
    @IBOutlet weak var circleSecConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var circleSecStackView: UIStackView!
    
    @IBOutlet weak var bottomSecConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var subLbl: UILabel!
    
    @IBOutlet weak var thirdPageView: UIView!
    
    @IBOutlet weak var circlethirdCOnst: NSLayoutConstraint!
    
    @IBOutlet weak var thirdPageStackView: UIStackView!
    var constant = CGFloat()
    var isSecondPage = true
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        topCustomView.transform = CGAffineTransform(scaleX: 0, y: 0)
        circleConstraint.constant = self.view.frame.width
        
        constant = 15
        circleStackView.spacing = circleStackView.spacing+constant
        secondStackViewConst.constant = self.view.frame.width
        secondStackView.spacing = secondStackView.spacing+constant
        
        thirdConst.constant = kScreenWidth
        thirdStackView.spacing = thirdStackView.spacing+constant
        self.view.layoutIfNeeded()
        secondPageView.isHidden = true
        thirdPageView.isHidden = true
    }
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        UIView.animate(withDuration: 0.4) {
            self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.6)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.4) {
            self.view.backgroundColor = UIColor.clear.withAlphaComponent(1)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.4) {
            self.topCustomView.transform = CGAffineTransform.identity
            self.circleConstraint.isActive = false
            self.circleStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.circleStackView.spacing -= self.constant
            
            
            self.view.layoutIfNeeded()
        }completion: { _ in
            UIView.animate(withDuration: 0.4) {
                self.secondStackViewConst.isActive = false
                self.secondStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                self.secondStackView.spacing -= self.constant
                self.view.layoutIfNeeded()
            }completion: { _ in
                self.thirdConst.isActive = false
                self.thirdStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                self.thirdStackView.spacing -= self.constant
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        if isSecondPage{
            constant = bottomSecConstraint.constant
            bottomSecConstraint.constant = 0
            secondPageView.isHidden = false
            topSECCustomView.transform = CGAffineTransform(scaleX: 0, y: 0)
            circleSecConstraint.constant = kScreenWidth
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.4) {
                self.topSECCustomView.transform = CGAffineTransform.identity
                self.circleSecConstraint.isActive = false
                self.circleSecStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                self.bottomSecConstraint.constant = self.constant
                self.view.layoutIfNeeded()
                
            }completion: { _ in
                self.isSecondPage = false
            }
        }else{
            thirdPageView.isHidden = false
            self.headerLbl.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.subLbl.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.circlethirdCOnst.constant = kScreenWidth
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.4) {
                self.headerLbl.transform = CGAffineTransform.identity
                self.subLbl.transform = CGAffineTransform.identity
                self.circlethirdCOnst.isActive = false
                self.thirdPageStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                self.nextButton.configuration?.baseBackgroundColor = .black
                self.nextButton.configuration?.title="Confirm"
                self.view.layoutIfNeeded()
                self.nextButton.isUserInteractionEnabled = false
            }
        }
        
    }
    
}


extension ThirdViewController{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        if touch?.view == self.view{
            dismiss(animated: true, completion: nil)
        }
    }

    
}
