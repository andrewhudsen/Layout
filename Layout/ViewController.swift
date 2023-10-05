//
//  ViewController.swift
//  Layout
//
//  Created by Andrew on 03/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var appTitle: UILabel!
    
    var current : TableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenHeight-kScreenHeight/2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController  else { return }
        let custom = CustomTransition(cell: tableView.cellForRow(at: indexPath)! as! TableViewCell)
        self.current = tableView.cellForRow(at: indexPath) as? TableViewCell
        navigationController?.delegate = custom
        navigationController?.pushViewController(vc, animated: true)
        
    }
}


