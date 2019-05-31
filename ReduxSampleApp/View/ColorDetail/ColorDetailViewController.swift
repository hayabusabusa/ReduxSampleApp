//
//  ColorDetailViewController.swift
//  ReduxSampleApp
//
//  Created by 山田隼也 on 2019/05/28.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit
import ReSwift
import Hero

final class ColorDetailViewController: UIViewController, StoreSubscriber {
    
    typealias StoreSubscriberStateType = ColorDetailState
    
    @IBOutlet weak var mainColorView: UIView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var monochromeStackView: UIStackView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetUI()
        
        appStore.dispatch(ColorDetailState.Action.updateViewState(viewState: .idle))
        appStore.dispatch(ColorDetailState.Action.fetchMonochromeColorsActionCreator())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appStore.subscribe(self) { subscription in
            subscription.select { state in state.colorDetailState }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appStore.unsubscribe(self)
    }
    
    func newState(state: ColorDetailState) {
        switch state.viewState {
        case .loading:
            print("Now loading")
        case .update:
            updateUI(color: state.color, heroId: state.heroId)
            setupMonochrome(colors: state.monochromeColors)
            appStore.dispatch(ColorDetailState.Action.updateViewState(viewState: .show))
        case .error(let error):
            print(error)
        default:
            break
        }
    }
    
    @IBAction func tapFavoriteButton(_ sender: Any) {
        appStore.dispatch(HomeState.Action.updateFavoriteActionCreator())
    }
}

// UI
extension ColorDetailViewController {
    
    func updateUI(color: ColorEntity, heroId: String) {
        // Naviagtion
        navigationItem.title = color.name.value
        
        // UI
        mainColorView.hero.id = heroId
        mainColorView.backgroundColor = UIColor(hex: color.hex.clean)
        mainTitleLabel.text = color.name.value
        titleLabel.text = color.name.value
        redLabel.text = "\(color.rgb.r)"
        greenLabel.text = "\(color.rgb.g)"
        blueLabel.text = "\(color.rgb.b)"
        hexLabel.text = color.hex.value
        addFavoriteButton.setTitle(color.isFavorite ? "Delete favorite" : "Add favorite", for: .normal)
        addFavoriteButton.titleLabel?.textColor = UIColor(hex: color.hex.clean)
    }
    
    func resetUI() {
        monochromeStackView.alpha = 0
        monochromeStackView.superview?.isHidden = true
        monochromeStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func setupMonochrome(colors: ColorsEntity) {
        guard !colors.colors.isEmpty else { return }
        
        monochromeStackView.superview?.isHidden = false
        colors.colors.forEach { color in
            let view = UIView(frame: .zero)
            view.backgroundColor = UIColor(hex: color.hex.clean)
            self.monochromeStackView.addArrangedSubview(view)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.monochromeStackView.alpha = 1.0
        }
    }
}
