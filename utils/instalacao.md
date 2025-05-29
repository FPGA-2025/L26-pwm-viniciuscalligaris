# Instalação  

## OSS CAD Suite  

O **OSS CAD Suite** é um conjunto de ferramentas open source para design de hardware. Ele inclui ferramentas para síntese, simulação, verificação e build para diversas FPGAs. O tutorial abaixo é baseado no repositório oficial do [OSS CAD Suite no GitHub](https://github.com/YosysHQ/oss-cad-suite-build).  

1. Baixe o pacote de instalação do [OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build/releases/tag/2025-05-07). Eu utilizei especificamente esta [versão](https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2025-05-07/oss-cad-suite-linux-x64-20250507.tgz). Caso haja uma versão mais recente disponível no dia em que você seguir este tutorial, recomendo verificar a seção de releases no GitHub para baixar a versão mais atualizada.  

2. Crie uma pasta chamada **eda** (abreviação de *Electronic Design Automation*) no seu diretório home e descompacte o arquivo nela, com o nome **oss-cad-suite**.  

3. Adicione o **oss-cad-suite** ao seu PATH, incluindo uma entrada no seu `.bashrc` ou `.zshrc`, como mostrado abaixo:  

   ```bash
   export PATH=$PATH:~/eda/oss-cad-suite/bin
   ```

Esse passo a passo pode ser resumido nos seguintes comandos:  

```bash
mkdir -p ~/eda
cd ~/eda
wget https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2025-05-07/oss-cad-suite-linux-x64-20250507.tgz
tar xvf oss-cad-suite-linux-x64-20250219.tgz
# Para usuários de Bash
echo "export PATH=\$PATH:~/eda/oss-cad-suite/bin" >> ~/.bashrc
# Para usuários de Zsh
echo "export PATH=\$PATH:~/eda/oss-cad-suite/bin" >> ~/.zshrc
rm oss-cad-suite-linux-x64-20250219.tgz
```

### Observações para macOS e Windows

* **macOS:** Certifique-se de baixar a versão correta do pacote, compatível com seu sistema. Para Macs com Apple Silicon (M1/M2/M3/M4), utilize a versão com o sufixo `darwin-arm64`. Para Macs com processadores Intel, use a versão `darwin-x64`.
  Exemplo: **`oss-cad-suite-darwin-arm64-20250507.tgz`**

* **Windows:** Recomenda-se fortemente utilizar o **WSL (Windows Subsystem for Linux)** para maior compatibilidade com as ferramentas.

---

## Litex

O LiteX é um framework robusto que facilita a criação e uso de cores e sistemas em chip (SoCs) em FPGAs. Ele oferece suporte a várias FPGAs e inclui uma rica biblioteca de IPs e cores *open-source*.

### Dependências do LiteX

O **LiteX** depende de ferramentas Python e também do sistema de build **Meson**. Abaixo estão as instruções para instalação nos principais sistemas operacionais.

#### Ferramentas necessárias

* **Python 3** (>= 3.6)
* **pip** (gerenciador de pacotes Python)
* **venv** (para criação de ambientes virtuais Python)
* **Meson** (sistema de build externo)

---

### Instruções por sistema

#### Debian/Ubuntu

```bash
sudo apt update
sudo apt install -y python3 python3-pip python3-venv meson
```

#### Arch Linux

```bash
sudo pacman -Syu python python-pip meson
# O módulo 'venv' já vem incluído no pacote 'python'.
```

#### Fedora

```bash
sudo dnf install -y python3 python3-pip python3-virtualenv meson
# Em versões mais recentes, o 'venv' já está incluído no pacote 'python3'.
```

#### macOS (via Homebrew)

```bash
brew install python3 meson
# O Python instalado via Homebrew já inclui pip e venv.
```

### Instalando o LiteX

A instalação do LiteX em um sistema Linux é um processo simples. Para instalar o LiteX, siga os passos abaixo, conforme indicado na documentação oficial:

```bash
cd
mkdir -p eda/litex
cd eda/litex
python3 -m venv env
wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
python3 ./litex_setup.py --init --install --config=standard
echo 'alias get_litex=". $HOME/eda/litex/litex_env/bin/activate"' >> ~/.bashrc
echo 'alias get_litex=". $HOME/eda/litex/litex_env/bin/activate"' >> ~/.zshrc
```

A instalação ocorre em um ambiente virtual Python, e para utilizá-lo, você deve ativar o ambiente com o comando get_litex. O processo pode levar alguns minutos, pois o LiteX clona diversos repositórios necessários para o funcionamento do framework e das ferramentas associadas.

Para aqueles que desejam se aprofundar no LiteX, os desenvolvedores disponibilizam alguns tutoriais: [https://github.com/litex-hub/fpga_101](https://github.com/litex-hub/fpga_101)

---

## Plugins do VSCode  

Alguns plugins são recomendados para o VSCode. A maneira mais simples de instalá-los é pesquisando pelo nome dentro do próprio editor, mas os links diretos também estão disponíveis abaixo:  

1. [Verilog HDL/SystemVerilog](https://marketplace.visualstudio.com/items?itemName=mshr-h.VerilogHDL&ref=learn.lushaylabs.com)  
2. [WaveTrace](https://marketplace.visualstudio.com/items?itemName=wavetrace.wavetrace&ref=learn.lushaylabs.com)  
3. [Serial Monitor](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-serial-monitor)  
4. [DigitalJS](https://marketplace.visualstudio.com/items?itemName=yuyichao.digitaljs)  

---

## Ajuste de permissões para acessar a USB sem ser root  

Se precisar acessar dispositivos USB sem permissões de superusuário (*root*), execute o seguinte comando:  

```bash
curl -sSL https://raw.githubusercontent.com/lushaylabs/openfpgaloader-ubuntufix/main/setup.sh | sh
```

---

## Compilador RISC-V

Para utilizar processadores RISC-V, é necessário um compilador capaz de traduzir código C para a arquitetura RISC-V. Em algumas distribuições, esse compilador já está disponível nos repositórios. Ele pode ser instalado com o seguinte comando:

```bash
cd ~/eda/litex 
sudo python3 ./litex_setup.py --gcc=riscv
```
