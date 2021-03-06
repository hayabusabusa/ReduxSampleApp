//
//  HomeViewController.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit
import ReSwift
import JGProgressHUD

final class HomeViewController: UIViewController, StoreSubscriber {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias StoreSubscriberStateType = HomeState
    
    private var progressHud: JGProgressHUD!
    private var refreshControl: UIRefreshControl!
    private var colorList: ColorsEntity = .init() {
        didSet {
            refreshControl.endRefreshing()
            collectionView.reloadData()
        }
    }
    
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
        switch state.request {
        case .loading:
            showLoading()
        case .success:
            hideLoading()
            colorList = state.colorList
        case .error:
            hideLoading()
            refreshControl.endRefreshing()
            showError(message: "Something wrong")
        default:
            break
        }
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
        navigationController?.hero.navigationAnimationType = .fade
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
        
        // RefreshControl
        refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func showLoading() {
        if progressHud == nil {
            progressHud = JGProgressHUD(style: .dark)
            progressHud.textLabel.text = "Loading"
            progressHud.show(in: self.view)
        }
    }
    
    func hideLoading() {
        if progressHud != nil {
            progressHud.dismiss(afterDelay: 0.5)
            progressHud = nil
        }
    }
    
    func showError(message: String) {
        if progressHud == nil {
            progressHud = JGProgressHUD(style: .dark)
            progressHud.textLabel.text = "Error"
            progressHud.detailTextLabel.text = message
            progressHud.show(in: self.view)
            progressHud.dismiss(afterDelay: 3.0)
        }
    }
}

// CollectionView delegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        appStore.dispatch(ColorDetailState.Action.setColor(color: colorList.colors[indexPath.row], heroId: "ColorView\(indexPath.row)"))
        
        let vc = UIStoryboard(name: "ColorDetailViewController", bundle: nil).instantiateInitialViewController() ?? UIViewController()
        navigationController?.pushViewController(vc, animated: true)
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

// RefreshControl
extension HomeViewController {
    
    @objc func refresh() {
        appStore.dispatch(HomeState.Action.refreshHexActionCreator())
        appStore.dispatch(HomeState.Action.fetchColorsActionCreator())
    }
}
