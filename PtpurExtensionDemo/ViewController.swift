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
        
        //AMAVersionInteractor.showLatestUpdateView(selectedBlock: nil)
        
      //  AMAVersionManager.defaultManager.checkVersionUpdateManually(at: self)
        
    }

    @IBAction func action(_ sender: Any) {
       /*
        AMAPickerViewInteractor *interactor = [AMAPickerViewInteractor interactorWithViewModel:[[AMAPickerViewViewModel alloc] initWithDataSource:@[]]];
        [interactor presentPickerView];
        interactor.pickerView.delegate = self;
 */
        
        
        AMAVersionManager.defaultManager.checkVersionUpdateManually(at: self)
    }
    @IBOutlet weak var showMore: UIButton!
    
    @IBOutlet weak var checkAction: UIButton!
    @IBAction func showMore(_ sender: Any) {
        
      //  AMAMoreInstructionInteractor.showMoreInstructionView()
    }
    
    @IBAction func showInstrutions(_ sender: Any) {
        
        
        let view = AMAInstructionsView(viewModel: AMAInstructionsViewModel.init(pageIndex: 7))
        view.frame = self.view.bounds
        self.view.addSubview(view)
    }
  


}

