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

In the demo UI the white box with green points indicate the result of iOS detection; the white box with green points is the prediction of the model.


The image source can be camera, video and web images.

The demo uses the image vision web resource from the website of The Computer Vision Laboratory of  Computer Science Department of University of Massachusetts (http://vis-www.cs.umass.edu). These images are small and because the human heads are all centered in the image, the training base on only these images will be leaded to wrong direction. (If the university find it is annoying of using their web resources in this demo, please let we know, we will remove it.)

The mp4 streaming video is ideally as training resources. Check the function trainVideo for more detail.

# About the Animoji 3D models used in the demo
Animoji is the product of Apple inc. (https://apple.com/ ) which is first introduced in iPhone X in 2017. The 3D cartoon model files are assets of apple and can be achieved on the internet. Note the Animoji of Apple is not open and free.
VividFaces uses Animoji models only for research purpose. Please do not try to use this assets in your business software or even try to upload it to App store. Because it will be denied by apple.
But you can recreate 3d models of your own based on the same facial morph structure. Anyone who has the 3D modeling knowledge will find these models followed same bone/morph/skin structure of the well-known opened productions. Even the same morph names had been used for decades. 
 ## Tensorflow modelling

The tensorflow framework used in the demo is a customized version of tf 1.8. It is not compatible with the one published by google.

The frcnn model build here is also the customized one. Because the process of building it is too complicated so the details of how to make it will be not describe here. Google’s object detection has the code of keypoints detection half made but after testing none of their models works (untill Sep. 2018). 

Actually none of any open tensorflow facial keypoints detections projects works currently if the keypoints number is bigger than 10 (untill Sep. 2018). So, we decided to make one. It is not fully completed but helped by some unproved mathematical theories it has show great promising.  

The version published now only contained the model pb file. The checkpoint data is not included. You can train the model yourself on your mobiles.

A more accurate facial landmark and morph modelling is coming soon.

Enjoy.
