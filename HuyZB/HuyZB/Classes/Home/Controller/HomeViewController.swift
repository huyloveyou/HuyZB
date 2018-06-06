//
//  HomeViewController.swift
//  HuyZB
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 come.huy. All rights reserved.
//

import UIKit

private let hTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: hStatusBarH + hNavigationBarH, width: hScreenW, height: hTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.blue
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        let contentH = hScreenH - hStatusBarH - hNavigationBarH - hTitleViewH
        let contentFrame = CGRect(x: 0, y: hStatusBarH + hNavigationBarH + hTitleViewH, width: hScreenW, height: contentH)
        
        var childVc = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVc.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVc, parentViewController: self)
        contentView.delegate = self //成为代理
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

//设置UI界面
extension HomeViewController {
    private func setupUI(){
        // MARK: 不需要调整scrollView内边距
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
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

extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(curretIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
