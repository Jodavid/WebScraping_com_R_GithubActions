

WebScraping <- function(Webpage, class)
  {
    jarbas_names_html <- html_nodes(Webpage, class)
    jarbas_names <- html_text(jarbas_names_html)
    
    return( jarbas_names )
  }

ConveterStrparaNumerico <- function(vetor)
  {
  jarbas_value <- as.numeric(sub(",",".",
                                 stringr::str_extract(vetor,pattern = "\\-*\\d+,\\s{0,}\\d+")))
  
  return( jarbas_value )
  
  }
  