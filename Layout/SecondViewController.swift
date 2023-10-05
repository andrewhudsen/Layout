//
//  SecondViewController.swift
//  Layout
//
//  Created by Andrew on 03/10/23.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var userView: UIView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var readmoreLbl: UIButton!
    
    @IBOutlet weak var downloadBtnTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var statusImageVw: UIImageView!
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var loadingViewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionStackView: UIStackView!
    
    @IBOutlet weak var collectionStackVIewConstr: NSLayoutConstraint!
    
    @IBOutlet weak var closeBtn: UIImageView!
    
    @IBOutlet weak var closeView: UIView!
    
    @IBOutlet weak var rightLine: NSLayoutConstraint!
    
    @IBOutlet weak var leftLine: NSLayoutConstraint!
    
    
    @IBOutlet weak var widthCollecConst: NSLayoutConstraint!
    
    var cell : UITableViewCell!
    var count = 0
    var isdownload = true
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize  = CGSize(width: kScreenWidth/2, height: kScreenHeight/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = flowLayout
        loadingView.isHidden = true
        closeBtn.isHidden = true
        rightLine.constant = 0
        leftLine.constant = 0
        widthCollecConst.constant = kScreenWidth/2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.alpha = 0
        collectionStackView.spacing = 30
        collectionStackView.subviews.forEach { i in
            i.transform = CGAffineTransform(scaleX: 1, y: 1.15)
            i.alpha = 0.5
        }
        closeView.transform = CGAffineTransform(rotationAngle: .pi/4)
        
        UIView.animate(withDuration: 0.9) {
            self.collectionStackView.spacing = 5
            self.collectionStackVIewConstr.constant = 10
            self.collectionStackView.subviews.forEach { i in
                i.transform = CGAffineTransform.identity
                i.alpha = 1
            }
            self.rightLine.constant = 25
            self.view.layoutIfNeeded()
        }completion: { _ in
            self.collectionStackView.removeFromSuperview()
            self.collectionView.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.leftLine.constant = 25
                self.view.layoutIfNeeded()
            }completion: { _ in
                self.closeView.removeFromSuperview()
                self.closeBtn.isHidden = false
            }
        }
    }
    
    @IBAction func downloadBtn(_ sender: UIButton) {
        var constraintConst = CGFloat()
        if isdownload {
            UIView.animate(withDuration: 0.5) {
                self.downloadBtnTrailing.constant = 50
                constraintConst = self.downloadBtnTrailing.constant
                self.view.layoutIfNeeded()
                self.statusImageVw.alpha = 1
            }completion: { _ in
                self.button.isUserInteractionEnabled = false
                self.button.alpha = 0.5
                self.loadingView.isHidden = false
                self.loadingViewTrailing.constant = kScreenWidth-20
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.8) {
                    self.loadingViewTrailing.constant = constraintConst
                    self.view.layoutIfNeeded()
                }completion: { _ in
                    self.statusImageVw.image =  UIImage(systemName: "checkmark.circle.fill")
                    UIView.animate(withDuration: 0.5) {
                        self.statusImageVw.alpha = 0
                        self.loadingView.alpha = 0
                        self.button.alpha = 0
                    }completion: { _ in
                        self.loadingView.isHidden = true
                        self.statusImageVw.isHidden = true
                        constraintConst = self.buttonBottomConstraint.constant
                        self.buttonBottomConstraint.constant = 0
                        self.view.layoutIfNeeded()
                        
                        
                        self.button.isUserInteractionEnabled = true
                        self.button.configuration?.baseBackgroundColor = .tintColor
                        self.button.configuration?.title="PLAY"
                        self.button.configuration?.subtitle = nil
                        
                        self.button.alpha = 1
                        self.downloadBtnTrailing.constant = 10
                        self.view.layoutIfNeeded()
                        UIView.animate(withDuration: 0.5) {
                            self.buttonBottomConstraint.constant = constraintConst
                            self.view.layoutIfNeeded()
                        }completion: { _ in
                            self.isdownload = false
                        }
                    }
                }
            }
        }else{
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController else {return}
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
    }
    

}

extension SecondViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
    }
    
}


