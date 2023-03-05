//
//  FloatingView+Modifier.swift
//  FloatingWindow
//
//  Created by hesper on 2023-03-05(Sun).
//

import Foundation
import SwiftUI

///让view的modifer方法能够创建浮动窗口 2023-03-05(Sun) 14:54:10
fileprivate struct FloatingViewModifier<ViewContent: View>: ViewModifier {
    @Binding var isShow: Bool
    
    var contentRect: CGRect = CGRect(x: 0, y: 0, width: 600, height: 500)
    
    @ViewBuilder let view: () -> ViewContent
    
    @State var floatingView: FloatingView<ViewContent>?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                floatingView = FloatingView(view: view, contentRect: contentRect, isShow: $isShow)
                floatingView?.center()
                if isShow {
                    show()
                }
            }
            .onDisappear {
                floatingView?.close()
                floatingView = nil
            }
            .onChange(of: isShow) { newValue in
                if newValue {
                    show()
                } else {
                    floatingView?.close()
                }
            }
    }
    
    func show() {
        floatingView?.orderFront(nil)
        floatingView?.makeKey()
    }
    
}

///将modifier的调用简便化 2023-03-05(Sun) 14:54:41
extension View {
    func floatingView<Content: View>(
        isShow: Binding<Bool>,
        contentRect: CGRect = CGRect(x: 0, y: 0, width: 600, height: 500),
        @ViewBuilder content: @escaping () -> Content) -> some View {
            self.modifier(FloatingViewModifier(isShow: isShow, contentRect: contentRect , view: content))
        }
}
