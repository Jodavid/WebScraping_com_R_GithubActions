
# WebScraping com R GithubActions

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

-   /15 \* \* \* \*

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

    # Controls when the action will run.
    on:
      schedule:
        - cron:  '*/5 * * * *'


    jobs: 
      autoscrape:
        # The type of runner that the job will run on
        runs-on: macos-latest

        # Load repo and install R
        steps:
        - uses: actions/checkout@master
        - uses: r-lib/actions/setup-r@master

        # Set-up R
        - name: Install packages
          run: |
            R -e 'install.packages("tidyverse")'
            R -e 'install.packages("janitor")'
            R -e 'install.packages("rvest")'
        # Run R script
        - name: Scrape
          run: Rscript nifty50_scraping.R
          
     # Add new files in data folder, commit along with other modified files, push
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
