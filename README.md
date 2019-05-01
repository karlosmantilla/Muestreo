
# TEORÍA GENERAL DEL MUESTREO

## Introducción

El objeto del muestreo es hacer inferencias de características cuantitativas sobre una población a partir de una muestra. Esto es posible si la muestra es como indican algunos autores _representativa_ de la población.

**¿Cuándo es representativa una muestra?**

Antes de responder, veamos la diferencia entre muestra y población:

* **Población:** Son cada unas de las variables que se definen sobre un universo. Mediante esta definición puede hacerse notar que puede existir más de una población asociada a un mismo universo.
* **Muestra:** Es una parte representativa de la población.

Bien, aceptemos que eso no dice mucho. Veamos la cosa con un ejemplo:

> Se tiene la información sobre todos los estudiantes de la UIS pero se desea trabajar con una muestra de ellos dado el volumen de datos (supongamos que es grande). Los datos son los siguientes:


```R
load('Datos/estudiantes.RData')
ls() # Con esta función podemos revisar los objetos que tenemos en el área de trabajo
```


<ol class=list-inline>
	<li>'mystats'</li>
	<li>'poblacion'</li>
</ol>




```R
dim(poblacion) # Cuáles son las dimensiones de data.frame
```


<ol class=list-inline>
	<li>24040</li>
	<li>21</li>
</ol>




```R
names(poblacion) # Los nombres de las variables del conjunto de datos
```


<ol class=list-inline>
	<li>'NUM_DOCUMENTO'</li>
	<li>'SEXO_BIOLOGICO'</li>
	<li>'ID_ESTADO_CIVIL'</li>
	<li>'AÑO.NACIMIENTO'</li>
	<li>'EDAD'</li>
	<li>'PAIS.NACIMIENTO'</li>
	<li>'REGIÓN'</li>
	<li>'COD_PROG_SNIES'</li>
	<li>'PROGRAMA'</li>
	<li>'COD_ESTUDIANTE'</li>
	<li>'SEDE'</li>
	<li>'ESTADO'</li>
	<li>'VIGENTE'</li>
	<li>'COD_FAC'</li>
	<li>'FACULTAD'</li>
	<li>'COD_ESC'</li>
	<li>'ESCUELA_DEP'</li>
	<li>'METODOLOGÍA'</li>
	<li>'PROGRAMA.TIPO'</li>
	<li>'NIVEL.ACADEMICO'</li>
	<li>'NIVEL.DE.FORMACION'</li>
</ol>




```R
# Seleccionemos sólo unas variables para efectos del ejercicio
edad<-data.frame(codigo=poblacion$COD_ESTUDIANTE, edad=poblacion$EDAD, facultad=poblacion$FACULTAD)
```


```R
head(edad); tail(edad) # Primeras y últimas observaciones de la tabla
```


<table>
<thead><tr><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr></thead>
<tbody>
	<tr><td>2158108 </td><td>30      </td><td>CIENCIAS</td></tr>
	<tr><td>2188261 </td><td>26      </td><td>CIENCIAS</td></tr>
	<tr><td>2168284 </td><td>30      </td><td>CIENCIAS</td></tr>
	<tr><td>2168283 </td><td>28      </td><td>CIENCIAS</td></tr>
	<tr><td>2178275 </td><td>28      </td><td>CIENCIAS</td></tr>
	<tr><td>2188259 </td><td>28      </td><td>CIENCIAS</td></tr>
</tbody>
</table>




<table>
<thead><tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr></thead>
<tbody>
	<tr><th scope=row>24035</th><td>2172579   </td><td>18        </td><td>C. HUMANAS</td></tr>
	<tr><th scope=row>24036</th><td>2121969   </td><td>38        </td><td>C. HUMANAS</td></tr>
	<tr><th scope=row>24037</th><td>2131294   </td><td>27        </td><td>SALUD     </td></tr>
	<tr><th scope=row>24038</th><td>2172624   </td><td>19        </td><td>C. HUMANAS</td></tr>
	<tr><th scope=row>24039</th><td>2143435   </td><td>28        </td><td>C. HUMANAS</td></tr>
	<tr><th scope=row>24040</th><td>2170842   </td><td>19        </td><td>C. HUMANAS</td></tr>
</tbody>
</table>




```R
# Algunas gráficas para apreciar la dispersión de los datos:
par(mfrow=c(3,1))
with(edad, plot(facultad,edad))
with(edad, plot(edad, pch = 20))
with(edad, hist(edad, nclass = 50))
par(mfrow=c(1,1))
```


![png](output_7_0.png)


Gráficamente, tenemos representada allí las edades de la población estudiantil de la UIS; toda ella, sin distinción de carrera, nivel de formación o cualquier otro tipo de agrupamiento. Seleccionemos una muestra. Empecemos con una de tamaño pequeño:


```R
n<-30
muestra1<- sample(1:nrow(edad),size=n,replace=FALSE)
head(muestra1) 
```


<ol class=list-inline>
	<li>17638</li>
	<li>15500</li>
	<li>11077</li>
	<li>5691</li>
	<li>6596</li>
	<li>23971</li>
</ol>




```R
par(mfrow=c(3,1))
with(edad[muestra1,], plot(facultad,edad))
with(edad[muestra1,], plot(edad, pch = 20))
with(edad[muestra1,], hist(edad, nclass = 50))
par(mfrow=c(1,1))
```


![png](output_10_0.png)


Cambiemos el tamaño de la muestra y miremos el comportamiento:


```R
n2<-200
muestra2<- sample(1:nrow(edad),size=n2,replace=FALSE)
head(muestra2)
```


<ol class=list-inline>
	<li>15453</li>
	<li>2591</li>
	<li>6997</li>
	<li>2517</li>
	<li>8495</li>
	<li>19828</li>
</ol>




```R
par(mfrow=c(3,1))
with(edad[muestra2,], plot(facultad,edad))
with(edad[muestra2,], plot(edad, pch = 20))
with(edad[muestra2,], hist(edad, nclass = 50))
par(mfrow=c(1,1))
```


![png](output_13_0.png)


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
<thead><tr><th></th><th scope=col>pop</th><th scope=col>m1</th><th scope=col>m2</th></tr></thead>
<tbody>
	<tr><th scope=row>tamaño</th><td>24040.0</td><td>30.0   </td><td>200.0  </td></tr>
	<tr><th scope=row>media</th><td>   23.0</td><td>23.3   </td><td> 22.6  </td></tr>
	<tr><th scope=row>desviación estándar</th><td>    5.7</td><td> 6.7   </td><td>  4.9  </td></tr>
	<tr><th scope=row>simetría</th><td>    2.4</td><td> 2.2   </td><td>  2.1  </td></tr>
	<tr><th scope=row>kurtosis</th><td>    8.2</td><td> 5.2   </td><td>  6.2  </td></tr>
</tbody>
</table>



Antes de avanzar, respondamos algunas preguntas
* ¿Qué se aprecia en los resultados?
* ¿Qué diferencias y similitudes se puden ver?
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

<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\dpi{150}&space;\large&space;\frac{1}{\left(&space;\begin{smallmatrix}&space;N&space;\\&space;n&space;\end{smallmatrix}&space;\right)}&space;\left(&space;\begin{smallmatrix}&space;N&space;-&space;1&space;\\&space;n&space;-&space;1\end{smallmatrix}&space;\right)&space;=&space;\left(&space;\begin{smallmatrix}&space;n&space;\\&space;N&space;\end{smallmatrix}&space;\right)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\dpi{150}&space;\large&space;\frac{1}{\left(&space;\begin{smallmatrix}&space;N&space;\\&space;n&space;\end{smallmatrix}&space;\right)}&space;\left(&space;\begin{smallmatrix}&space;N&space;-&space;1&space;\\&space;n&space;-&space;1\end{smallmatrix}&space;\right)&space;=&space;\left(&space;\begin{smallmatrix}&space;n&space;\\&space;N&space;\end{smallmatrix}&space;\right)" title="\large \frac{1}{\left( \begin{smallmatrix} N \\ n \end{smallmatrix} \right)} \left( \begin{smallmatrix} N - 1 \\ n - 1\end{smallmatrix} \right) = \left( \begin{smallmatrix} n \\ N \end{smallmatrix} \right)" /></a>


El MAS tiene sus propios parámetros:

**Media Poblacional:**
<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\dpi{150}&space;\large&space;\overline{Y}&space;=&space;\overline{y}&space;=&space;\sum&space;\frac{y_{1}}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\dpi{150}&space;\large&space;\overline{Y}&space;=&space;\overline{y}&space;=&space;\sum&space;\frac{y_{1}}{n}" title="\large \overline{Y} = \overline{y} = \sum \frac{y_{1}}{n}" /></a>

**Total Poblacional:**
<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\dpi{150}&space;\large&space;\widehat{Y}&space;=&space;N&space;\overline{y}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\dpi{150}&space;\large&space;\widehat{Y}&space;=&space;N&space;\overline{y}" title="\large \widehat{Y} = N \overline{y}" /></a>

**Varianza Poblacional:**
<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\dpi{150}&space;\large&space;\sigma(\overline{y})&space;=&space;\frac{s^{2}}{n}&space;\frac{N-n}{N}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\dpi{150}&space;\large&space;\sigma(\overline{y})&space;=&space;\frac{s^{2}}{n}&space;\frac{N-n}{N}" title="\large \sigma(\overline{y}) = \frac{s^{2}}{n} \frac{N-n}{N}" /></a>

**Varianza Total:**
<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\dpi{150}&space;\large&space;\sigma(\widehat{Y})&space;=&space;\frac{N^{2}s^{2}}{n}&space;\frac{N-n}{N}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\dpi{150}&space;\large&space;\sigma(\widehat{Y})&space;=&space;\frac{N^{2}s^{2}}{n}&space;\frac{N-n}{N}" title="\large \sigma(\widehat{Y}) = \frac{N^{2}s^{2}}{n} \frac{N-n}{N}" /></a>


### ¿cuándo se realiza el muestreo aleatorio simple?

El MAS se realiza cuando la población no se encuentra subdividida o sus subdivisiones no son de importancia para el estudio.

#### Ejemplo

Sigamos usando como base la tabla con la información de la edad de la población de estudiantes UIS:


```R
head(edad)
```


<table>
<thead><tr><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr></thead>
<tbody>
	<tr><td>2158108 </td><td>30      </td><td>CIENCIAS</td></tr>
	<tr><td>2188261 </td><td>26      </td><td>CIENCIAS</td></tr>
	<tr><td>2168284 </td><td>30      </td><td>CIENCIAS</td></tr>
	<tr><td>2168283 </td><td>28      </td><td>CIENCIAS</td></tr>
	<tr><td>2178275 </td><td>28      </td><td>CIENCIAS</td></tr>
	<tr><td>2188259 </td><td>28      </td><td>CIENCIAS</td></tr>
</tbody>
</table>



Vamos a obviar la variable facultad, para los propósitos del estudio (supuesto) no nos interesa, sólo es de interés analizar la edad de los estudiantes sin considerar ningún tipo de agrupamiento. En ese aspecto, cualquier muestra que seleccionemos será un MAS. En la sección anterior habíamos tomado dos muestras para ilustrar, tomemos una muestra más y comparemos:


```R
n3<-500
muestra3<- sample(1:nrow(edad),size=n3,replace=FALSE)
head(muestra3)
```


<ol class=list-inline>
	<li>2797</li>
	<li>19939</li>
	<li>2018</li>
	<li>19960</li>
	<li>5426</li>
	<li>6710</li>
</ol>




```R
par(mfrow=c(3,1))
with(edad[muestra3,], plot(facultad,edad))
with(edad[muestra3,], plot(edad, pch = 20))
with(edad[muestra3,], hist(edad, nclass = 50))
par(mfrow=c(1,1))
```


![png](output_31_0.png)



```R
pop<-round(mystats(edad[,'edad']),1)
m1<-round(mystats(edad[muestra1,'edad']),1)
m2<-round(mystats(edad[muestra2,'edad']),1)
m3<-round(mystats(edad[muestra3,'edad']),1)
data.frame(pop,m1,m2,m3)
```


<table>
<thead><tr><th></th><th scope=col>pop</th><th scope=col>m1</th><th scope=col>m2</th><th scope=col>m3</th></tr></thead>
<tbody>
	<tr><th scope=row>tamaño</th><td>24040.0</td><td>30.0   </td><td>200.0  </td><td>500.0  </td></tr>
	<tr><th scope=row>media</th><td>   23.0</td><td>23.3   </td><td> 22.6  </td><td> 23.3  </td></tr>
	<tr><th scope=row>desviación estándar</th><td>    5.7</td><td> 6.7   </td><td>  4.9  </td><td>  6.1  </td></tr>
	<tr><th scope=row>simetría</th><td>    2.4</td><td> 2.2   </td><td>  2.1  </td><td>  2.1  </td></tr>
	<tr><th scope=row>kurtosis</th><td>    8.2</td><td> 5.2   </td><td>  6.2  </td><td>  5.5  </td></tr>
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


![png](output_34_0.png)


Como observamos, el tamaño de la muestra es determinante en su 'representatividad'. De ello hablaremos más adelante, por el momento sigamos viendo otros tipos de muestreo)

### Muestreo Estratificado

En el MAS no hacemos distinción si la población se encuentra dividida en _subpoblaciones_ o estratos; ahora, si tomamos en cuenta esta característica (en el ejemplo que hemos venido desarrollando son las facultades) es necesario construir la muestra de manera tal que contenga elementos de cada estrato. Estas _subpoblaciones_ no se sobreponen y, juntas, forman la población total. Entonces tenemos:

<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\dpi{150}&space;\large&space;N_{1}&space;&plus;&space;N_{2}&space;&plus;&space;\dots&space;&plus;&space;N_{L}&space;=&space;\sum_{i=1}^{L}&space;N_{i}&space;=&space;N" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\dpi{150}&space;\large&space;N_{1}&space;&plus;&space;N_{2}&space;&plus;&space;\dots&space;&plus;&space;N_{L}&space;=&space;\sum_{i=1}^{L}&space;N_{i}&space;=&space;N" title="\large N_{1} + N_{2} + \dots + N_{L} = \sum_{i=1}^{L} N_{i} = N" /></a>


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
<thead><tr><th scope=col>facultad</th><th scope=col>n</th><th scope=col>s</th><th scope=col>p</th></tr></thead>
<tbody>
	<tr><td>C. HUMANAS  </td><td>4115        </td><td> 6.104970   </td><td>0.1711730449</td></tr>
	<tr><td>CEDEDUIS    </td><td>  19        </td><td>11.373767   </td><td>0.0007903494</td></tr>
	<tr><td>CIENCIAS    </td><td>1661        </td><td> 5.008459   </td><td>0.0690931780</td></tr>
	<tr><td>F.MECÁNICAS </td><td>8982        </td><td> 4.771159   </td><td>0.3736272879</td></tr>
	<tr><td>F.QUÍMICAS  </td><td>4259        </td><td> 5.158950   </td><td>0.1771630616</td></tr>
	<tr><td>IPRED       </td><td>3129        </td><td> 7.855062   </td><td>0.1301580699</td></tr>
	<tr><td>SALUD       </td><td>1875        </td><td> 4.124805   </td><td>0.0779950083</td></tr>
</tbody>
</table>



Es importante notar la distribución de frecuencias en los estratos. Estas nos permitirán seleccionar adecuadamente cada muestra. Vamos a usar los tamaños previos: `30`, `200` y `500`:


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
<thead><tr><th scope=col>fac</th><th scope=col>p</th><th scope=col>p.1</th><th scope=col>p.2</th></tr></thead>
<tbody>
	<tr><td>C. HUMANAS </td><td> 6         </td><td>35         </td><td> 86        </td></tr>
	<tr><td>CEDEDUIS   </td><td> 1         </td><td> 1         </td><td>  1        </td></tr>
	<tr><td>CIENCIAS   </td><td> 3         </td><td>14         </td><td> 35        </td></tr>
	<tr><td>F.MECÁNICAS</td><td>12         </td><td>75         </td><td>187        </td></tr>
	<tr><td>F.QUÍMICAS </td><td> 6         </td><td>36         </td><td> 89        </td></tr>
	<tr><td>IPRED      </td><td> 4         </td><td>27         </td><td> 66        </td></tr>
	<tr><td>SALUD      </td><td> 3         </td><td>16         </td><td> 39        </td></tr>
</tbody>
</table>



Las proporciones se mantienen de manera relativa. Podemos notar que los valores son redondeados hacia el entero superior por lo que el tamaño de la muestra será mayor en este caso, si se compara con el MAS. La selección de la muestra se hace, entonces, dento de cada estrato:


```R
nhumanas30<-6
muestrahumanas30<- sample(1:nrow(edad[edad$facultad=='C. HUMANAS',]),size=nhumanas30,replace=FALSE)
muestrahumanas30
```


<ol class=list-inline>
	<li>1934</li>
	<li>1786</li>
	<li>1508</li>
	<li>1456</li>
	<li>795</li>
	<li>25</li>
</ol>




```R
ncedeuis30<-1
muestracedeuis30<- sample(1:nrow(edad[edad$facultad=='CEDEDUIS',]),size=ncedeuis30,replace=FALSE)
muestracedeuis30
```


19



```R
nciencias30<-3
muestraciencias30<- sample(1:nrow(edad[edad$facultad=='CIENCIAS',]),size=nciencias30,replace=FALSE)
muestraciencias30
```


<ol class=list-inline>
	<li>872</li>
	<li>466</li>
	<li>142</li>
</ol>




```R
nmecanicas30<-12
muestramecanicas30<- sample(1:nrow(edad[edad$facultad=='F.MECÁNICAS',]),size=nmecanicas30,replace=FALSE)
muestramecanicas30
```


<ol class=list-inline>
	<li>1156</li>
	<li>2843</li>
	<li>3358</li>
	<li>1724</li>
	<li>5328</li>
	<li>7753</li>
	<li>1461</li>
	<li>119</li>
	<li>4954</li>
	<li>5660</li>
	<li>8410</li>
	<li>6210</li>
</ol>




```R
nquimicas30<-6
muestraquimicas30<- sample(1:nrow(edad[edad$facultad=='F.QUÍMICAS',]),size=nquimicas30,replace=FALSE)
muestraquimicas30
```


<ol class=list-inline>
	<li>293</li>
	<li>759</li>
	<li>3025</li>
	<li>2543</li>
	<li>2242</li>
	<li>3350</li>
</ol>




```R
nipred30<-4
muestraipred30<- sample(1:nrow(edad[edad$facultad=='IPRED',]),size=nipred30,replace=FALSE)
muestraipred30
```


<ol class=list-inline>
	<li>2703</li>
	<li>1943</li>
	<li>1089</li>
	<li>1616</li>
</ol>




```R
nsalud30<-3
muestrasalud30<- sample(1:nrow(edad[edad$facultad=='SALUD',]),size=nsalud30,replace=FALSE)
muestrasalud30
```


<ol class=list-inline>
	<li>1821</li>
	<li>863</li>
	<li>261</li>
</ol>



Construyamos un vector que nos permita seleccionar la muestra:


```R
mestrato30<-c(muestrahumanas30,muestracedeuis30,muestraciencias30,muestramecanicas30,muestraquimicas30,muestraipred30,muestrasalud30)
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


![png](output_55_0.png)


* ¿Qué diferencias observamos?
* ¿A qué se deberán estas diferencias?
* ¿Cambiará en algo si ampliamos la muestra?

## Muestreo Sistemático

El muestro sistemático consiste en tomar alestoriamente un cierto númoer _i_ de las primeras _k_ unidades que designara en una lista o población de _N_ elementos al primero que va a formar parte de la muestra.

Luego, de manera casi rígida o sistemática, se va tomando el elemento _i+k_ que está _k_ lugares del i-ésimo en la lista; el _i+2k_ que está a _2k_ lugares y así sucesivamente hasta que se agoten los elementos disponibles en la lista


```R
library(SamplingUtil) # librería empleada para muestreo sistemático:
```


```R
# construyamos una muestra sistemática de tamaño 30:
msis30<- sys.sample(N=nrow(edad),n=30)
msis30
```


<ol class=list-inline>
	<li>296</li>
	<li>1097</li>
	<li>1898</li>
	<li>2699</li>
	<li>3500</li>
	<li>4301</li>
	<li>5102</li>
	<li>5903</li>
	<li>6704</li>
	<li>7505</li>
	<li>8306</li>
	<li>9107</li>
	<li>9908</li>
	<li>10709</li>
	<li>11510</li>
	<li>12311</li>
	<li>13112</li>
	<li>13913</li>
	<li>14714</li>
	<li>15515</li>
	<li>16316</li>
	<li>17117</li>
	<li>17918</li>
	<li>18719</li>
	<li>19520</li>
	<li>20321</li>
	<li>21122</li>
	<li>21923</li>
	<li>22724</li>
	<li>23525</li>
</ol>




```R
# construyamos una muestra sistemática de tamaño 200:
msis200<- sys.sample(N=nrow(edad),n=200)
head(msis200,10);tail(msis200,10)
```


<ol class=list-inline>
	<li>58</li>
	<li>178</li>
	<li>298</li>
	<li>418</li>
	<li>538</li>
	<li>658</li>
	<li>778</li>
	<li>898</li>
	<li>1018</li>
	<li>1138</li>
</ol>




<ol class=list-inline>
	<li>22858</li>
	<li>22978</li>
	<li>23098</li>
	<li>23218</li>
	<li>23338</li>
	<li>23458</li>
	<li>23578</li>
	<li>23698</li>
	<li>23818</li>
	<li>23938</li>
</ol>




```R
# construyamos una muestra sistemática de tamaño 500:
msis500<- sys.sample(N=nrow(edad),n=500)
head(msis500,10);tail(msis500,10)
```


<ol class=list-inline>
	<li>23</li>
	<li>71</li>
	<li>119</li>
	<li>167</li>
	<li>215</li>
	<li>263</li>
	<li>311</li>
	<li>359</li>
	<li>407</li>
	<li>455</li>
</ol>




<ol class=list-inline>
	<li>23543</li>
	<li>23591</li>
	<li>23639</li>
	<li>23687</li>
	<li>23735</li>
	<li>23783</li>
	<li>23831</li>
	<li>23879</li>
	<li>23927</li>
	<li>23975</li>
</ol>




```R
# Ahora extraemos la muestra:
m30sis<- edad[msis30, ]
head(m30sis)
```


<table>
<thead><tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr></thead>
<tbody>
	<tr><th scope=row>296</th><td>2178774    </td><td>31         </td><td>F.QUÍMICAS </td></tr>
	<tr><th scope=row>1097</th><td>2188584    </td><td>35         </td><td>F.QUÍMICAS </td></tr>
	<tr><th scope=row>1898</th><td>2188465    </td><td>37         </td><td>F.MECÁNICAS</td></tr>
	<tr><th scope=row>2699</th><td>2187583    </td><td>21         </td><td>IPRED      </td></tr>
	<tr><th scope=row>3500</th><td>2187523    </td><td>23         </td><td>IPRED      </td></tr>
	<tr><th scope=row>4301</th><td>2186291    </td><td>44         </td><td>IPRED      </td></tr>
</tbody>
</table>




```R
m200sis<- edad[msis200, ]
head(m200sis)
```


<table>
<thead><tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr></thead>
<tbody>
	<tr><th scope=row>58</th><td>2169097    </td><td>26         </td><td>F.MECÁNICAS</td></tr>
	<tr><th scope=row>178</th><td>2188805    </td><td>25         </td><td>F.MECÁNICAS</td></tr>
	<tr><th scope=row>298</th><td>2178119    </td><td>32         </td><td>CIENCIAS   </td></tr>
	<tr><th scope=row>418</th><td>2188812    </td><td>45         </td><td>F.MECÁNICAS</td></tr>
	<tr><th scope=row>538</th><td>2188058    </td><td>32         </td><td>F.MECÁNICAS</td></tr>
	<tr><th scope=row>658</th><td>2087747    </td><td>33         </td><td>F.MECÁNICAS</td></tr>
</tbody>
</table>




```R
m500sis<- edad[msis500, ]
head(m500sis)
```


<table>
<thead><tr><th></th><th scope=col>codigo</th><th scope=col>edad</th><th scope=col>facultad</th></tr></thead>
<tbody>
	<tr><th scope=row>23</th><td>2158775    </td><td>29         </td><td>CIENCIAS   </td></tr>
	<tr><th scope=row>71</th><td>2168300    </td><td>27         </td><td>F.MECÁNICAS</td></tr>
	<tr><th scope=row>119</th><td>2148687    </td><td>30         </td><td>F.MECÁNICAS</td></tr>
	<tr><th scope=row>167</th><td>2188192    </td><td>25         </td><td>CIENCIAS   </td></tr>
	<tr><th scope=row>215</th><td>2188274    </td><td>24         </td><td>F.MECÁNICAS</td></tr>
	<tr><th scope=row>263</th><td>2169111    </td><td>41         </td><td>CIENCIAS   </td></tr>
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
```


![png](output_65_0.png)



```R
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


## Ejercicio

En el siguiente enlace encontrará el script correspondiente al ejercicio propuesto en clase:
https://github.com/karlosmantilla/Muestreo/blob/master/Datos/Muestreo3.R
