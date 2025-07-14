//
//  ButtonBar.swift
//  API B3
//

import SwiftUI
import UIKit

/// Componente de barra de botões para a parte inferior do aplicativo
struct ButtonBar: View {
    // Estado para controlar o botão selecionado
    @Binding var selectedButton: Int
    
    // Opções de botões disponíveis
    private let buttonOptions = [
        ("creditcard", "Cartões"),
        ("chart.line.uptrend.xyaxis", "Investimentos"),
        ("clock.arrow.circlepath", "Histórico"),
        ("questionmark.circle", "Suporte")
    ]
    
    // Função para obter o estilo de fundo do círculo com base na seleção
    @ViewBuilder
    private func getCircleBackground(isSelected: Bool) -> some View {
        if isSelected {
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
        } else {
            Circle()
                .fill(Color.gray.opacity(0.2))
        }
    }
    
    // Função para obter a cor do texto com base na seleção
    private func getTextColor(isSelected: Bool) -> Color {
        return isSelected ? Color("AppPrimary") : Color.gray
    }
    
    // Função para obter a cor do indicador com base na seleção
    private func getIndicatorColor(isSelected: Bool) -> Color {
        return isSelected ? Color("AppPrimary") : Color.clear
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<buttonOptions.count, id: \.self) { index in
                let option = buttonOptions[index]
                let isSelected = selectedButton == index
                
                VStack(spacing: 8) {
                    // Botão com ícone
                    Button(action: {
                        // Feedback háptico ao pressionar o botão
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        // Atualiza o botão selecionado
                        withAnimation(.spring()) {
                            selectedButton = index
                        }
                    }) {
                        VStack(spacing: 8) {
                            // Ícone do botão
                            ZStack {
                                getCircleBackground(isSelected: isSelected)
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: option.0)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            
                            // Texto do botão
                            Text(option.1)
                                .font(.system(size: 12))
                                .foregroundColor(getTextColor(isSelected: isSelected))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Indicador de seleção
                    Circle()
                        .fill(getIndicatorColor(isSelected: isSelected))
                        .frame(width: 5, height: 5)
                        .padding(.top, -5)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.8))
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -5)
        )
    }
}

// Visualização de prévia para o componente
#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        
        VStack {
            Spacer()
            ButtonBar(selectedButton: .constant(0))
        }
    }
}