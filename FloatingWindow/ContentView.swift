//
//  ContentView.swift
//  FloatingWindow
//
//  Created by hesper on 2023-03-02(Thu).
//

import SwiftUI

struct ContentView: View {
    @State var isShow = false
    @State var isShowBlendingWindow = false
    var body: some View {
        VStack {
            Button("显示浮动窗口") {
                isShow.toggle()
            }
            .floatingView(isShow: $isShow) {
                ZStack {
                    Rectangle().fill(.white)
                    Text("浮动大窗")
                }
            }
            Button("浮动玻璃窗口") {
                isShowBlendingWindow.toggle()
            }.floatingView(isShow: $isShowBlendingWindow) {
                VisualEffectView(material: .sidebar, blendingMode: .behindWindow, state: .active, emphasized: false)
            }
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
