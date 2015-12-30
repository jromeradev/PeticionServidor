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
    
    @IBOutlet weak var isbn: UITextField!
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var autores: UILabel!
    
    @IBOutlet weak var portada: UIImageView!
    
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
        titulo.text = ""
        autores.text = ""
        portada.image = nil
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
    
    func loadBookData(isbn:String)throws->NSData? {
        let url = NSURL(string:urlBase+isbn)
        let datos:NSData? = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
        return datos
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        do{
            //let data:NSString? = try loadBookInfo(isbn.text!)
            //if (data != nil){
            let datos:NSData? = try loadBookData(isbn.text!)
            if (datos != nil) {
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                    if let mainjson = json as? NSDictionary{
                        if let main = mainjson["ISBN:"+isbn.text!] as? NSDictionary {
                            let titlejs = main["title"] as! NSString as String
                            titulo.text = titlejs
                            let autoresjs = main["authors"] as! NSArray
                    
                            if let coverMainjs = main["cover"] as? NSDictionary {
                    
                                let urlCoverjs = coverMainjs["medium"] as! NSString as String
                                let url = NSURL(string:urlCoverjs)
                                let dataImg = NSData(contentsOfURL: url!)
                                portada.image = UIImage(data:dataImg!)
                                
                            }
                            for autor in autoresjs {
                                autores.text = autores.text! + (autor["name"] as! NSString as String) + ","
                            }
                        }
                    }
                    
                    
                }catch let error as NSError {
                    let alerta = UIAlertController(title:"Error acceso datos", message: error.description, preferredStyle:.Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alerta.addAction(OKAction)
                    self.presentViewController(alerta, animated: true, completion: nil)
                }
                
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

