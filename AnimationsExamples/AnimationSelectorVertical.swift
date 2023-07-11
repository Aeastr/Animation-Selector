//
//  AnimationSelectorVertical.swift
//  AnimationsExamples
//
//  Created by Aether on 11/07/2023.
//

import SwiftUI

struct AnimationSelectorVertical: View {
    @AppStorage("animationModeKey") private var animationsMode: AnimationMode = .enabled
    @Environment(\.colorScheme) var colorScheme
    let color = Color.indigo // Replace with your desired color

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach(AnimationMode.allCases.indices, id: \.self) { index in
                    let mode = AnimationMode.allCases[index]
                    let makeDivider = index < AnimationMode.allCases.count - 1

                    Button {
                        animationsMode = mode
                    } label: {
                        HStack(spacing: 7) {
                            Image(systemName: mode.imageName)
                                .font(.title2)

                            Text(mode.title)
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .padding(.vertical, 13)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(BouncyButton())

                    if makeDivider {
                      if !(index == animationsMode.rawValue || (index + 1) == animationsMode.rawValue )  {
                        Divider()
                          .frame(width: 310, height: 0)
                          .transition(.asymmetric(insertion: .opacity.animation(.linear(duration: 0.1).delay(0.15)), removal: .opacity.animation(.linear(duration: 0.1))))
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
                        .frame(height: proxy.size.height / CGFloat(caseCount))
                        // Offset the background horizontally based on the selected animation mode
                        .offset(y: proxy.size.height / CGFloat(caseCount) * CGFloat(animationsMode.rawValue))
                }
            }

            .padding(12)
            .background {
                Color(.systemBackground)
                    .opacity(0.6)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.primary.opacity(colorScheme == .dark ? 0.15 : 0.08), lineWidth: 1.2))

            }
            .padding(.horizontal, 25)
            .animation(.smooth, value: animationsMode)


        }
    }
}

#Preview {
    AnimationSelectorVertical()
}
