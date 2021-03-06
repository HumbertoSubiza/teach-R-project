### Fundamentos de estat�stica Monte Carlo e de programa��o em R para Ecologia
### Pavel Dodonov - pdodonov@gmail.com
### Aula pr�tica 4 - Bootstrap

setwd("F:/Profissional/Ensino/Disciplinas/MonteCarlo_PPGECB_UESC_2016/Planilhas")
getwd()

dados.orig <- read.table("Seedbank.txt", header=T, sep="\t")
### O sep="\t" � necess�rio porque existe um espa�o nos nomes de coluna
str(dados.orig)
### No nome da coluna ele foi substitu�do por um ponto.

### Vamos trabalhar com apenas um n�vel de �rea, data, ano e tratamento

dados.teste <- subset(dados.orig, area=="CNQ", data=="EC",
	ano==2009, tratamento=="P1")
### Deu erro... Porque o teste l�gico estava errado
dados.teste <- subset(dados.orig, area=="CQ" & data=="EC" &
	ano==2009 & tratamento=="P1")
str(dados.teste)
### Agora sim - as 30 observa��es correspondentes a essa combina��o
#### de fatores.
### Vamos pegar apenas os valores de abund�ncia para simplificar
dados.teste <- dados.teste$M..albicans
str(dados.teste)
### Um vetor com 30 n�meros - parece que est� tudo certo...
hist(dados.teste)
qqnorm(dados.teste)
qqline(dados.teste)
###Isso n�o � normal nem aqui nem em Mordor...
##### Calculando diferentes intervalos de confian�a
###Intervalo de confian�a param�trico
media.real <- mean(dados.teste)
N <- length(dados.teste) 
#tamanho amostral
SE.real <- sd(dados.teste)/sqrt(N)  
#standard error, ou erro padr�o (da m�dia)
#sqrt: raiz quadrada
IC.parametrico <- c(media.real-1.96*SE.real, media.real+1.96*SE.real)
IC.parametrico
###Intervalo de confian�a por bootsrap padr�o
### Vamos fazer um objeto com o n�mero de boots
Nboot=5000
#### Fica mais f�cil para modificarmos depois
medias.boot <- numeric(Nperm)
medias.boot[1] <- media.real
for (i in 2:5000) {
	dados.boot=sample(dados.teste, replace=T)	
	#replace=T diz que � bootstrap (com reposi��o)
	medias.boot[i]=mean(dados.boot)	
	}
hist(medias.boot)
### Reparem que a distribui��o � assim�trica...
SE.boot=sd(medias.boot)	
c(SE.real, SE.boot)
### Reparem que os dois erros foram parecidos... mas diferentes!
IC.boot.padrao=c(media.real-1.96*SE.boot, media.real+1.96*SE.boot)
IC.parametrico
IC.boot.padrao
### Mais estreito que o param�trico
IC.boot.padrao - media.real
### Mas � sim�trico ao redor da m�dia...
#### Intervalo de confian�a de Efron:
### Simplesmente pegar os 95% centrais da distribui��o
IC.boot.Efron<-quantile(medias.boot, c(0.025, 0.975))
### Nem precisam fazer a reamostragem de novo!
IC.boot.Efron
IC.boot.Efron-media.real
### N�o � sim�trico, e sim maior para a direita
#### Intervalo de confian�a de Hall:
### Calcular os erros
### Calcular os limites superiores e inferiores dos erros
### Aplicar a f�rmula: media.real - lim.sup, media.real - lim.inf
erros.boot <- medias.boot - media.real
hist(erros.boot)
IC.boot.erros <- quantile(erros.boot, c(0.025, 0.975))
IC.boot.erros
### Para a f�rmula, � mais f�cil inverter:
IC.boot.erros <- quantile(erros.boot, c(0.975, 0.025))
IC.boot.erros
IC.boot.Hall <- media.real - IC.boot.erros
IC.boot.Hall
### Fa�amos um gr�fico...
hist(dados.teste, breaks=20)
abline(v=IC.parametrico, col="red", lwd=3)
abline(v=IC.boot.padrao, col="blue", lwd=3)
abline(v=IC.boot.Efron, col="green", lwd=3)
abline(v=IC.boot.Hall, col="orange", lwd=3)

### T�, mas e pra fazer pras outras combina��es?

### Podemos transformar isso em fun��es!

bootstrap <- function(x, Nboot=5000, type="Efron") {
	### A primeira linha diz que faremos uma fun��o chamada bootstrap
	### Esta fun��o ter� os argumentos: x (o vetor de dados),
	### Nboot (o n�mero de boots) e type (o tipo de IC)
	media.real <- mean(x)
	medias.boot <- numeric(Nboot)
	medias.boot[1] <- media.real
	for (i in 2:Nboot) {
		### Reparem que aqui j� � indenta��o dupla!
		medias.boot[i] <- mean(sample(x, replace=T))
		### Fiz tudo em uma �nica linha
	}
	if (type=="standard") {
		SE.boot <- sd(medias.boot)	
		IC <- c(media.real-1.96*SE.boot, media.real+1.96*SE.boot)
	}
	if (type=="Efron") {
		IC <- quantile(medias.boot, c(0.025, 0.975))
	}
	if (type=="Hall") {
		erros.boot <- medias.boot - media.real
		IC.erros <- quantile(erros.boot, c(0.975, 0.025))
		IC <- media.real - IC.erros
	}
	return(IC)
}
bootstrap(dados.teste)
### Se repetirmos v�rias vezes, vai dar pequenas diferen�as
### Se quisermos pra cada ano: fun��o aggregate
aggregate(M..albicans ~ ano, data=dados.orig, FUN=bootstrap)
aggregate(M..albicans ~ ano, data=dados.orig, FUN=bootstrap, type="Hall")
### Para dois fatores
aggregate(M..albicans ~ ano+area, data=dados.orig, FUN=bootstrap, type="Hall")
### Para mais fatores
aggregate(M..albicans ~ ano+data+area, data=dados.orig, FUN=bootstrap, type="Hall")
### Lindo, n�o? :-)
### A fun��o bootstrapT, que enviei, calcula um outro tipo de bootstrap
### Colem ela no console para ela ficar guardada
aggregate(M..albicans ~ ano, data=dados.orig, FUN=bootstrapT)
### Exerc�cio: criem uma fun��o para calcular o intervalo de confian�a param�trico (sem bootstrap)
### Exerc�cio 2: comentem a fun��o bootstrapT (explicando o que cada as diferentes partes dela fazem)



	




