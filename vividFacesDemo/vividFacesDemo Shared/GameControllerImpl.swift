//
//  GameControllerImpl.swift
//  vividFacesDemo iOS
//
//  Created by Admin on 2018/7/24.
//  Copyright © 2018 mmy. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import vividFaces

class GameControllerImpl : GameController{
    var indicatorDialog : UIViewController?
    var forShowIndicatorDialog : ()->(UIViewController)
    
    var downloadingBrainDialog : UIViewController?
    var forShowDownloadingBrainDialog : ()->(UIViewController)
    var forProgress : ((CGFloat)->())
    public override init(sceneRenderer renderer: SCNSceneRenderer, modelName : String, modelUrl: URL ) {
        forShowIndicatorDialog = UIInterfaceQMUI().createCommonNonCancellableProgressDialog()
        
        (forShowDownloadingBrainDialog, forProgress) = UIInterfaceQMUI().createDownloadingBrainDialog()
        super.init(sceneRenderer: renderer, modelName: modelName, modelUrl: modelUrl)
    }
    override func showErrorDialog(error: VFError, onRetry: @escaping ()->(), onCancel: @escaping ()->() ){
        //fatalError("Not Implemented 'onError'")
        UIInterfaceQMUI().createErrorRetryDialog(error: error, onRetry: onRetry, onDismiss: onCancel)()
    }
    override func showDownloadProgressDialog() {
        //fatalError("Not Implemented 'showDownloadProgressDialog'")
        downloadingBrainDialog = forShowDownloadingBrainDialog()
        (downloadingBrainDialog as? QMUIAlertController)?.showWith(animated: true)
    }
    override func setProgress(progress: CGFloat) {
        //fatalError("Not Implemented 'setProgress'")
        forProgress(progress)
    }
    override func dismissDownloadProgressDialog() {
        //fatalError("Not Implemented 'dismissDownloadProgressDialog'")
        let qmuiDownloadingBrainDialog = (downloadingBrainDialog as? QMUIAlertController)
        if qmuiDownloadingBrainDialog != nil &&  (qmuiDownloadingBrainDialog?.qmui_isViewLoadedAndVisible())! {
            qmuiDownloadingBrainDialog?.dismiss(animated: true, completion: {
                print("DownloadingBrainDialog dismiss")
            })
        }
    }
    override func showIndicatorDialog() {
        //fatalError("Not Implemented 'showIndicatorDialog'")
        let forShowDialog = UIInterfaceQMUI().createCommonNonCancellableProgressDialog()
        indicatorDialog = forShowDialog()
    }
    override func dismissIndicatorDialog() {
        //fatalError("Not Implemented 'dismissIndicatorDialog'")
        let qmuiIndicatorDialog = (indicatorDialog as? QMUIAlertController)
        if qmuiIndicatorDialog != nil &&  (qmuiIndicatorDialog?.qmui_isViewLoadedAndVisible())! {
            qmuiIndicatorDialog?.dismiss(animated: true, completion: {
                print("indicatorDialog dismiss")
            })
        }
    }
}
