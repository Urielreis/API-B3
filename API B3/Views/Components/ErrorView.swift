//
//  ErrorView.swift
//  API B3
//
//

import SwiftUI

/// Componente que exibe uma mensagem de erro e um botão para tentar novamente
struct ErrorView: View {
    // Mensagem de erro a ser exibida
    let errorMessage: String
    
    // Ação a ser executada quando o botão "Tentar Novamente" for pressionado
    let retryAction: () -> Void
    
    // Corpo da visualização que define a aparência do componente
    var body: some View {
        VStack {
            // Ícone de erro
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(Color("Error"))
                .padding()
            
            // Mensagem de erro
            Text(errorMessage)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("Error"))
                .padding()
            
            // Botão para tentar novamente
            Button("Tentar Novamente") {
                // Executa a ação de retry quando o botão é pressionado
                retryAction()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("Primary"), Color("Secondary")]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: Color("Primary").opacity(0.5), radius: 5, x: 0, y: 2)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.5))
                .shadow(color: Color("Primary").opacity(0.3), radius: 10)
        )
        .padding(.horizontal)
    }
}

// Visualização de prévia para o componente
#Preview {
    ErrorView(
        errorMessage: "Erro ao carregar dados: Verifique sua conexão com a internet e tente novamente.",
        retryAction: {}
    )
    .padding()
    .background(Color.black)
}