//
//  CryptoCurrencyItem.swift
//  API B3
//
//

import SwiftUI

/// Componente que exibe informações sobre uma criptomoeda específica
struct CryptoCurrencyItem: View {
    // Símbolo da criptomoeda
    let symbol: String
    
    // Nome da criptomoeda
    let name: String
    
    // Valor da criptomoeda
    let value: String
    
    // Variação percentual da criptomoeda
    let change: String
    
    // Indica se a variação é positiva ou negativa
    let isPositive: Bool
    
    // Corpo da visualização que define a aparência do componente
    var body: some View {
        HStack(spacing: 15) {
            // Ícone da criptomoeda
            Circle()
                .fill(name == "Bitcoin" ? Color.orange : Color.white)
                .frame(width: 50, height: 50)
                .overlay(
                    Text(symbol)
                        .font(.title2)
                        .foregroundColor(name == "Bitcoin" ? .white : .black)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                // Nome da criptomoeda
                Text(name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                // Valor e variação
                HStack {
                    Text(value)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(change)
                        .font(.caption)
                        .foregroundColor(isPositive ? .green : .red)
                }
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.3))
        .cornerRadius(20)
    }
}

// Visualização de prévia para o componente
#Preview {
    VStack(spacing: 10) {
        CryptoCurrencyItem(symbol: "₿", name: "Bitcoin", value: "1,1272", change: "+2,35%", isPositive: true)
        CryptoCurrencyItem(symbol: "Ξ", name: "Ethereum", value: "0,6948", change: "+1,45%", isPositive: true)
    }
    .padding()
    .background(Color.black)
}