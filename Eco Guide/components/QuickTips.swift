//
//  QuickTips.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 20.11.21.
//

import SwiftUI
import Combine

#warning("hold gesture")
#warning("close button")

struct QuickTips: View {
    @Environment(\.dismiss) private var dismiss
    
    private let facts: [FunFact]
    @ObservedObject private var storyTimer: StoryTimer
    
    private var factIndex: Int {
        return Int(self.storyTimer.progress) % facts.count
    }
    
    init(facts: [FunFact]) {
        self.facts = facts
        self.storyTimer = StoryTimer(items: facts.count, interval: 10.0)
    }
    
    var body: some View {
        VStack {
            progressBars
            
            Spacer()
            
            Text(facts[factIndex].fact)
                .font(.title.bold())
                .padding(.bottom, 30)
            
            Spacer()
            
            Button(action: {
                #warning("todo: export tip")
            }) {
                Image(systemSymbol: .squareAndArrowUp)
                    .font(.largeTitle)
            }
        }
        .shadow(radius: 15)
        .padding(.horizontal, 30)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            Color.black
                .ignoresSafeArea()
                .opacity(0.6)
            splitTapGesture
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
        .onAppear { self.storyTimer.start() }
        .onChange(of: storyTimer.done) { done in
            if done { dismiss() }
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.height > 0 {
                        dismiss()
                    }
                })
        )
    }
    
    private var splitTapGesture: some View {
        HStack {
            Color.clear.contentShape(Rectangle())
                .onTapGesture { self.storyTimer.advance(by: -1) }
            Color.clear.contentShape(Rectangle())
                .onTapGesture { self.storyTimer.advance(by: 1) }
        }
    }
    
    private var progressBars: some View {
        HStack {
            ForEach(self.facts.indices) { x in
                ProgressBar(value: min(max((CGFloat(self.storyTimer.progress) - CGFloat(x)), 0.0), 1.0))
                    .animation(.linear, value: self.storyTimer.progress)
            }
        }
        .foregroundColor(.white)
    }
    
    private var backgroundImageName: String {
        let category = facts[factIndex].category
        return category.images[factIndex % category.images.count]
    }
}

fileprivate struct ProgressBar: View {
    let value: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.5)
                //                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle()
                    .frame(width: min(self.value * geometry.size.width, geometry.size.width), height: geometry.size.height)
                //                    .foregroundColor(Color(UIColor.systemBlue))
            }
            .cornerRadius(45.0)
        }
        .frame(height: 7)
    }
}

fileprivate class StoryTimer: ObservableObject {
    @Published var progress: Double
    private var interval: TimeInterval
    private var max: Int
    private let publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    @Published var done: Bool
    
    init(items: Int, interval: TimeInterval) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
        self.done = false
    }
    
    func start() {
        self.cancellable = self.publisher.autoconnect().sink(receiveValue: {  _ in
            var newProgress = self.progress + (0.1 / self.interval)
            if Int(newProgress) >= self.max {
                newProgress = 0
                self.done = true
            }
            self.progress = newProgress
        })
    }
    
    func advance(by number: Int) {
        var newProgress = Swift.max((Int(self.progress) + number), 0)
        if Int(newProgress) >= self.max {
            newProgress = 0
            self.done = true
        }
        self.progress = Double(newProgress)
    }
}

struct QuickTips_Previews: PreviewProvider {
    static var previews: some View {
        QuickTips(facts: Array(FunFact.data.dropFirst(4)))
    }
}
