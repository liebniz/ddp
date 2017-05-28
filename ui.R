
fluidPage(
  # Application title
  titlePanel("Thumpin' Bible Word Cloud Generator"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Choose your favorite chapter:",
                  choices = chapters),
      # actionButton("update", "Update"),
      hr(),
      sliderInput("freq",
                  "Minimum Word Frequency:",
                  min = 1,  max = 100, value = 30),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 100,  value = 50)
    ),
    
    # Show Word Cloud
    mainPanel(
      textOutput("chapter"),
      plotOutput("plot")
    )
  )
)
