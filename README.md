# ESALQ-Tese-Template

## Introdução

Este é o template original escrito em LaTeX para a produção de teses da
ESALQ, escrito originalmente pelo professor Antonio Augusto Franco
Garcia, e disponibilizado no site da [Biblioteca da
ESALQ](http://www4.esalq.usp.br/biblioteca/apoio-a-producao-academica).

As alterações feitas aqui são para possibiliar que a tese seja escrita
usando o formato `Rnw`, do pacote **knitr** para o R. Dessa forma,
pode-se misturar códigos R ao texto escrito em LaTeX. Para informações
gerais sobre o **knitr**, veja este [site](https://yihui.name/knitr).

Todos os arquivos disponibilizados no formato `tex` foram convertidos
para o formato `Rnw`, portanto aqui são esses arquivos que devem ser
editados (mesmo que nenhum código R seja utilizado em algum arquivo).

O template com os arquivos em `Rnw` também foi modificado para o formato
de tese em capítulos. Esse formato também é permitido pela biblioteca,
e, deve conter uma introdução geral e considerações finais sobre todos
os capítulos. Dessa forma, cada capítulo deve ser auto-contido, ou seja,
deve conter seu próprio resumo, introdução, etc, e deve ser independente
dos outros capítulos. Além disso, as referências bibliográficas devem
ser colocadas ao final de cada capítulo.

Mesmo que você opte por usar a tese no formato de capítulos, recomendo
que leia antes as instruções de uso do template da tese no formato
tradicional.

## Tese no formato tradicional

As instruções para a versão original em LaTeX estão
[aqui](http://www.esalq.usp.br/biblioteca/tutorial-template-latex.pdf),
e todas elas são válidas para o formato `Rnw` também. Portanto, esse é o
documento inicial que todos devem ler antes de começar. Abaixo vou
mencionar apenas as diferenças principais.

Antes de fazer qualquer modificação nos arquivos, a primeira coisa a
fazer é compilar este template para ver se está funcionando corretamente
no seu sistema. Para isso, abra uma sessão do R (na raíz deste
diretório), e execute os comandos:

```{r}
library(knitr)
knit("Tese.Rnw")
```

Isso irá gerar um arquivo `Tese.tex`. Compile esse aqruivo `tex` no seu
editor de preferência ou via terminal, usando o `xelatex`. Por
exemplo, no terminal:

```{sh}
xelatex Tese.tex
bibtex Tese.aux
xelatex Tese.tex
xelatex Tese.tex
xelatex Tese.tex
```

Ou, uma forma alternativa (e melhor) no Linux é usar o comando `make`,
que já faz a conversão de `Rnw` para `tex` e compila o documento de uma
só vez.

Se não houver nenhum erro, o arquivo `pdf` gerado deve estar pronto.

Abra o arquivo `Tese.Rnw` e veja a sequência de arquivos que são
chamados dentro dele. Todos os comandos

```{r}
\input{arquivo.tex}
```

no arquivo `Tese.tex` original foram modificados para

```
<<child, child='arquivo.Rnw'>>=
@
```

no arquivo `Tese.Rnw`. Assim, basta ir seguindo a ordem e editando os
arquivos `Rnw` que são chamados na sequência. Mesmo que esses arquivos
não tenha nenhum código R, não altere o formato do arquivo para `tex`.
Após alguma edição, basta compilar **apenas** o arquivo `Tese.Rnw`
conforme mencionado acima (não esqueça de rodar o `knit()` antes).

Para inserir códigos R no meio do texto, basta abrir os *chuncks* e
inserir os comandos conforme qualquer outro documento do **knitr**. Isso
é particularmente útil para gerar as figuras e tabelas que vão no meio
do texto. Fazendo isso e compilando o arquivo `Tese.Rnw` já é o
suficiente para executar os códigos do R que estiberem em qualquer
arquivo desse template.

O arquivo `setup_knitr.R` contém algumas definições globais para
chuncks, e pode ser alterado conforme necessidades especificas.

Uma alternativa mais viável para misturar chuncks do R em textos longos
(como o de uma tese) é usar o conceito de [code
externalization](https://yihui.name/knitr/demo/externalization/) do
**knitr**. Pense que à medida que for escrevendo a tese e fazendo suas
análises, tanto o texto quanto a quantidade de códigos em um chunk podem
ficar muito grandes. Chunks muito longos no meio do texto podem
atrapalhar o fluxo de leitura, e para evitar isso podemos usar um script
R separado do texto, e chamar nos chunks apenas aquelas partes do código
que realmente são necessárias (como a geração de uma figura por
exemplo).

O **code externalization** tem várias vantagens, entre elas:

1. Não interrompe o fluxo de leitura do texto no arquivo fonte com
   chunks que muitas vezes não serão úteis (no texto), como por exemplo
   uma parte do código que só serve para arrumar e limpar os dados, ou
   códigos que estão sendo apenas testados.
2. O mesmo script pode ser utilizado em mais de um arquivo. Por exemplo,
   você pode usar o script para a tese, mas também para um artigo
   derivado dela, sem a necessidade de vários scripts separados que
   fazem a mesma coisa.
3. Os chunks se comportam da mesma forma como se os códigos estivessem
   no documento fonte. Assim, todas as opções de chunk também são
   válidas.

Para ver um exemplo de como esse conceito funciona, veja o arquivo
`textual/Resultados.Rnw` e o script `scripts/resultados.R`. A primeira
coisa que encontramos no `Resultados.Rnw` é um chunk com esse conteúdo:

```
<<setup-resultados, include=FALSE, cache=FALSE>>=
## Carrega formatação geral para todos os chunks
source("../setup_knitr.R")
## Torna disponível os chunks nomeados desse script (o script pode ter
## qualquer nome e pode ser carregado mais de um)
read_chunk("../scripts/resultados.R")
@
```

O primeiro comando apenas carrega as configurações gerais de chunk do
arquivo `setup_knitr.R`, e o segundo comando faz com que o script
`resultados.R` seja lido por esse documento. Dentro do arquivo
`resultados.R` você pode fazer sua análise da maneira usual. Quando você
quiser que uma parte desse script se torne um chunk dentro do arquivo
`Resultados.Rnw`, basta identificar essa parte do chunk com um
comentário especial seguido pelo nome do chunk (obrigatoriamente você
terá que dar nome para todos os chunks). O formato é o seguinte:

```
## ---- nome
```

Esse formato, com 2 `#` e 4 `-` é obrigatório. Somente dessa forma que a
função `read_chunk()` utilizada acima será capaz de importar os códigos
que estiverem abaixo desse comantário especial.

Por exemplo, depois de importar e explorar os dados você deseja inserir
uma figura no arquivo `Resultado.Rnw`. Para isso, bastaria fazer no
arquivo `resultados.R`:

```
## ---- meugrafico
plot(y ~ x, data = dados)
```

E no arquivo `Resultados.Rnw` você abre um chunk vazio com o nome
`meugrafico`:

```
<<meugrafico>>=
@
```

Isso basta para que o código seja executado no documento e o gráfico
seja inserido. A ideia para inserir chunks dessa forma é sempre a mesma.
Note que as opções de chunk são válidas normalmente, então fazendo

```
<<meugrafico, out.width='50%'>>=
@
```

é uma declaração perfeitamente válida.

Para mais exemplos veja o arquivo `textual/Resultados.Rnw` e o script
`scripts/resultados.R`. Note que você pode ter mais de um script R sendo
carregado em um documento com a função `read_chunk()`, e o nome do
arquivo não precisa necessariamente ser `resultados.R`.

**Observação:** usar esta opção de **code externalization** não é
obrigatória para usar estes arquivos `Rnw`. Você pode fazer sem isso,
inserindo chunks e códigos diretamente no arquivo fonte `Rnw**. No
entanto, isso torna sua tese mais portável e reproduzível.

## Tese no formato de capítulos

**Atenção:** leia antes as instruções de uso do template no formato
tradicional acima.

O formato de tese em capítulos segue basicamente a mesma ideia do
formato tradicional, mas a grande diferença é que agora cada capítulo
está contido em um único arquivo. Por exemplo, o arquivo
`textual/Capitulo1.Rnw` contém todas as seções necessárias (introdução,
metodologia, etc), incluindo resumo e referências próprias. Para gerar
as referências em cada capítulo foi utilizado o pacote do LaTeX
**bibtopic**. Note que cada capítulo se inicia com

```
\begin{btUnit}
\chapter{Título do capítulo}
```

e termina com

```
\begin{btSect}[referencias/apalikept]{referencias/bibliografia}
\section*{Referências}
\addcontentsline{toc}{section}{Referências}
\btPrintCited
\end{btSect}
\end{btUnit}
```

Essa parte não deve ser modificada, pois é a responsável por incluir as
referências no final. Por simplificação, o arquivo bibTex
`referencias/bibliografia.bib` contém as referências de todos os
capítulos.

No arquivo principal `Tese.Rnw`, a única modificação é que as chamadas
agora são para cada capítulo, por exemplo

```
<<child-cap1, child='textual/Capitulo1.Rnw'>>=
@
```

ao invés de cada seção da tese, como no formato tradicional.

O uso do pacote do R **knitr**, dos chunks de código no meio do texto ou
do *code externalization* são exatemente iguais ao já descrito para o
template de tese no formato tradicional.

## Alterações feitas para converter os arquivos para o formato knitr:

(Só leia isso se você tiver interesse).

- Todos os arquivos `.tex` foram renomeados para `.Rnw` (inclusive nas
  subpastas).
- No arquivo principal (`Tese.Rnw`), troquei as linhas com `\input{}`
  para um chunk com a opção `child`. Por exemplo:
```
\input{pre-textual/Capa.Rnw}
```
foi alterado para:
```
<<child-capa, child='pre-textual/Capa.Rnw'>>=
@
```
- Por padrão, o knitr insere uma chamada do pacote `color`, logo depois
do `\documentclass{}`, dessa forma:
```
\usepackage[]{color}
```
Mas no arquivo `sty` existe uma chamada para o pacote color com estas
opções:
```
\usepackage[usenames,dvipsnames]{color}
```
e isso causa um erro na compilação. Para resolver isso, é necessário
definir essa opção global do knitr logo no início do arquivo principal:
```
<<setup-root, echo=FALSE, cache=FALSE>>=
knitr::opts_knit$set(latex.options.color = "usenames,dvipsnames")
@
```
Isso fará com que a chamada do pacote feita pelo knitr inclua essas duas
opções. Para evitar que o pacote seja chamado duas vezes, removi
(comentei) a chamada para ele no arquivo sty.
- Define um arquivo (na raiz) com as definições globais do knitr
  (`setup_knitr.R`).
- No início de algum capítulo que tenha código R (eg, resultados),
  inserir esse chunk:
```
<<setup-resultados, include=FALSE, cache=FALSE>>=
source("../setup_knitr.R")
read_chunk("../scripts/resultados.R")
@
```
que lê as opções globais do knitr e torna disponíveis os chunks
(nomeados) do script correspondente.
- Essa segunda parte não é obrigatória já que os chunks podem ser
escritos normalmente no meio do texto, mas dessa forma fica mais
organizado. Isso faz parte do conceito de "code externalization" do
knitr. O script R contém comentários nomeados exatamente dessa forma:
```
## ---- nome
```
Então no texto, basta abrir um chunk (vazio) com exatamente o mesmo
nome:
```
<<nome>>=
@
```
que todo o código que estiver no script abaixo desse nome será executado
naquele ponto (incluindo a geração de tabelas e figuras). Também é
possível usar as opções de chunk normalmente.
- No Makefile os arquivos do `target` (arquivo `Tese.pdf`) foram
alterados para `Rnw`, e foi utilizado *wildcards* para indicar que todos
os arquivos das subpastas devem ser utilizados (ao invés de escrever um
a um). Também foi incluido uma chamada para rodar o knitr no arquivo
principal.

Referências:

- https://stackoverflow.com/questions/22716088/working-with-rstudio-for-writing-thesis-chapters-in-rnw
- https://yihui.name/knitr/demo/child/
- https://yihui.name/knitr/demo/externalization/
- https://yihui.name/knitr/options/#package-options
