//
//  PageTitleView.swift
//  HuyZB
//
//  Created by mac on 2018/5/26.
//  Copyright © 2018年 come.huy. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index : Int)
}

private let scrollLineH : CGFloat = 2
private let normalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85)
private let selectColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)
class PageTitleView: UIView {

    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate: PageTitleViewDelegate?
    
    // MARK: - 记录数组
    private lazy var labels : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false;
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels(){
        print(titles.count)
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        print(frame.width,labelW)
        let labelH : CGFloat = frame.height - scrollLineH
        let labelY : CGFloat = 0
        
        for(index, title) in titles.enumerated() {
            print(title,index)
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            labels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLabel = labels.first else {return}
        firstLabel.textColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollLineH, width: firstLabel.frame.width, height: scrollLineH)
    }
}

extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        guard let currentLabel = tapGes.view as? UILabel else { return }
        let oldLabel = labels[currentIndex]
        currentLabel.textColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
        oldLabel.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
        currentIndex = currentLabel.tag
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int){
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelta = (selectColor.0 - normalColor.0, selectColor.1 - normalColor.1, selectColor.2 - normalColor.2)
        
        sourceLabel.textColor = UIColor(r: selectColor.0 - colorDelta.0 * progress, g: selectColor.1 - colorDelta.1 * progress, b: selectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: normalColor.0 + colorDelta.0 * progress, g: normalColor.1 + colorDelta.1 * progress, b: normalColor.2 + colorDelta.2 * progress)
    }
}
