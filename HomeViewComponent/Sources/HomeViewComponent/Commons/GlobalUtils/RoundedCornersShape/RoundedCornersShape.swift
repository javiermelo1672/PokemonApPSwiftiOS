//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import UIKit
import SwiftUI

public struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

