# Resources

## How-to kNN
https://towardsdatascience.com/implementing-knn-from-scratch-70c800f6f64b

Essensen:
- For hver observasjon:
  - Iterer gjennom egenskapene i treningssettet og regn ut differansen mellom observasjon og trening
    - Kan tenkes at vi for 4 egenskaper tar differansen mellom obs og trening for hver av de 4 egenskapene, og summerer differansene
  - Identifiser de k nærmeste trenings-dataene
    - De k treningsdataene som har minst differanse-sum
  - Blant de k nærmeste, hvilken sjanger er representert mest -> dette er det vi klassifiserer observasjonen som
