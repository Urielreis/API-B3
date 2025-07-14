//
//  FinanceView.swift
//  API B3
//
//

import SwiftUI
import UIKit // Importado para usar o feedback háptico

// Visualização principal que exibe os dados financeiros obtidos da API
struct FinanceView: View {
    // Observa o ViewModel para atualizações nos dados financeiros
    @StateObject private var viewModel = FinanceViewModel()
    
    // Estado para controlar a aba selecionada
    @State private var selectedTab = 0
    
    // Estado para controlar o botão selecionado na barra inferior
    @State private var selectedButton = 0
    
    // Opções de abas disponíveis
    private let tabOptions = ["Crypto", "Fiat", "Cards", "Savings"]
    
    // Nome do usuário para exibição no cabeçalho
    private let userName = "Mitchell Santos"
    
    // Saldo total fictício para exibição no cabeçalho
    private let totalBalance = "$72 829,62"
    
    // Estado para controlar a animação de transição entre abas
    @State private var animationAmount = 0.0
    
    // Função para filtrar as moedas de acordo com a aba selecionada
    private func filteredCurrencies(financeData: FinanceResponse) -> [(String, CurrencyInfo)] {
        let allCurrencies: [(String, CurrencyInfo)] = [
            ("BTC", financeData.currencies.btc),
            ("USD", financeData.currencies.usd),
            ("EUR", financeData.currencies.eur),
            ("GBP", financeData.currencies.gbp),
            ("ARS", financeData.currencies.ars),
            ("CAD", financeData.currencies.cad),
            ("AUD", financeData.currencies.aud),
            ("JPY", financeData.currencies.jpy)
        ]
        
        switch selectedTab {
        case 0: // Crypto
            return allCurrencies.filter { $0.0 == "BTC" }
        case 1: // Fiat
            return allCurrencies.filter { ["USD", "EUR", "GBP", "ARS", "CAD", "AUD", "JPY"].contains($0.0) }
        case 2: // Cards
            // Simulando dados para a aba Cards (poderia ser implementado com dados reais)
            return allCurrencies.filter { ["USD", "EUR"].contains($0.0) }
        case 3: // Savings
            // Simulando dados para a aba Savings (poderia ser implementado com dados reais)
            return allCurrencies.filter { ["USD", "BTC"].contains($0.0) }
        default:
            return allCurrencies
        }
    }
    
    // Corpo da visualização que define a aparência da tela
    var body: some View {
        // NavigationView fornece uma estrutura de navegação para a tela
        NavigationView {
            // ZStack para criar camadas de elementos
            ZStack {
                // Fundo escuro para toda a tela com gradiente sutil
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                // VStack principal para organizar o conteúdo e a barra de botões
                VStack(spacing: 0) {
                    // ScrollView permite rolar o conteúdo quando não cabe na tela
                    ScrollView {
                        // VStack organiza os elementos verticalmente
                        VStack(spacing: 30) {
                            // Cabeçalho com informações de saldo
                            HeaderView(userName: userName, totalBalance: totalBalance)
                            
                            // Abas de navegação
                            TabsView(selectedTab: $selectedTab, tabOptions: tabOptions)
                            
                            // Verifica se os dados estão sendo carregados
                            if viewModel.isLoading {
                                // Exibe um indicador de progresso durante o carregamento
                                LoadingView()
                            }
                            // Verifica se ocorreu algum erro
                            else if let errorMessage = viewModel.errorMessage {
                                // Exibe a mensagem de erro
                                ErrorView(errorMessage: errorMessage) {
                                    // Tenta carregar os dados novamente quando o botão é pressionado
                                    Task {
                                        await viewModel.loadFinanceData()
                                    }
                                }
                            }
                            // Verifica se os dados financeiros estão disponíveis
                            else if let financeData = viewModel.financeData {
                                // Exibe os cards de moeda filtrados de acordo com a aba selecionada
                                LazyVStack(spacing: 35) { // Aumentado o espaçamento de 20 para 35
                                    ForEach(filteredCurrencies(financeData: financeData), id: \.0) { currencyInfo in
                                        CurrencyCardView(
                                            currencyName: currencyInfo.1.name,
                                            buyValue: viewModel.formatCurrency(currencyInfo.1.buy),
                                            sellValue: viewModel.formatCurrency(currencyInfo.1.sell),
                                            variation: viewModel.formatVariation(currencyInfo.1.variation),
                                            variationColor: viewModel.variationColor(currencyInfo.1.variation)
                                        )
                                        .transition(.asymmetric(
                                            insertion: .scale(scale: 0.9).combined(with: .opacity).animation(.easeInOut(duration: 0.3)),
                                            removal: .scale(scale: 0.8).combined(with: .opacity).animation(.easeInOut(duration: 0.2))
                                        ))
                                        .padding(.horizontal, 5) // Padding horizontal para melhorar a aparência
                                        // O gesto de toque está implementado diretamente no CurrencyCardView
                                    }
                                }
                                .padding(.vertical, 10) // Adicionado padding vertical para melhorar o espaçamento
                                .animation(.easeInOut(duration: 0.5), value: selectedTab)
                            }
                            // Exibe uma mensagem quando não há dados disponíveis
                            else {
                                Text("Nenhum dado financeiro disponível")
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                    .padding(.bottom, 70) // Espaço para a barra de botões
                }
                // Define o título da tela de navegação
                .navigationTitle("")
                .navigationBarHidden(true)
                // Adiciona um botão de atualização na barra de navegação
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Tenta carregar os dados novamente quando o botão é pressionado
                            Task {
                                await viewModel.loadFinanceData()
                            }
                        }) {
                            // Ícone de atualização
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.white)
                        }
                    }
                }
                
                // Barra de botões fixa na parte inferior
                VStack {
                    Spacer()
                    ButtonBar(selectedButton: $selectedButton)
                        .padding(.bottom, 10)
                }
            }
        }
    }
}

// Visualização de prévia para a tela
#Preview {
    FinanceView()
}