//
//  Comunicacion.swift
//  PeticionServidor
//
//  Created by Jose on 17/12/15.
//  Copyright © 2015 jromeradev. All rights reserved.
//

import Foundation

class Comunicacion {
    
    let urlBase:String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    
    func loadBookInfo(isbn:String)->NSString? {
        let url = NSURL(string:urlBase+isbn)
        let datos:NSData? = NSData(contentsOfURL:url!)
        var texto:NSString?
        if (datos != nil){
            texto = NSString(data:datos!, encoding: NSUTF8StringEncoding)
        }
        return texto
    }
    
   
}