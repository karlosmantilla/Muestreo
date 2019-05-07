
# TAMAÑO MUESTRAL

El tamaño sí importa, sobre todo cuando se requiere una precisión determinada para el cálculo de un parámetro poblacional.

Hasta el momento, hemos diseñado el muestreo con base en una tamaño muestral arbitario. Ahora nos corresponde determinar el tamaño adecuado de la muestra.

## Estimación de la Media

Para el cálculo del tamaño muestral es necesario fijar de antemano unos parámetros que dependen del tipo de estudio. En el caso de la estimación de una media, estos parámetros son la desviación típica de la respuesta ($\sigma$), la confianza ($1-\alpha$) y la semi-amplitud ($e$) del intervalo.

La fórmula es:

$$
n = \left(\frac{Z_{\alpha/2} \cdot \sigma}{e}\right)^{2}
$$

donde $Z_{\alpha/2}$ es el cuantil de la distribución normal estándar correspondiente (p.ej.: $Z_{\alpha/2} = 1.96$ para un nivel de confianza del $95\%$

Veamos el ejemplo de los estudiantes. Sabemos que la desviación estándar de la edad es $5.7$; con esto queremos calcular el tamaño adecuado y queremos que el error o la amplitud se del $10\%$ respecto a la media (sabemos que la media es 23 años por lo que el $10\%$ equivale a $2.3$). Así, entonces, el tamaño de la muestra es:

$$
n = \left( \frac{1.96 \times 5.7}{2.3} \right)^{2} \approx 23.59425 \rightarrow 24
$$

Increible, ¿verdad? La muestra es bastante pequeña y confiamos en ella un $95\%$.

Ahora, queremos más precisión e igual confianza, entonces, reducimos el error $e = 5\% \equiv 1.15$

$$
n = \left( \frac{1.96 \times 5.7}{1.15} \right)^{2} \approx 94.37353277 \rightarrow 95
$$

En  R, podemos calcular el tamaño para la media usando la función `sample.size.mean` de la librería `samplingbook`. Recordemos que, si la librería no está instalada debemos hacerlo mediante la siguiente línea: `install.packages('samplingbook')`.


```R
library(samplingbook) # llamamos la librería
```

    Loading required package: pps
    Loading required package: sampling
    Loading required package: survey
    Loading required package: grid
    Loading required package: Matrix
    Loading required package: survival
    
    Attaching package: 'survival'
    
    The following objects are masked from 'package:sampling':
    
        cluster, strata
    
    
    Attaching package: 'survey'
    
    The following object is masked from 'package:graphics':
    
        dotchart
    
    


```R
# calculamos la muestra con el 10%
sample.size.mean(e=2.3, S=5.7, level = 0.95)
```


    
    sample.size.mean object: Sample size for mean estimate
    Without finite population correction: N=Inf, precision e=2.3 and standard deviation S=5.7
    
    Sample size needed: 24
    



```R
# Y, ahora, con el 5%:
sample.size.mean(e=1.15, S=5.7, level = 0.95)
```


    
    sample.size.mean object: Sample size for mean estimate
    Without finite population correction: N=Inf, precision e=1.15 and standard deviation S=5.7
    
    Sample size needed: 95
    


## Estimación de una Proporción

Para el cálculo del tamaño de una proporción la formula es similar:

$$
n = \left( \frac{Z_{\alpha/2}}{2 \cdot e} \right)^{2}
$$

Veamos cuál es el tamaño si quieremos un error de $10\%$:

$$
n = \left( \frac{1.96}{2 \cdot 0.1} \right)^{2} \approx 96.03647052 \rightarrow 97
$$

Y para un error de $5\%$:

$$
n = \left( \frac{1.96}{2 \cdot 0.05} \right)^{2} \approx 384.1458821 \rightarrow 385
$$

En  R, podemos calcular el tamaño para la media usando la función `sample.size.prop` de la librería `samplingbook`.


```R
# Para el 10%
sample.size.prop(e=0.1, level = 0.95)
```


    
    sample.size.prop object: Sample size for proportion estimate
    Without finite population correction: N=Inf, precision e=0.1 and expected proportion P=0.5
    
    Sample size needed: 97
    



```R
# Para el 5%
sample.size.prop(e=0.05, level = 0.95)
```


    
    sample.size.prop object: Sample size for proportion estimate
    Without finite population correction: N=Inf, precision e=0.05 and expected proportion P=0.5
    
    Sample size needed: 385
    


## Poblaciones Finitas

Hasta el momento no hemos hablado del tamaño de la población. Los cálculos se han basado en tamaño desconocido o poblaciones infinitas. La cosa cambia un poco cuando la población es finita, es decir, se puede contar facilmente.

En este caso, tenemos dos opciones: proporción de individuos y varianza de la población. En el primer caso, la fórmula es:

$$
n = \frac{Z_{\alpha/2}^{2} N p q}{ e^{e} (N-1) + Z_{\alpha/2}^{2} p q}
$$

Cuando el conocemos la varianza de la población, entonces, la fórmula es:

$$
n = \frac{Z_{\alpha/2}^{2} N \sigma^{2}}{ e^{e} (N-1) + Z_{\alpha/2}^{2} \sigma^{2}}
$$


Volvamos con el ejemplo de los estudiantes. Sabemos que el tamaño es $N = 24040$, la media de la edad es $\mu = 23$ y la desviación estándar es $\sigma = 5.7$.

Hagámoslo directamente en el software:


```R
# Para el 10%
sample.size.mean(e=2.3, S=5.7, level = 0.95, N = 24040)
```


    
    sample.size.mean object: Sample size for mean estimate
    With finite population correction: N=24040, precision e=2.3 and standard deviation S=5.7
    
    Sample size needed: 24
    



```R
# Para el 5%
sample.size.mean(e=1.15, S=5.7, level = 0.95, N = 24040)
```


    
    sample.size.mean object: Sample size for mean estimate
    With finite population correction: N=24040, precision e=1.15 and standard deviation S=5.7
    
    Sample size needed: 95
    


Notamos que el tamaño no cambia en ambos casos. Esto se debe a que, luego de cierto tamaño poblacional, el tamaño de la muestra no varía.

En el caso que no conociéramos la varianza, recurriríamos a la probabilidad que tienen los individuos de ser seleccionados. Por defecto, se emplea $p = 0.5$:


```R
# Para el 10%
sample.size.prop(e=0.1, P = 0.5, N = 24040, level = 0.95)
```


    
    sample.size.prop object: Sample size for proportion estimate
    With finite population correction: N=24040, precision e=0.1 and expected proportion P=0.5
    
    Sample size needed: 96
    



```R
# Para el 5%
sample.size.prop(e=0.05, P = 0.5, N = 24040, level = 0.95)
```


    
    sample.size.prop object: Sample size for proportion estimate
    With finite population correction: N=24040, precision e=0.05 and expected proportion P=0.5
    
    Sample size needed: 379
    


## Ejercicio

Con los datos trabajados en clase, calcule el tamaño de la muestra para diferentes errores y niveles de confianza y diseñe un nuevo muestreo
