//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Alecsandra Konson on 9/14/16.
//  Copyright © 2016 Apperator. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: "https://www.bignerdranch.com/")
        let requestObj = URLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest)
    }

}
