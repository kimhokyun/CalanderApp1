//
//  DetailVC.swift
//  Template
//
//  Created by 82205 on 2023/08/13.
//

import UIKit

class DetailVC: UIViewController {

    
    
    var testStr = ""
    var sampleData = SampleData()
    var delegate:SendDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func addBtn(_ sender: Any) {
        
//        self.sampleData.title = titleTextField.text
//        self.sampleData.contents = contentsTextField.text
        delegate?.receiveData(data: self.sampleData)
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
