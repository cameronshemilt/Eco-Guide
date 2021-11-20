import SwiftUI

struct ProgressRing: View {
    var size: CGFloat
    var lineSize: CGFloat { size/9 }
    var fontSize: CGFloat { size / 4 }
    var fontWeight: Font.Weight {
        if size < 10 {
            return .thin
        } else if size < 20 {
            return .regular
        } else if size < 30 {
            return .medium
        } else if size < 40 {
            return .semibold
        } else {
            return .bold
        }
    }
    var percentage: CGFloat
    var progress: CGFloat { (100 - (percentage * 100)) / 100 }
    var color: Color
    @State var show: Bool = false
    
    init(_ percentage: CGFloat, color: Color = .accentColor) {
        self.size = 44
        self.percentage = percentage
        self.color = color
    }
    
    private init (_ percentage: CGFloat, color: Color, size: CGFloat) {
        self.size = size
        self.percentage = percentage
        self.color = color
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.1), style: StrokeStyle(lineWidth: lineSize))
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(color, style: StrokeStyle(lineWidth: lineSize, lineCap: .round))
                .animation(Animation.easeInOut.delay(0.2))
                .frame(width: size, height: size)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            
            UnitText("\(Int(percentage * 100))" , unit: "%")
                .fontSize(fontSize)
                .foregroundColor(color)
        }.onAppear(perform: {
            self.show = true
        })
    }
    
    func diameter(_ size: CGFloat) -> some View {
        return ProgressRing(percentage, color: color, size: size)
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 100) {
            ProgressRing(0.75)
                .diameter(90)
            ProgressRing(0.5)
            ProgressRing(0.25)
                .diameter(22)
        }
    }
}
