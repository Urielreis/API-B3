//
//  TabsView.swift
//  API B3
//
//

import SwiftUI

/// Componente que exibe as abas de navegação e o conteúdo específico para cada aba
struct TabsView: View {
    // Estado para controlar a aba selecionada
    @Binding var selectedTab: Int
    
    // Opções de abas disponíveis
    private let tabOptions: [String]
    
    // Inicializador que recebe os dados necessários para as abas
    init(selectedTab: Binding<Int>, tabOptions: [String]) {
        self._selectedTab = selectedTab
        self.tabOptions = tabOptions
    }
    
    // Corpo da visualização que define a aparência do componente
    var body: some View {
        VStack(spacing: 15) {
            // Abas horizontais
            HStack(spacing: 0) {
                ForEach(0..<tabOptions.count, id: \.self) { index in
                    Button(action: {
                        // Atualiza a aba selecionada
                        withAnimation {
                            selectedTab = index
                        }
                    }) {
                        Text(tabOptions[index])
                            .font(.system(size: 14, weight: selectedTab == index ? .bold : .regular))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .foregroundColor(selectedTab == index ? .white : .gray)
                            .background(
                                selectedTab == index ?
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black.opacity(0.3)) : nil
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                
                // Botão de gráfico
                Button(action: {
                    // Feedback háptico ao pressionar o botão
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                    
                    // Alerta para mostrar opções de visualização de gráficos
                    let alertController = UIAlertController(title: "Visualizar Gráficos", 
                                                           message: "Selecione o tipo de gráfico", 
                                                           preferredStyle: .actionSheet)
                    
                    // Opções de tipos de gráficos
                    let graphTypes = ["Linha", "Barras", "Candlestick", "Área"]
                    
                    for graphType in graphTypes {
                        let action = UIAlertAction(title: graphType, style: .default) { _ in
                            print("Tipo de gráfico selecionado: \(graphType)")
                            
                            // Notificação de sucesso
                            let notificationFeedback = UINotificationFeedbackGenerator()
                            notificationFeedback.notificationOccurred(.success)
                            
                            // Apresenta um alerta com um gráfico simulado
                            let graphAlert = UIAlertController(title: "Gráfico de \(graphType)", 
                                                             message: "Dados dos últimos 30 dias", 
                                                             preferredStyle: .alert)
                            
                            // Adiciona uma imagem simulada do gráfico
                            let graphImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
                            
                            // Configura a imagem de acordo com o tipo de gráfico
                            switch graphType {
                            case "Linha":
                                graphImageView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
                                // Desenha um gráfico de linha simulado
                                let renderer = UIGraphicsImageRenderer(size: graphImageView.bounds.size)
                                let graphImage = renderer.image { ctx in
                                    let path = UIBezierPath()
                                    path.move(to: CGPoint(x: 0, y: 100))
                                    path.addCurve(to: CGPoint(x: 250, y: 50),
                                                 controlPoint1: CGPoint(x: 80, y: 120),
                                                 controlPoint2: CGPoint(x: 150, y: 20))
                                    UIColor.systemBlue.setStroke()
                                    path.lineWidth = 2
                                    path.stroke()
                                }
                                graphImageView.image = graphImage
                            case "Barras":
                                graphImageView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
                                // Desenha um gráfico de barras simulado
                                let renderer = UIGraphicsImageRenderer(size: graphImageView.bounds.size)
                                let graphImage = renderer.image { ctx in
                                    for i in 0..<5 {
                                        let barHeight = CGFloat.random(in: 30...120)
                                        let barRect = CGRect(x: CGFloat(i) * 50 + 10, y: 150 - barHeight, width: 30, height: barHeight)
                                        UIColor.systemGreen.setFill()
                                        UIBezierPath(rect: barRect).fill()
                                    }
                                }
                                graphImageView.image = graphImage
                            case "Candlestick":
                                graphImageView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
                                // Desenha um gráfico de candlestick simulado
                                let renderer = UIGraphicsImageRenderer(size: graphImageView.bounds.size)
                                let graphImage = renderer.image { ctx in
                                    for i in 0..<8 {
                                        let x = CGFloat(i) * 30 + 10
                                        let open = CGFloat.random(in: 50...100)
                                        let close = CGFloat.random(in: 50...100)
                                        let high = min(open, close) - CGFloat.random(in: 10...20)
                                        let low = max(open, close) + CGFloat.random(in: 10...20)
                                        
                                        // Linha vertical (sombra)
                                        let linePath = UIBezierPath()
                                        linePath.move(to: CGPoint(x: x + 5, y: high))
                                        linePath.addLine(to: CGPoint(x: x + 5, y: low))
                                        UIColor.black.setStroke()
                                        linePath.lineWidth = 1
                                        linePath.stroke()
                                        
                                        // Retângulo (corpo)
                                        let color = open > close ? UIColor.red : UIColor.green
                                        color.setFill()
                                        let rectPath = UIBezierPath(rect: CGRect(x: x, y: min(open, close), width: 10, height: abs(close - open)))
                                        rectPath.fill()
                                    }
                                }
                                graphImageView.image = graphImage
                            case "Área":
                                graphImageView.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1)
                                // Desenha um gráfico de área simulado
                                let renderer = UIGraphicsImageRenderer(size: graphImageView.bounds.size)
                                let graphImage = renderer.image { ctx in
                                    let path = UIBezierPath()
                                    path.move(to: CGPoint(x: 0, y: 150))
                                    path.addLine(to: CGPoint(x: 0, y: 100))
                                    path.addCurve(to: CGPoint(x: 250, y: 80),
                                                 controlPoint1: CGPoint(x: 80, y: 120),
                                                 controlPoint2: CGPoint(x: 150, y: 40))
                                    path.addLine(to: CGPoint(x: 250, y: 150))
                                    path.close()
                                    UIColor.systemPurple.withAlphaComponent(0.5).setFill()
                                    path.fill()
                                    
                                    // Linha superior
                                    let linePath = UIBezierPath()
                                    linePath.move(to: CGPoint(x: 0, y: 100))
                                    linePath.addCurve(to: CGPoint(x: 250, y: 80),
                                                     controlPoint1: CGPoint(x: 80, y: 120),
                                                     controlPoint2: CGPoint(x: 150, y: 40))
                                    UIColor.systemPurple.setStroke()
                                    linePath.lineWidth = 2
                                    linePath.stroke()
                                }
                                graphImageView.image = graphImage
                            default:
                                break
                            }
                            
                            // Adiciona a imagem ao alerta
                            graphAlert.view.addSubview(graphImageView)
                            
                            // Ajusta o tamanho do alerta para acomodar a imagem
                            let height: NSLayoutConstraint = NSLayoutConstraint(item: graphAlert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
                            let width: NSLayoutConstraint = NSLayoutConstraint(item: graphAlert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
                            graphAlert.view.addConstraint(height)
                            graphAlert.view.addConstraint(width)
                            
                            // Posiciona a imagem
                            graphImageView.translatesAutoresizingMaskIntoConstraints = false
                            graphImageView.centerXAnchor.constraint(equalTo: graphAlert.view.centerXAnchor).isActive = true
                            graphImageView.topAnchor.constraint(equalTo: graphAlert.view.topAnchor, constant: 50).isActive = true
                            
                            // Adiciona botão de fechar
                            let closeAction = UIAlertAction(title: "Fechar", style: .default)
                            graphAlert.addAction(closeAction)
                            
                            // Apresenta o alerta com o gráfico
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let rootViewController = windowScene.windows.first?.rootViewController {
                                rootViewController.present(graphAlert, animated: true)
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
                }) {
                    Image(systemName: "chart.bar.xaxis")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                }
            }
            .padding(5)
            .background(Color.black.opacity(0.2))
            .cornerRadius(20)
            
            // Conteúdo específico para a aba selecionada
            switch selectedTab {
            case 0:
                // Conteúdo para a aba Crypto
                HStack(spacing: 15) {
                    // Bitcoin
                    CryptoCurrencyItem(symbol: "₿", name: "Bitcoin", value: "1,1272", change: "+2,35%", isPositive: true)
                    
                    // Ethereum
                    CryptoCurrencyItem(symbol: "Ξ", name: "Ethereum", value: "0,6948", change: "+1,45%", isPositive: true)
                }
                .padding(.top, 10)
                
            case 1:
                // Conteúdo para a aba Fiat
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        // Dólar
                        CryptoCurrencyItem(symbol: "$", name: "Dólar", value: "5,2530", change: "-0,15%", isPositive: false)
                        
                        // Euro
                        CryptoCurrencyItem(symbol: "€", name: "Euro", value: "5,7820", change: "+0,25%", isPositive: true)
                    }
                    
                    HStack(spacing: 15) {
                        // Libra
                        CryptoCurrencyItem(symbol: "£", name: "Libra", value: "6,8240", change: "+0,32%", isPositive: true)
                        
                        // Iene
                        CryptoCurrencyItem(symbol: "¥", name: "Iene", value: "0,0348", change: "-0,05%", isPositive: false)
                    }
                }
                .padding(.top, 10)
                
            case 2:
                // Conteúdo para a aba Cards
                VStack(spacing: 15) {
                    // Card de crédito
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.blue.opacity(0.3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Cartão de Crédito")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("Limite disponível: R$ 5.000,00")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(15)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                    
                    // Card de débito
                    HStack {
                        Image(systemName: "banknote.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.green.opacity(0.3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Cartão de Débito")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("Saldo: R$ 3.250,75")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(15)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                }
                .padding(.top, 10)
                
            case 3:
                // Conteúdo para a aba Savings
                VStack(spacing: 15) {
                    // Poupança
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.yellow.opacity(0.3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Poupança")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("Saldo: R$ 12.500,00")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("+2,5% a.a.")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(15)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                    
                    // Investimento
                    HStack {
                        Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.purple.opacity(0.3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Tesouro Direto")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("Saldo: R$ 25.750,50")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("+8,2% a.a.")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(15)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                }
                .padding(.top, 10)
                
            default:
                EmptyView()
            }
        }
    }
}

// Visualização de prévia para o componente
#Preview {
    TabsView(selectedTab: .constant(0), tabOptions: ["Crypto", "Fiat", "Cards", "Savings"])
        .padding()
        .background(Color.black)
}