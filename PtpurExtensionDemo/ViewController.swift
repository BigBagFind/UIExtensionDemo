//
//  ViewController.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/22.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let view = AMAMoreInstructions
        //UIView.initFromNib()
//        view.frame = self.view.bounds
//        self.view.addSubview(view)
    }

    @IBOutlet weak var showMore: UIButton!
    
    @IBAction func showMore(_ sender: Any) {
        
      //  AMAMoreInstructionInteractor.showMoreInstructionView()
    }
    
    @IBAction func showInstrutions(_ sender: Any) {
        
        
        let view = AMAInstructionsView(viewModel: AMAInstructionsViewModel.init(pageIndex: 7))
        view.frame = self.view.bounds
        self.view.addSubview(view)
    }
  


}

