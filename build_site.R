
rm(list = ls())

create_content <- function(dir = "./tutoriais"){
  tu_files <- list.files("./workshops/") #lista os diretórios dos tutorias
  tu_names <- stringr::str_remove(tu_files, "\\.Rmd")   #lista os arquivos dentro dos diretórios
  for(i in seq_along(tu_names)){
    #Cria o diretório para o tutoria ldentro de ./content
    suppressWarnings(dir.create(sprintf("./content/%s", tu_names[[i]]),recursive = TRUE))
    #Testa se o arquivo é um .md ou um .Rmd
    create_Rmd(tu_files[[i]], tu_names[[i]])
  }
}
#cria um .md a partir de um .Rmd
create_Rmd <- function(tu_files, tu_names){
  ezknitr::ezknit(file    = tu_files,
                  wd      = stringr::str_c(getwd(),"/workshops"),
                  out_dir = stringr::str_c("../content/", tu_names),
                  fig_dir = "figures",
                  keep_html = FALSE)
  system(sprintf("mv ./content/%s/%s.md ./content/%s/index.md", tu_names, tu_names, tu_names))
}

create_content()



# #Instala o Hugo (0.22) e constrói o site
blogdown::install_hugo(version = "0.22", force = T)
blogdown::hugo_build()