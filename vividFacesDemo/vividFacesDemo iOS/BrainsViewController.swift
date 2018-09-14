import Foundation
import UIKit
import M13ProgressSuite
import vividFaces

class BrainsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progressImage = UIImage(named: "Striped_apple_logo")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setProgress(progress: 0.0)
        
        if VividFaces.modelIsReady() {
            nextPage()
            return
        }
        initCheck()
    }
    @IBOutlet weak var progressView: M13ProgressViewImage!
    func initCheck(){
        let initSuc : ()->() = { () -> () in
            print("vividfaces init suc")
            self.nextPage()
            return
        }
        let initProgress: (CGFloat)->() = { (progress: CGFloat) -> () in
            self.setProgress(progress: progress)
        }
        let initFail = {(error: VFError, onRetry: @escaping ()->(), onCancel: @escaping ()->())  -> () in
            print("vividfaces init Error \(error)")
            UIInterfaceQMUI().createNonCancellableErrorRetryDialog(error: error, onRetry: {
                print("onRetry clicked")
                self.setProgress(progress: 0.0)
                onRetry()
            })()
        }
        VividFaces.mayDownloadModel(onInitSuc: initSuc, onInitFail: initFail, onProgress: initProgress, ignoreDownloadMessage: false)
    }
    func nextPage (){
       //DispatchQueue.main.async {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateInitialViewController()
            self.present(vc!, animated: true, completion: {
                print("nextPage")
            })
        //}
    }
    func setProgress(progress: CGFloat){
        progressView.setProgress(progress, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
