//
//  FloatingView.swift
//  FloatingWindow
//
//  Created by hesper on 2023-03-02(Thu).
//

import SwiftUI
///用NSPanel封装一个浮动窗口，但是不能被SwiftUI使用 2023-03-05(Sun) 14:50:32
class FloatingView<Content: View>: NSPanel {
    @Binding var isShow: Bool
    
    init(view: () -> Content,
         contentRect: NSRect,
         backing: NSWindow.BackingStoreType = .buffered,
         defer flag: Bool = false,
         isShow: Binding<Bool>) {
        self._isShow = isShow
        
        super.init(contentRect:
                    contentRect,
                   styleMask: [.nonactivatingPanel,.titled, .resizable, .closable, .fullSizeContentView],
                   backing: backing,
                   defer: flag)
        isFloatingPanel = true
        level = .floating
        
        collectionBehavior.insert(.fullScreenAuxiliary)
        
        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        
        isMovableByWindowBackground = true
        
        hidesOnDeactivate = true
        
        standardWindowButton(.closeButton)?.isHidden = true
        standardWindowButton(.miniaturizeButton)?.isHidden = true
        standardWindowButton(.zoomButton)?.isHidden = true
        
        animationBehavior = .utilityWindow
        
        contentView = NSHostingView(rootView: view()
            .ignoresSafeArea()
//            .environment(\.floatingView, self) //让子窗口都可以访问到自身
        )
        
    }
    

    override func resignMain() {
        super.resignMain()
        close()
    }
    
    override func close() {
        super.close()
        isShow = false
    }
    
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return true
    }
    
}


///自定义一个环境变量，访问到浮动窗口 2023-03-05(Sun) 14:53:03
struct FloatingViewKey: EnvironmentKey {
    static let defaultValue: NSPanel? = nil
}

extension EnvironmentValues {
    var floatingView: NSPanel? {
        get { self[FloatingViewKey.self]}
        set { self[FloatingViewKey.self] = newValue}
    }
}

//https://cindori.com/developer/floating-panel
