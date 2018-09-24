---
title: "Transformando Dados"
author: "P4H"
output: html_document
---



## Introdução

No nosso último encontro, trabalhamos um pouco com importação de dados e _webscraping_. Uma vez que essa etapa é realizada, como proceder com o nosso banco de dados? Como transformá-lo para algo mais significado para nós? Hoje iremos entender como funciona a estruturação e a transformação de dados, de acordo com o _tidyverse approach_.

<img src="https://github.com/p4hUSP/workshops_2018.2/blob/master/imgs/w1_01.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

## Estruturação

> tidy datasets are all alike but every messy dataset is messy in its own way (Hadley, 2014)

Estruturar um banco é uma tarefa __essencial__ antes de realizar qualquer operação. Uma banco desestruturado nos impede de transformar, visualizar e até modelar as nossas variáveis! Qual padrão iremos utilizar? Trabalharemos com bancos em que as linhas contêm observações; as colunas, variáveis e as células, valores.

<img src="https://github.com/p4hUSP/workshops_2018.2/blob/master/imgs/tidy-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

## Como deixar os dados tidy com o `tidyr`.

O pacote `tidyr` possui funções que irão nos auxiliar durante o processo de _estruturação_ de um banco de dados. Ela é carregada com o comando `library(tidyverse)`.

Neste workshop, iremos trabalhar com o banco de dados sobre cursos _online_ oferecidos pelo MIT e pela Harvard.


```r
# Carrega o pacote tidyverse
library(tidyverse)

# Lê o banco de dado
banco_1 <- read_csv('../data/w2/w2_01_use.csv') # Não se esqueça de alterar o caminho
```

Após carregar o nosso banco de dados, podemos dar uma "olhada rápida" por ele com a função `glimpse`.


```r
glimpse(banco_1)
```

```
## Observations: 290
## Variables: 25
## $ course_number                     <chr> "6.002x", "6.00x", "3.091x",...
## $ launch_month                      <int> 9, 9, 10, 10, 10, 2, 2, 2, 2...
## $ launch_day                        <int> 5, 26, 9, 15, 15, 4, 5, 12, ...
## $ course_title                      <chr> "Circuits and Electronics", ...
## $ instructors                       <chr> "Khurram Afridi", "Eric Grim...
## $ course_subject                    <chr> "Science, Technology, Engine...
## $ year                              <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
## $ honor_code_certificates           <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
## $ participants                      <int> 36105, 62709, 16663, 129400,...
## $ audited                           <int> 5431, 8949, 2855, 12888, 107...
## $ certified                         <int> 3003, 5783, 2082, 1439, 5058...
## $ percent_played_video              <dbl> 83.20, 89.14, 87.49, 0.00, 7...
## $ percent_posted_forum              <dbl> 8.17, 14.38, 14.42, 0.00, 15...
## $ percent_grade_higher_than_zero    <dbl> 28.97, 39.50, 34.89, 1.11, 3...
## $ total_course_hours_per_1000       <dbl> 418.94, 884.04, 227.55, 220....
## $ median_hours_for_certification    <dbl> 64.45, 78.53, 61.28, 0.00, 7...
## $ median_age                        <dbl> 26, 28, 27, 28, 32, 27, 27, ...
## $ percent_male                      <dbl> 88.28, 83.50, 70.32, 80.02, ...
## $ percent_female                    <dbl> 11.72, 16.50, 29.68, 19.98, ...
## $ percent_bachelor_degree_or_higher <dbl> 60.68, 63.04, 58.76, 58.78, ...
## $ `2012`                            <chr> "MITx", "MITx", "MITx", "Har...
## $ `2013`                            <chr> NA, NA, NA, NA, NA, "MITx", ...
## $ `2014`                            <chr> NA, NA, NA, NA, NA, NA, NA, ...
## $ `2015`                            <chr> NA, NA, NA, NA, NA, NA, NA, ...
## $ `2016`                            <chr> NA, NA, NA, NA, NA, NA, NA, ...
```

### `gather`

Repare que as últimas quatro colunas não são exatamente variáveis. `2012`, `2013`, `2014`, `2015` e `2016` na verdade são valores de uma outra variável, ao mesmo tempo que as células correspondentes a essas variáveis dizem respeito também a outra variável. Você saberia dizer tendo em vista apenas os valores quais são essas __duas__ variáveis?


```r
banco_2 <- gather(banco_1, c("2012", "2013", "2014", "2015", "2016"), key = "year", value = "institutions")
```

Se você está familiarizado com a notação _wide_ e _long_, o que acabamos de fazer foi transformar um banco com características _wide_ em um _long_. É possível ir além e afirmar que o formato _tidy data_ sempre é um banco _long_.

Uma outra maneira de entender o que aconteceu é pensar que as linhas foram _derretidas_ para formar novas variáveis.

Obs: Se você tiver interesse de ir mais a fundo nas diferenças de _wide_ e _long_, assista este [vídeo](https://pt.coursera.org/lecture/designexperiments/21-long-format-and-wide-format-data-tables-dqWIT)

## Os principais verbos do dplyr.

As funções do pacote `dplyr` podem 

1. `filter`: filtra as linhas de um banco de dados de acordo com uma regra lógica.

2. `mutate`: modifica ou cria colunas de acordo com valores fornecidos.

3. `select`: seleciona ou exclui colunas de um banco de dados.

4. `count`: conta os valores e uma variável.

    + Especialmente útil para variáveis categóricas.
    
5. `group_by` e `summarise`: são funções normalmente utilizadas em conjunto. Elas permitem realizar operações de agregações com o banco de dados e, assim, alterar a unidade de análise. 

### filter

Vamos voltar ao nosso banco de cursos _online_. Após realizarmos uma operação a fim de tornar o nosso banco _long_, você reparou que o número de observações aumentou? Podemos verificar isso com a função `nrow()`.


```r
nrow(banco_1)
```

```
## [1] 290
```

```r
nrow(banco_2)
```

```
## [1] 1450
```

De 290 observações, fomos para 1450! Em alguns casos, isso não seria um problema. Porém, neste em caso em específico, houve uma criação de vários valores NA (missing) para a coluna `institutions`. Isso ocorreu porque no fundo esse banco foi transformado previamente com objetivo de produzir um exemplo para este tutorial.

Independentemente disso, temos que arrumar esse problema e excluir as linhas com valor NA. Como realizar isso? Antes precisamos trabalhar rapidamente com avaliações lógicas no R como também entender melhor qual a natureza desse valor de _missing_ no R, o `NA`.

### Valores Booleanos e Avaliações Lógicas

Valores booleanos são resultados de operações booleanas e podem ser definidos como __verdadeiros__ ou __falsos__. Por convenção, trabalhamos com os termos em inglês. Portanto, __TRUE__ ou __FALSE__.

Por operações booleanas, podemos pensar em diferentes testes que tenham __necessariamente__ uma resposta ou verdadeira ou falsa. Por exemplo, 3 é maior do que 1? Verdadeiro! E 3 é menor do que 2? Falso! Vamos realizar essas duas operações no R.


```r
# 3 é maior do que 1?

3 > 1
```

```
## [1] TRUE
```


```r
# 3 é maior do que 1?

3 < 2
```

```
## [1] FALSE
```

Existem, obviamente, outras operações. É possível também testar a igualdade entre dois valores com `==`.


```r
# 2 é igual a 2?

2 == 2
```

```
## [1] TRUE
```

Também podemos testar se dois valores são diferentes.


```r
#120 é diferente de 20?

120 != 20
```

```
## [1] TRUE
```

Outras variações utilizadas são o maior ou igual (`>=`) e o menor ou igual (`<=`). Além disso, também é possível realizar essas operações com textos.


```r
# "harvard" é igual a "MIT"?

"harvard" == "MIT"
```

```
## [1] FALSE
```

Não iremos introduzir essa ideia aqui, mas caso seja de interesse também podemos utilizar as noções de maior e menor para textos. Você teria um palpite de como um texto pode ser maior do que outro?

Por fim, temos uma operação booleana no R para testar se um valor é _missing_. Normalmente, ao realizar a nossa coleta de dados, não conseguimos acessar determinados dados para algumas observações. De modo geral, representamos esses valores como _missing_. No R, representamos valores _missing_ como NAs e para testar se um valor é NA __NÃO__ podemos utilizar o operador `==`. Por que?


```r
NA == NA
```

```
## [1] NA
```

Ao invés de `==`, nós utilizamos a função `is.na()`.


```r
is.na(NA)
```

```
## [1] TRUE
```

Para testar se um valor __não__ é um _missing_, precisamos adicionar um `!` antes do `is.na()`.


```r
!is.na("oi")
```

```
## [1] TRUE
```

```r
!is.na(NA)
```

```
## [1] FALSE
```

| Operador       | Símbolo |
| -------------- |:-------:| 
| Igual          | ==      |
| Diferente      | !=      |
| Maior          | >       |
| Maior ou igual | >=      |
| Menor          | <       |
| Menor ou igual | <=      |
| É missing      | is.na() |

### Aplicando operações booleanas em `filter`.

Após essa breve exposição, talvez você tenha uma ideia de que como iremos _filtrar_ as observações que __não__ são _missings_ na variável `institutions`.


```r
banco_3 <- filter(banco_2, !is.na(institutions))
```

Pronto, agora temos um banco com 290 observações.

### mutate

Por que transformar os nossos dados? Após importar um banco para o R, antes de realizar qualquer análise, precisamos (1) garantir que as nossas variáveis estão limpas, ou seja, que todos os valores estão condizentes com o padrão esperado (2) e, às vezes, precisamos _recodificá-las_ para algo com mais significado para nós.

Quais _recodificações_ podem ser realizadas no nosso banco? Vamos utilizar novamente a função `glimpse` para ter uma ideia geral dos conteúdos das nossas variáveis.


```r
glimpse(banco_3)
```

```
## Observations: 290
## Variables: 21
## $ course_number                     <chr> "6.002x", "6.00x", "3.091x",...
## $ launch_month                      <int> 9, 9, 10, 10, 10, 2, 2, 2, 2...
## $ launch_day                        <int> 5, 26, 9, 15, 15, 4, 5, 12, ...
## $ course_title                      <chr> "Circuits and Electronics", ...
## $ instructors                       <chr> "Khurram Afridi", "Eric Grim...
## $ course_subject                    <chr> "Science, Technology, Engine...
## $ honor_code_certificates           <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
## $ participants                      <int> 36105, 62709, 16663, 129400,...
## $ audited                           <int> 5431, 8949, 2855, 12888, 107...
## $ certified                         <int> 3003, 5783, 2082, 1439, 5058...
## $ percent_played_video              <dbl> 83.20, 89.14, 87.49, 0.00, 7...
## $ percent_posted_forum              <dbl> 8.17, 14.38, 14.42, 0.00, 15...
## $ percent_grade_higher_than_zero    <dbl> 28.97, 39.50, 34.89, 1.11, 3...
## $ total_course_hours_per_1000       <dbl> 418.94, 884.04, 227.55, 220....
## $ median_hours_for_certification    <dbl> 64.45, 78.53, 61.28, 0.00, 7...
## $ median_age                        <dbl> 26, 28, 27, 28, 32, 27, 27, ...
## $ percent_male                      <dbl> 88.28, 83.50, 70.32, 80.02, ...
## $ percent_female                    <dbl> 11.72, 16.50, 29.68, 19.98, ...
## $ percent_bachelor_degree_or_higher <dbl> 60.68, 63.04, 58.76, 58.78, ...
## $ year                              <chr> "2012", "2012", "2012", "201...
## $ institutions                      <chr> "MITx", "MITx", "MITx", "Har...
```

Podemos, por exemplo, pensar na porcentagem de pessoas que participaram em pelo menos 50% do curso (`certified`/`participants`).


```r
banco_4 <- mutate(banco_3, 
                  perc_certified = (certified / participants) * 100)
```

Outra estatística relevante é a porcentagem de pessoas que compareceram em pelo menos 50% do curso (`audited`/`participants`).


```r
banco_5 <- mutate(banco_4, 
                  perc_audited   = (audited / participants) * 100)
```

Por fim, podemos pensar na quantidade de pessoas que ganharam certificado (`certified`) entre as que participaram em pelo menos 50% do curso (`audited`).


```r
banco_6 <- mutate(banco_5,
                  perc_cert_aud  = (certified / audited) * 100)
```



```r
glimpse(banco_6)
```

```
## Observations: 290
## Variables: 24
## $ course_number                     <chr> "6.002x", "6.00x", "3.091x",...
## $ launch_month                      <int> 9, 9, 10, 10, 10, 2, 2, 2, 2...
## $ launch_day                        <int> 5, 26, 9, 15, 15, 4, 5, 12, ...
## $ course_title                      <chr> "Circuits and Electronics", ...
## $ instructors                       <chr> "Khurram Afridi", "Eric Grim...
## $ course_subject                    <chr> "Science, Technology, Engine...
## $ honor_code_certificates           <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
## $ participants                      <int> 36105, 62709, 16663, 129400,...
## $ audited                           <int> 5431, 8949, 2855, 12888, 107...
## $ certified                         <int> 3003, 5783, 2082, 1439, 5058...
## $ percent_played_video              <dbl> 83.20, 89.14, 87.49, 0.00, 7...
## $ percent_posted_forum              <dbl> 8.17, 14.38, 14.42, 0.00, 15...
## $ percent_grade_higher_than_zero    <dbl> 28.97, 39.50, 34.89, 1.11, 3...
## $ total_course_hours_per_1000       <dbl> 418.94, 884.04, 227.55, 220....
## $ median_hours_for_certification    <dbl> 64.45, 78.53, 61.28, 0.00, 7...
## $ median_age                        <dbl> 26, 28, 27, 28, 32, 27, 27, ...
## $ percent_male                      <dbl> 88.28, 83.50, 70.32, 80.02, ...
## $ percent_female                    <dbl> 11.72, 16.50, 29.68, 19.98, ...
## $ percent_bachelor_degree_or_higher <dbl> 60.68, 63.04, 58.76, 58.78, ...
## $ year                              <chr> "2012", "2012", "2012", "201...
## $ institutions                      <chr> "MITx", "MITx", "MITx", "Har...
## $ perc_certified                    <dbl> 8.317408, 9.221962, 12.49474...
## $ perc_audited                      <dbl> 15.042238, 14.270679, 17.133...
## $ perc_cert_aud                     <dbl> 55.29368, 64.62175, 72.92469...
```

### Verboas para Análise de Dados

Além de transformações com objetivo de __recodificar__ variáveis, o `dplyr` oferece funções para análises do nosso banco. 

#### `group by` e `summarise`

Na última seção, criamos proporções de pessoas que completaram o curso (`perc_certified`), que participaram de pelo menos 50% das aulas (`perc_audited`) e que completaram o curso entre aqueles que participaram de pelo menos 50% das aulas (`perc_cert_aud`).

Para isso, precisamos utilizar duas funções: `group_by()` e `summarise()`. Essas funções, em conjunto, são poderosíssimas para análise exploratória dos nossos dados. Vamos começar pela `summarise()`.


```r
summarise(banco_6, MEDIA = mean(perc_certified))
```

```
## # A tibble: 1 x 1
##   MEDIA
##   <dbl>
## 1  7.78
```

No último comando, descobrimos que 7,7% é a média de certificados "emitidos" por curso. O cálculo dessa média foi realizado para TODAS as observações do nosso banco. Agora, como fariámos para calcular a média de certicidados emitidos por instituição? Para isso, precisamos utilizar uma função `group_by()` __antes__.


```r
banco_6 %>% 
  group_by(institutions) %>% 
  summarise(CERTIFICADOS = mean(perc_certified))
```

```
## # A tibble: 2 x 2
##   institutions CERTIFICADOS
##   <chr>               <dbl>
## 1 HarvardX            10.9 
## 2 MITx                 5.25
```

Percebe como `group_by()` e `summarise()` em conjunto são ferramentas poderosas? Podemos repetir o processo para as outras variáveis.


```r
banco_6 %>% 
  group_by(institutions) %>% 
  summarise(PARICIPARAM_50 = mean(perc_audited))
```

```
## # A tibble: 2 x 2
##   institutions PARICIPARAM_50
##   <chr>                 <dbl>
## 1 HarvardX               31.9
## 2 MITx                   19.3
```


```r
banco_6 %>% 
  group_by(institutions) %>% 
  summarise(CERT_PART_50 = mean(perc_cert_aud))
```

```
## # A tibble: 2 x 2
##   institutions CERT_PART_50
##   <chr>               <dbl>
## 1 HarvardX             35.2
## 2 MITx                 29.9
```

A fim de tornar o nosso trablho mais eficiente, podemos calcular mais de uma estatística dentro de `summarise()`. Logo, ao invés de calcular cada média individualmente, podemos calcular todas de uma vez.


```r
banco_6 %>% 
  group_by(institutions) %>% 
  summarise(CERTIFICADOS   = mean(perc_certified),
            PARICIPARAM_50 = mean(perc_audited),
            CERT_PART_50   = mean(perc_cert_aud))
```

```
## # A tibble: 2 x 4
##   institutions CERTIFICADOS PARICIPARAM_50 CERT_PART_50
##   <chr>               <dbl>          <dbl>        <dbl>
## 1 HarvardX            10.9            31.9         35.2
## 2 MITx                 5.25           19.3         29.9
```

Além de realizar mais de um cálculo por vez, também é possível adicionar mais de uma variável para o `group_by()`. Ao fazer isso, você irá trabalhar com a combinação das duas variáveis, ou seja, çaso selecionemos uma variável com __3__ categorias e uma segunda com __4__, teremos no final __12__ (3 x 4) categorias. 

Como exemplo, vamos pensar a porcentagem de certificados emitidos por ano (`perc_certified`) e por instituição (`institutions`).


```r
banco_6 %>% 
  group_by(year, institutions) %>% 
  summarise(CERTIFICADOS = mean(perc_certified))
```

```
## # A tibble: 10 x 3
## # Groups:   year [?]
##    year  institutions CERTIFICADOS
##    <chr> <chr>               <dbl>
##  1 2012  HarvardX             5.37
##  2 2012  MITx                10.0 
##  3 2013  HarvardX             6.58
##  4 2013  MITx                 6.58
##  5 2014  HarvardX            14.9 
##  6 2014  MITx                 6.15
##  7 2015  HarvardX            12.3 
##  8 2015  MITx                 5.62
##  9 2016  HarvardX             4.57
## 10 2016  MITx                 3.20
```

#### `count`

Com a função `count()` podemos contar as categorias presentes dentro de uma variável.


```r
banco_6 %>% 
  count(institutions)
```

```
## # A tibble: 2 x 2
##   institutions     n
##   <chr>        <int>
## 1 HarvardX       129
## 2 MITx           161
```


```r
banco_6 %>% 
  count(course_subject)
```

```
## # A tibble: 4 x 2
##   course_subject                                           n
##   <chr>                                                <int>
## 1 Computer Science                                        30
## 2 Government, Health, and Social Science                  75
## 3 Humanities, History, Design, Religion, and Education    94
## 4 Science, Technology, Engineering, and Mathematics       91
```

Também é possível, por exemplo, fornecer mais de uma variável para `count()`. Isso fará com que ela calcule a quantidade de observações presentes para as __combinações__ de categorias.


```r
banco_6 %>% 
  count(institutions, course_subject)
```

```
## # A tibble: 8 x 3
##   institutions course_subject                                           n
##   <chr>        <chr>                                                <int>
## 1 HarvardX     Computer Science                                         4
## 2 HarvardX     Government, Health, and Social Science                  37
## 3 HarvardX     Humanities, History, Design, Religion, and Education    80
## 4 HarvardX     Science, Technology, Engineering, and Mathematics        8
## 5 MITx         Computer Science                                        26
## 6 MITx         Government, Health, and Social Science                  38
## 7 MITx         Humanities, History, Design, Religion, and Education    14
## 8 MITx         Science, Technology, Engineering, and Mathematics       83
```


## Exercício

1. Investigue quais os temas de curso (`course_subject`) mais recorrentes para cada instituição (`institutions`).

2. Investigue a distribuição de gênero (`percent_female` e `percent_male`).

    + 2.1. Para cada instituição (`institutions`). 
    
    + 2.2. Para cada tema de curso (`course_subject`)
    
    + 2.3. Qual seria uma possível origem da diferença da proporção de mulheres entre os cursos oferecidos pela HarvardX e a MITx? (Dica: tente pensar nos cursos oferecidos por cada instituição)
    
3. Quais são os meses em que mais cursos são oferecidos?
