# Assembly com NASM + QEMU

## O que você precisa para compilar e rodar o código

### Pré-requisitos

#### **Linux (Ubuntu/Debian)**

```bash
sudo apt update
sudo apt install nasm qemu-system-x86
```

#### **Windows (MSYS2)**

1. Baixe e instale o **MSYS2**: [https://www.msys2.org](https://www.msys2.org)
2. Abra o terminal **MSYS2 UCRT64**.
3. Instale NASM e QEMU:

   ```bash
   pacman -S mingw-w64-ucrt-x86_64-nasm
   pacman -S mingw-w64-ucrt-x86_64-qemu
   ```

---

### Compilar o código

No terminal, dentro da pasta do projeto:

```bash
nasm -f bin [caminho]/[arquivo].asm -o [caminho]/[arquivo].bin
```

---

### Executar no QEMU

```bash
qemu-system-i386 -fda [caminho]/[arquivo].bin
```

Isso abre uma janela do QEMU com a execução do teu código Assembly.

> Observação: No MSYS2, você não precisa colocar .exe no qemu-system-i386, mas no CMD/PowerShell sim.

---

### 📚 Recursos úteis

* Documentação NASM: [https://www.nasm.us/docs.php](https://www.nasm.us/docs.php)
* QEMU: [https://www.qemu.org/documentation](https://www.qemu.org/documentation)
* Guia Bootsector: [https://wiki.osdev.org/Bootsector](https://wiki.osdev.org/Bootsector)

> Observação: O código deve ser escrito como bootsector (começando em org 0x7C00 e terminando com dw 0xAA55) para que o QEMU consiga executar corretamente.