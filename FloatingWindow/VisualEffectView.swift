//
//  VisualEffectView.swift
//  FloatingWindow
//
//  Created by hesper on 2023-03-05(Sun).
//

import SwiftUI

/// 将特效窗口集成到swiftui中 2023-03-05(Sun) 14:55:38
struct VisualEffectView: NSViewRepresentable {
    
    var material : NSVisualEffectView.Material
    var blendingMode : NSVisualEffectView.BlendingMode
    var state: NSVisualEffectView.State
    var emphasized: Bool
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        context.coordinator.visualEffectView
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        context.coordinator.update(material: material, blendingMode: blendingMode, state: state, emphasized: emphasized)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        let visualEffectView = NSVisualEffectView()
        
        init() {
            visualEffectView.blendingMode = .withinWindow
        }
        
        func update(material: NSVisualEffectView.Material,
                    blendingMode: NSVisualEffectView.BlendingMode,
                    state: NSVisualEffectView.State,
                    emphasized: Bool) {
            visualEffectView.material = material
        }
        
    }
    
}
