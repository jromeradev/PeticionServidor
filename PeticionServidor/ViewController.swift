//
//  ViewController.swift
//  PeticionServidor
//
//  Created by Jose on 17/12/15.
//  Copyright © 2015 jromeradev. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    var com:Comunicacion = Comunicacion()
    @IBOutlet weak var result: UITextView!
    @IBOutlet weak var isbn: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.isbn.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clear(sender: AnyObject) {
        isbn.text=""
        result.text=""
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
       
        do {
         let data:NSString? = try com.loadBookInfo(isbn.text!)
        if (data != nil){
            result.text = (data as String?)!
        }
        }catch let ex as NSException {
            result.text = ex.callStackSymbols.joinWithSeparator("-")
        }
                
        return true
    }
    
}

