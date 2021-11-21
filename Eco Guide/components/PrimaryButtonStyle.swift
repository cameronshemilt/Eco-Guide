import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    private var color: Color = .accentColor
    private var foregroundColor: Color = .white
    private var scheme: ColorScheme = .light
    
    public init(color: Color = .accentColor,
         foregroundColor: Color = .white,
         scheme: ColorScheme = .light
    ) {
        self.color = color
        self.foregroundColor = foregroundColor
        self.scheme = scheme
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(scheme == .dark ? color : foregroundColor)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(18)
            .background(color.opacity(scheme == .dark ? 0.15 : 1).opacity(configuration.isPressed ? 0.8 : 1))
            .cornerRadius(10)
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button("Button", action: {})
                .buttonStyle(PrimaryButtonStyle(scheme: .light))
                .padding()
            
            Button("Button", action: {})
                .buttonStyle(PrimaryButtonStyle(scheme: .dark))
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}
