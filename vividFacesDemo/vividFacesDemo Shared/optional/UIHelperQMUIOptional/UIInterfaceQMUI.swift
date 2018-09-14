import Foundation
import QMUIKit
import M13ProgressSuite
import vividFaces

public class UIInterfaceQMUI: UIInterface {
    public func createCommonNonCancellableProgressDialog()-> ()->(UIViewController){
        let forShowDialog = {()->(UIViewController) in
            print("implement the closure for showing progress Dialog which cannot be cancelled by user")
            let animView = AnimView()
            let alertController = UIInterfaceQMUI.emptyDialog(customView: animView, title: "Loading", message: "Please wait...")
            return alertController
        }
        return forShowDialog
    }
    public func createErrorRetryDialog(error: VFError, onRetry: @escaping ()->(), onDismiss: @escaping ()->()) -> ()->()  {
        
        let retryHandler: ((QMUIAlertController?, QMUIAlertAction?) -> Swift.Void)! = {arg, arg1 in
            onRetry()
        }
        let actionRetry = QMUIAlertAction(title: getVFConfirmBtnTxt(error: error), style: QMUIAlertActionStyle.default, handler: retryHandler)
        let dismissHandler: ((QMUIAlertController?, QMUIAlertAction?) -> Swift.Void)! = {arg, arg1 in
            onDismiss()
        }
        let actionDismiss = QMUIAlertAction(title: "Dismiss", style: QMUIAlertActionStyle.cancel, handler: dismissHandler)
        var msg = getVFMessage(error: error)
        let alertController = UIInterfaceQMUI.twoBtnDialog(customView: nil, title: "Error", message: msg, action1: actionRetry, action2: actionDismiss)
        let forShowDialog = {()->() in
            print("implement the closure for showing a Dialog of error with two buttons retry and cancel on it")
            print("put 'onDismiss()' in the click event handler of the cancel btn")
            print("put 'onRetry()' in the click event handler of the retry btn")
            alertController.showWith(animated: true)
        }
        return forShowDialog
    }
    public func getVFConfirmBtnTxt(error: VFError) -> String{
        switch error {
        case VFError.AccountExpired:
            return "Retry"
        case VFError.AccountForbbiden:
            return "Retry"
        case VFError.AccountInvalid:
            return "Retry"
        case VFError.DownloadFail:
            return "Retry"
        case VFError.IllegalTerminal:
            return "Retry"
        case VFError.LimitReached:
            return "Retry"
        case VFError.NetworkError:
            return "Retry"
        case VFError.NotWLAN:
            return "Continue Anyway"
        case VFError.SystemError:
            return "Retry"
        case VFError.WrongParams:
            return "Retry"
        case VFError.ModelFileCorrupted:
            return "ReDownload"
        default:
            return "Retry"
        }
    }
    public func getVFMessage(error: VFError) -> String{
        switch error {
        case VFError.AccountExpired:
            return "Account Expired"
        case VFError.AccountForbbiden:
            return "Account Forbbiden"
        case VFError.AccountInvalid:
            return "Account Invalid"
        case VFError.DownloadFail:
            return "Download Fail"
        case VFError.IllegalTerminal:
            return "Illegal Terminal"
        case VFError.LimitReached:
            return "Limit Reached"
        case VFError.NetworkError:
            return "Network Error"
        case VFError.NotWLAN:
            return "Not WLAN. Download huge file is costly."
        case VFError.SystemError:
            return "System Error"
        case VFError.WrongParams:
            return "Wrong Params"
        case VFError.ModelFileCorrupted:
            return "Model File Corrupted"
        default:
            return "Unknown Error"
        }
    }
    public func createNonCancellableErrorRetryDialog(error: VFError, onRetry: @escaping ()->()) -> ()->(){
        let retryHandler: ((QMUIAlertController?, QMUIAlertAction?) -> Swift.Void)! = {arg, arg1 in
            onRetry()
        }
        let actionRetry = QMUIAlertAction(title: getVFConfirmBtnTxt(error: error), style: QMUIAlertActionStyle.default, handler: retryHandler)
        let msg = getVFMessage(error: error)
        let alertController = UIInterfaceQMUI.twoBtnDialog(customView: nil, title: "Error", message: msg, action1: actionRetry, action2: nil)
        let forShowDialog = {()->() in
            print("implement the closure for showing a Dialog of error with two buttons retry and cancel on it")
            print("put 'onRetry()' in the click event handler of the retry btn")
            alertController.showWith(animated: true)
        }
        return forShowDialog
    }
    public func createDownloadingBrainDialog() -> (()->(UIViewController), (_ progress: CGFloat)->()){
        var progressView: M13ProgressViewImage = M13ProgressViewImage(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        progressView.progressImage = UIImage(named: "Striped_apple_logo")
        let alertController = UIInterfaceQMUI.twoBtnDialog(customView: progressView, title: "Brain Downloading...", message: "", action1: nil, action2: nil)
        print("TODO: show a non-cancelable progress dialog for downloading model file. ")
        let forShowDialog = {()->(UIViewController) in
            print("implement the closure for showing progress Dialog")
            alertController.showWith(animated: true)
            return alertController
        }
        let forProgress = {(_ progress: CGFloat)->() in
            print("implement the closure for handling download progress")
            if !alertController.qmui_isViewLoadedAndVisible(){
                alertController.showWith(animated: true)
            }
            progressView.setProgress(progress, animated: true)
        }
        return (forShowDialog, forProgress)
    }
    public func createBrainNeedReDownloadDialog(onConfirm: @escaping ()->()) -> ()->(){
        let confirmHandler: ((QMUIAlertController?, QMUIAlertAction?) -> Swift.Void)! = {arg, arg1 in
            onConfirm()
        }
        let actionConfirm = QMUIAlertAction(title: "Ok", style: QMUIAlertActionStyle.default, handler: confirmHandler)
        let alertController = UIInterfaceQMUI.twoBtnDialog(customView: nil, title: "Download", message: "Download Brain?", action1: actionConfirm, action2: nil)
        let forShowDialog = {()->() in
            print("implement the closure for showing a Dialog with a button of re-download on it")
            print("put 'onConfirm()' in the click event handler of the btn")
            alertController.showWith(animated: true)
        }
        return forShowDialog
    }
    public func createConfirmDownloadUnderWWANDialog(onConfirm: @escaping ()->(), onDismiss: @escaping ()->()) -> ()->(){
        
        let confirmHandler: ((QMUIAlertController?, QMUIAlertAction?) -> Swift.Void)! = {arg, arg1 in
            onConfirm()
        }
        let actionConfirm = QMUIAlertAction(title: "Download under WWAN", style: QMUIAlertActionStyle.default, handler: confirmHandler)
        let dismissHandler: ((QMUIAlertController?, QMUIAlertAction?) -> Swift.Void)! = {arg, arg1 in
            onDismiss()
        }
        let actionDismiss = QMUIAlertAction(title: "Dismiss", style: QMUIAlertActionStyle.cancel, handler: dismissHandler)
        let alertController = UIInterfaceQMUI.twoBtnDialog(customView: nil, title: "Download", message: "Download big file under WWAN is costly.", action1: actionConfirm, action2: actionDismiss)
        let forShowDialog = {()->() in
            print("implement the closure for showing a Dialog of confirming downloading under WWAN with two buttons 'Download under WWAN' and 'cancel' on it")
            print("put 'onDismiss()' in the click event handler of the cancel btn")
            print("put 'onConfirm()' in the click event handler of the 'Download under WWAN' btn")
            alertController.showWith(animated: true)
        }
        return forShowDialog
    }
    
    public func createUnknownErrorDialog(onRetry: @escaping ()->()) -> ()->() {
        let retryHandler: ((QMUIAlertController?, QMUIAlertAction?) -> Swift.Void)! = {arg, arg1 in
            onRetry()
        }
        let actionRetry = QMUIAlertAction(title: "Retry", style: QMUIAlertActionStyle.default, handler: retryHandler)
        let alertController = UIInterfaceQMUI.twoBtnDialog(customView: nil, title: "Error", message: "Unknown error", action1: actionRetry, action2: nil)
        let forShowDialog = {()->() in
            print("implement the closure for showing a Dialog when unknown error occurs")
            print("put 'onRetry()' in the click event handler of the retry btn")
            alertController.showWith(animated: true)
        }
        return forShowDialog
    }
    static func emptyDialog(customView: UIView, title: String, message: String) -> QMUIAlertController{
        let alertController = QMUIAlertController(title: title, message: message, preferredStyle: QMUIAlertControllerStyle.alert)
        
        var titleAttributs : [String: Any] = alertController.alertTitleAttributes
        titleAttributs[NSAttributedStringKey.foregroundColor.rawValue] = UIColor.white
        alertController.alertTitleAttributes = titleAttributs
        var messageAttributs: [String: Any] = alertController.alertMessageAttributes
        messageAttributs[NSAttributedStringKey.foregroundColor.rawValue] = UIColor(red: 255, green: 255, blue: 255, alpha: 0.75)
        
        alertController.alertMessageAttributes = messageAttributs //as! [String : Any]
        if customView != nil{
            alertController.addCustomView(customView)
        }
        alertController.alertHeaderBackgroundColor =
            QDThemeManager.sharedInstance().currentTheme.themeTintColor()
        alertController.alertSeparatorColor = alertController.alertButtonBackgroundColor
        alertController.alertTitleMessageSpacing = 7
        return alertController
    }
    static func twoBtnDialog(customView: UIView?, title: String, message: String, action1: QMUIAlertAction?,  action2: QMUIAlertAction?) -> QMUIAlertController{
        
        let alertController = QMUIAlertController(title: title, message: message, preferredStyle: QMUIAlertControllerStyle.alert)
        
        //action2.button.setImage(UIImageMake("icon_emotion").qmui_imageWithScale(toSize: CGSize(width: CGFloat(18), height: CGFloat(18)), contentMode: .scaleToFill).qmui_image(with: QDThemeManager.sharedInstance().currentTheme.themeTintColor), for: .normal)
        action2?.button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8)
        
        var titleAttributs : [String: Any] = alertController.alertTitleAttributes
        print("xxx\(NSAttributedStringKey.foregroundColor.rawValue)")
        titleAttributs[NSAttributedStringKey.foregroundColor.rawValue] = UIColor.white
        alertController.alertTitleAttributes = titleAttributs
        var messageAttributs: [String: Any] = alertController.alertMessageAttributes
        messageAttributs[NSAttributedStringKey.foregroundColor.rawValue] = UIColor(red: 255, green: 255, blue: 255, alpha: 0.75)
        
        alertController.alertMessageAttributes = messageAttributs //as! [String : Any]
        if customView != nil{
            alertController.addCustomView(customView)
        }
        alertController.alertHeaderBackgroundColor =
            QDThemeManager.sharedInstance().currentTheme.themeTintColor()
        alertController.alertSeparatorColor = alertController.alertButtonBackgroundColor
        alertController.alertTitleMessageSpacing = 7
        
        var buttonAttributes: [String: Any] = alertController.alertButtonAttributes
        buttonAttributes[NSAttributedStringKey.foregroundColor.rawValue] = alertController.alertHeaderBackgroundColor
        alertController.alertButtonAttributes = buttonAttributes //as! [String : Any]
        var cancelButtonAttributes: [String: Any] = alertController.alertCancelButtonAttributes
        cancelButtonAttributes[NSAttributedStringKey.foregroundColor.rawValue] = buttonAttributes[NSAttributedStringKey.foregroundColor.rawValue]
        alertController.alertCancelButtonAttributes = cancelButtonAttributes// as! [String : Any]
        if action1 != nil {
            alertController.addAction(action1!)
        }
        if action2 != nil {
            alertController.addAction(action2!)
        }
        return alertController
    }
    static func shoToast(text: String){
        QMUITips.show(withText: text)
    }
}
