
se
#pacotes
#install.packages("leaflet")

library(bslib)
library(shiny)
library(leaflet)

# Pontos aproximados das sedes dos 7 municípios do Grande ABC
municipios <- data.frame(
  nome = c("Santo André", "São Bernardo do Campo", "São Caetano do Sul",
           "Diadema", "Mauá", "Ribeirão Pires", "Rio Grande da Serra"),
  lat  = c(-23.6639, -23.6914, -23.6229, -23.6861, -23.6677, -23.7106, -23.7439),
  lng  = c(-46.5383, -46.5646, -46.5548, -46.6228, -46.4613, -46.4136, -46.3978)
)

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
    leaflet(municipios) |>
      addTiles() |>
      setView(lng = -46.52, lat = -23.68, zoom = 11) |>
      addMarkers(~lng, ~lat, popup = ~nome, label = ~nome)
  })
}


# Junta tudo e roda
shinyApp(ui, server)