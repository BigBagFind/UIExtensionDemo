//
//  AMAInstructionsView.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/22.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

// TODO
// 调小视图
// 增加动画


class AMAInstructionsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var viewModel: AMAInstructionsViewModelProtocal
    var backgroundView: UIButton!
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    var hitView: AMAInstructionsHitView!
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.collectionView.scrollToItem(at: IndexPath(item: self.viewModel.initPageIndex, section: 0), at: .centeredHorizontally, animated: false)
//        // self.collectionView.setContentOffset(CGPoint(x: ItemWidth * Double(self.viewModel.initPageIndex), y: 0), animated: false)
//        
//        self.pageControl.currentPage = self.viewModel.initPageIndex
//
//    }
    
    init(viewModel: AMAInstructionsViewModelProtocal) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.customInitalizer()
        self.layoutViews()
        self.showAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customInitalizer() {
        backgroundView = UIButton.init(type: .custom)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.addSubview(backgroundView)
        
        hitView = AMAInstructionsHitView()
        hitView.backgroundColor = UIColor.clear
        self.addSubview(hitView)
        
        let layout = AMAInstructionFlowLayout(contentOffsetPoint: CGPoint(x: ItemWidth * Double(self.viewModel.initPageIndex), y: 0))
        layout.itemSize = CGSize(width: ItemWidth, height: ItemHeight)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 10
        collectionView.register(UINib(nibName: CellIdentifier, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.hitView.addSubview(collectionView)
        
        pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = NumberOfPages
        pageControl.currentPage = self.viewModel.initPageIndex
        pageControl.isUserInteractionEnabled = false
        self.addSubview(pageControl)
    }
    
    func layoutViews() {
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(ItemWidth)
            make.height.equalTo(ItemHeight)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.centerX.equalTo(self)
            make.width.equalTo(ItemWidth)
            make.height.equalTo(20)
        }
        
        hitView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(ItemHeight)
            make.center.equalTo(self)
        }
    }
    
    //MARK:- CollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberOfPages
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! AMAInstructionsCell
        cell.bindViewModel(self.viewModel.itemDisplayData(indexPath: indexPath))
        cell.okButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = self.viewModel.pageControlCurrentIndex(offsetX: Double(collectionView.contentOffset.x))
    }
 
    //Mark:- Animaition
    func dismissAction(_ sender: UIButton) {
        self.pageControl.layer.setValue("0.5", forKey: "opacity")
        UIView.animate(withDuration: AnimationInterval, animations: {
            self.collectionView.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1,y: 0.1))
            self.layer.setValue("0.0", forKey: "opacity")
        }) { (completed) in
            self.removeFromSuperview()
        }
    }
    
    func showAnimation() {
        self.collectionView.alpha = 0
        self.collectionView.layer.setAffineTransform(CGAffineTransform(scaleX: 0.6,y: 0.6))
        self.pageControl.alpha = 0
        self.backgroundView.alpha = 0
        UIView.animate(withDuration: AnimationInterval, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.collectionView.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0,y: 1.0))
            self.collectionView.alpha = 1
            self.backgroundView.alpha = 1
        }) { (completed) in
            self.pageControl.alpha = 1
        }
    }
    
    
    
    
    
    
    
}
