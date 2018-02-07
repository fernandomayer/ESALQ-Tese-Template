Template tese ESALQ:

http://www4.esalq.usp.br/biblioteca/apoio-a-producao-academica

Alterações feitas para converter os arquivos para o formato knitr:

Renomeei todos os arquivos .tex para .Rnw (inclusive nas subpastas)

No arquivo principal (`Tese.Rnw`), troquei as linhas com `\input{}` para
um chunk com a opção `child`. Por exemplo:

\input{pre-textual/Capa.Rnw}

foi alterado para:

<<child-capa, child='pre-textual/Capa.Rnw'>>=
@

Por padrão, o knitr insere uma chamada do pacote `color`, logo depois do
`\documentclass{}`, dessa forma:

\usepackage[]{color}

Mas no arquivo sty existe uma chamada para o pacote color com estas
opções:

\usepackage[usenames,dvipsnames]{color}

e isso causa um erro na compilação. Para resolver isso, é necessário
definir essa opção global do knitr logo no início do arquivo principal:

<<setup-root, echo=FALSE, cache=FALSE>>=
knitr::opts_knit$set(latex.options.color = "usenames,dvipsnames")
@

Isso fará com que a chamada do pacote feita pelo knitr inclua essas duas
opções. Para evitar que o pacote seja chamado duas vezes, removi
(comentei) a chamada para ele no arquivo sty.

Define um arquivo (na raiz) com as definições globais do knitr
(setup_knitr.R).

No início de algum capítulo que tenha código R (eg, resultados), inserir
esse chunk:

<<setup-resultados, include=FALSE, cache=FALSE>>=
source("../setup_knitr.R")
read_chunk("../scripts/resultados.R")
@

que le as opções globais do knitr e torna disponíveis os chunks
(nomeados) do script correspondente.

Essa segunda parte não é obrigatória já que os chunks podem ser escritos
normalmente no meio do texto, mas dessa forma fica mais organizado. Isso
faz parte do conceito de "code externalization" do knitr. O script R
contém comentários nomeados exatamente dessa forma:

## ---- nome

Então no texto, basta abrir um chunk (vazio) com exatamente o mesmo
nome:

<<nome>>=
@

que todo o código que estiver no script abaixo desse nome será executado
naquele ponto (incluindo a geração de tabelas e figuras). Também é
possível usar as opções de chunk normalmente.

No Makefile os arquivos do `target` (arquivo `Tese.pdf`) foram alterados
para `Rnw`, e foi utilizado *wildcards* para indicar que todos os arquivos
das subpastas devem ser utilizados (ao invés de escrever um a um).
Também foi incluido uma chamada para rodar o knitr no arquivo principal.

Referências:

https://stackoverflow.com/questions/22716088/working-with-rstudio-for-writing-thesis-chapters-in-rnw

https://yihui.name/knitr/demo/child/

https://yihui.name/knitr/demo/externalization/

https://yihui.name/knitr/options/#package-options
