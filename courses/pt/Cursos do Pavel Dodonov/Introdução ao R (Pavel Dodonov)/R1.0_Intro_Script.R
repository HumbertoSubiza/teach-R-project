###Curso de introdu��o ao R###
###Pavel Dodonov - pdodonov@gmail.com (doutorando em Ecologia e Recursos Naturais pela UFSCar)###
###Ministrado em um lugar muito lega, a Unesp de Rio Claro, em 16 e 17 de maio de 2014###


#Facilita a vida se abrirmos um script!
#File, new script
#E podemos salvar o script, o que facilita mais ainda a vida!

#Para rodar uma linha do script: ctrl + R (no Mac - comand + R)

#Parte 1 - N�meros, fun��es e objetos
#Elementos abordados:+ / c() , = <- -> : rnorm() runif() rm

# (sustenido/jogo-da-velha) � o s�mbolo usado para fazer anota��es no c�digo.
Se escrever sem este s�mbolo, acontece isso (erro)

#Com o s�mbolo, n�o acontece nada 

1
2
5

#Podemos fazer opera��es b�sicas com os n�meros

1+5
1/5

#E se queremos trabalhar com mais de um n�mero simultaneamente?

1 2 4
1, 2, 4

#N�o funciona!

c(1,2,4)

#c() � uma fun��o. O que est� dentro dos par�nteses s�o os argumentos desta fun��o.
#No caso, a fun��o est� combinando os n�meros 1, 2, 4 para que possamos trabalhar com eles ao mesmo tempo

c(1,2,4)/5

c(1,2,4)+c(4,5,7)

#Mas � claro que n�o vamos ficar escrevendo esses n�meros toda vez que formos fazer alguma coisa com eles.
#Precisamos criar um objeto

#Um objeto pode ser um conjunto de n�meros, um texto, um conjunto de textos, os resultados de uma an�lise...
#Enfim, um objeto pode ser essencialmente qualquer coisa

#E um objeto precisa de um nome!
#Recomenda��es pessoas de nomes:
	#Se queremos fazer algo bem r�pido: a, b, d, e, f... N�o c porque c � uma fun��o!
	#Para an�lises mais completas: ter um sistema que te permita sempre achar o objeto mais importante
	#Exemplos: dados, dados.Ilha, modelo.Ilha, modelo1.Ilha...
	#Para objetos tempor�rios, que n�o ser�o usados novamente: temp, temporario, foo, bar, foobar...

a=c(1,2,4)
b=c(4,5,7)

	#Evitar dar nomes que coincidam com nomes de fun��es ou objetos j� existentes!
	#Na d�vida, teste
pi
data
Pi	#Pi � um nome que podemos usar sem sobrep�r a outro objeto ou fun��o.

#Mas e se fizermos algo errado?

a=c(1,2,4)
b=c(4,5,7)
c=c(8,9,11)

c(1,2,6)	#continua funcionando - n�o sobrep�s a fun��o
		#mas agora temos uma fun��o e um objeto que t�m o mesmo nome, e isso pode confundir

pi=c(1,4,5)	#Agora perdemos o valor do pi, que o R tinha salvo

#Solu��o:
rm(c)
rm(pi)

#a fun��o rm remove os objetos que criamos.

#Diferentes forma de criar objetos
a=c(1,2,4)
a = c(1,2,4)
a = c ( 1 , 2 , 4 )
a <- c(1, 2, 4)
c(1, 2, 4) -> a

c(1, 2
,
4) ->
a

#� claro que existem limites...

a=
c
(
1,2,
4)

a

a=
c(
1,2,
4)


#Ent�o n�o saiam quebrando linhas por a� sem motivo :)


#Espa�os e quebras de linha n�o importam
#Algumas pessoas gostam de usar =, outras de usar <-... � quest�o de estilo. 

1:10

a=1:10
b=11:20

# : � muito �til para criar sequ�ncias de n�meros.

d=seq(0, 10, by=0.1)

d

# seq() permite criar sequ�ncias com espa�amento maior ou menor que 1.

#Fun��es t�m argumentos, que definem o que exatamente a fun��o vai fazer

rnorm(n=15, mean=1, sd=1)
rnorm(15, 1, 1)
#Se n�o damos os nomes dos argumentos, eles s�o usados na mesma ordem que aparecem na defini��o da fun��o
rnorm

#Se n�o fornecemos um argumento, � usado o default - no caso 0 e 1
rnorm(15)

a=rnorm(15, 1,1)
b=runif(n=15, min=1, max=2)

a-b

#Se n�o sabemos o que uma fun��o faz, podemos perguntar ao R!
?rnorm

#Embora �s vezes o help n�o ajuda tanto assim...

#�s vezes perdemos conta dos objetos que criamos

ls()

#Para evitar que objetos de sess�es passadas apare�am na nossa sess�o atual e nos confundam mais ainda:

rm(list=ls())

ls()

#Pronto, n�o temos mais objetos.

###Fim da parte 1###

###Parte 2 - inserindo dados###
getwd()
setwd(F:\Pavel\2-Ensino\MINICURSOS\R-RioClaro-2014)
setwd("F:\Pavel\2-Ensino\MINICURSOS\R-RioClaro-2014")
setwd("F:/Pavel/2-Ensino/MINICURSOS/R-RioClaro-2014")
setwd("F:\\Pavel\\2-Ensino\\MINICURSOS\\R-RioClaro-2014")
getwd()

setwd(choose.dir())


read.table("dadosfogo.txt", sep="", dec=".")
read.table("dadosfogo.txt", sep="", dec=".", skip=3)
read.table("dadosfogo.txt", sep="", dec=".", skip=3, header=T)

read.table(file.choose(), sep="", dec=".", skip=3, header=T)

read.table("clipboard", sep="\t", dec=".", header=T)
#No mac: read.table(pipe("pbpaste")) 

fogo=read.table("dadosfogo.txt", sep="", dec=".", skip=3, header=T)

fogo

fogo.errado=read.table("dadosfogo.txt", sep="", dec=".", skip=3)

fogo.errado

###Fim da parte 2###

###Parte 3 - verificando a estrutura dos dados###
str(fogo)
str(fogo.errado)

rm(fogo.errado)

head(fogo, n=5)
tail(fogo, n=5)

ncol(fogo)
nrow(fogo)
dim(fogo)

names(fogo)

names(fogo) = c("Transecto", "Parcela", "x", "y", "Severidade", "Tipo", "Nind")
colnames(fogo) = c("Transecto", "Parcela", "x", "y", "Severidade", "Tipo", "Nind")

#Como � um data.frame, tanto names() quanto colnames() pode ser usado.
#No caso de listas, apenas names() funciona para isso
#No caso de matrizes, apenas colnames()

###Parte 4 - tipos de objetos###
fogo$Tipo=as.character(fogo$Tipo)
str(fogo)
fogo$Tipo=as.factor(fogo$Tipo)
str(fogo)
fogo$Tipo=ordered(fogo$Tipo, levels=c("Pl", "Br", "AdBr", "Ad", "M"))
str(fogo)
fogo$Tipo=factor(fogo$Tipo, ordered=F)
str(fogo)



#O objeto fogo atualmente � um data.frame
#data.frames s�o conjuntos de vetores, todos com o mesmo comprimento, podendo serem de diferentes tipos

#Outro tipo de objeto que pode conter diferentes tipos de vari�veis e coisas s�o as listas

a.lista = list(1:10, list(a=c(2,5), b=3:7), "oisouumapalavraqualquer")

a.lista

str(a.lista)
length(a.lista)

#Se quisermos, podemos transformar essa lista em um �nico vetor

a.vetor = unlist(a.lista)

a.vetor

length(a.vetor)
str(a.vetor)

#como tem um caracter na lista, ela se transformou inteira em caracteres

as.numeric(a.vetor)

#NAs introduced by coercion: a palavra "oisouumapalavraqualquer" n�o pode ser transformada em n�mero

#NA: not available; NaN: Not a Number - por exemplo, divis�o de zero por zero

5/0
0/0
log(0)
log(-1)

# Inf: infinito.

#Digamos que queremos um objeto com os dados separados por transecto...
#Podemos fazer uma matriz!

a=1:10
matrix(a, ncol=2)

#Percebam que ele preencheu por colunas
matrix(a, ncol=2, byrow=T)

#Percebam que agora ele preencheu por linhas!

fogo.sever.tr=matrix(fogo$Severidade,ncol=5)

str(fogo.sever.tr)

fogo.sever.tr

head(fogo.sever.tr)

colnames(fogo.sever.tr) = c("T1", "T2", "T3", "T4", "T5")
rownames(fogo.sever.tr) = 1:100

str(fogo.sever.tr)

dimnames(fogo.sever.tr)=list(Parcela=c(1:100), Transecto=c("T1", "T2", "T3", "T4", "T5") )

str(fogo.sever.tr)

fogo.sever.tr



#Mas percebam que est� tudo repetido? � porque a severidade ela mesma est� repetida...

###Fim da parte 4###

###Parte 5 - indexa��o###

#� melhor pegar apenas os referente apenas um conjunto de valores de fireSeverity.

#Como cada vari�vel tem 100 valores, podemos pegar simplesmente os 100 primeiros valores do vetor FireSeverity

fogo$Severidade[1:100]

fogo.sever.tr=matrix(fogo$Severidade[1:100],ncol=5)

fogo.sever.tr

#E se quisermos pegar as 100 primeiras linhas, mas para todas as vari�veis?

fogo[1:100]

fogo[1:100,]

head(fogo)

#Podemos, por exemplo, querer todas as informa��es sobre os indiv�duos adultos, sem a coluna Tipo

fogo.Ad=fogo[1:100,c(1:5,7)]
fogo.Ad=fogo[1:100,-6]

colnames(fogo)

fogo.Ad=fogo[1:100,c("Transecto", "Parcela", "x", "y", "Severidade", "Nind")]

str(fogo.Ad)

fogo.Ad=as.matrix(fogo.Ad)

str(fogo.Ad)

fogo.Ad[1:10,c("x", "y", "Nind")]

fogo.Ad[1:10]

#E se quisermos, por exemplo, pegar apenas as linhas �mpares?

#O R tem um comportamento interessante com vetores de verdadeiro/falso

a=1:100
a[c(T,F)]

a=runif(100,0,100)

a<50

a[a<50]

#Se quisermos saber quais os n�meros que satisfazem a equa��o:

1:100[a<50]
(1:100)[a<50]

(1:length(a)) [a<50]

which(a<50)

a[a<50]

#No nosso objeto fogo... Podemos, por exemplo, querer as linhas correspondtes ao tipo Br

fogo.Br=fogo[fogo$Tipo=="Br",]

fogo$Tipo=="Br"

#Seleciona apenas as linhas correspondentes a TRUE


fogo.Br=fogo[which(fogo$Tipo=="Br"),]

which(fogo$Tipo=="Br")

#Seleciona as linhas correspondentes a TRUE, pelos n�meros

fogo.Br=subset(fogo, Tipo=="Br")

#E se quisermos, por exemplo, todos os indiv�duos vivos, ou seja, exceto o tipo M?

fogo.Vivo=subset(fogo, Tipo!="M")

fogo.Vivo=fogo[fogo$Tipo!="M",]

#E quanto a listas?

fogo$Nind

fogo[["Nind"]]

fogo[[7]]


a.lista

a.lista[[2]]

a.lista[[2]]$a

a.lista[[2]][[1]]

#E se quisermos pegar mais de duas coisas da lista?

a.lista[[c(1,2)]]

a.lista[c(1,2)]

#Ou seja, tanto [[ ]] quanto [ ] se aplicam a listas e data.frames.

#Finalmente, pudemos mudar apenas parte dos valores...

#Por exemplo, decidimos que parcelas com FireSeverity < 0.4 t�m FireSeverity = 0

fogo.mudado=fogo

fogo.mudado$FireSeverity[fogo.mudado$FireSeverity<0.4]=0



#Opera��es matem�ticas e estat�stica descritiva

5+2
5*2
5/2
5^2
sqrt(5)
5%%2
5%/%2

adultos=subset(fogo,Tipo=="Ad")$Nind
brotos=subset(fogo, Tipo=="Br")$Nind

sum(adultos)
mean(adultos)
var(adultos)
sd(adultos)

mean(fogo.sever.tr)

mean(fogo.sever.tr, na.rm=T)


adultos+brotos

adultos>brotos

#E se quisermos ver quantas parcelas t�m mais adultos que brotos?

length(which(adultos>brotos))

sum(adultos>brotos)

#Podemos tamb�m querer ver onde temos adultos, brotos, adultos e brotos, ou adultos ou brotos

adultos>0
brotos>0

adultos>0 & brotos>0

adultos&0 | brotos>0


#E se quisermos ver de forma f�cil o que � NA em um objeto?

fogo.sever.tr==NA
is.na(fogo.sever.tr)
sum(is.na(fogo.sever.tr))

#A somat�ria funciona porque um T ou TRUE � igual a 1 e um F ou FALSE � igual 0.

### Fim da parte 6!###

###Parte 7 - Gr�ficos simples###

#Esta � apenas uma introdu��o b�sica, bem b�sica mesma, sobre gr�ficos.
#Se tudo der certo pretendo ministrar um curso s� sobre gr�ficos no futuro...


#eixo x � a ordem ao longo do objeto

plot(brotos~adultos)

#quantitade de brotos em fun��o da quantidade de adultos

#E se quisermos ver a rela��o de n�mero de brotos com a severidade do fogo?

#Vamos fazer um novo objeto antes

ls()

str(fogo.Br)

plot(fogo.Br$Nind ~ fogo.Br$Severidade)

plot(Nind ~ Severidade, data=fogo.Br)

points(Nind~Severidade, data=fogo.Ad)


plot(Nind ~ Severidade, data=fogo.Br)

points(Nind~Severidade, data=fogo.Ad, col="red")

#Podemos querer olhar como a intensidade do fogo muda ao longo de um transecto

ls()

str(fogo.sever.tr)

plot(fogo.sever.tr[,1])

plot(fogo.sever.tr[,1], type="l")

points(fogo.sever.tr[,2], type="l", col="red")
points(fogo.sever.tr[,3], type="l", col="green")
points(fogo.sever.tr[,4], type="l", col="blue")
points(fogo.sever.tr[,5], type="l", col="orange")

#Para ver diferentes coisas que voc� pode mudar no gr�fico:

?par

#E se quiserem ter dois gr�ficos juntos?

par(mfrow=c(2,1) )

plot(fogo.sever.tr[,1], type="l")

#Mas agora podemos fazer uma outra fun��o pra fazer as linhas

lines(fogo.sever.tr[,2], col="red")
lines(fogo.sever.tr[,3], col="green")
lines(fogo.sever.tr[,4], col="blue")
lines(fogo.sever.tr[,5], col="orange")


plot(brotos~adultos)

###Fim da parte 7###

###Parte 8 - modelos lineares###

#E se quisermos ver se existe uma rela��o nisso tudo?

mod.br.ad = lm(brotos~adultos)

summary(mod.br.ad)


plot(brotos~adultos)

new.data=min(adultos):max(adultos)

predicted.br.ad=predict(mod.br.ad,list(adultos=new.data))

lines(predicted.br.ad~new.data)

predicted.br.ad=predict(mod.br.ad)

lines(predicted.br.ad~adultos, col="red")

# A reta ficou irregular porque os originais n�o est�o distrubu�dos de ordem crescente e s�o menos regulares.

###Fim da parte 8###

###Parte 9 - Help do R###

?lm
??"linear model"

?%%
?"%%"

#Algumas coisas precisar ser usadas entre aspas

help(lm)
help.search("linear model")

help(package="stats")


###Fim da parte 9###

###Parte 10 - Instalando e usando pacotes###

#Pacotes s�o conjuntos de fun��es e objetos que n�o v�m com a instala��o base do R
#Existem MUITOS pacotes. Mas normalmente usamos apenas alguns poucos.

#Podem ser baixados da internet ou instalados de zip files

Se quisermos instalar dois pacotes ao mesmo tempo, da internet:
install.packages(c("mgcv", "nlme"))

library(mgcv)
require(mgcv)

detach("package:mgcv")

#�til quando se trabalha com diferentes pacotes que t�m fun��es do mesmo nome.

help(package="mgcv")


###Fim da parte 10###

###Exerc�cio para casa (ou n�o)!###

library(mgcv)

fogo.Ad=subset(fogo,Tipo=="Ad")

modelo=gamm(Nind~s(Severidade, fx=F, k=-1), data=fogo.Ad, cor=corSpher(form=~x+y, nugget=F), method="REML")

#Usando summary e outras coisas de indexa��o que aprenderam hoje, encontrar o valor de signific�ncia do s(Severidade)
#Escrever um c�digo para extrair este valor automaticamente e o salvar em um objeto
#Fazer o gr�fico de Nind~Severidade e adicionar a linha predita pelo modelo





###Resolu��o do exerc�cio###


summary(modelo)
str(modelo)
names(modelo)

summary(modelo$lme)
summary(modelo$gam)

str(modelo$gam)

str(summary(modelo$gam))

summary(modelo$gam)$s.table

str(summary(modelo$gam)$s.table)

signif=summary(modelo$gam)$s.table[,"p-value"]


new.data=seq(min(fogo.Ad$Severidade, na.rm=T), max(fogo.Ad$Severidade, na.rm=T), 0.01)

predicted=predict(modelo$gam, list(Severidade=new.data), type="response")

plot(Nind~Severidade, data=fogo.Ad)
lines(predicted~new.data)

###Fim da resolu��o do exerc�cio###

###Parte 11 - exportando texto###

#Digamos que a gente quer salvar como txt o nosso objeto fogo.Ad

?write.table
write.table(x=fogo.Ad, file="fogo_Ad.txt", quote=F, row.names=F, col.names=T, sep="\t")

#E se quisermos salvar o resultado da an�lise?

summary(modelo$gam)

write.table(summary(modelo$gam), file="modelo_fogo_Ad.txt")

write(summary(modelo$gam), file="modelo_fogo_Ad.txt")

unlist(summary(modelo$gam))

capture.output(summary(modelo$gam))

temp=capture.output(summary(modelo$gam))

write(temp, file="modelo_fogo_Ad.txt")

###Fim da parte 11###

###Parte 12 - Exportando figuras###


plot(Nind~Severidade, data=fogo.Ad)
lines(predicted~new.data)

png(filename="fogo_Ad.png", res=300, height=20, width=20, unit="cm")

plot(Nind~Severidade, data=fogo.Ad)
lines(predicted~new.data)

dev.off()


pdf(file="fogo_Ad.pdf", width=7, height=7)

plot(Nind~Severidade, data=fogo.Ad)
lines(predicted~new.data)

dev.off()


###Fim da parte 12 ###

###Parte 13 - loops###

#Fizemos a an�lise para Nind de um tipo, mas temos cinco tipos.
#Podemos fazer as cinco an�lises uma por uma.
#Mas, e se tiv�ssemos 50 vari�veis?
#� melhor pedir ao R fazer as 50 an�lises automaticamente (e ir dormir! rs)

modelos=list()
tipos=unique(fogo$Tipo)
Ntipos = length(tipos)
tipos

i=1

for(i in 1:Ntipos) {
	
	print(i)

	tipo=tipos[i]
	fogo.temp=subset(fogo, Tipo==tipo)
	modelo.temp=gamm(Nind~s(Severidade, fx=F, k=-1), data=fogo.temp, cor=corSpher(form=~x+y, nugget=F), method="REML")
	signif=summary(modelo.temp$gam)$s.table[,"p-value"]
	output.temp=capture.output(summary(modelo.temp$gam))
	
	nome.arq=paste("modelo_", tipo, ".txt", sep="")
	write(output.temp, file=nome.arq)

	new.data=seq(min(fogo.Ad$Severidade, na.rm=T), max(fogo.Ad$Severidade, na.rm=T), 0.01)
	predicted=predict(modelo.temp$gam, list(Severidade=new.data), type="response")

	nome.arq=paste("figura_", tipo, ".png", sep="")
	
	png(filename=nome.arq, res=300, height=20, width=20, unit="cm")

	plot(Nind~Severidade, data=fogo.temp)
	lines(predicted~new.data, lty=ifelse(signif<0.05,1,2))

	dev.off()

	}


###Fim da parte 13###

print("Muito obrigado pela aten��o e bom almo�o! :)")











