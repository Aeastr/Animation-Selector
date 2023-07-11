//
//  AnimationSelector.swift
//  AnimationsExamples
//
//  Created by Aether on 11/07/2023.
//

import SwiftUI

enum AnimationMode: Int, CaseIterable {
    case enabled
    case reduced
    case disabled
    case extra

    var imageName: String {
        switch self {
        case .disabled:
            return "figure.stand"
        case .reduced:
            return "figure.walk"
        case .enabled:
            return "figure.run"

        case .extra:
            return "cube"
        }}

    var title: String {
        switch self {
        case .disabled:
            return "Disabled"
        case .reduced:
            return "Reduced"
        case .enabled:
            return "Enabled"

        case .extra:
            return "Extra"
        }}
}

struct AnimationsView: View {
    @AppStorage("animationModeKey") private var animationsMode: AnimationMode = .enabled
    @Environment(\.colorScheme) var colorScheme
    let color = Color.indigo // Replace with your desired color

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(AnimationMode.allCases.indices, id: \.self) { index in
                    let mode = AnimationMode.allCases[index]
                    let makeDivider = index < AnimationMode.allCases.count - 1

                    Button {
                        animationsMode = mode
                    } label: {
                        VStack(spacing: 7) {
                            Image(systemName: mode.imageName)
                                .font(.title2)

                            Text(mode.title)
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .padding(.vertical, 13)
                    }
                    .buttonStyle(BouncyButton())

                    if makeDivider {
                      if !(index == animationsMode.rawValue || (index + 1) == animationsMode.rawValue )  {
                        Divider()
                          .frame(width: 0, height: 55)
                      }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 2)
            .background {
                GeometryReader { proxy in
                    let caseCount = AnimationMode.allCases.count
                    color.opacity(0.1)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: proxy.size.width / CGFloat(caseCount))
                        // Offset the background horizontally based on the selected animation mode
                        .offset(x: proxy.size.width / CGFloat(caseCount) * CGFloat(animationsMode.rawValue))
                }
            }

            .padding(12)
            .background {
                Color("NeoButton")
                    .opacity(0.6)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.primary.opacity(colorScheme == .dark ? 0.15 : 0.08), lineWidth: 1.2))

            }
            .padding(.horizontal, 25)
            .animation(.smooth, value: animationsMode)


        }
    }
}

struct BouncyButton: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .scaleEffect(x: configuration.isPressed ? 0.95 : 1.0, y: configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}



struct Animations_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsView()
    }
}

