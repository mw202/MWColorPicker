//
//  ViewController.swift
//  MWColorPicker
//
//  Created by mw202 on 05/29/2024.
//  Copyright (c) 2024 mw202. All rights reserved.
//

import UIKit
import MWColorPicker

class ViewController: UIViewController, MWColorPickerViewDataSource, MWColorPickerViewDelegate {
    
    private var selected = 0
    
    @IBOutlet weak var picker2: MWColorPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let picker = MWColorPickerView()
        picker.selectedColor = "9bff38"
        picker.frame = CGRect(x: 100, y: 100, width: 200, height: 300)
        picker.dataSource = self
        picker.delegate = self
        view.addSubview(picker)
        
        picker2.style = MWColorPickerSelectBoxStyle.default
        picker2.bindBlock(selected: "000000") { (view, index, color) in
            print("selected(\(index)): \(color)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MWColorPickerView data source
    
    func colorPickerViewShowSelectBox(_ view: MWColorPickerView) -> MWColorPickerSelectBoxStyle? {
        return MWColorPickerSelectBoxStyle.default
    }
    
    // MARK: - MWColorPickerView delegate
    
    func colorPickerView(_ view: MWColorPickerView, didSelectAt index: Int, color: String) {
        print("selected(\(index)) - \(color)")
    }

}

