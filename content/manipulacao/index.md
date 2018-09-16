---
title: "Manipulação de Dados (Data Wragling)"
output: html_notebook
---

# A base está na pasta data/w2 e chama w2_01_use.csv; o dado original se encontra na mesma pasta com o nome w2_01.csv

O que veremos hoje:

- [O pacote `tidyverse`.](#tidyverse)

- [O que é _tidy data_?](#tidydata)

- [Como deixar os dados tidy com o `tidyr`.](#tidyr)

- [Os principais verbos do `dplyr`.](#dplyr)

- [Extra: Juntar dados de diferentes fontes](#joins)

<a href="#tidyverse">

# O tidyverse

SUGESTÃO: Falar para que serve e como utilizaremos neste workshop

<a href="#tidydata">

# Tidydata

SUGESTÃO: Falar a difereça de dados Long e Wide

<a href="#tidyr">

# tidyr

SUGESTÃO: Falar sobre gather/spread e as funções unite e separete. O banco de dados possibilita por exemplo, fazer um unite com as variaveis launch_month, launch_day e launch_year*

* Sobre as funções gather e spread, eu baguncei a base de proposito: então as colunas com os anos precisam de um gather: ` gather(launch_year, institutions, c("2012", "2013", "2014", "2015", "2016")) %>% drop_na(institutions)`

<a href="#dplyr">

# dplyr

Apresentar os verbos do dplyr. O banco de dados permite:

- calcular a porcentagem de alunos que obteram certficado (certificados/participantes)

- calcular a porcentagem de certificados por alunos ouvintes (autided/certificados)

- calcular a porcentagem de alunos ouvintes (audited/participantes)

Além disso, dá para pensar em perguntas como:

- Os cursos costumam ser lançados em quais meses?

- quais cursos tem uma porcentagem de postagens no forum maior que 50%?

- Existe diferença entre os cursos de Harvard e do MIT?


<a href="#joins">

# Join

Só se for necessario
