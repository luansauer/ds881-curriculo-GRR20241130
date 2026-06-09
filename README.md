# DS881 — Currículo Online · GRR20241130

Currículo profissional desenvolvido para a disciplina **DS881** da UFPR, demonstrando o domínio de conteinerização com Docker, automação de pipeline CI/CD com GitHub Actions e governança de código via Branch Protection e Pull Requests.

🌐 **[Ver currículo em produção →](https://luansauer.github.io/ds881-curriculo-GRR20241130)**

---

## Stack

| Camada | Tecnologia |
|---|---|
| Site | HTML5 + CSS3 puro (sem dependências de build) |
| Dev container | Docker + nginx:alpine |
| CI/CD | GitHub Actions (Lint → Build → Deploy) |
| Hospedagem | GitHub Pages |

---

## Execução local via Docker

> **Pré-requisito:** Docker e Docker Compose instalados. Nenhuma outra dependência (Node.js, Ruby, etc.) é necessária no sistema operacional.

### 1. Clone o repositório

```bash
git clone https://github.com/luansauer/ds881-curriculo-GRR20241130.git
cd ds881-curriculo-GRR20241130
```

### 2. Suba o container

```bash
docker compose up --build
```

### 3. Acesse no navegador

```
http://localhost:8080
```

O container usa **bind mounts** (`./index.html` e `./style.css` montados diretamente no container), portanto qualquer alteração salva nos arquivos locais é refletida imediatamente no navegador ao recarregar a página.

### Parar o container

```bash
docker compose down
```

---

## Pipeline CI/CD

O workflow `.github/workflows/main.yml` executa automaticamente em todo PR e push na `main`:

```
PR aberto
   └── lint          → HTMLHint (HTML) + stylelint (CSS)
         └── build   → docker build + smoke test na porta 8080
               └── deploy (só na main) → GitHub Pages
```

Merge na `main` só é permitido com o pipeline **verde** (ver Branch Protection abaixo).

---

## Fluxo de trabalho Git

Todo desenvolvimento segue o fluxo:

```bash
# 1. Criar branch a partir da main
git checkout -b feat/nome-da-feature

# 2. Fazer commits com Conventional Commits
git commit -m "feat: adiciona seção de projetos"
git commit -m "fix: corrige responsividade mobile"
git commit -m "ci: adiciona smoke test no workflow"

# 3. Abrir Pull Request → aguardar CI verde → merge
```

**Prefixos de commit utilizados:** `feat:`, `fix:`, `ci:`, `docs:`, `style:`

---

## Configuração de Branch Protection

A branch `main` está configurada com as seguintes regras no GitHub:

- ✅ **Require a pull request before merging** — push direto bloqueado
- ✅ **Require status checks to pass before merging** — jobs `lint` e `build` obrigatórios
- ✅ **Do not allow bypassing the above settings** — sem exceções, nem para admins

> 📸 Print da configuração de Branch Protection:

<!-- INSTRUÇÃO: substitua a linha abaixo pelo print real após configurar no GitHub -->
![Branch Protection](docs/branch-protection.png)

---

## Estrutura do repositório

```
ds881-curriculo-GRR20241130/
├── index.html              # Currículo (HTML puro)
├── style.css               # Estilos
├── Dockerfile              # Imagem nginx:alpine + site
├── docker-compose.yml      # Ambiente de dev com bind mount na porta 8080
├── nginx.conf              # Configuração do servidor nginx
├── .htmlhintrc             # Regras do linter HTML
├── .stylelintrc.json       # Regras do linter CSS
├── .gitignore
├── .github/
│   └── workflows/
│       └── main.yml        # Pipeline CI/CD (Lint → Build → Deploy)
└── README.md
```

---

## Critérios de avaliação atendidos

| Item | Implementação |
|---|---|
| Docker (30%) | `Dockerfile` + `docker-compose.yml` com bind mount e porta 8080 |
| CI/CD (30%) | Lint (HTMLHint + stylelint) + Build (docker + smoke test) + Deploy (Pages) |
| Branch Protection + PRs (20%) | Branch `main` protegida, merge via PR com CI obrigatório |
| Documentação + commits (10%) | README completo, commits com Conventional Commits |
| GitHub Pages (10%) | Deploy automático após merge na `main` |
