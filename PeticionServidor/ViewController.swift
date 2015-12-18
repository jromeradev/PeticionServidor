//
//  ViewController.swift
//  PeticionServidor
//
//  Created by Jose on 17/12/15.
//  Copyright © 2015 jromeradev. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    let urlBase:String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    
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

    func loadBookInfo(isbn:String)throws->NSString? {
        let url = NSURL(string:urlBase+isbn)
        let datos:NSData? = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
        var texto:NSString?
        if (datos != nil){
            texto = NSString(data:datos!, encoding: NSUTF8StringEncoding)
        }
        return texto
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        do{
            let data:NSString? = try loadBookInfo(isbn.text!)
            if (data != nil){
                result.text = (data as String?)!
            }
        } catch let error as NSError {
            let alerta = UIAlertController(title:"Error acceso URL", message: error.description, preferredStyle:.Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alerta.addAction(OKAction)
            self.presentViewController(alerta, animated: true, completion: nil)
        }
        
        return true
    }
    
}

