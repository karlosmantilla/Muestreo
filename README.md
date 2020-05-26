
# TEORÍA GENERAL DEL MUESTREO

## Introducción

El objeto del muestreo es hacer inferencias de características cuantitativas sobre una población a partir de una muestra. Esto es posible si la muestra es como indican algunos autores _representativa_ de la población.

**¿Cuándo es representativa una muestra?**

Antes de responder, veamos la diferencia entre muestra y población:

* **Población:** Son cada unas de las variables que se definen sobre un universo. Mediante esta definición puede hacerse notar que puede existir más de una población asociada a un mismo universo.
* **Muestra:** Es una parte representativa de la población.

Bien, aceptemos que eso no dice mucho. Veamos la cosa con un ejemplo:

> Se tiene la información sobre todos los estudiantes de la UIS pero se desea trabajar con una muestra de ellos dado el volumen de datos (supongamos que es grande). Los datos son los siguientes:

_Antes que nada, debeos importar los dato. Los tenemos un tres tipos de archivos: portable .RData; .csv y .xlsx.
La forma de traerlos al ambiente de trabajo dependerá del origen. Vamos a traerlos desde un enlace de internet de archivo portable .RData. (El símbolo numeral representa la anotación y no responde a una línea ejecutable)_


```R
# load('Datos/estudiantes.RData') # Se carga localmente
load(url('https://www.dropbox.com/s/hboulhkzmu5c993/estudiantes.RData?dl=1')) # Desde una url
# poblacion <- read.delim('clipboard', header = T, dec = ',') # Copiar y pegar
# poblacion <- read.csv(url('https://www.dropbox.com/s/qm5siml56nfctw4/matriculados.csv?dl=1')) # tipo csv
ls() # Con esta función podemos revisar los objetos que tenemos en el área de trabajo
```


'poblacion'



```R
class(poblacion)
dim(poblacion) # Cuáles son las dimensiones de data.frame
```


'data.frame'



<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>18950</li><li>24</li></ol>




```R
names(poblacion) # Los nombres de las variables del conjunto de datos
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'TIPO_DOC'</li><li>'DOCUMENTO'</li><li>'SEXO_BIOLOGICO'</li><li>'FECHA_NACIMIENTO'</li><li>'AÑO.NACIMIENTO'</li><li>'EDAD'</li><li>'ID_PAIS'</li><li>'PAIS.NACIMIENTO'</li><li>'ID_MUNICIPIO'</li><li>'REGIÓN'</li><li>'DEPARTAMENTO'</li><li>'COD_PROG_SNIES'</li><li>'PROGRAMA'</li><li>'COD_ESTUDIANTE'</li><li>'TIPO_VINCULACION'</li><li>'SEDE'</li><li>'ESTADO'</li><li>'VIGENTE'</li><li>'COD_FAC'</li><li>'FACULTAD'</li><li>'COD_ESC'</li><li>'ESCUELA_DEP'</li><li>'METODOLOGÍA'</li><li>'NIVEL.DE.FORMACION'</li></ol>




```R
# Seleccionemos sólo unas variables para efectos del ejercicio
edad<-data.frame(codigo=poblacion$COD_ESTUDIANTE, edad=poblacion$EDAD, facultad=poblacion$FACULTAD)
```


```R
head(edad); tail(edad) # Primeras y últimas observaciones de la tabla
```


<table>
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>2140297</td><td>42</td><td>CIENCIAS    </td></tr>
	<tr><th scope=row>2</th><td>2170036</td><td>26</td><td>SALUD       </td></tr>
	<tr><th scope=row>3</th><td>2172352</td><td>20</td><td>F. MECÁNICAS</td></tr>
	<tr><th scope=row>4</th><td>2182367</td><td>26</td><td>F. MECÁNICAS</td></tr>
	<tr><th scope=row>5</th><td>2184579</td><td>20</td><td>F. QUÍMICAS </td></tr>
	<tr><th scope=row>6</th><td>2181937</td><td>20</td><td>SALUD       </td></tr>
</tbody>
</table>




<table>
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>18945</th><td>2193101</td><td>27</td><td>F. QUÍMICAS</td></tr>
	<tr><th scope=row>18946</th><td>2193093</td><td>21</td><td>SALUD      </td></tr>
	<tr><th scope=row>18947</th><td>2193100</td><td>23</td><td>F. QUÍMICAS</td></tr>
	<tr><th scope=row>18948</th><td>2193102</td><td>25</td><td>C. HUMANAS </td></tr>
	<tr><th scope=row>18949</th><td>2193103</td><td>22</td><td>C. HUMANAS </td></tr>
	<tr><th scope=row>18950</th><td>2193098</td><td>25</td><td>C. HUMANAS </td></tr>
</tbody>
</table>




```R
library(repr)
options(repr.plot.width=16, repr.plot.height=16)
```


```R
# Algunas gráficas para apreciar la dispersión de los datos:
par(mfrow=c(3,1))
with(edad, plot(facultad,edad))
with(edad, plot(edad, pch = 20))
with(edad, hist(edad, nclass = 50))
par(mfrow=c(1,1))
```


![png](output_9_0.png)


Gráficamente, tenemos representada allí las edades de la población estudiantil de la UIS; toda ella, sin distinción de carrera, nivel de formación o cualquier otro tipo de agrupamiento. Seleccionemos una muestra. Empecemos con una de tamaño pequeño:


```R
n<-30
muestra1<- sample(1:nrow(edad),size=n,replace=FALSE)
head(muestra1) 
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>12142</li><li>10715</li><li>1736</li><li>1032</li><li>1694</li><li>16822</li></ol>




```R
par(mfrow=c(3,1))
with(edad[muestra1,], plot(facultad,edad))
with(edad[muestra1,], plot(edad, pch = 20))
with(edad[muestra1,], hist(edad, nclass = 50))
par(mfrow=c(1,1))
```


![png](output_12_0.png)


Cambiemos el tamaño de la muestra y miremos el comportamiento:


```R
n2<-200
muestra2<- sample(1:nrow(edad),size=n2,replace=FALSE)
head(muestra2)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>13174</li><li>10226</li><li>1899</li><li>13563</li><li>10739</li><li>17331</li></ol>




```R
par(mfrow=c(3,1))
with(edad[muestra2,], plot(facultad,edad))
with(edad[muestra2,], plot(edad, pch = 20))
with(edad[muestra2,], hist(edad, nclass = 50))
par(mfrow=c(1,1))
```


![png](output_15_0.png)


Aparentemente, entre más grande la muestra, más se parece a la población; sin embargo, el muestreo está asociado a un nivel de confianza y un nivel de error que son, al final, los que ayudan a determinar el tamaño adecuado de la muestra.

Pero, veamos si las muestras que hemos construido tiene algún parecido con la población. Para ellos, calculemos algunas medidas:


```R
mystats <- function(x, na.omit=FALSE){
  if (na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  skew <- sum((x-m)^3/s^3)/n
  kurt <- sum((x-m)^4/s^4)/n - 3
  return(c("tamaño"=n, "media"=m, "desviación estándar"=s, "simetría"=skew, "kurtosis"=kurt))
}
```


```R
pop<-round(mystats(edad[,'edad']),1)
m1<-round(mystats(edad[muestra1,'edad']),1)
m2<-round(mystats(edad[muestra2,'edad']),1)
data.frame(pop,m1,m2)
```


<table>
<caption>A data.frame: 5 × 3</caption>
<thead>
	<tr><th></th><th scope=col>pop</th><th scope=col>m1</th><th scope=col>m2</th></tr>
	<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>tamaño</th><td>18950.0</td><td>30.0</td><td>200.0</td></tr>
	<tr><th scope=row>media</th><td>   21.8</td><td>22.1</td><td> 21.8</td></tr>
	<tr><th scope=row>desviación estándar</th><td>    4.3</td><td> 4.5</td><td>  4.0</td></tr>
	<tr><th scope=row>simetría</th><td>    2.8</td><td> 1.5</td><td>  1.5</td></tr>
	<tr><th scope=row>kurtosis</th><td>   12.6</td><td> 1.6</td><td>  2.8</td></tr>
</tbody>
</table>



Antes de avanzar, respondamos algunas preguntas
* ¿Qué se aprecia en los resultados?
* ¿Qué diferencias y similitudes se pueden ver?
* ¿Qué se podría hacer?

Podría decirse que los valores son muy parecidos, que la muestra pequeña y la grande son bastante parecidas a la población y, por inducción, que es representativa. Sin embargo, dependiendo de los características de la población, se requiere de un adecuado diseño más complejo de la muestra, empezando por seleccionar el tamaño adecuado.

## Algunos conceptos básicos:

Veamos algunas definiciones que serán básicas en la comprensión del muestreo:

* **Universo:** Es un conjunto finito o infinito de animales, seres, cosas, etc. En términos de esta definición puede hablarse de un universo de individuo, animales, vehículos, etc.
* **Población:** Son cada unas de las variables que se definen sobre un universo. Mediante esta definición puede hacerse notar que puede existir más de una población asociada a un mismo universo.

* **Unidades Estadísticas:** Son requeridas por el diseñador, por una parte para saber cuál es la estrategia a seguir para la medición y, por otra, pensar en la estructura del marco de referencia de las unidades a ser estudiadas. Estas unidades son: la de investigación, análisis, observación y de muestreo.
> * **Unidad de Investigación:** Esta se refiere a la que contiene las partes que se van a analizar. Algunos ejemplos aclaran este concepto. En la encuesta de hogares para el estudio de la fuerza de trabajo que realiza el Instituto Nacional de Estadística, el motivo de la investigación es el hogar el cual contiene las unidades a examinar, es decir las, las personas. El estudio antropométrico que realiza Fundacredesa la unidad a investigar es el individuo, el cual contiene las partes del cuerpo que se van a analizar, mientras que en estudios sobre el sector industrial, la unidad de investigación esta dada por el establecimiento.

> * **Unidad de Análisis:** Comprende la unidad que se analiza, vale decir, de la que se busca la información y su naturaleza depende de los objetivos del estudio. Esta unidad puede ser el hogar, las partes del cuerpo de las personas, la granja, el establecimiento, etc. Las unidades de análisis reciben frecuentemente el nombre de “Elementos de la Población”
> * **Unidad de Observación:** Se denomina con este nombre a la unidad a través de la cual se obtiene la información, pudiendo o no coincidir con el elemento. Por ejemplo cada uno de los miembros del hogar puede constituir un elemento de la población y sin embargo ser sólo uno de ellos, por ejemplo, el jefe del hogar, quien proporcione la información requerida. Este último por tanto, constituirá la unidad de observación, también llamada unidad respondiente.
> * **Unidad de Muestreo:** Será un individuo o conjunto de individuos que se seleccionan en una única extracción. Como requisito se exige que el elemento o el grupo de elementos que componen el estudio reúnan las características de la población.

* **Muestreo:** El procedimiento mediante el cual obtenemos una o mas muestras recibe el nombre de muestreo. Obtener una muestra adecuada significa lograr una versión simplificada de la población, que reproduzca de algún modo sus rasgos básicos en términos de variación y localización.
* **Error de Muestreo:** El error que se comete debido al hecho de que se obtienen conclusiones sobre cierta realidad a partir de la observación de sólo una parte de ella.
* **Marco del Muestreo:** El conjunto de todas las unidades muestreadas consideradas.
* **Variables:** Rasgos o magnitudes que varían de unos individuos a otros. Se refiere a las características particulares que podría presentarse en uno o varios elementos de los que componen la población estudiada.
* **Características Poblacionales (parámetros):** Las más habituales como la media poblacional, el total poblacional y la proporción poblacional, entre otras características de la población se podrían citar la varianza, la mediana, la moda, entre otros.
* **Estadísticos:** Son funciones de los valores muestrales. Algunos de ellos se utilizan para estimar los parámetros (en general desconocidos), partiendo de los datos recabados en una investigación por muestreo

### ¿Por qué muestrear?

Esta pregunta, aunque simple, es completamente válida. Existen muchas razones para trabajar con muestras y no censar. Las más claras son:

* Resulta mas económica la muestra que una enumeración completa.
* El tiempo para obtener los resultados a través de una muestra es sustancialmente mas pequeño que para obtenerlo por la vía del censo, si el tamaño del universo es grande.
* La calidad de la información muestral es superior, ya que se puede concentrar más la atención en los casos individuales de la muestra y ejercer mayor control sobre ellos que una operación censal.
* Cuando el proceso de medida o examen de las características de cada elemento sea destructivo o disminuya su valor, por ejemplo, si se desea determinar la vida útil promedio de bombillos.
* Cuando la población sea considerada como infinita o tan grande que el tratamiento total exceda las posibilidades del investigador.
* Cuando los elementos de la población sean suficientemente homogéneos. Un buen ejemplo de esto lo constituye un análisis de sangre, ya que los componentes de la sangre son los mismos en cualquier  parte del cuerpo donde se encuentre ubicada.

## Tipos de Muestreo

No hay un único tipo de muestreo. Según las características de los individuos que conforman la población. Veamos algunos:

### Muestreo Aleatorio Simple (MAS)

Consiste en la selección de $n$ elementos entre los $N$ constituyen la población, de modo que todas las muestras posibles de tamaño $n$ (tantas como combinaciones de $N$ elementos de $n$ en $n$) tengan la misma probabilidad $\frac{1}{\left( \begin{smallmatrix} N \\ n \end{smallmatrix} \right)}$ de ser obtenidas.

Dado lo anterior, la probabilidad de cada elemento se calcula así:

$$
\frac{1}{\left( \begin{smallmatrix} N \\ n \end{smallmatrix} \right)} \left( \begin{smallmatrix} N - 1 \\ n - 1\end{smallmatrix} \right) = \left( \begin{smallmatrix} n \\ N \end{smallmatrix} \right)
$$


El MAS tiene sus propios parámetros:

**Media Poblacional:**
$$
\overline{Y} = \overline{y} = \sum \frac{y_{1}}{n}
$$
**Total Poblacional:**
$$
\widehat{Y} = N \overline{y}
$$
**Varianza Poblacional:**
$$
\sigma(\overline{y}) = \frac{s^{2}}{n} \frac{N-n}{N}
$$
**Varianza Total:**
$$
\sigma(\widehat{Y}) = \frac{N^{2}s^{2}}{n} \frac{N-n}{N}
$$


### ¿cuándo se realiza el muestreo aleatorio simple?

El MAS se realiza cuando la población no se encuentra subdividida o sus subdivisiones no son de importancia para el estudio.

#### Ejemplo

Sigamos usando como base la tabla con la información de la edad de la población de estudiantes UIS:


```R
head(edad)
```


<table>
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>2140297</td><td>42</td><td>CIENCIAS    </td></tr>
	<tr><th scope=row>2</th><td>2170036</td><td>26</td><td>SALUD       </td></tr>
	<tr><th scope=row>3</th><td>2172352</td><td>20</td><td>F. MECÁNICAS</td></tr>
	<tr><th scope=row>4</th><td>2182367</td><td>26</td><td>F. MECÁNICAS</td></tr>
	<tr><th scope=row>5</th><td>2184579</td><td>20</td><td>F. QUÍMICAS </td></tr>
	<tr><th scope=row>6</th><td>2181937</td><td>20</td><td>SALUD       </td></tr>
</tbody>
</table>



Vamos a obviar la variable facultad, para los propósitos del estudio (supuesto) no nos interesa, sólo es de interés analizar la edad de los estudiantes sin considerar ningún tipo de agrupamiento. En ese aspecto, cualquier muestra que seleccionemos será un MAS. En la sección anterior habíamos tomado dos muestras para ilustrar, tomemos una muestra más y comparemos:


```R
n3<-500
muestra3<- sample(1:nrow(edad),size=n3,replace=FALSE)
head(muestra3)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>9929</li><li>11108</li><li>12326</li><li>9246</li><li>625</li><li>9455</li></ol>




```R
par(mfrow=c(3,1))
with(edad[muestra3,], plot(facultad,edad))
with(edad[muestra3,], plot(edad, pch = 20))
with(edad[muestra3,], hist(edad, nclass = 50))
par(mfrow=c(1,1))
```


![png](output_33_0.png)



```R
pop<-round(mystats(edad[,'edad']),1)
m1<-round(mystats(edad[muestra1,'edad']),1)
m2<-round(mystats(edad[muestra2,'edad']),1)
m3<-round(mystats(edad[muestra3,'edad']),1)
data.frame(pop,m1,m2,m3)
```


<table>
<caption>A data.frame: 5 × 4</caption>
<thead>
	<tr><th></th><th scope=col>pop</th><th scope=col>m1</th><th scope=col>m2</th><th scope=col>m3</th></tr>
	<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>tamaño</th><td>18950.0</td><td>30.0</td><td>200.0</td><td>500.0</td></tr>
	<tr><th scope=row>media</th><td>   21.8</td><td>22.1</td><td> 21.8</td><td> 21.7</td></tr>
	<tr><th scope=row>desviación estándar</th><td>    4.3</td><td> 4.5</td><td>  4.0</td><td>  4.0</td></tr>
	<tr><th scope=row>simetría</th><td>    2.8</td><td> 1.5</td><td>  1.5</td><td>  2.5</td></tr>
	<tr><th scope=row>kurtosis</th><td>   12.6</td><td> 1.6</td><td>  2.8</td><td> 10.3</td></tr>
</tbody>
</table>



Comparemos todos los gráficos. Como hemos establecido que no es de nuestro interés la variable _facultad_ no consideraremos los diagramas de caja para cada facultad


```R
par(mfrow=c(3,4))
with(edad, boxplot(edad, main = 'Población', ylim=c(0,85)))
with(edad[muestra1,], boxplot(edad, main = 'Muestra 1 (30)', ylim=c(0,85)))
with(edad[muestra2,], boxplot(edad, main = 'Muestra 2 (200)', ylim=c(0,85)))
with(edad[muestra3,], boxplot(edad, main = 'Muestra 3 (500)', ylim=c(0,85)))
with(edad, plot(edad, pch = 20, main = 'Población'))
with(edad[muestra1,], plot(edad, pch = 20, main = 'Muestra 1 (30)', ylim=c(0,85)))
with(edad[muestra2,], plot(edad, pch = 20, main = 'Muestra 2 (200)', ylim=c(0,85)))
with(edad[muestra3,], plot(edad, pch = 20, main = 'Muestra 3 (500)', ylim=c(0,85)))
with(edad, hist(edad, nclass = 50, main = 'Población'))
with(edad[muestra1,], hist(edad, nclass = 50, main = 'Muestra 1 (30)'))
with(edad[muestra2,], hist(edad, nclass = 50, main = 'Muestra 2 (200)'))
with(edad[muestra3,], hist(edad, nclass = 50, main = 'Muestra 3 (500)'))
par(mfrow=c(1,1))
```


![png](output_36_0.png)


Como observamos, el tamaño de la muestra es determinante en su 'representatividad'. De ello hablaremos más adelante, por el momento sigamos viendo otros tipos de muestreo)

### Muestreo Estratificado

En el MAS no hacemos distinción si la población se encuentra dividida en _subpoblaciones_ o estratos; ahora, si tomamos en cuenta esta característica (en el ejemplo que hemos venido desarrollando son las facultades) es necesario construir la muestra de manera tal que contenga elementos de cada estrato. Estas _subpoblaciones_ no se sobreponen y, juntas, forman la población total. Entonces tenemos:

$$
N_{1} + N_{2} + \dots + N_{L} = \sum_{i=1}^{L} N_{i} = N
$$

Una vez que hayamos identificado los estratos, sacamos una muestra de cada uno, esto es equivalente a realizar un MAS en cada uno de los estratos y se conoce como Muestreo Estratificado. Sigamos con el ejemplo de la edad de los estudiantes.

En primer lugar, tenemos que traer dos librerías que nos van a soportar algunas funciones:


```R
library(magrittr) # Permite leer la función %>%
library(dplyr) # Contiene la función select
```

    
    Attaching package: 'dplyr'
    
    
    The following objects are masked from 'package:stats':
    
        filter, lag
    
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, setequal, union
    
    
    

Instaladas y llamadas las librerías, vamos a identificar los estratos:


```R
Estratos<- edad %>%
  select(facultad,edad) %>%
  group_by(facultad) %>%
  summarise(n=n(),
            s=sd(edad)) %>%
  mutate(p=n/sum(n))

Estratos
```


<table>
<caption>A tibble: 6 × 4</caption>
<thead>
	<tr><th scope=col>facultad</th><th scope=col>n</th><th scope=col>s</th><th scope=col>p</th></tr>
	<tr><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>C. HUMANAS  </td><td>3207</td><td>3.149296</td><td>0.16923483</td></tr>
	<tr><td>CIENCIAS    </td><td>1265</td><td>3.494117</td><td>0.06675462</td></tr>
	<tr><td>F. MECÁNICAS</td><td>7126</td><td>2.758794</td><td>0.37604222</td></tr>
	<tr><td>F. QUÍMICAS </td><td>3111</td><td>3.153490</td><td>0.16416887</td></tr>
	<tr><td>IPRED       </td><td>2650</td><td>7.498839</td><td>0.13984169</td></tr>
	<tr><td>SALUD       </td><td>1591</td><td>2.855829</td><td>0.08395778</td></tr>
</tbody>
</table>



Es importante notar la distribución de frecuencias en los estratos. Estas nos permitirán seleccionar adecuadamente cada muestra. Vamos a usar los tamaños previos: `30`, `200` y `500`. En este punto la función `nstrata` y `sys.sample` del paquete SamplingUtil. Para instalar este paquete, se debe inicialmente instalar el paquete devtools ya que no se encuentra en CRAN.Las instrucciones son las siguientes:

* Instalar devtools: `install.packages("devtools")`
* Cargar libreria: `library(devtools)`
* Instalar SamplingUtils: `install_github("DFJL/SamplingUtil")`


```R
library('SamplingUtil') # Contiene la función nstrata
```


```R
nsizeProp30<-nstrata(n=30,wh=Estratos[,4],method="proportional")
nsizeProp200<-nstrata(n=200,wh=Estratos[,4],method="proportional")
nsizeProp500<-nstrata(n=500,wh=Estratos[,4],method="proportional")
```


```R
data.frame(fac=Estratos$facultad,nsizeProp30,nsizeProp200,nsizeProp500)
```


<table>
<caption>A data.frame: 6 × 4</caption>
<thead>
	<tr><th scope=col>fac</th><th scope=col>p</th><th scope=col>p.1</th><th scope=col>p.2</th></tr>
	<tr><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>C. HUMANAS  </td><td> 6</td><td>34</td><td> 85</td></tr>
	<tr><td>CIENCIAS    </td><td> 3</td><td>14</td><td> 34</td></tr>
	<tr><td>F. MECÁNICAS</td><td>12</td><td>76</td><td>189</td></tr>
	<tr><td>F. QUÍMICAS </td><td> 5</td><td>33</td><td> 83</td></tr>
	<tr><td>IPRED       </td><td> 5</td><td>28</td><td> 70</td></tr>
	<tr><td>SALUD       </td><td> 3</td><td>17</td><td> 42</td></tr>
</tbody>
</table>



Las proporciones se mantienen de manera relativa. Podemos notar que los valores son redondeados hacia el entero superior por lo que el tamaño de la muestra será mayor en este caso, si se compara con el MAS. La selección de la muestra se hace, entonces, dento de cada estrato:


```R
nhumanas30<-6
muestrahumanas30<- sample(1:nrow(edad[edad$facultad=='C. HUMANAS',]),size=nhumanas30,replace=FALSE)
muestrahumanas30
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>723</li><li>1175</li><li>3191</li><li>2382</li><li>2484</li><li>2815</li></ol>




```R
nciencias30<-3
muestraciencias30<- sample(1:nrow(edad[edad$facultad=='CIENCIAS',]),size=nciencias30,replace=FALSE)
muestraciencias30
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>834</li><li>1207</li><li>594</li></ol>




```R
nmecanicas30<-12
muestramecanicas30<- sample(1:nrow(edad[edad$facultad=='F. MECÁNICAS',]),size=nmecanicas30,replace=FALSE)
muestramecanicas30
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>3201</li><li>3203</li><li>4050</li><li>2333</li><li>2218</li><li>5623</li><li>5195</li><li>3234</li><li>1419</li><li>450</li><li>3408</li><li>1116</li></ol>




```R
nquimicas30<-5
muestraquimicas30<- sample(1:nrow(edad[edad$facultad=='F. QUÍMICAS',]),size=nquimicas30,replace=FALSE)
muestraquimicas30
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>610</li><li>807</li><li>1137</li><li>2001</li><li>3056</li></ol>




```R
nipred30<-5
muestraipred30<- sample(1:nrow(edad[edad$facultad=='IPRED',]),size=nipred30,replace=FALSE)
muestraipred30
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1366</li><li>1173</li><li>1983</li><li>552</li><li>1460</li></ol>




```R
nsalud30<-3
muestrasalud30<- sample(1:nrow(edad[edad$facultad=='SALUD',]),size=nsalud30,replace=FALSE)
muestrasalud30
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1539</li><li>293</li><li>1348</li></ol>



Construyamos un vector que nos permita seleccionar la muestra:


```R
mestrato30<-c(muestrahumanas30,muestraciencias30,muestramecanicas30,muestraquimicas30,muestraipred30,muestrasalud30)
```

Y unas gráficas que nos permitan comparar:


```R
par(mfrow=c(3,3))
with(edad, plot(facultad,edad, main = 'Población', ylim=c(0,85)))
with(edad[muestra1,], plot(facultad,edad, main = 'MAS (30)', ylim=c(0,85)))
with(edad[mestrato30,], plot(facultad,edad, main = 'ME (30)', ylim=c(0,85)))

with(edad, plot(edad, pch = 20, main = 'Población'))
with(edad[muestra1,], plot(edad, pch = 20, main = 'MAS (30)', ylim=c(0,85)))
with(edad[mestrato30,], plot(edad, pch = 20, main = 'ME (30)', ylim=c(0,85)))

with(edad, hist(edad, nclass = 50, main = 'Población'))
with(edad[muestra1,], hist(edad, nclass = 50, main = 'MAS (30)'))
with(edad[mestrato30,], hist(edad, nclass = 50, main = 'ME (30)'))

par(mfrow=c(1,1))
```


![png](output_56_0.png)


* ¿Qué diferencias observamos?
* ¿A qué se deberán estas diferencias?
* ¿Cambiará en algo si ampliamos la muestra?

## Muestreo Sistemático

El muestro sistemático consiste en tomar alestoriamente un cierto númoer $i$ de las primeras $k$ unidades que designara en una lista o población de $N$ elementos al primero que va a formar parte de la muestra.

Luego, de manera casi rígida o sistemática, se va tomando el elemento $i+k$ que está $k$ lugares del i-ésimo en la lista; el $i+2k$ que está a $2k$ lugares y así sucesivamente hasta que se agoten los elementos disponibles en la lista


```R
library(SamplingUtil) # librería empleada para muestreo sistemático:
```


```R
# construyamos una muestra sistemática de tamaño 30:
msis30<- sys.sample(N=nrow(edad),n=30)
msis30
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>541</li><li>1172</li><li>1803</li><li>2434</li><li>3065</li><li>3696</li><li>4327</li><li>4958</li><li>5589</li><li>6220</li><li>6851</li><li>7482</li><li>8113</li><li>8744</li><li>9375</li><li>10006</li><li>10637</li><li>11268</li><li>11899</li><li>12530</li><li>13161</li><li>13792</li><li>14423</li><li>15054</li><li>15685</li><li>16316</li><li>16947</li><li>17578</li><li>18209</li><li>18840</li></ol>




```R
# construyamos una muestra sistemática de tamaño 200:
msis200<- sys.sample(N=nrow(edad),n=200)
head(msis200,10);tail(msis200,10)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>9</li><li>103</li><li>197</li><li>291</li><li>385</li><li>479</li><li>573</li><li>667</li><li>761</li><li>855</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>17869</li><li>17963</li><li>18057</li><li>18151</li><li>18245</li><li>18339</li><li>18433</li><li>18527</li><li>18621</li><li>18715</li></ol>




```R
# construyamos una muestra sistemática de tamaño 500:
msis500<- sys.sample(N=nrow(edad),n=500)
head(msis500,10);tail(msis500,10)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>33</li><li>70</li><li>107</li><li>144</li><li>181</li><li>218</li><li>255</li><li>292</li><li>329</li><li>366</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>18163</li><li>18200</li><li>18237</li><li>18274</li><li>18311</li><li>18348</li><li>18385</li><li>18422</li><li>18459</li><li>18496</li></ol>




```R
# Ahora extraemos la muestra:
m30sis<- edad[msis30, ]
head(m30sis)
```


<table>
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>541</th><td>2161144</td><td>21</td><td>F. MECÁNICAS</td></tr>
	<tr><th scope=row>1172</th><td>2191756</td><td>17</td><td>C. HUMANAS  </td></tr>
	<tr><th scope=row>1803</th><td>2170769</td><td>20</td><td>CIENCIAS    </td></tr>
	<tr><th scope=row>2434</th><td>2191513</td><td>17</td><td>C. HUMANAS  </td></tr>
	<tr><th scope=row>3065</th><td>2192423</td><td>17</td><td>F. QUÍMICAS </td></tr>
	<tr><th scope=row>3696</th><td>2172009</td><td>19</td><td>F. MECÁNICAS</td></tr>
</tbody>
</table>




```R
m200sis<- edad[msis200, ]
head(m200sis)
```


<table>
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>9</th><td>2192816</td><td>19</td><td>F. QUÍMICAS</td></tr>
	<tr><th scope=row>103</th><td>2166170</td><td>41</td><td>IPRED      </td></tr>
	<tr><th scope=row>197</th><td>2176187</td><td>43</td><td>IPRED      </td></tr>
	<tr><th scope=row>291</th><td>2086381</td><td>36</td><td>IPRED      </td></tr>
	<tr><th scope=row>385</th><td>2065314</td><td>47</td><td>IPRED      </td></tr>
	<tr><th scope=row>479</th><td>2196463</td><td>19</td><td>IPRED      </td></tr>
</tbody>
</table>




```R
m500sis<- edad[msis500, ]
head(m500sis)
```


<table>
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>33</th><td>2174613</td><td>19</td><td>F. MECÁNICAS</td></tr>
	<tr><th scope=row>70</th><td>2032251</td><td>38</td><td>C. HUMANAS  </td></tr>
	<tr><th scope=row>107</th><td>2176210</td><td>47</td><td>IPRED       </td></tr>
	<tr><th scope=row>144</th><td>2176175</td><td>36</td><td>IPRED       </td></tr>
	<tr><th scope=row>181</th><td>2196296</td><td>40</td><td>IPRED       </td></tr>
	<tr><th scope=row>218</th><td>2186056</td><td>50</td><td>IPRED       </td></tr>
</tbody>
</table>




```R
# Y las gráficas
par(mfrow=c(3,4))
with(edad, plot(facultad,edad, main = 'Población', ylim=c(0,85)))
with(edad[muestra1,], plot(facultad,edad, main = 'MAS (30)', ylim=c(0,85)))
with(edad[mestrato30,], plot(facultad,edad, main = 'ME (30)', ylim=c(0,85)))
with(edad[msis30,], plot(facultad,edad, main = 'MS (30)', ylim=c(0,85)))

with(edad, plot(edad, pch = 20, main = 'Población'))
with(edad[muestra1,], plot(edad, pch = 20, main = 'MAS (30)', ylim=c(0,85)))
with(edad[mestrato30,], plot(edad, pch = 20, main = 'ME (30)', ylim=c(0,85)))
with(edad[msis30,], plot(edad, pch = 20, main = 'MS (30)', ylim=c(0,85)))

with(edad, hist(edad, nclass = 50, main = 'Población'))
with(edad[muestra1,], hist(edad, nclass = 50, main = 'MAS (30)'))
with(edad[mestrato30,], hist(edad, nclass = 50, main = 'ME (30)'))
with(edad[msis30,], hist(edad, nclass = 50, main = 'MS (30)'))

par(mfrow=c(1,1))

# Con la muestra 200
par(mfrow=c(3,3))
with(edad, plot(facultad,edad, main = 'Población', ylim=c(0,85)))
with(edad[muestra2,], plot(facultad,edad, main = 'MAS (200)', ylim=c(0,85)))
with(edad[msis200,], plot(facultad,edad, main = 'MS (200)', ylim=c(0,85)))

with(edad, plot(edad, pch = 20, main = 'Población'))
with(edad[muestra2,], plot(edad, pch = 20, main = 'MAS (200)', ylim=c(0,85)))
with(edad[msis200,], plot(edad, pch = 20, main = 'MS (200)', ylim=c(0,85)))

with(edad, hist(edad, nclass = 50, main = 'Población'))
with(edad[muestra2,], hist(edad, nclass = 50, main = 'MAS (200)'))
with(edad[msis200,], hist(edad, nclass = 50, main = 'MS (200)'))

par(mfrow=c(1,1))
```


![png](output_66_0.png)



![png](output_66_1.png)


## Ejercicio

En el siguiente enlace encontrará el script correspondiente al ejercicio propuesto en clase:
https://github.com/karlosmantilla/Muestreo/blob/master/Datos/Muestreo3.R
