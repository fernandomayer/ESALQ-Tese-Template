##======================================================================
## Resultados
##======================================================================

## Exemplo de figura
## ---- xyplot2
data(cars)
plot(dist ~ speed, data = cars)
abline(h = mean(cars$dist))

## Exemplo de tabela
## ---- tab-cars2
library(xtable)
tab <- head(cars)
print(xtable(tab, caption =
                      "Tabela gerada diretamente a partir de um objeto do R.",
             label = "tab:res2", align = "ccc"),
      table.placement = "!htb",
      caption.placement = "top",
      include.rownames = FALSE)
