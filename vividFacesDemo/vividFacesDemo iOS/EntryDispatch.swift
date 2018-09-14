import Foundation
import UIKit

import Alamofire
import vividFaces

class EntryDispatch: UIViewController {

    @IBOutlet weak var loadingView: AnimView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (VividFaces.modelIsReady()){
            self.goMain()
        }else{
            goDownload()
        }
    }
    func goDownload(){
        self.performSegue(withIdentifier: "segueBrainDownload", sender: nil)
    }
    func goMain(){
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateInitialViewController()
        self.present(vc!, animated: true, completion: {
            print("goMain")
        })
    }
}
