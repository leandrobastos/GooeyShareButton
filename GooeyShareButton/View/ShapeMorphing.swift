//
//  ShapeMorphing.swift
//  GooeyShareButton
//
//  Created by Leandro Bastos on 13/06/23.
//

import SwiftUI

struct ShapeMorphing: View {
    var systemImage: String
    var fontSize: CGFloat
    var color: Color = .white
    var duration: CGFloat = 0.5

    @State private var newImage: String = ""
    @State private var radius: CGFloat = 0
    @State private var animatedRadiusValue: CGFloat = 0
    var body: some View {
        GeometryReader {
            let size = $0.size

            Canvas { ctx, size in
                ctx.addFilter(.alphaThreshold(min: 0.5, color: color))
                ctx.addFilter(.blur(radius: animatedRadiusValue))

                ctx.drawLayer { ctx1 in
                    if let resolvedImageView = ctx.resolveSymbol(id: 0) {
                        ctx1.draw(resolvedImageView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                    }
                }
            } symbols: {
                ImageView(size: size)
                    .tag(0)
            }
        }
        .onAppear {
            if newImage == "" {
                newImage = systemImage
            }
        }
        .onChange(of: systemImage) { newValue in
            newImage = newValue
            withAnimation(.linear(duration: duration).speed(2)) {
                radius = 12
            }
        }
        .animationProgress(endValue: radius) { value in
            animatedRadiusValue = value

            if value >= 6 {
                withAnimation(.linear(duration: duration).speed(2)) {
                    radius = 0
                }
            }
        }
    }

    @ViewBuilder
    func ImageView(size: CGSize) -> some View {
        if newImage != "" {
            Image(systemName: newImage)
                .font(.system(size: fontSize))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.9), value: newImage)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.9), value: fontSize)
                .frame(width: size.width, height: size.height)
        }
    }
}

struct ShapeMorphing_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
