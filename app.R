
#ui
ui <- navbarPage(
  title = "Gerenciamento de Resíduos Sólidos no ABC Paulista",
  
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
    
    h3("Objetivo"),
    
    p("Reunir e apresentar informações sobre a geração, coleta,
    disposição e tratamento de resíduos sólidos, permitindo
    visualizar sua distribuição espacial e explorar alternativas
    tecnológicas para seu aproveitamento energético."),
    
    h3("Desenvolvimento"),
    
    p("Desenvolvido em R, utilizando o framework Shiny, o painel
    integra dados, geoprocessamento e modelagem matemática para
    facilitar a consulta e a interpretação das informações,
    contribuindo para o planejamento e a tomada de decisão
    na gestão de resíduos sólidos.")
  )

  
  
  tabPanel(title = "Valorização Energética"),
  tabPanel(title = "Caso de Estudo: o ABC Paulista"),

)



# Server: a lógica (pode ficar vazio por enquanto)
server <- function(input, output, session) {
}

# Junta tudo e roda
shinyApp(ui, server)