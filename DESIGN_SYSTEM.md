# Design System - Sushi Counter App

Este documento descreve as especificações visuais do Sushi Counter App (Doodle Style), servindo como referência para garantir a integridade do design durante a refatoração.

## 🎨 Cores

### Paleta Principal
- **Fundo da App:** `#F9F7F2` (Off-white quente)
- **Fundo dos Cards:** `Color.white` ou `Color(hex: "F9F7F2")` para modais.
- **Destaque Primário:** `Color.black` (Usado em botões de ação e textos principais).
- **Feedback de Erro/Exclusão:** `#FF3B30` (Vermelho vibrante).
- **Cores de Itens (Seed Data):**
  - Harumaki: `#FF5E5E`
  - Hossomaki: `#4E9F3D`
  - Hot: `#FFB319`
  - Joe: `#FF8C32`
  - Nigiri: `#845EC2`
  - Sashimi: `#D65DB1`
  - Tiradito: `#4B4453`
  - Uramaki: `#C34A36`

## 📐 Bordas e Contornos (Stroke)
- **LineWidth Padrão:** `3` (Obrigatório para o estilo Doodle/Cartoon).
- **Cor do Stroke:** `Color.black`.
- **Raio de Canto (Corner Radius):**
  - Cards e Botões: `16` ou `24`.
  - Modais: `24`.

## 👤 Sombras (Hard Shadows)
- **Estilo:** Sombras sólidas (hard shadows), sem blur excessivo, para manter o visual de desenho.
- **Configuração Típica:** `.shadow(color: .black, radius: 0, x: 4, y: 4)` ou `x: 8, y: 8` para modais.
- **Opacidade:** Frequentemente `1.0` (totalmente opaca) ou `.black.opacity(0.1)` para sombras mais sutis em elementos menores.

## 🔡 Tipografia
- **Design:** `.rounded` (Obrigatório para manter a estética amigável).
- **Pesos:** `.black` ou `.bold` para títulos e números grandes.
- **Tamanhos Notáveis:**
  - Título Principal: `.title` ou `.title2`.
  - Contador Gigante: `size: 96, weight: .black`.
  - Labels de Seção: `.caption` com `.black` weight e `tracking(1)` ou `tracking(2)`.

## 🍱 Componentes Visuais
- **Doodle Background:** Padrão de bolinhas (`dot pattern`) desenhado via `Canvas` com opacidade `0.03`.
- **Haptics:** Uso de `UIImpactFeedbackGenerator` e `UINotificationFeedbackGenerator` para interações.
- **Animações:** Uso predominante de `.spring()` para transições orgânicas.
