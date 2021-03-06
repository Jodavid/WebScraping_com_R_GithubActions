
# WebScraping com R GithubActions

[![JodaScraping](https://github.com/Jodavid/WebScraping_com_R_GithubActions/actions/workflows/main.yml/badge.svg)](https://github.com/Jodavid/WebScraping_com_R_GithubActions/actions/workflows/main.yml)

Última atualização: 11-02-2022

<hr/>

Este repositório é para estudo e aplicação de um *Web Scraping* simples
com agendamento no Github Actions.

A estruturação das pastas é dada como segue:

-   **src/**
    -   WebScraping.R
-   **data/**
    -   \[\*\]\_scraping.csv
-   *CodigoPrincipal.R*

em que \[\*\] representa a data atual;

Na pasta **src/** estão localizados os arquivos `.R` para execução do
objetivo do estudo.

Na pasta **data/** é onde serão salvo os retornos do Scraping.

O arquivo *CodigoPrincipal.R* é o arquivo principal que chama os códigos
necessários para execução necessária.

### Detalhe sobre o Crontab

Abaixo segue detalhes sobre eles:

-   Minuto: Valores de 0 a 59 ou \*
-   Hora: Valores de 0 a 23 ou \*
-   Dia: Valores de 1 a 31 ou \*
-   Mês: Valores de 1 a 12, jan a dec ou \*
-   Semana: 0 a 6, sun a sat ou \* (0 e 7 representa Domingo)

O caractere asterisco (\*) significa do primeiro ao último.

Para executar em intervalos de tempos em um dia pode ser usado por
exemplo: `*/5 * * * *` no qual o código vai ser executado a cada 5
minutos.

### Etapas para criar o workflow no Github:

1.  Arquivo `main.yml`:

<!-- -->

    # Scraping por Dia
    name: JodaScraping

    # Controles para execução do action.
    on:
      schedule:
        - cron:  '*/5 * * * *'


    jobs: 
      autoscrape:
        # O tipo de executor no qual o trabalho será executado
        runs-on: ubuntu-latest

        # Carregar repo e instalar R
        steps:
        - uses: actions/checkout@master
        - uses: r-lib/actions/setup-r@master

        # Setup R
        - name: Install packages
          run: |
            R -e 'install.packages("rvest")'
            R -e 'install.packages("stringr")'
        # Run R script
        - name: Scrape
          run: Rscript CodigoPrincipal.R
          
     # Adicione novos arquivos na pasta de dados, confirme junto com outros arquivos modificados, empurre
        - name: Commit files
          run: |
            git config --local user.name actions-user
            git config --local user.email "actions@github.com"
            git add data/*
            git commit -am "GH ACTION Headlines $(date)"
            git push origin main
          env:
            REPO_KEY: ${{secrets.GITHUB_TOKEN}}
            username: github-actions

2.  Criar uma pasta `.github`

3.  Dentro da pasta `.github` criar a pasta `workflows`

4.  Dentro da pasta `workflows` cria o arquivo `main.yml` com o código
    desenvolvido acima

5.  Faz o commit e envia as modificações

6.  No Github vai na opção `Actions`

7.  Clica no Workflow criado;

8.  
