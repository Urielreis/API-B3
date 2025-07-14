# API B3 - Aplicativo de Monitoramento Financeiro

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.5-orange" alt="Swift Version">
  <img src="https://img.shields.io/badge/iOS-15.0+-blue" alt="iOS Version">
  <img src="https://img.shields.io/badge/Arquitetura-MVVM-green" alt="Architecture">
  <img src="https://img.shields.io/badge/API-HG%20Brasil-yellow" alt="API">
</p>

## 📊 Visão Geral

O **API B3** é um aplicativo iOS moderno e elegante que consome a API de finanças da HG Brasil para fornecer informações em tempo real sobre cotações de moedas, incluindo moedas fiduciárias (USD, EUR, GBP, etc.) e criptomoedas (BTC). O aplicativo apresenta uma interface de usuário sofisticada com animações fluidas, feedback háptico e uma experiência de usuário intuitiva.

## 🌟 Funcionalidades Principais

### 📱 Interface de Usuário Moderna
- **Design Elegante**: Interface escura com gradientes sutis e elementos visuais modernos
- **Animações Fluidas**: Transições suaves entre telas e componentes
- **Feedback Háptico**: Resposta tátil ao interagir com elementos da interface
- **Componentes Reutilizáveis**: Cards de moeda, cabeçalho, abas e barra de botões

### 💹 Monitoramento de Moedas
- **Cotações em Tempo Real**: Valores atualizados de compra e venda de diversas moedas
- **Variação Percentual**: Indicadores visuais de alta (verde) e baixa (vermelho)
- **Categorização**: Filtros por tipo de moeda (Crypto, Fiat, Cards, Savings)
- **Detalhes Expandidos**: Visualização detalhada ao interagir com os cards de moeda

### 🔄 Integração com API
- **Consumo Eficiente**: Requisições otimizadas à API HG Brasil Finance
- **Tratamento de Erros**: Feedback visual em caso de falhas na conexão
- **Atualização Manual**: Botão para atualizar os dados a qualquer momento
- **Carregamento Assíncrono**: Indicador visual durante o carregamento dos dados

## 🏗️ Arquitetura

O projeto segue o padrão de arquitetura **MVVM (Model-View-ViewModel)** para uma separação clara de responsabilidades:

### 📦 Model
- **FinanceData.swift**: Define as estruturas de dados que representam a resposta da API, incluindo informações sobre moedas (nome, valores de compra/venda, variação)

### 🖼️ View
- **FinanceView.swift**: View principal que exibe os dados financeiros e gerencia a navegação
- **CurrencyCardView.swift**: Componente reutilizável que exibe informações detalhadas sobre uma moeda específica
- **Componentes Auxiliares**: HeaderView, TabsView, ButtonBar, LoadingView, ErrorView

### 🧠 ViewModel
- **FinanceViewModel.swift**: Gerencia o estado da aplicação, processa os dados da API e fornece métodos auxiliares para formatação e apresentação dos dados

### 🔌 Service
- **FinanceService.swift**: Responsável pela comunicação com a API externa, utilizando URLSession para requisições assíncronas

## 🛠️ Tecnologias Utilizadas

- **Swift 5**: Linguagem de programação moderna e segura
- **SwiftUI**: Framework declarativo para construção de interfaces de usuário
- **Combine**: Para processamento de dados assíncronos e reatividade
- **URLSession**: Para comunicação com APIs RESTful
- **Async/Await**: Utilização de programação assíncrona moderna
- **MVVM**: Padrão de arquitetura para separação de responsabilidades
- **HG Brasil Finance API**: Fonte de dados financeiros em tempo real

## 🚀 Destaques Técnicos

### ⚡ Performance
- **Carregamento Lazy**: Renderização eficiente de listas com LazyVStack
- **Assincronicidade**: Uso de async/await para operações de rede sem bloqueio da UI
- **Memória**: Utilização eficiente de recursos com padrão Singleton para serviços

### 🧩 Código Limpo
- **Documentação Detalhada**: Comentários explicativos em componentes-chave
- **Componentes Reutilizáveis**: Estrutura modular para facilitar manutenção
- **Nomenclatura Clara**: Nomes de variáveis e funções autoexplicativos
- **Tratamento de Erros**: Gestão robusta de casos de erro e estados de carregamento

### 🎨 UI/UX
- **Tema Escuro**: Interface moderna com tema escuro nativo
- **Feedback Visual**: Indicadores claros de estados (carregamento, erro, sucesso)
- **Responsividade**: Adaptação a diferentes tamanhos de tela
- **Acessibilidade**: Considerações para melhorar a experiência de todos os usuários

## 📈 Possibilidades de Expansão

- **Gráficos Históricos**: Implementação de visualizações gráficas da variação de preços
- **Notificações**: Alertas para variações significativas nas cotações
- **Conversão de Moedas**: Calculadora para conversão entre diferentes moedas
- **Favoritos**: Permitir que usuários marquem moedas como favoritas
- **Widgets**: Extensão para visualização rápida de cotações na tela inicial

## 🔧 Instalação e Execução

1. Clone o repositório
2. Abra o arquivo `API B3.xcodeproj` no Xcode
3. Selecione um simulador ou dispositivo iOS
4. Execute o projeto (⌘+R)

## 📝 Notas de Desenvolvimento

Este projeto foi desenvolvido com foco em práticas modernas de desenvolvimento iOS, incluindo:

- Uso de SwiftUI para construção de interfaces declarativas
- Implementação do padrão MVVM para separação de responsabilidades
- Utilização de async/await para operações assíncronas
- Tratamento adequado de estados de carregamento e erro
- Design de interface moderna e responsiva

---

<p align="center">Desenvolvido por Uriel Reis </p>
