
library(samplingbook) # llamamos la librería

# calculamos la muestra con el 10%
sample.size.mean(e=2.3, S=5.7, level = 0.95)

# Y, ahora, con el 5%:
sample.size.mean(e=1.15, S=5.7, level = 0.95)

# Para el 10%
sample.size.prop(e=0.1, level = 0.95)

# Para el 5%
sample.size.prop(e=0.05, level = 0.95)

# Para el 10%
sample.size.mean(e=2.3, S=5.7, level = 0.95, N = 24040)

# Para el 5%
sample.size.mean(e=1.15, S=5.7, level = 0.95, N = 24040)

# Para el 10%
sample.size.prop(e=0.1, P = 0.5, N = 24040, level = 0.95)

# Para el 5%
sample.size.prop(e=0.05, P = 0.5, N = 24040, level = 0.95)
