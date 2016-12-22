//
//  AMAInstructionsView.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/22.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class AMAInstructionsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let numberOfPages = 8
    let itemWidth = 280
    let itemHeight = 336
    let identifier = "AMAInstructionsCell"
    
    var backgroundView: UIButton!
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    
    init() {
        super.init(frame: .zero)
        self.customInitalizer()
        self.layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func customInitalizer() {
        backgroundView = UIButton.init(type: .custom)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.addSubview(backgroundView)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        
        pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = numberOfPages
        self.addSubview(pageControl)
    }
    
    func layoutViews() {
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemHeight)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.centerX.equalTo(self)
            make.width.equalTo(itemWidth)
            make.height.equalTo(20)
        }
    }

    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
