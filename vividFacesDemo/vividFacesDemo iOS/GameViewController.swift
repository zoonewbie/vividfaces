import UIKit
import SceneKit
import vividFaces
import vividFacesTrainHelper//Optional

class GameViewController: UIViewController {
    var gameView: SCNView {
        return self.view as! SCNView
    }
    var gameController: GameController!
    var buttonList: [UIButton] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameController = GameControllerImpl(sceneRenderer: gameView, modelName: modelNames[currentModelIndex], modelUrl: modelUrls[currentModelIndex]!)
        
        // Allow the user to manipulate the camera
        self.gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        
        // Configure the view
        self.gameView.backgroundColor = UIColor.black
        
        // Add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        var gestureRecognizers = gameView.gestureRecognizers ?? []
        gestureRecognizers.insert(tapGesture, at: 0)
        self.gameView.gestureRecognizers = gestureRecognizers
        
        let nextButton = UIButton(type: .system)
        nextButton.frame = CGRect(x: 70, y: 60, width: 140, height: 35)
        nextButton.setTitle("Switch Model", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 21)
        nextButton.tintColor = .white
        nextButton.addTarget(self, action: #selector(nextModel), for: .touchUpInside)
        self.gameView.addSubview(nextButton)
        //buttonList.append(nextButton)
        
        let sourceCameraButton = UIButton(type: .system)
        sourceCameraButton.frame = CGRect(x: 70, y: 100, width: 140, height: 35)
        sourceCameraButton.setTitle("Camera", for: .normal)
        sourceCameraButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 21)
        sourceCameraButton.tintColor = .white
        sourceCameraButton.addTarget(self, action: #selector(sourceCamera), for: .touchUpInside)
        self.gameView.addSubview(sourceCameraButton)
        buttonList.append(sourceCameraButton)
        
        let sourcePhotoButton = UIButton(type: .system)
        sourcePhotoButton.frame = CGRect(x: 70, y: 140, width: 140, height: 35)
        sourcePhotoButton.setTitle("Photos", for: .normal)
        sourcePhotoButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 21)
        sourcePhotoButton.tintColor = .white
        sourcePhotoButton.addTarget(self, action: #selector(sourcePhoto), for: .touchUpInside)
        self.gameView.addSubview(sourcePhotoButton)
        buttonList.append(sourcePhotoButton)
        
        let sourceVideoButton = UIButton(type: .system)
        sourceVideoButton.frame = CGRect(x: 70, y: 180, width: 140, height: 35)
        sourceVideoButton.setTitle("Video", for: .normal)
        sourceVideoButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 21)
        sourceVideoButton.tintColor = .white
        sourceVideoButton.addTarget(self, action: #selector(sourceVideo), for: .touchUpInside)
        self.gameView.addSubview(sourceVideoButton)
        buttonList.append(sourceVideoButton)
        
        let showLandmarkButton = UIButton(type: .system)
        showLandmarkButton.frame = CGRect(x: 70, y: 220, width: 140, height: 35)
        showLandmarkButton.setTitle("Toggle Landmark", for: .normal)
        showLandmarkButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 18)
        showLandmarkButton.tintColor = .white
        showLandmarkButton.addTarget(self, action: #selector(toggleShowLandmark), for: .touchUpInside)
        self.gameView.addSubview(showLandmarkButton)
        
        let trainImageButton = UIButton(type: .system)
        trainImageButton.frame = CGRect(x: 70, y: 260, width: 140, height: 35)
        trainImageButton.setTitle("Web Image Train", for: .normal)
        trainImageButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 17)
        trainImageButton.tintColor = .white
        trainImageButton.addTarget(self, action: #selector(trainWebImage), for: .touchUpInside)
        self.gameView.addSubview(trainImageButton)
        buttonList.append(trainImageButton)
        
        let trainVideoButton = UIButton(type: .system)
        trainVideoButton.frame = CGRect(x: 70, y: 300, width: 140, height: 35)
        trainVideoButton.setTitle("Video Train", for: .normal)
        trainVideoButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 19)
        trainVideoButton.tintColor = .white
        trainVideoButton.addTarget(self, action: #selector(trainVideo), for: .touchUpInside)
        self.gameView.addSubview(trainVideoButton)
        buttonList.append(trainVideoButton)
        
        let trainCameraButton = UIButton(type: .system)
        trainCameraButton.frame = CGRect(x: 70, y: 340, width: 140, height: 35)
        trainCameraButton.setTitle("Camera Train", for: .normal)
        trainCameraButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 17)
        trainCameraButton.tintColor = .white
        trainCameraButton.addTarget(self, action: #selector(trainCamera), for: .touchUpInside)
        self.gameView.addSubview(trainCameraButton)
        buttonList.append(trainCameraButton)
        
        let switchCameraButton = UIButton(type: .system)
        switchCameraButton.frame = CGRect(x: 70, y: 380, width: 140, height: 35)
        switchCameraButton.setTitle("Switch Camera", for: .normal)
        switchCameraButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 17)
        switchCameraButton.tintColor = .white
        switchCameraButton.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)
        self.gameView.addSubview(switchCameraButton)
        
        previewView = UIView(frame: CGRect(x: 300,
                                           y: 10,
                                           width: UIScreen.main.bounds.size.width/previewSizeFrationX,
                                           height: UIScreen.main.bounds.size.height/previewSizeFrationY))
        
        previewView.contentMode = UIViewContentMode.scaleAspectFit
        self.gameView.addSubview(previewView)
    }
    let modelNames = ["dog", "cat", "monkey"]
    let modelUrls = [Bundle.main.url(forResource: "Art.scnassets/puppets/cat/cat", withExtension: "scn"),
                     Bundle.main.url(forResource: "Art.scnassets/puppets/dog/dog", withExtension: "scn"),
                     Bundle.main.url(forResource: "Art.scnassets/puppets/monkey/monkey", withExtension: "scn")
    ]
    var currentModelIndex = 0
    func highlightButton(currentBtn: UIButton){
        for button in buttonList {
            button.tintColor = .white
        }
        currentBtn.tintColor = .yellow
    }
    @objc func nextModel(sender : UIButton) {
        print("Next button pressed!")
        highlightButton(currentBtn: sender)
        //clearState()
        currentModelIndex = (currentModelIndex + 1) % modelNames.count
        gameController.loadModel(modelName: modelNames[currentModelIndex], modelUrl: modelUrls[currentModelIndex]!)
    }
    @objc func sourceCamera(sender : UIButton) {
        print("sourceCamera button pressed!")
        highlightButton(currentBtn: sender)
        clearState()
        let camerRejectBlock: ()->() = {() -> () in
            UIInterfaceQMUI.shoToast(text: "camera rejected")
            return
        }
        gameController.sourceCamera(previewView: previewView, onReject: camerRejectBlock)
        self.gameView.setNeedsLayout()
    }
    @objc func sourcePhoto(sender : UIButton) {
        print("sourcePhoto button pressed!")
        highlightButton(currentBtn: sender)
        clearState()
        let images = [UIImage(named: "Art.scnassets/testImg.jpg"), UIImage(named: "Art.scnassets/testImg1.jpg")]
        gameController.sourceImage(previewView: previewView, images:images as! [UIImage])
        self.gameView.setNeedsLayout()
    }
    @objc func sourceVideo(sender : UIButton) {
        print("sourceVideo button pressed!")
        highlightButton(currentBtn: sender)
        clearState()
        let videoURL = Bundle.main.url(forResource: "Art.scnassets/MarcoRubio", withExtension: "mp4")
        gameController.sourceVideo(previewView: previewView, videoURL: videoURL!)
        self.gameView.setNeedsLayout()
    }
    @objc func toggleShowLandmark(sender : UIButton) {
        print("toggleShowLandmark button pressed!")
        let newState = !gameController.isShowLandmarkInPreview()
        gameController.setShowLandmarkInPreview(previewView: previewView, show: newState)
        if newState {
            sender.tintColor = .yellow
        }else{
            sender.tintColor = .white
        }
        self.gameView.setNeedsLayout()
    }
    var trainSrc : Landmark65TrainSrc?
    @objc func trainWebImage(sender : UIButton) {
        print("train webImage button pressed!")
        highlightButton(currentBtn: sender)
        clearState()
        UIInterfaceQMUI.shoToast(text: "Please wait a while for loading web images...")
        if trainSrc == nil {
            trainSrc = Landmark65TrainSrc()
        }
        self.gameController.sourceImageTrain(previewView: self.previewView)
        let trainBlock : (UIImage, [[CGPoint]]) -> () = {(image: UIImage, normalizedPoints: [[CGPoint]]) -> () in
            self.gameController.trainImage(previewView: self.previewView, image:image, normalizedPoints: normalizedPoints)
            return
        }
        trainSrc!.trainWebImage(forTrain: trainBlock)
        self.gameView.setNeedsLayout()
    }
    @objc func trainVideo(sender : UIButton) {
        print("trainVideo button pressed!")
        highlightButton(currentBtn: sender)
        clearState()
        if trainSrc == nil {
            trainSrc = Landmark65TrainSrc()
        }
        //let videoURL = Bundle.main.url(forResource: "Art.scnassets/MarcoRubio", withExtension: "mp4")
        var videoURL  = NSURL(string: "http://192.168.2.4/a0.mp4")
        UIInterfaceQMUI.shoToast(text: "Find a mp4 on the web and replace the code here. Make sure it supports streaming.")
        let trainsrcBlock : (UIImage) -> ([[CGPoint]]?) = trainSrc!.trainImageBlock()
        self.gameController.sourceVideoTrain(previewView: self.previewView, videoURL: videoURL! as URL, trainsrcBlock: trainsrcBlock)
        self.gameView.setNeedsLayout()
    }
    @objc func trainCamera(sender : UIButton) {
        print("trainCamera button pressed!")
        highlightButton(currentBtn: sender)
        clearState()
        if trainSrc == nil {
            trainSrc = Landmark65TrainSrc()
        }
        let trainsrcBlock : (UIImage) -> ([[CGPoint]]?) = trainSrc!.trainImageBlock()
        
        let camerRejectBlock: ()->() = {() -> () in
            UIInterfaceQMUI.shoToast(text: "camera rejected")
            return
        }
        gameController.sourceCameraTrain(previewView: previewView, trainsrcBlock: trainsrcBlock, onReject: camerRejectBlock)
        self.gameView.setNeedsLayout()
    }
    @objc func switchCamera(sender : UIButton) {
        print("switchCamera button pressed!")
        gameController.switchCamera(previewView: previewView)
        self.gameView.setNeedsLayout()
    }
    func clearState(){
        self.gameController.clearState()
        if trainSrc != nil {
            trainSrc!.stopTrain()
            trainSrc = nil
        }
    }
    var previewView : UIView!
    let previewSizeFrationX: CGFloat = 3.0
    let previewSizeFrationY: CGFloat = 3.0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //updatePreviewLayer()
        previewView.frame =
            CGRect(x: 300,
                   y: 10,
                   width: UIScreen.main.bounds.size.width/previewSizeFrationX,
                   height: UIScreen.main.bounds.size.height/previewSizeFrationY)
        gameController.updatePreviewLayer(previewView: previewView)
    }
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        // Highlight the tapped nodes
        let p = gestureRecognizer.location(in: gameView)
        gameController.highlightNodes(atPoint: p)
    }
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
