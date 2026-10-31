####Pra publicar
#setwd('C:/Users/bianc/OneDrive - Universidade Federal do ABC/TG_Programação')
#rsconnect::writeManifest()


#pacotes
#install.packages("leaflet")
#install.packages(c("geobr", "sf"))
#install.packages(("arrow"))
install.packages("geobr")

#Ativar pacotes
library(leaflet)
library(geobr)
library(sf)
library(arrow)
library(bslib)

#Mapa dos Municipios 

options(timeout = 1200)

municipios <- c("Santo André"           = 3547809,
                "São Bernardo do Campo" = 3548708,
                "São Caetano do Sul"    = 3548807,
                "Mauá"                  = 3529401)

lista <- lapply(seq_along(municipios), function(i) {
  g <- read_municipality(code_muni = municipios[i], year = 2020)  # use o ano que funcionou
  g$name_muni <- names(municipios)[i]
  g[, c("code_muni", "name_muni")]
})

abc <- do.call(rbind, lista)
abc <- st_transform(abc, 4326)

nrow(abc)                # deve dar 4
saveRDS(abc, "abc.rds")  # salva na pasta de trabalho (veja com getwd())


#ui
ui <- navbarPage(
  title = "Gerenciamento de Resíduos Sólidos no ABC Paulista",
  theme = bs_theme(bootswatch = "minty", bg = "#f0f4f1", fg = "#1b3a1f"),
  #Texto de Apresentação do trabalho
  tabPanel(
    title = "Apresentação",
    
    h3("Sobre o projeto"),
    
    p("Este painel interativo é resultado de um Trabalho de Graduação
    desenvolvido no curso de Engenharia Ambiental e Urbana da
    Universidade Federal do ABC (UFABC), cujo objetivo é analisar
    o cenário da gestão de resíduos sólidos urbanos (RSU) no
    ABC Paulista, com ênfase no mapeamento geoespacial e na
    identificação de oportunidades para recuperação energética."),
    
    p("O trabalho na íntegra pode ser acesssado em: "),
    a('https://curso-r.github.io/main-dashboards/slides/04-layouts.pdf'),
    
    h3("Objetivo"),
    
    p("Reunir e apresentar informações sobre a geração, coleta,
    disposição e tratamento de resíduos sólidos, permitindo
    visualizar sua distribuição espacial e explorar alternativas
    tecnológicas para seu aproveitamento energético."),
    
    h3("Desenvolvimento"),
    
    p("Desenvolvido em R, utilizando o framework Shiny, o painel
    integra dados, geoprocessamento e modelagem matemática para
    facilitar a consulta e a interpretação das informações,
    contribuindo para o planejamento, a tomada de decisão
    na gestão de resíduos sólidos e a divulgação mais acessível da informação.")
  ),

  
  
  tabPanel(title = "Valorização Energética"),
  tabPanel(
    title = "Caso de Estudo: o ABC Paulista",
    h3("Municípios do Grande ABC"),
    leafletOutput("mapa_abc", height = 550)
  )
)



# Server: a lógica (pode ficar vazio por enquanto)
server <- function(input, output, session) {
  output$mapa_abc <- renderLeaflet({
    pal <- colorFactor("Set2", abc$name_muni)
    
    leaflet(abc) |>
      addTiles() |>
      addPolygons(label = ~name_muni,
                  fillColor = ~pal(name_muni), fillOpacity = 0.5,
                  color = "#333333", weight = 1.5,
                  highlightOptions = highlightOptions(weight = 3, fillOpacity = 0.8)) |>
      addLegend(pal = pal, values = ~name_muni, title = "Município")
  })
}


# Junta tudo e roda
shinyApp(ui, server)