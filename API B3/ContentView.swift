//
//  ContentView.swift
//  API B3
//
//  Este arquivo serve como ponto de entrada principal para a interface do usuário do aplicativo.
//  Ele importa e utiliza o componente FinanceView que exibe os dados financeiros.

import SwiftUI

// Estrutura principal da interface do usuário que conforma com o protocolo View
struct ContentView: View {
    // Propriedade computada que define o conteúdo visual da view
    var body: some View {
        // Utiliza o componente FinanceView como conteúdo principal
        // FinanceView é responsável por exibir os dados financeiros obtidos da API
        FinanceView()
    }
}

// Estrutura de prévia para visualização no Canvas
#Preview {
    // Cria uma instância de ContentView para visualização no Canvas
    ContentView()
}
