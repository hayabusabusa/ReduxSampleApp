//
//  HomeViewController.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit
import ReSwift

final class HomeViewController: UIViewController, StoreSubscriber {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias StoreSubscriberStateType = HomeState
    
    private var colorList: ColorsEntity = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appStore.subscribe(self) { subscription in
            subscription.select { state in state.homeState }
        }
        appStore.dispatch(HomeState.Action.generateRandomHex())
        appStore.dispatch(HomeState.Action.fetchColorsActionCreator())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appStore.unsubscribe(self)
    }
    
    func newState(state: HomeState) {
        colorList = state.colorList
        collectionView.reloadData()
    }
}

// UI
extension HomeViewController {
    
    func setupUI() {
        // Navigation
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-bold", size: 20) ?? UIFont.systemFont(ofSize: 5)]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.title = "Palette"
        
        // Hero
        navigationController?.hero.isEnabled = true
        collectionView.hero.modifiers = [.cascade]
        
        // CollectionView
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 3.0 - 6.0
        layout.minimumLineSpacing = 4.0
        layout.minimumInteritemSpacing = 4.0
        layout.sectionInset = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        layout.itemSize = CGSize(width: width, height: width)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCollectionViewCell.nib, forCellWithReuseIdentifier: HomeCollectionViewCell.cellReuseIdentifier)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

// CollectionView delegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let vc = UIStoryboard(name: "ColorDetailViewController", bundle: nil).instantiateInitialViewController() as? ColorDetailViewController {
            vc.color = colorList.colors[indexPath.row]
            vc.heroId = "ColorView\(indexPath.row)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// CollectionView dataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.cellReuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.setupCell(color: colorList.colors[indexPath.row])
        cell.hero.modifiers = [.fade, .scale(0.5)]
        cell.hero.id = "ColorView\(indexPath.row)"
        return cell
    }
}
