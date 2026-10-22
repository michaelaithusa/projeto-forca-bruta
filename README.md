# 🔐 Auditoria de Segurança: Ataques de Força Bruta (FTP, Web e SMB)

Projeto desenvolvido como parte da trilha de estudos em Cibersegurança (Blue Team), com foco em entender, na prática, como funcionam ataques de força bruta contra serviços de rede e como mitigá-los.

> ⚠️ **Aviso legal:** este projeto é destinado exclusivamente a ser executado em **ambiente de laboratório controlado e isolado** (máquinas virtuais próprias, como Metasploitable2 e DVWA), sem qualquer impacto em sistemas de terceiros. Força bruta contra sistemas sem autorização explícita é crime (Lei 12.737/2012 e Lei 14.155/2021 no Brasil). Este repositório tem finalidade exclusivamente educacional.

> 📌 **Status do projeto:** estrutura, teoria e comandos documentados. Execução prática em laboratório **a ser realizada** — os campos de resultado abaixo serão atualizados assim que os testes forem executados.

---

## 🎯 Objetivos

- Compreender o funcionamento de ataques de força bruta em diferentes serviços (FTP, formulários Web e SMB);
- Utilizar o Kali Linux e a ferramenta **Medusa** para auditoria de segurança;
- Documentar o processo técnico de forma clara e estruturada;
- Identificar vulnerabilidades comuns relacionadas a senhas fracas;
- Propor medidas de mitigação e boas práticas de defesa.

---

## 🧰 Ambiente e Ferramentas

| Item | Descrição |
|---|---|
| Sistema atacante | Kali Linux |
| Ferramenta principal | [Medusa](https://github.com/jmk-foofus/medusa) |
| Alvo de testes | Metasploitable2 (VM vulnerável para fins didáticos) |
| Rede | Rede interna/isolada (host-only ou NAT, sem saída para a internet) |
| Wordlists | `rockyou.txt` (nativa do Kali) e lista customizada em `/wordlists` |

---

## 🗂️ Estrutura do Repositório

```
├── README.md
├── wordlists/
│   ├── usuarios.txt
│   └── senhas.txt
├── scripts/
│   └── comandos-medusa.sh
└── images/
    ├── ftp-bruteforce.png
    ├── web-bruteforce.png
    └── smb-bruteforce.png
```

---

## 1️⃣ Força Bruta em FTP

### Comando utilizado
```bash
medusa -h <IP_ALVO> -U wordlists/usuarios.txt -P wordlists/senhas.txt -M ftp
```

### Parâmetros
- `-h` : endereço IP do alvo
- `-U` : wordlist de usuários
- `-P` : wordlist de senhas
- `-M` : módulo do serviço (ftp)

### Resultado
🔲 **[A preencher após execução em laboratório]**
*(Adicione aqui a captura de tela em `/images/ftp-bruteforce.png` — opcional — e descreva a credencial encontrada.)*

### Observação
O FTP do Metasploitable2 aceita login anônimo e possui credenciais fracas por padrão, o que facilita o ataque em poucos segundos.

---

## 2️⃣ Força Bruta em Formulário Web

### Comando utilizado
```bash
medusa -h <IP_ALVO> -U wordlists/usuarios.txt -P wordlists/senhas.txt -M web-form \
-m FORM:"/dvwa/login.php" -m DENY-SIGNAL:"login.php" \
-m FORM-DATA:"post?username=&password=&Login=Login"
```

### Parâmetros
- `-m FORM` : caminho do formulário de login
- `-m DENY-SIGNAL` : string que indica falha de login (usada para diferenciar sucesso de erro)
- `-m FORM-DATA` : campos do formulário que serão preenchidos

### Resultado
🔲 **[A preencher após execução em laboratório]**
*(Adicione aqui a captura de tela em `/images/web-bruteforce.png` — opcional — e descreva a credencial encontrada.)*

### Observação
Ataques desse tipo são mitigados com **rate limiting**, **CAPTCHA** e bloqueio temporário de conta após N tentativas.

---

## 3️⃣ Força Bruta em SMB

### Comando utilizado
```bash
medusa -h <IP_ALVO> -U wordlists/usuarios.txt -P wordlists/senhas.txt -M smbnt
```

### Parâmetros
- `-M smbnt` : módulo específico para autenticação SMB/NTLM

### Resultado
🔲 **[A preencher após execução em laboratório]**
*(Adicione aqui a captura de tela em `/images/smb-bruteforce.png` — opcional — e descreva a credencial encontrada.)*

### Observação
Compartilhamentos SMB mal configurados, com contas padrão e sem política de bloqueio, são um dos vetores mais explorados em redes corporativas (movimentação lateral).

---

## 🛡️ Mitigações Recomendadas

- **Política de senhas fortes:** exigir senhas longas, com complexidade mínima;
- **Bloqueio por tentativas (account lockout):** travar a conta após N tentativas falhas;
- **MFA (autenticação multifator):** reduz drasticamente o impacto mesmo com senha comprometida;
- **Rate limiting / fail2ban:** limitar tentativas de login por IP em um intervalo de tempo;
- **Desabilitar serviços desnecessários:** FTP anônimo e SMBv1, por exemplo, devem ser desativados quando não utilizados;
- **Monitoramento e alertas (SIEM):** detectar picos de tentativas de autenticação como indicativo de ataque em andamento;
- **Segmentação de rede:** limitar a exposição de serviços internos (FTP, SMB) à internet.

---

## 📚 Referências

- [Documentação oficial do Medusa](https://github.com/jmk-foofus/medusa)
- [OWASP - Brute Force Attack](https://owasp.org/www-community/attacks/Brute_force_attack)
- [Metasploitable2 - Documentação](https://docs.rapid7.com/metasploit/metasploitable-2/)

---

## 👤 Autor

**Michael**  
Supervisor de Operações | Estudante de Cibersegurança (foco em Blue Team)  
[GitHub](https://github.com/michaelaithusa)
