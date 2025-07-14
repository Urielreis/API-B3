//
//  LoadingView.swift
//  API B3
//
//

import SwiftUI

/// Componente que exibe um indicador de progresso durante o carregamento de dados
struct LoadingView: View {
    // Corpo da visualização que define a aparência do componente
    var body: some View {
        // Exibe um indicador de progresso durante o carregamento
        ProgressView("Carregando dados...")
            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, minHeight: 200)
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
    LoadingView()
        .padding()
        .background(Color.black)
}