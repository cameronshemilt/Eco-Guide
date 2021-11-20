import SwiftUI

struct UnitText: View {
    var text: String
    var unit: String
    var fontSize: CGFloat = 25
    
    init(_ text: String, unit: String) {
        self.text = text
        self.unit = unit
    }
    
    var body: some View {
        HStack(alignment:.bottom, spacing: fontSize*0.17) {
            Text(text)
                .font(.system(size: fontSize, weight: .semibold, design: .rounded))
            
            Text(unit)
                .font(.system(size: (fontSize*0.7), weight: .semibold, design: .rounded))
                .padding(.bottom, (fontSize*0.1))
        }
    }
    
    func fontSize(_ fontSize: CGFloat) -> some View{
        var copy = self
        copy.fontSize = fontSize
        return copy
    }
}

struct UnitText_Previews: PreviewProvider {
    static var previews: some View {
        UnitText("42", unit: "Questions")
            .fontSize(40)
    }
}
