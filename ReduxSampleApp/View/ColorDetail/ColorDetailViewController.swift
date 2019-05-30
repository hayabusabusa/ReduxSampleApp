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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        setupUI(color: state.color, heroId: state.heroId)
    }
}

// UI
extension ColorDetailViewController {
    
    func setupUI(color: ColorEntity, heroId: String) {
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
    }
}
