# vividfaces
              
![Vividfaces](https://raw.githubusercontent.com/zoonewbie/vividfaces/master/launchScreengh.png) 

A demo of applying FRCNN on mobile platforms for extracting and training facial landmarks and 3D morph animations.

## Installation
### IOS
Download the project. 
Upzip the zipped file 
$root$/vividFacesDemo/Pods/TensorFlow-experimental/Frameworks/tensorflow_experimental.framework/tensorflow_experimental.zip
in the same folder and then remove the zip file.
Because the github does not support file larger than 100M. But the binary of tf is more than 200M.

## Build and Run
Tensorflow currently is not working on simulators. Make sure the xcode is building for devices or Generic iOS Device.

![demo](https://raw.githubusercontent.com/zoonewbie/vividfaces/master/screenshotgp.jpg) 


## Train on iOS devices

![demo](https://raw.githubusercontent.com/zoonewbie/vividfaces/master/landmark.jpg) 

Framework vividFacesTrainHelper integrates iOS API VNImageRequestHandler providing facial landmark training data. 

In the demo UI the white box with green points is the result of iOS detection; the white box with green points is the prediction of the model.


The image source can be camera, video and web images.

The demo uses the image vision web resource from the website of The Computer Vision Laboratory of  Computer Science Department of University of Massachusetts (http://vis-www.cs.umass.edu). These images are small and because the human heads are all centered in the image, the training base on only these images will be leaded to wrong direction. (If the university find it is annoying of using their web resources in this demo, please let we know, we will remove it.)

The mp4 streaming video is ideally as training resources. Check the function sourceVideoTrain for more detail. 
