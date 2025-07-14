//
//  ActionButton.swift
//  API B3
//
//

import SwiftUI
import UIKit // Importado para usar o feedback háptico

/// Componente de botão de ação padronizado para a interface
struct ActionButton: View {
    // Ícone do botão
    let icon: String
    
    // Título do botão
    let title: String
    
    // Cor de fundo do botão
    let color: Color
    
    // Ação a ser executada quando o botão for pressionado
    var action: () -> Void = {}
    
    // Corpo da visualização que define a aparência do componente
    var body: some View {
        Button(action: {
            // Feedback háptico ao pressionar o botão
            let impactMed = UIImpactFeedbackGenerator(style: .light)
            impactMed.impactOccurred()
            
            // Executa a ação definida
            action()
        }) {
            VStack(spacing: 8) {
                // Ícone do botão
                Circle()
                    .fill(color)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(.white)
                    )
                
                // Texto do botão
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Visualização de prévia para o componente
#Preview {
    HStack {
        ActionButton(icon: "plus", title: "Add saving", color: Color.gray.opacity(0.2))
        ActionButton(icon: "arrow.up", title: "Withdraw", color: Color.gray.opacity(0.2))
        ActionButton(icon: "arrow.down", title: "Top up", color: Color.gray.opacity(0.2))
        ActionButton(icon: "arrow.2.squarepath", title: "Exchange", color: Color.blue.opacity(0.8))
    }
    .padding()
    .background(Color.black)
}