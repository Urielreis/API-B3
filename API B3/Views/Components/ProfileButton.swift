//
//  ProfileButton.swift
//  API B3
//

import SwiftUI
import UIKit

/// Componente de botão para a barra de perfil
struct ProfileButton: View {
    // Ícone do botão
    let icon: String
    
    // Título do botão
    let title: String
    
    // Ação a ser executada quando o botão for pressionado
    var action: () -> Void
    
    // Estado para controlar o efeito de escala ao tocar no botão
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button(action: {
            // Feedback háptico ao pressionar o botão
            let impactLight = UIImpactFeedbackGenerator(style: .light)
            impactLight.impactOccurred()
            
            // Executa a ação definida
            action()
        }) {
            VStack(spacing: 8) {
                // Ícone do botão
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color("AppPrimary").opacity(0.7),
                                    Color("AppPrimary Variant").opacity(0.5)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                }
                .scaleEffect(isPressed ? 0.9 : 1.0)
                
                // Texto do botão
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: 50, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.2)) {
                self.isPressed = pressing
            }
        }, perform: { })
    }
}

// Visualização de prévia para o componente
#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        
        HStack(spacing: 20) {
            ProfileButton(icon: "creditcard", title: "Cartões", action: {})
            ProfileButton(icon: "chart.line.uptrend.xyaxis", title: "Investimentos", action: {})
            ProfileButton(icon: "clock.arrow.circlepath", title: "Histórico", action: {})
            ProfileButton(icon: "questionmark.circle", title: "Suporte", action: {})
        }
        .padding()
    }
}