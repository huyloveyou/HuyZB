//
//  HomeViewController.swift
//  HuyZB
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 come.huy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }

}

//设置UI界面
extension HomeViewController {
    private func setupUI(){
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "btn_nav_history", highImageName: "btn_nav_historyRedPoint", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "search_btn_pk", highImageName: "searchBtnIconHL", size: size)
        
        
        let qrCodeItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrCodeItem]
        
    }
}
