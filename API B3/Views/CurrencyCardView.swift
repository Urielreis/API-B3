//
//  CurrencyCardView.swift
//  API B3
//

import SwiftUI
import UIKit // Importado para usar o feedback háptico

/// Componente de visualização que exibe informações detalhadas sobre uma moeda específica
///
/// Este componente é responsável por exibir um cartão com informações sobre uma moeda,
/// incluindo seu nome, valores de compra e venda, e variação percentual.
/// O componente aplica formatação visual adequada para cada tipo de informação,
/// incluindo cores diferentes para variações positivas e negativas, e tratamento
/// especial para valores não disponíveis (N/A).
///

struct CurrencyCardView: View {
    // MARK: - Propriedades
    
    /// Nome da moeda a ser exibida (ex: "Dólar Americano", "Euro")
    let currencyName: String
    
    /// Valor de compra da moeda formatado como string (ex: "R$ 5,25" ou "N/A")
    let buyValue: String
    
    /// Valor de venda da moeda formatado como string (ex: "R$ 5,30" ou "N/A")
    let sellValue: String
    
    /// Variação percentual da moeda formatada como string (ex: "+0,75%")
    let variation: String
    
    /// Cor para exibir a variação (verde para positiva, vermelha para negativa, cinza para neutra)
    let variationColor: Color
    
    /// Imagem associada à moeda
    var currencyImage: String {
        // Retorna a imagem apropriada baseada no nome da moeda
        if currencyName.contains("Dólar") {
            return "dollar"
        } else if currencyName.contains("Bitcoin") {
            return "Investimento"
        } else {
            return "cash"
        }
    }
    
    // MARK: - Métodos auxiliares
    
    /// Verifica se um valor é "N/A" (não disponível)
    /// - Parameter value: O valor a ser verificado
    /// - Returns: True se o valor for "N/A", false caso contrário
    private func isValueNA(_ value: String) -> Bool {
        return value == "N/A"
    }
    
    // MARK: - Body
    
    // Estado para controlar o efeito de escala ao tocar no card
    @State private var isPressed: Bool = false
    // Estado para controlar a exibição de detalhes expandidos
    @State private var isExpanded: Bool = false
    // Estado para controlar o feedback háptico
    @State private var hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    /// Corpo da visualização que define a aparência do componente
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Fundo com gradiente mais moderno
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("AppPrimary").opacity(0.9),
                    Color("AppPrimary Variant").opacity(0.7)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(25)
            
            // Efeito de brilho no canto superior
            Circle()
                .fill(Color.white.opacity(0.15))
                .frame(width: 180, height: 180)
                .blur(radius: 25)
                .offset(x: -50, y: -50)
            
            // Conteúdo do cartão
            VStack(alignment: .leading, spacing: 18) {
                // Cabeçalho com ícone e nome da moeda
                HStack(spacing: 14) {
                    // Ícone da moeda
                    Image(currencyImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    // Título com o nome da moeda
                    Text(currencyName)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 8)
                
                // Linha separadora com gradiente
                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.05)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 1)
                .padding(.vertical, 5)
                
                // Informações da moeda
                HStack {
                    // VStack para os rótulos
                    VStack(alignment: .leading, spacing: 14) {
                        // Rótulo para o valor de compra
                        Text("Compra:")
                            .font(.system(size: 14))
                            .foregroundColor(Color.white.opacity(0.7))
                        
                        // Rótulo para o valor de venda
                        Text("Venda:")
                            .font(.system(size: 14))
                            .foregroundColor(Color.white.opacity(0.7))
                        
                        // Rótulo para a variação
                        Text("Variação:")
                            .font(.system(size: 14))
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    // Spacer para empurrar os valores para a direita
                    Spacer()
                    
                    // VStack para os valores
                    VStack(alignment: .trailing, spacing: 14) {
                        // Valor de compra formatado
                        Text(buyValue)
                            .font(.system(size: 14, weight: .semibold))
                            // Aplica cor secundária se o valor for N/A
                            .foregroundColor(isValueNA(buyValue) ? Color.white.opacity(0.5) : .white)
                        
                        // Valor de venda formatado
                        Text(sellValue)
                            .font(.system(size: 14, weight: .semibold))
                            // Aplica cor secundária se o valor for N/A
                            .foregroundColor(isValueNA(sellValue) ? Color.white.opacity(0.5) : .white)
                        
                        // Variação percentual formatada com cor apropriada
                        Text(variation)
                            .font(.system(size: 13, weight: .bold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(variationColor.opacity(0.15))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(variationColor.opacity(0.3), lineWidth: 1)
                            )
                            .foregroundColor(variationColor)
                    }
                }
            }
            .padding(20)
            
            // Conteúdo adicional que aparece quando o card está expandido
            if isExpanded {
                VStack(spacing: 20) {
                    // Linha separadora com gradiente
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.05)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(height: 1)
                    .padding(.vertical, 5)
                    
                    // Gráfico simulado (representação visual simplificada)
                    VStack(alignment: .leading, spacing: 8) {
                        // Título do gráfico
                        Text("Variação nos últimos 7 dias")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color.white.opacity(0.7))
                            .padding(.leading, 4)
                        
                        // Gráfico interativo
                        HStack(spacing: 4) {
                            ForEach(0..<20, id: \.self) { index in
                                let height = CGFloat.random(in: 10...50)
                                Rectangle()
                                    .fill(variationColor.opacity(0.7))
                                    .frame(width: 8, height: height)
                                    .cornerRadius(4)
                                    .onTapGesture {
                                        // Feedback háptico ao tocar na barra do gráfico
                                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                                        impactLight.impactOccurred()
                                        
                                        // Simula a exibição de um valor específico para o dia selecionado
                                        let randomValue = Double.random(in: -2.5...2.5)
                                        let formattedValue = String(format: "%.2f%%", randomValue)
                                        
                                        // Alerta com o valor do dia selecionado
                                        let alertController = UIAlertController(
                                            title: "Valor no dia \(20 - index)",
                                            message: "Variação: \(randomValue >= 0 ? "+" : "")\(formattedValue)",
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
                        }
                        .frame(height: 60)
                        .padding(.horizontal, 4)
                        
                        // Legenda do gráfico
                        HStack {
                            Text("7 dias atrás")
                                .font(.system(size: 10))
                                .foregroundColor(Color.white.opacity(0.5))
                            
                            Spacer()
                            
                            Text("Hoje")
                                .font(.system(size: 10))
                                .foregroundColor(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal, 4)
                    }
                    .padding(.horizontal)
                    
                    // Botões de ação
                    HStack(spacing: 15) {
                        // Botão Comprar
                        Button(action: {
                            // Feedback háptico ao pressionar o botão
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                            
                            // Lógica para comprar a moeda
                            print("Comprar \(currencyName)")
                            
                            // Verifica se o valor de compra está disponível
                            if isValueNA(buyValue) {
                                // Alerta informando que a operação não está disponível
                                let errorAlert = UIAlertController(title: "Operação Indisponível", 
                                                                message: "Não é possível realizar a compra pois o valor de compra não está disponível.", 
                                                                preferredStyle: .alert)
                                
                                let okAction = UIAlertAction(title: "OK", style: .default)
                                errorAlert.addAction(okAction)
                                
                                // Apresenta o alerta de erro
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let rootViewController = windowScene.windows.first?.rootViewController {
                                    rootViewController.present(errorAlert, animated: true)
                                }
                                return
                            }
                            
                            // Alerta para confirmar a compra
                            let alertController = UIAlertController(title: "Comprar \(currencyName)", 
                                                                  message: "Informe o valor que deseja comprar", 
                                                                  preferredStyle: .alert)
                            
                            alertController.addTextField { textField in
                                textField.placeholder = "Valor"
                                textField.keyboardType = .decimalPad
                            }
                            
                            let buyAction = UIAlertAction(title: "Confirmar", style: .default) { _ in
                                if let textField = alertController.textFields?.first, let text = textField.text, !text.isEmpty {
                                    print("Valor para comprar: \(text)")
                                    
                                    // Notificação de sucesso
                                    let notificationFeedback = UINotificationFeedbackGenerator()
                                    notificationFeedback.notificationOccurred(.success)
                                    
                                    // Simula o processamento da compra
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        // Calcula o valor total da compra (simulado)
                                        var buyValueClean = buyValue
                                        if !isValueNA(buyValue) {
                                            buyValueClean = buyValue.replacingOccurrences(of: "R$ ", with: "")
                                                                  .replacingOccurrences(of: ".", with: "")
                                                                  .replacingOccurrences(of: ",", with: ".")
                                        }
                                        let buyValueDouble = Double(buyValueClean) ?? 0.0
                                        let amount = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0.0
                                        let totalValue = buyValueDouble * amount
                                        
                                        // Formata o valor total
                                        let formatter = NumberFormatter()
                                        formatter.numberStyle = .currency
                                        formatter.currencySymbol = "R$"
                                        let formattedTotal = formatter.string(from: NSNumber(value: totalValue)) ?? "R$ 0,00"
                                        
                                        // Alerta de confirmação com detalhes da transação
                                        let successAlert = UIAlertController(title: "Compra Realizada", 
                                                                          message: "Você comprou \(text) \(currencyName) por \(formattedTotal)\n\nData: \(Date().formatted(date: .abbreviated, time: .shortened))\nID da transação: \(UUID().uuidString.prefix(8))", 
                                                                          preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: "OK", style: .default)
                                        successAlert.addAction(okAction)
                                        
                                        // Apresenta o alerta de sucesso
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let rootViewController = windowScene.windows.first?.rootViewController {
                                            rootViewController.present(successAlert, animated: true)
                                        }
                                    }
                                } else {
                                    // Feedback háptico de erro se o valor estiver vazio
                                    let errorFeedback = UINotificationFeedbackGenerator()
                                    errorFeedback.notificationOccurred(.error)
                                    
                                    // Alerta de erro
                                    let errorAlert = UIAlertController(title: "Erro", 
                                                                    message: "Por favor, informe um valor válido para a compra.", 
                                                                    preferredStyle: .alert)
                                    
                                    let okAction = UIAlertAction(title: "OK", style: .default)
                                    errorAlert.addAction(okAction)
                                    
                                    // Apresenta o alerta de erro
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                       let rootViewController = windowScene.windows.first?.rootViewController {
                                        rootViewController.present(errorAlert, animated: true)
                                    }
                                }
                            }
                            
                            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
                            
                            alertController.addAction(buyAction)
                            alertController.addAction(cancelAction)
                            
                            // Apresenta o alerta
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let rootViewController = windowScene.windows.first?.rootViewController {
                                rootViewController.present(alertController, animated: true)
                            }
                        }) {
                            Text("Comprar")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(isValueNA(buyValue) ? Color.gray.opacity(0.5) : Color.green.opacity(0.8))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isValueNA(buyValue) ? Color.gray.opacity(0.3) : Color.green.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .disabled(isValueNA(buyValue))
                        
                        // Botão Vender
                        Button(action: {
                            // Feedback háptico ao pressionar o botão
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                            
                            // Lógica para vender a moeda
                            print("Vender \(currencyName)")
                            
                            // Verifica se o valor de venda está disponível
                            if isValueNA(sellValue) {
                                // Alerta informando que a operação não está disponível
                                let errorAlert = UIAlertController(title: "Operação Indisponível", 
                                                                message: "Não é possível realizar a venda pois o valor de venda não está disponível.", 
                                                                preferredStyle: .alert)
                                
                                let okAction = UIAlertAction(title: "OK", style: .default)
                                errorAlert.addAction(okAction)
                                
                                // Apresenta o alerta de erro
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let rootViewController = windowScene.windows.first?.rootViewController {
                                    rootViewController.present(errorAlert, animated: true)
                                }
                                return
                            }
                            
                            // Alerta para confirmar a venda
                            let alertController = UIAlertController(title: "Vender \(currencyName)", 
                                                                  message: "Informe o valor que deseja vender", 
                                                                  preferredStyle: .alert)
                            
                            alertController.addTextField { textField in
                                textField.placeholder = "Valor"
                                textField.keyboardType = .decimalPad
                            }
                            
                            let sellAction = UIAlertAction(title: "Confirmar", style: .default) { _ in
                                if let textField = alertController.textFields?.first, let text = textField.text, !text.isEmpty {
                                    print("Valor para vender: \(text)")
                                    
                                    // Notificação de sucesso
                                    let notificationFeedback = UINotificationFeedbackGenerator()
                                    notificationFeedback.notificationOccurred(.success)
                                    
                                    // Simula o processamento da venda
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        // Calcula o valor total da venda (simulado)
                                        var sellValueClean = sellValue
                                        if !isValueNA(sellValue) {
                                            sellValueClean = sellValue.replacingOccurrences(of: "R$ ", with: "")
                                                                  .replacingOccurrences(of: ".", with: "")
                                                                  .replacingOccurrences(of: ",", with: ".")
                                        }
                                        let sellValueDouble = Double(sellValueClean) ?? 0.0
                                        let amount = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0.0
                                        let totalValue = sellValueDouble * amount
                                        
                                        // Formata o valor total
                                        let formatter = NumberFormatter()
                                        formatter.numberStyle = .currency
                                        formatter.currencySymbol = "R$"
                                        let formattedTotal = formatter.string(from: NSNumber(value: totalValue)) ?? "R$ 0,00"
                                        
                                        // Alerta de confirmação com detalhes da transação
                                        let successAlert = UIAlertController(title: "Venda Realizada", 
                                                                          message: "Você vendeu \(text) \(currencyName) por \(formattedTotal)\n\nData: \(Date().formatted(date: .abbreviated, time: .shortened))\nID da transação: \(UUID().uuidString.prefix(8))", 
                                                                          preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: "OK", style: .default)
                                        successAlert.addAction(okAction)
                                        
                                        // Apresenta o alerta de sucesso
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let rootViewController = windowScene.windows.first?.rootViewController {
                                            rootViewController.present(successAlert, animated: true)
                                        }
                                    }
                                } else {
                                    // Feedback háptico de erro se o valor estiver vazio
                                    let errorFeedback = UINotificationFeedbackGenerator()
                                    errorFeedback.notificationOccurred(.error)
                                    
                                    // Alerta de erro
                                    let errorAlert = UIAlertController(title: "Erro", 
                                                                    message: "Por favor, informe um valor válido para a venda.", 
                                                                    preferredStyle: .alert)
                                    
                                    let okAction = UIAlertAction(title: "OK", style: .default)
                                    errorAlert.addAction(okAction)
                                    
                                    // Apresenta o alerta de erro
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                       let rootViewController = windowScene.windows.first?.rootViewController {
                                        rootViewController.present(errorAlert, animated: true)
                                    }
                                }
                            }
                            
                            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
                            
                            alertController.addAction(sellAction)
                            alertController.addAction(cancelAction)
                            
                            // Apresenta o alerta
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let rootViewController = windowScene.windows.first?.rootViewController {
                                rootViewController.present(alertController, animated: true)
                            }
                        }) {
                            Text("Vender")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(isValueNA(sellValue) ? Color.gray.opacity(0.5) : Color.red.opacity(0.8))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isValueNA(sellValue) ? Color.gray.opacity(0.3) : Color.red.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .disabled(isValueNA(sellValue))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .frame(height: isExpanded ? 320 : 190)
        .shadow(color: Color("AppPrimary").opacity(0.4), radius: 15, x: 0, y: 8)
        .padding(.horizontal, 2)
        .padding(.vertical, 5)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            // Ativa o efeito de pressionar
            isPressed = true
            
            // Feedback háptico ao tocar no card
            hapticFeedback.prepare()
            hapticFeedback.impactOccurred()
            
            // Alterna o estado de expansão após um curto período
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            }
        }
    }
}

// Visualização de prévia para o componente
#Preview("Currency Card") {
    // Exemplo de uso do componente com dados fictícios
    CurrencyCardView(
        currencyName: "Dólar Americano",
        buyValue: "R$ 5,25",
        sellValue: "R$ 5,30",
        variation: "+0,75%",
        variationColor: .green
    )
    .padding()
    // Removido o método .previewDisplayName que estava causando erro
}
