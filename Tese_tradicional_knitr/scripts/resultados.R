##======================================================================
## Resultados
##======================================================================

## Exemplo de figura
## ---- xyplot
data(cars)
plot(dist ~ speed, data = cars)
abline(h = mean(cars$dist))

## Exemplo de tabela
## ---- tab-cars
library(xtable)
tab <- head(cars)
print(xtable(tab, caption =
                      "Tabela gerada diretamente a partir de um objeto do R.",
             label = "tab:res", align = "ccc"),
      table.placement = "!htb",
      caption.placement = "top",
      include.rownames = FALSE)
