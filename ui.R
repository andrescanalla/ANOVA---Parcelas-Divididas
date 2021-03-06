
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(markdown)
library(DT)
#--NavBarpage---
navbarPage("ANOVA Parcelas Dividias con BCA",

#--Datos TabPanel---           
 tabPanel("Datos",
  column(3,
         wellPanel(
      fileInput('file1', 'Choose xlsx file',
                accept = c(".xlsx")
      ),
      numericInput("n0", "N° de columna Parcelas Divididas",
                   min = 1, max = 20, value = 1, step = 1),
      numericInput("n1", "N° de columna Tratamientos",
                   min = 1, max = 20, value = 2, step = 1),
      numericInput("n2", "N° de columna Rep/Bloques",
                   min = 1, max = 20, value = 3, step = 1),
      numericInput("n3", "N° de columna Variable  Dependiente",
                   min = 1, max = 20, value = 4, step = 1)
    
    ),
    wellPanel(
      
      numericInput("n4", "N° de decimales:",
                   min = 1, max = 20, value = 1, step = 1),
      numericInput("n6", "Valor Alfa %:",
                   min = 0, max = 20, value = 0.1, step = 0.05),
      textInput("n5", "Unidad Variable Dependiente",value = "Rendimiento (kg/ha)"),
      textInput("n7", "Tratamiento Testigo",value = "T1")
      
    ),
    wellPanel(
      
      numericInput("n8", "Nº de columna Row:",
                   min = 0, max = 20, value = 0, step = 1),
      numericInput("n9", "Nº de columna Col:",
                   min = 0, max = 20, value = 0, step = 1)
      
    )
    ),

    # ----Show a exel table ---
    column(9,
      dataTableOutput('contents'),
      plotOutput("plano")
    )),

#---Analisis TabPanel---
 tabPanel("Análisis",
           column(6,
                  fluidRow(
                    column(12,tags$b("Tabla de Promedios"), dataTableOutput("table"))),
                  fluidRow(
                    column(12,tags$br(),tags$b("Tabla ANOVA"),  verbatimTextOutput("anova"))),
                  fluidRow(
                    column(12,tags$b("Tabla LSD Fisher "),  verbatimTextOutput("LSD")))
         
),
column(6,
  tabsetPanel(type = "tabs",
              tabPanel("Tratamientos",
                fluidRow(
                  column(12, tags$br(),plotOutput("plots"))),
                fluidRow(tags$b("BoxPlot"), verbatimTextOutput("boxplot"),tags$p(
                  "- La linea, dentro de la caja, es la mediana de los datos.",
                  tags$br("- Caja, representa el rango intercuartilico (del 25% al  75% de los datos)contiene el 50% de los datos."),
                  ("- Bigotes, las lineas salidas al final de las lineas de guiones que se extienden desde la caja. Definen los limites mas alla de los cuales consideramos los valores como atipicos. Existen diferentes modos de calcularlos."),  
                  tags$br("- Valores atipicos, aquellos puntos fuera de los bigotes. Se representan como puntos o circulos."))),
                fluidRow(
                  column(12, tags$br(),plotOutput("plots2")))
                ),
              tabPanel("Interaccion",tags$br(), plotOutput("plotsblq"),plotOutput("plotsblq2")),
              tabPanel("LSD - Fisher", tags$br(),plotOutput("plotlsd")),
              tabPanel("Tabla de Datos", tags$br(),dataTableOutput("tabla"))
  )
)),

#---Supuestos de Variancia TabPanel---
tabPanel("Supuestos Variancia",
         tabsetPanel(type = "tabs",
            tabPanel("Residuales Normalmente Distribuidos", 
              fluidRow(
                column(5, plotOutput("disres")),
              column(4,plotOutput("hista"),
                     tags$br(),tags$b("Prueba de Normalidad (shapiro-wilks modificado)"),
                     verbatimTextOutput("shap"),tags$div("p-value > 0,05 no puedo rechazar Ho, Residuos con distribucion Normal ")
                     )     
            )),
            tabPanel("Varianzas Homogeneas",
              fluidRow(
                column(6,tags$br(),tags$div(tags$b("Predichos vs Residuos"), align = "center"),plotOutput("homo")),
                column(6,tags$br(),tags$div(tags$b("Residuos vs Tratamientos"), align = "center"),plotOutput("resi"),
                       tags$b("Test de Levene"),tags$br(),verbatimTextOutput("test"),tags$div("p-value > 0,05 Varianza Homogenea"))
            )),
            tabPanel("Errores independientes -> Repeticiones",
                     fluidRow(
            column(6,tags$br(),tags$div(tags$b("Independencia"), align = "center"),plotOutput("inde")))

)
)),
navbarMenu("More",
           tabPanel("Exportar",
                  downloadButton("report", "Generate report")
                    
                    ),
           tabPanel("Contacto: pasquinelli@a-w-a.com.ar"))
)