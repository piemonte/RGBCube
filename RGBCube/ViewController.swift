//
//  ViewController.swift
//  RGBCube
//
//  Created by patrick piemonte on 8/18/20.
//  Copyright © 2020 Patrick Piemonte. All rights reserved.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015-present patrick piemonte (http://patrickpiemonte.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import Foundation
import SceneKit
import simd

public final class ViewController: UIViewController {
    
    // MARK: - properties
    
    // MARK: - ivars
    
    private lazy var _sceneView: SCNView = {
        let sceneView = SCNView()
        sceneView.backgroundColor = UIColor.clear
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sceneView.antialiasingMode = .multisampling4X
        return sceneView
    }()
    private var _scene: SCNScene?
    private var _camera: SCNNode?
    private var _ambientLight: SCNNode?
    private var _node: SCNNode?
    
    // MARK: - object lifecycle
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        self._sceneView.scene = nil
    }
    
    // MARK: - view lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        let sceneView = self._sceneView
        sceneView.frame = self.view.bounds
        self.view.addSubview(self._sceneView)
        
        self.setupScene()
        self.setupCamera()
        self.setupLighting()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let rotationXAction = SCNAction.rotate(by: (.pi / 4), around: SCNVector3(1, 0, 0), duration: 5.0)
        let rotationYAction = SCNAction.rotate(by: (.pi / 4), around: SCNVector3(0, 1, 0), duration: 5.0)
        let rotationZAction = SCNAction.rotate(by: -(.pi / 4), around: SCNVector3(0, 0, 1), duration: 5.0)
        let groupAction = SCNAction.group([rotationXAction, rotationYAction, rotationZAction])
        let rotateForever = SCNAction.repeatForever(groupAction)
        self._node?.runAction(rotateForever)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self._node?.removeAllAnimations()
    }
    
}

// MARK: - setup

extension ViewController {
    
    fileprivate func setupScene() {
        self._scene = SCNScene()
        self._sceneView.scene = self._scene
        
        SCNTransaction.begin()
        let node = SCNNode(geometry: SCNGeometry.rgbCube(0.25))
        node.renderingOrder = 5
        node.castsShadow = true
        self._scene?.rootNode.addChildNode(node)
        self._node = node
        SCNTransaction.commit()
        
        self._sceneView.isPlaying = true
        
        self._sceneView.defaultCameraController.interactionMode = .orbitTurntable
        self._sceneView.defaultCameraController.inertiaEnabled = true
        self._sceneView.allowsCameraControl = true
    }
    
    fileprivate func setupCamera() {
        self._camera = SCNNode()
        if let cameraNode = self._camera {
            SCNTransaction.begin()
            let camera = SCNCamera()
            camera.zFar = 100
            camera.zNear = 0.1
            camera.fieldOfView = 25
            cameraNode.camera = camera
            cameraNode.position = SCNVector3(x: 0, y: 0, z: 3.2)
            self._sceneView.pointOfView = cameraNode
            SCNTransaction.commit()
        }
    }
    
    fileprivate func setupLighting() {
        SCNTransaction.begin()
        self._ambientLight = SCNNode()
        if let ambientLight = self._ambientLight {
            ambientLight.name = "AmbientLight"
            ambientLight.light = SCNLight()
            ambientLight.light?.type = .ambient
            ambientLight.light?.color = UIColor.lightGray
            ambientLight.light?.intensity = 200
            ambientLight.position = SCNVector3Make(0, 10.0, 0)
            self._scene?.rootNode.addChildNode(ambientLight)
        }
        SCNTransaction.commit()
    }
}

