//
//  AnimatedHeart.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/28/22.
//
//import SwiftUI
//
//struct AnimatedHeartBackground: View {
//    @State private var animate = false
//
//    var body: some View {
//        ZStack {
//            ForEach(0..<50) { i in
//                Heart(color: self.getRandomColor())
//                    .offset(self.getRandomPosition())
//                    .rotationEffect(.degrees(self.animate ? 360 : 0))
//                    .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false))
//            }
//        }
//        .onAppear {
//            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
//                self.animate.toggle()
//            }
//        }
//    }
//
//    private func getRandomColor() -> Color {
//        let colors: [Color] = [.purple, .pink, .blue, .red]
//        return colors.randomElement()!
//    }
//
//    private func getRandomPosition() -> CGSize {
//        let width = UIScreen.main.bounds.width
//        let height = UIScreen.main.bounds.height
//        let x = CGFloat.random(in: -width/2...width/2)
//        let y = CGFloat.random(in: -height/2...height/2)
//        return CGSize(width: x, height: y)
//    }
//}
//
//
//struct Heart: View {
//    var color: Color
//
//    var body: some View {
//        Path { path in
//            path.move(to: CGPoint(x: 75, y: 40))
//            path.addCurve(to: CGPoint(x: 50, y: 0), control1: CGPoint(x: 75, y: 17.5), control2: CGPoint(x: 50, y: 17.5))
//            path.addCurve(to: CGPoint(x: 25, y: 40), control1: CGPoint(x: 50, y: 22.5), control2: CGPoint(x: 25, y: 22.5))
//            path.addCurve(to: CGPoint(x: 0, y: 0), control1: CGPoint(x: 25, y: 17.5), control2: CGPoint(x: 0, y: 17.5))
//            path.addCurve(to: CGPoint(x: 25, y: -40), control1: CGPoint(x: 0, y: -17.5), control2: CGPoint(x: 25, y: -17.5))
//            path.addCurve(to: CGPoint(x: 50, y: 0), control1: CGPoint(x: 25, y: -22.5), control2: CGPoint(x: 50, y: -22.5))
//            path.addCurve(to: CGPoint(x: 75, y: -40), control1: CGPoint(x: 50, y: -17.5), control2: CGPoint(x: 75, y: -17.5))
//            path.addCurve(to: CGPoint(x: 50, y: 0), control1: CGPoint(x: 75, y: -22.5), control2: CGPoint(x: 50, y: -22.5))
//        }
//        .fill(color)
//        .scaleEffect(0.25)
//        .frame(width: 150, height: 150)
//    }
//}
//
//struct Heart_Previews: PreviewProvider{
//    static var previews: some View{
//        AnimatedHeartBackground()
//    }
//}
