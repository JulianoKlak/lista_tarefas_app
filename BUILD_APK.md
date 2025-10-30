# Como Construir o APK do Lista de Tarefas

Este guia explica como construir o arquivo APK do aplicativo Lista de Tarefas para instalar em dispositivos Android.

## Novo Ícone do App

O ícone do aplicativo foi atualizado com um design criativo relacionado a listas de tarefas, mostrando um bloco de notas com itens de tarefas e checkboxes.

## Pré-requisitos

1. **Flutter SDK** instalado no seu sistema
   - Download: https://docs.flutter.dev/get-started/install
   - Versão recomendada: 3.19.6 ou superior

2. **Android SDK** instalado
   - Pode ser instalado através do Android Studio ou via linha de comando

3. **Java JDK** (versão 11 ou superior)

## Passos para Construir o APK

### 1. Instalar Dependências

```bash
flutter pub get
```

### 2. Construir APK de Release

Para construir um APK otimizado para distribuição:

```bash
flutter build apk --release
```

O APK será gerado em: `build/app/outputs/flutter-apk/app-release.apk`

### 3. Construir APK de Debug (para testes)

Se preferir um APK de debug:

```bash
flutter build apk --debug
```

O APK será gerado em: `build/app/outputs/flutter-apk/app-debug.apk`

### 4. Construir APK Split por ABI (menor tamanho)

Para criar APKs otimizados por arquitetura (resultando em arquivos menores):

```bash
flutter build apk --split-per-abi
```

Isso criará múltiplos APKs em `build/app/outputs/flutter-apk/`:
- `app-armeabi-v7a-release.apk` (para dispositivos ARM de 32 bits)
- `app-arm64-v8a-release.apk` (para dispositivos ARM de 64 bits)
- `app-x86_64-release.apk` (para emuladores x86)

## Instalar o APK no Dispositivo

### Via USB (ADB)

```bash
flutter install
```

Ou manualmente:

```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Via Arquivo

1. Transfira o arquivo APK para o seu dispositivo Android
2. Abra o arquivo APK no dispositivo
3. Permita a instalação de fontes desconhecidas se solicitado
4. Instale o aplicativo

## Verificar a Instalação

Após a instalação, o aplicativo aparecerá com o novo ícone personalizado (bloco de notas com checkboxes).

## Solução de Problemas

### Erro: Flutter não encontrado

Certifique-se de que o Flutter está no seu PATH:

```bash
export PATH="$PATH:$HOME/flutter/bin"
```

### Erro: Licenças do Android não aceitas

```bash
flutter doctor --android-licenses
```

### Verificar configuração do Flutter

```bash
flutter doctor -v
```

## Alterações Recentes

- ✅ Novo ícone criativo do aplicativo (bloco de notas com checkboxes)
- ✅ Checkbox verde agora só marca tarefas (não desmarca)
- ✅ Botão X vermelho exibe confirmação antes de desmarcar tarefas completas
- ✅ Modal de confirmação com botões "Não concluí" e "Cancelar"
