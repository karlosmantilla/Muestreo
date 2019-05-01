### Ejemplo:

## Construyamos un conjunto de datos para representar una población pequeña que
## necesitamos muestrear:

x1<-rnorm(100000, mean = 10, sd = 5)

f1<-gl(3, 15, length=30000)
f2<-gl(2, 4, length=30000)
f3<-gl(3, 12, length=40000)
f<-c(f1,f2,f3)
  
x2<-factor(f, levels = c(1,2,3), labels = c("Blanco","Negro","Rojo"))

fc1<-gl(4, 8, length=30000)
fc2<-gl(2, 7, length=30000)
fc3<-gl(3, 6, length=40000)
fc<-c(fc1,fc2,fc3)

x3<-factor(fc, levels = c(1,2,3,4), labels = c("Norte","Sur","Oriente","Occidente"))

df<-data.frame(x1,x2,x3)
head(df)

### MAS (100)

n100<-100
muestra100<- sample(1:nrow(df),size=n100,replace=FALSE)
head(muestra100)

m100<-df[muestra100,]
summary(m100)

# ESTRATIFICADO

library(magrittr) # Permite leer la funcion %>%
library(dplyr) # Contiene la funcion select

Estratos<- df %>%
  select(x2,x1) %>%
  group_by(x2) %>%
  summarise(n=n(),
            s=sd(x1)) %>%
  mutate(p=n/sum(n))

Estratos

library('SamplingUtil') # Contiene la funcion nstrata

nsizeProp100<-nstrata(n=100,wh=Estratos[,4],method="proportional")
data.frame(x2=Estratos$x2,nsizeProp100)


neBlanco<-39
meBlanco100<- sample(1:nrow(df[df$x2=='Blanco',]),size=neBlanco,replace=FALSE)
meBlanco100

neNegro<-39
meNegro100<- sample(1:nrow(df[df$x2=='Negro',]),size=neNegro,replace=FALSE)
meNegro100

neRojo<-24
meRojo100<- sample(1:nrow(df[df$x2=='Rojo',]),size=neRojo,replace=FALSE)
meRojo100

mestrato100<-c(meBlanco100,meNegro100,meRojo100)

me100<-df[mestrato100,]

head(me100)

library(SamplingUtil)
msis100<- sys.sample(N=nrow(df),n=100)
msis100

m100sis<- df[msis100, ]
head(m100sis)

### CONGLOMERADOS

Conglomerados<- df %>%
  select(x3,x1) %>%
  group_by(x3) %>%
  summarise(n=n(),
            s=sd(x1)) %>%
  mutate(p=n/sum(n))

Conglomerados

nsCProp100<-nstrata(n=100,wh=Conglomerados[,4],method="proportional")
data.frame(x3=Conglomerados$x3,nsCProp100)

nCoNorte<-36
mCoNorte100<- sample(1:nrow(df[df$x3=='Norte',]),size=nCoNorte,replace=FALSE)
mCoNorte100

nCoSur<-36
mCoSur100<- sample(1:nrow(df[df$x3=='Sur',]),size=nCoSur,replace=FALSE)
mCoSur100

nCoOriente<-21
mCoOriente100<- sample(1:nrow(df[df$x3=='Oriente',]),size=nCoOriente,replace=FALSE)
mCoOriente100

nCoOccidente<-8
mCoOccidente100<- sample(1:nrow(df[df$x3=='Occidente',]),size=nCoOccidente,replace=FALSE)
mCoOccidente100

mCong100<-c(mCoNorte100,mCoSur100,mCoOriente100,mCoOccidente100)

mc100<-df[mCong100,]

head(mc100)


### GRÁFICOS
par(mfrow=c(2,2))
with(m100, plot(x1, pch=20, main = 'Aleatorio'))
with(me100, plot(x1, pch=20, main = 'Estratificado'))
with(m100sis, plot(x1, pch=20, main = 'Sistematico'))
with(mc100, plot(x1, pch=20, main = 'Conglomerados'))

with(m100, plot(x2,x1, pch=20, main = 'Aleatorio'))
with(me100, plot(x2,x1, pch=20, main = 'Estradificado'))
with(m100sis, plot(x2,x1, pch=20, main = 'Sistematico'))
with(mc100, plot(x2,x1, pch=20, main = 'Conglomerados'))

with(m100, plot(x3,x1, pch=20, main = 'Aleatorio'))
with(me100, plot(x3,x1, pch=20, main = 'Estradificado'))
with(m100sis, plot(x3,x1, pch=20, main = 'Sistematico'))
with(mc100, plot(x3,x1, pch=20, main = 'Conglomerados'))

with(m100, hist(x1, main = 'Aleatorio'))
with(me100, hist(x1, main = 'Estratificado'))
with(m100sis, hist(x1, main = 'Sistematico'))
with(mc100, hist(x1, main = 'Conglomerados'))

### PRUEBE CON VARIOS TAMAÑOS DE MUESTRA, COMPARE LOS RESULTADOS Y DISCÚTALOS
### CON SUS COMPAÑEROS
### USE LAs FUNCIONES mystas Y summary para los resultados numéricos

### FUNCIÓN mystats

mystats <- function(x, na.omit=FALSE){
  if (na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  skew <- sum((x-m)^3/s^3)/n
  kurt <- sum((x-m)^4/s^4)/n - 3
  return(c('tamaño'=n, 'media'=m, "desviación estándar"=s,
           'simetría'=skew, 'kurtosis'=kurt))
}


pop<-round(mystats(df[,'x1']),1)
alea<-round(mystats(m100[,'x1']),1)
estra<-round(mystats(me100[,'x1']),1)
siste<-round(mystats(m100sis[,'x1']),1)
conglo<-round(mystats(mc100[,'x1']),1)
data.frame(pop,alea,estra,siste,conglo)
