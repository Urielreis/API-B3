//
//  HeaderView.swift
//  API B3
//

import SwiftUI
import UIKit

/// Componente de cabeçalho que exibe informações do usuário e saldo
struct HeaderView: View {
    // Nome do usuário para exibição no cabeçalho
    private let userName: String
    
    // Saldo total para exibição no cabeçalho
    private let totalBalance: String
    
    // Estado para controlar a visibilidade do saldo
    @State private var isBalanceHidden = false
    
    // Estado para controlar a exibição do menu de perfil
    @State private var showProfileMenu = false
    
    // Inicializador que recebe os dados necessários para o cabeçalho
    init(userName: String, totalBalance: String) {
        self.userName = userName
        self.totalBalance = totalBalance
    }
    
    // Corpo da visualização que define a aparência do componente
    var body: some View {
        VStack(spacing: 20) {
            // Seção superior com foto de perfil e nome do usuário
            HStack {
                // Foto de perfil do usuário com menu
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image("Banco")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 46, height: 46)
                                .clipShape(Circle())
                        )
                        .shadow(color: Color("Primary").opacity(0.3), radius: 5)
                        .onTapGesture {
                            // Feedback háptico ao tocar na foto de perfil
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                            
                            // Alterna a exibição do menu de perfil
                            withAnimation(.spring()) {
                                showProfileMenu.toggle()
                            }
                        }
                    
                    // Indicador de menu ativo
                    if showProfileMenu {
                        Circle()
                            .stroke(Color("AppPrimary"), lineWidth: 2)
                            .frame(width: 54, height: 54)
                    }
                }
                
                // Nome do usuário
                Text(userName)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                
                Spacer()
                
                // Ícone de notificação
                Circle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "bell")
                            .foregroundColor(.white)
                    )
                    .onTapGesture {
                        // Feedback háptico ao tocar no ícone de notificação
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                    }
            }
            .padding(.horizontal, 5)
            
            // Menu de perfil (aparece quando showProfileMenu é true)
            if showProfileMenu {
                ProfileMenuView(showMenu: $showProfileMenu)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
            }
            
            // Seção de saldo
            VStack(alignment: .leading, spacing: 8) {
                // Texto "Total balance" com ícone de olho interativo
                HStack {
                    Text("Total balance")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        // Feedback háptico ao tocar no ícone de olho
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        // Alterna a visibilidade do saldo
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isBalanceHidden.toggle()
                        }
                    }) {
                        Image(systemName: isBalanceHidden ? "eye.slash" : "eye")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                // Valor do saldo (oculto ou visível)
                Text(isBalanceHidden ? "••••••••" : totalBalance)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 5)
            
            // Botões de ação
            HStack(spacing: 15) {
                // Botão Adicionar
                ActionButton(
                    icon: "plus", 
                    title: "Add saving", 
                    color: Color.gray.opacity(0.2),
                    action: {
                        print("Add saving tapped")
                        // Feedback háptico ao pressionar o botão
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        // Alerta para adicionar uma economia
                        let alertController = UIAlertController(title: "Adicionar Economia", 
                                                              message: "Informe o valor que deseja economizar", 
                                                              preferredStyle: .alert)
                        
                        alertController.addTextField { textField in
                            textField.placeholder = "Valor"
                            textField.keyboardType = .decimalPad
                        }
                        
                        let saveAction = UIAlertAction(title: "Salvar", style: .default) { _ in
                            if let textField = alertController.textFields?.first, let text = textField.text {
                                print("Valor para economizar: \(text)")
                                // Aqui seria implementada a lógica para salvar o valor
                            }
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
                        
                        alertController.addAction(saveAction)
                        alertController.addAction(cancelAction)
                        
                        // Apresenta o alerta
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let rootViewController = windowScene.windows.first?.rootViewController {
                            rootViewController.present(alertController, animated: true)
                        }
                    }
                )
                
                // Botão Enviar
                ActionButton(
                    icon: "arrow.up", 
                    title: "Withdraw", 
                    color: Color.gray.opacity(0.2),
                    action: {
                        print("Withdraw tapped")
                        // Feedback háptico ao pressionar o botão
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        // Alerta para sacar valor
                        let alertController = UIAlertController(title: "Sacar Valor", 
                                                              message: "Informe o valor que deseja sacar", 
                                                              preferredStyle: .alert)
                        
                        alertController.addTextField { textField in
                            textField.placeholder = "Valor"
                            textField.keyboardType = .decimalPad
                        }
                        
                        let withdrawAction = UIAlertAction(title: "Sacar", style: .default) { _ in
                            if let textField = alertController.textFields?.first, let text = textField.text {
                                print("Valor para sacar: \(text)")
                                // Aqui seria implementada a lógica para processar o saque
                            }
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
                        
                        alertController.addAction(withdrawAction)
                        alertController.addAction(cancelAction)
                        
                        // Apresenta o alerta
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let rootViewController = windowScene.windows.first?.rootViewController {
                            rootViewController.present(alertController, animated: true)
                        }
                    }
                )
                
                // Botão Receber
                ActionButton(
                    icon: "arrow.down", 
                    title: "Top up", 
                    color: Color.gray.opacity(0.2),
                    action: {
                        print("Top up tapped")
                        // Feedback háptico ao pressionar o botão
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        // Alerta para depositar valor
                        let alertController = UIAlertController(title: "Depositar Valor", 
                                                              message: "Informe o valor que deseja depositar", 
                                                              preferredStyle: .alert)
                        
                        alertController.addTextField { textField in
                            textField.placeholder = "Valor"
                            textField.keyboardType = .decimalPad
                        }
                        
                        let depositAction = UIAlertAction(title: "Depositar", style: .default) { _ in
                            if let textField = alertController.textFields?.first, let text = textField.text {
                                print("Valor para depositar: \(text)")
                                // Aqui seria implementada a lógica para processar o depósito
                            }
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
                        
                        alertController.addAction(depositAction)
                        alertController.addAction(cancelAction)
                        
                        // Apresenta o alerta
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let rootViewController = windowScene.windows.first?.rootViewController {
                            rootViewController.present(alertController, animated: true)
                        }
                    }
                )
                
                // Botão Trocar
                ActionButton(
                    icon: "arrow.2.squarepath", 
                    title: "Exchange", 
                    color: Color("Primary").opacity(0.8),
                    action: {
                        print("Exchange tapped")
                        // Feedback háptico ao pressionar o botão
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        // Alerta para trocar moedas
                        let alertController = UIAlertController(title: "Trocar Moedas", 
                                                              message: "Selecione as moedas para troca", 
                                                              preferredStyle: .actionSheet)
                        
                        // Opções de moedas disponíveis
                        let currencies = ["USD - Dólar Americano", "EUR - Euro", "GBP - Libra Esterlina", "BTC - Bitcoin"]
                        
                        for currency in currencies {
                            let action = UIAlertAction(title: currency, style: .default) { _ in
                                print("Moeda selecionada para troca: \(currency)")
                                
                                // Segundo alerta para selecionar a moeda de destino
                                let secondAlert = UIAlertController(title: "Trocar para", 
                                                                 message: "Selecione a moeda de destino", 
                                                                 preferredStyle: .actionSheet)
                                
                                for targetCurrency in currencies where targetCurrency != currency {
                                    let targetAction = UIAlertAction(title: targetCurrency, style: .default) { _ in
                                        print("Troca de \(currency) para \(targetCurrency)")
                                        
                                        // Feedback háptico de sucesso
                                        let notificationFeedback = UINotificationFeedbackGenerator()
                                        notificationFeedback.notificationOccurred(.success)
                                        
                                        // Terceiro alerta para informar o valor a ser trocado
                                        let valueAlert = UIAlertController(title: "Valor para troca", 
                                                                       message: "Informe o valor de \(currency.split(separator: " ").first ?? "") que deseja trocar", 
                                                                       preferredStyle: .alert)
                                        
                                        valueAlert.addTextField { textField in
                                            textField.placeholder = "Valor"
                                            textField.keyboardType = .decimalPad
                                        }
                                        
                                        let exchangeAction = UIAlertAction(title: "Confirmar", style: .default) { _ in
                                            if let textField = valueAlert.textFields?.first, let text = textField.text, !text.isEmpty {
                                                // Simula uma taxa de câmbio aleatória
                                                let exchangeRate = Double.random(in: 0.8...1.2)
                                                let inputValue = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0
                                                let resultValue = inputValue * exchangeRate
                                                
                                                // Formata os valores para exibição
                                                let formatter = NumberFormatter()
                                                formatter.numberStyle = .decimal
                                                formatter.minimumFractionDigits = 2
                                                formatter.maximumFractionDigits = 2
                                                
                                                let formattedResult = formatter.string(from: NSNumber(value: resultValue)) ?? "(resultValue)"
                                                
                                                // Alerta de confirmação com o resultado da troca
                                                let resultAlert = UIAlertController(
                                                    title: "Troca Realizada", 
                                                    message: "Você trocou \(text) \(currency.split(separator: " ").first ?? "") por \(formattedResult) \(targetCurrency.split(separator: " ").first ?? "")", 
                                                    preferredStyle: .alert
                                                )
                                                
                                                let okAction = UIAlertAction(title: "OK", style: .default)
                                                resultAlert.addAction(okAction)
                                                
                                                // Apresenta o alerta de resultado
                                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                                   let rootViewController = windowScene.windows.first?.rootViewController {
                                                    rootViewController.present(resultAlert, animated: true)
                                                }
                                            } else {
                                                // Feedback háptico de erro se o valor estiver vazio
                                                let errorFeedback = UINotificationFeedbackGenerator()
                                                errorFeedback.notificationOccurred(.error)
                                                
                                                // Alerta de erro
                                                let errorAlert = UIAlertController(
                                                    title: "Erro", 
                                                    message: "Por favor, informe um valor válido para a troca.", 
                                                    preferredStyle: .alert
                                                )
                                                
                                                let okAction = UIAlertAction(title: "OK", style: .default)
                                                errorAlert.addAction(okAction)
                                                
                                                // Apresenta o alerta de erro
                                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                                   let rootViewController = windowScene.windows.first?.rootViewController {
                                                    rootViewController.present(errorAlert, animated: true)
                                                }
                                            }
                                        }
                                        
                                        let cancelExchangeAction = UIAlertAction(title: "Cancelar", style: .cancel)
                                        
                                        valueAlert.addAction(exchangeAction)
                                        valueAlert.addAction(cancelExchangeAction)
                                        
                                        // Apresenta o alerta de valor
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let rootViewController = windowScene.windows.first?.rootViewController {
                                            rootViewController.present(valueAlert, animated: true)
                                        }
                                    }
                                    secondAlert.addAction(targetAction)
                                }
                                
                                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
                                secondAlert.addAction(cancelAction)
                                
                                // Apresenta o segundo alerta
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let rootViewController = windowScene.windows.first?.rootViewController {
                                    rootViewController.present(secondAlert, animated: true)
                                }
                            }
                            alertController.addAction(action)
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
                        alertController.addAction(cancelAction)
                        
                        // Apresenta o alerta
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let rootViewController = windowScene.windows.first?.rootViewController {
                            rootViewController.present(alertController, animated: true)
                        }
                    }
                )
            }
            
            // Barra de botões de perfil (aparece abaixo dos botões de ação)
            VStack(spacing: 15) {
                // Linha separadora com gradiente
                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.05)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 1)
                .padding(.vertical, 5)
                
                // Botões de perfil
                HStack(spacing: 20) {
                    // Botão de Cartões
                    ProfileButton(icon: "creditcard", title: "Cartões") {
                        showProfileFeatureAlert("Cartões", "Gerencie seus cartões de crédito e débito.")
                    }
                    
                    // Botão de Investimentos
                    ProfileButton(icon: "chart.line.uptrend.xyaxis", title: "Investimentos") {
                        showProfileFeatureAlert("Investimentos", "Acompanhe seus investimentos e rendimentos.")
                    }
                    
                    // Botão de Histórico
                    ProfileButton(icon: "clock.arrow.circlepath", title: "Histórico") {
                        showProfileFeatureAlert("Histórico", "Visualize seu histórico de transações.")
                    }
                    
                    // Botão de Suporte
                    ProfileButton(icon: "questionmark.circle", title: "Suporte") {
                        showProfileFeatureAlert("Suporte", "Entre em contato com nossa equipe de suporte.")
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.top, 10)
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(20)
        )
    }
    
    // Função para exibir alertas de funcionalidades de perfil
    private func showProfileFeatureAlert(_ title: String, _ message: String) {
        // Feedback háptico ao selecionar uma opção
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
        
        // Cria o alerta
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        // Apresenta o alerta
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alertController, animated: true)
        }
    }
}

// Visualização de prévia para o componente
#Preview {
    HeaderView(userName: "Mitchell Santos", totalBalance: "$72 829,62")
        .padding()
        .background(Color.black)
}