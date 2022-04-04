# Resources

## How-to kNN
https://towardsdatascience.com/implementing-knn-from-scratch-70c800f6f64b

Essensen:
- For hver observasjon:
  - Iterer gjennom egenskapene i treningssettet og regn ut differansen mellom observasjon og trening
    - Kan tenkes at vi for 4 egenskaper tar differansen mellom obs og trening for hver av de 4 egenskapene, og summerer differansene
  - Identifiser de k nærmeste trenings-dataene
    - De k treningsdataene som har minst differanse-sum
    - Lag en funksjon som søker og returner IDene til de k nærmeste treningsdataene
  - Blant de k nærmeste, hvilken sjanger er representert mest -> dette er det vi klassifiserer observasjonen som
    - Let opp IDene sin sjanger og bestem hvilken som er representert mest = klassifisert

Lagre hvilken observasjon vi har sett på (ID) og hvilken sjanger den ble tildelt. Sammenlign så dette med hvilken sjanger observasjonen faktisk hadde og lag en confusion matrix av dette.

*NB!* Det finnes on confusion-funksjon i Matlab fra før så dette må vi ikke lage selv. Trenger da en liste med det vi har klassifisert, og en liste med fasiten.
