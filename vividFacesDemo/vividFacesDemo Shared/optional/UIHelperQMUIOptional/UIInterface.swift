//
//  UIInterface.swift
//  vividFaces
//
//  Created by Admin on 2018/7/7.
//  Copyright © 2018 mmy. All rights.
import vividFaces

public protocol UIInterface {
    func createCommonNonCancellableProgressDialog()-> ()->(UIViewController)
    func createErrorRetryDialog(error: VFError, onRetry: @escaping ()->(), onDismiss: @escaping ()->()) -> ()->()
    func createNonCancellableErrorRetryDialog(error: VFError, onRetry: @escaping ()->()) -> ()->()
    func createDownloadingBrainDialog() -> (()->(UIViewController), (_ progress: CGFloat)->())
    func createBrainNeedReDownloadDialog(onConfirm: @escaping ()->()) -> ()->()
    func createConfirmDownloadUnderWWANDialog(onConfirm: @escaping ()->(), onDismiss: @escaping ()->()) -> ()->()
    func createUnknownErrorDialog(onRetry: @escaping ()->()) -> ()->()
}
