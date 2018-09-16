---
title: "Transformando Dados"
author: "P4H"
output: html_document
---



## Introdução

No nosso último encontro, trabalhamos um pouco com importação de dados e _webscraping_. Uma vez que essa etapa é realizada, como proceder com o nosso banco de dados? Como transformá-lo para algo mais significado para nós? Hoje iremos entender como funciona a estruturação e a transformação de dados, de acordo com o _tidyverse approach_.

<img src="https://github.com/p4hUSP/workshops_2018.2/blob/master/imgs/w1_01.png" class="cienciadedados" class="center" class="center">

## Estruturação

> tidy datasets are all alike but every messy dataset is messy in its own way (Hadley, 2014)

Estruturar um banco é uma tarefa __essencial__ antes de realizar qualquer operação. Uma banco desestruturado nos impede de transformar, visualizar e até modelar as nossas variáveis!

<img src="../imgs/tidy-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />


## Transformação

Por que transformar os nossos dados? Após importar um banco para o R, antes de realizar qualquer análise, precisamos (1) garantir que as nossas variáveis estão limpas, ou seja, que todos os valores estão condizentes com o padrão esperado (2) e, às vezes, precisamos _recodificá-las_ para algo com mais significado para nós.

Vamos ver alguns exemplos, antes de continuar. O que entendemos por limpar um banco? Imagine que ao coletar a renda de alguns indivíduos você tenha introduzido um hífem para identificar não respostas. 


|RENDA    | RENDA_NEW|
|:--------|---------:|
|19991,32 |  19991.32|
|-        |        NA|
|-        |        NA|
|829,23   |    829.23|
|9293,12  |   9293.12|
|839,79   |    839.79|

Embora isso possa ser considerado um procedimento válido durante a coleta, ele irá causar problemas durante a nossa análise. Uma vez que "-" é um texto, o R não sabe como compará-lo com valores numéricos (19991.32, por exemplo). Nesse sentido, precisamos explicitar para o R que "-" na verdade é um valor _missing_. Iremos ver que, na prática, transformaremos o "-" em NA através das funções `mutate` e `ifelse`.

Outro exemplo de transformação é a necessidade de _recodificação_ os valores de uma variável. Estamos falando, por exemplo, de criação de faixas para variáveis contínuas, reclassificação de variáveis categóricas, inflacionar/deflacionar valores monetários, etc. Um caso prático é a reclassificação das categorias do IBGE para valores com maior significado sociológico. É relaticamente comum classificar indíginas, pretos e pardos como não-brancos para fins de análise de desigualdade racial.


|RACA_IBGE |RACA_NEW    |
|:---------|:-----------|
|INDÍGENA  |NÃO BRANCOS |
|PRETA     |NÃO BRANCOS |
|PARDA     |NÃO BRANCOS |
|BRANCA    |BRANCOS     |

Uma vez que você tenha entendido para que precisamos transformar os nossos dados, vamos colocar a mão na massa e tentar realizar essa atividade por meio códigos!!!

A estrutura para modificar variáveis no R por meio do `tidyverse` segue sempre o mesmo padrão:


```r
mutate(BANCO_DE_DADOS,
       VARIAVEL QUE QUEREMOS CRIAR/MODIFICAR    =   VALOR QUE A VARIÁVEL IRÁ RECEBER)
```

`mutate` é uma função bem versátil e será muito utilizada por você sempre que quiser __acessar__ as variáveis de um `data frame`. Experimente por exemplo criar uma coluna com 