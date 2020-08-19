//
//  RGBCube.swift
//
//  Created by patrick piemonte on 5/14/18.
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

import Foundation
import SceneKit

extension SCNGeometry {
    
    /// RGB color space as a unit cube.
    /// - Parameter length: Length of the cube's sides.
    /// - Returns: Geometry of a unit cube to be used in a node.
    public class func rgbCube(_ length: CGFloat = 0.5) -> SCNGeometry {
        let halfLength = length * 0.5
        
        let vertices: [SCNVector3] = [SCNVector3(-halfLength, -halfLength,  halfLength),
                                      SCNVector3( halfLength, -halfLength,  halfLength),
                                      SCNVector3(-halfLength, -halfLength, -halfLength),
                                      SCNVector3( halfLength, -halfLength, -halfLength),
                                      SCNVector3(-halfLength,  halfLength,  halfLength),
                                      SCNVector3( halfLength,  halfLength,  halfLength),
                                      SCNVector3(-halfLength,  halfLength, -halfLength),
                                      SCNVector3( halfLength,  halfLength, -halfLength),
                                      
                                      SCNVector3(-halfLength, -halfLength,  halfLength),
                                      SCNVector3( halfLength, -halfLength,  halfLength),
                                      SCNVector3(-halfLength, -halfLength, -halfLength),
                                      SCNVector3( halfLength, -halfLength, -halfLength),
                                      SCNVector3(-halfLength,  halfLength,  halfLength),
                                      SCNVector3( halfLength,  halfLength,  halfLength),
                                      SCNVector3(-halfLength,  halfLength, -halfLength),
                                      SCNVector3( halfLength,  halfLength, -halfLength),
                                      
                                      SCNVector3(-halfLength, -halfLength,  halfLength),
                                      SCNVector3( halfLength, -halfLength,  halfLength),
                                      SCNVector3(-halfLength, -halfLength, -halfLength),
                                      SCNVector3( halfLength, -halfLength, -halfLength),
                                      SCNVector3(-halfLength,  halfLength,  halfLength),
                                      SCNVector3( halfLength,  halfLength,  halfLength),
                                      SCNVector3(-halfLength,  halfLength, -halfLength),
                                      SCNVector3( halfLength,  halfLength, -halfLength)]
        let vertexSource = SCNGeometrySource(vertices: vertices)
        let indices: [Int32] = [0, 2, 1,
                                1, 2, 3,
                                10, 14, 11,
                                11, 14, 15,
                                16, 20, 18,
                                18, 20, 22,
                                17, 19, 21,
                                19, 23, 21,
                                8,  9, 12,
                                9, 13, 12,
                                4, 5, 6,
                                5, 7, 6]
        let indexElement = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        
        let normals: [SCNVector3] = [SCNVector3( 0, -1, 0),
                                     SCNVector3( 0, -1, 0),
                                     SCNVector3( 0, -1, 0),
                                     SCNVector3( 0, -1, 0),
                                     
                                     SCNVector3( 0, 1, 0),
                                     SCNVector3( 0, 1, 0),
                                     SCNVector3( 0, 1, 0),
                                     SCNVector3( 0, 1, 0),
                                     
                                     SCNVector3( 0, 0,  1),
                                     SCNVector3( 0, 0,  1),
                                     SCNVector3( 0, 0, -1),
                                     SCNVector3( 0, 0, -1),
                                     
                                     SCNVector3( 0, 0, 1),
                                     SCNVector3( 0, 0, 1),
                                     SCNVector3( 0, 0, -1),
                                     SCNVector3( 0, 0, -1),
                                     
                                     SCNVector3(-1, 0, 0),
                                     SCNVector3( 1, 0, 0),
                                     SCNVector3(-1, 0, 0),
                                     SCNVector3( 1, 0, 0),
                                     
                                     SCNVector3(-1, 0, 0),
                                     SCNVector3( 1, 0, 0),
                                     SCNVector3(-1, 0, 0),
                                     SCNVector3( 1, 0, 0)]
        let normalSource = SCNGeometrySource(normals: normals)
        
        let colors: [SCNVector3] = [SCNVector3(1, 0, 1),
                                    SCNVector3(0, 0, 1),
                                    SCNVector3(1, 0, 0),
                                    SCNVector3(0, 0, 0),
                                    
                                    SCNVector3(1, 1, 1),
                                    SCNVector3(0, 1, 1),
                                    SCNVector3(1, 1, 0),
                                    SCNVector3(0, 1, 0),
                                    
                                    SCNVector3(1, 0, 1),
                                    SCNVector3(0, 0, 1),
                                    SCNVector3(1, 0, 0),
                                    SCNVector3(0, 0, 0),
                                    
                                    SCNVector3(1, 1, 1),
                                    SCNVector3(0, 1, 1),
                                    SCNVector3(1, 1, 0),
                                    SCNVector3(0, 1, 0),
                                    
                                    SCNVector3(1, 0, 1),
                                    SCNVector3(0, 0, 1),
                                    SCNVector3(1, 0, 0),
                                    SCNVector3(0, 0, 0),
                                    
                                    SCNVector3(1, 1, 1),
                                    SCNVector3(0, 1, 1),
                                    SCNVector3(1, 1, 0),
                                    SCNVector3(0, 1, 0)]
            
        let colorData = NSData(bytes: colors,
                               length: MemoryLayout<SCNVector3>.size * colors.count)
        let colorSource = SCNGeometrySource(data: colorData as Data,
                                            semantic: SCNGeometrySource.Semantic.color,
                                            vectorCount: colors.count,
                                            usesFloatComponents: true,
                                            componentsPerVector: 3,
                                            bytesPerComponent: MemoryLayout<Float>.size,
                                            dataOffset: 0,
                                            dataStride: MemoryLayout<SCNVector3>.size)
        
        let geometry = SCNGeometry(sources: [vertexSource, normalSource, colorSource],
                                   elements: [indexElement])
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        geometry.materials = [material]
        
        return geometry
    }
    
}
