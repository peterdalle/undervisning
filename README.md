# Undervisning

Diverse skript jag använder till undervisning och utbildning i statistisk, surveyundersökningar, slumpmässigt urval, sannolikhetsteori såsom centrala gränsvärdessatsen, power-beräkningar, Monte Carlo-simuleringar med mera.

Notera att Monte Carlo-simuleringar håller på att flyttas över till <https://github.com/peterdalle/sim>.

Just nu finns här R-skript för att visualisera:

* Simpsons paradox
* Anscombes kvartett
* Datasaurus, storebror till Anscombes kvartetts
* Simulering av tärningens väntevärde
* Simulering av Pearsons r och p-värden
* Felmarginal vid olika urvalsstorlekar (för exempelvis surveyundersökningar)
* Simulering av p-värde vid olika effektstorlekar och sampelstorlekar
* Simulering av power vid olika sampelstorlekar

## [Simpsons paradox](https://github.com/peterdalle/undervisning/blob/master/simpsons-paradox.r)
GIF-animation av [Simpsons paradox](https://plato.stanford.edu/entries/paradox-simpson/).

<img src="https://github.com/peterdalle/undervisning/blob/master/simpsons-paradox.gif" alt="Simpsons paradox" width="500">

## [Anscombes kvartett](https://github.com/peterdalle/undervisning/blob/master/anscombe-quartet.r)
Visualiserar [Anscombes kvartett](https://en.wikipedia.org/wiki/Anscombe%27s_quartet) för data som har samma medelvärde, standardavvikelse och korrelation, men ändå ser olika ut.

<img src="https://github.com/peterdalle/undervisning/blob/master/anscombe.png" alt="Anscombes kvartett" width="500">

## [Datasaurus](https://github.com/stephlocke/datasauRus)
En uppgradering av Anscombes kvartett som visar ännu mer extrema visualiseringar, men som ändå har samma medelvärden med mera.

<img src="https://github.com/peterdalle/undervisning/blob/master/datasaurus.gif" alt="Anscombes kvartett" width="500">

## [Felmarginal vid olika urvalsstorlekar](https://github.com/peterdalle/undervisning/blob/master/felmarginal.r)
Visualiserar felmarginalen vid olika urvalsstorlekar vid en viss proportion (exempelvis 50 %) för ett slumpmässigt urval.

<img src="https://github.com/peterdalle/undervisning/blob/master/felmarginal.png" alt="Felmarginal" width="500">

Se också blogginlägget [Hur stor blir felmarginalen vid en viss urvalsstorlek?](http://www.backendmedia.se/2015/02/10/felmarginal/) för mer information.

## [Simulering av tärningens väntevärde](https://github.com/peterdalle/undervisning/blob/master/dice-expected-value.r)
Simulering av 500 tärningskast för att nå tärningens [väntevärde](https://sv.wikipedia.org/wiki/V%C3%A4ntev%C3%A4rde). En illustration av [de stora talens lag](https://sv.wikipedia.org/wiki/De_stora_talens_lag).

<img src="https://github.com/peterdalle/undervisning/blob/master/vantevarde.png" alt="Väntevärde" width="500">

## [Simulering av Pearsons r och p-värden](https://github.com/peterdalle/undervisning/blob/master/pearson-r-p-simulation.r)
Simulering av Pearson r och motsvarande p-värden hos slumpmässig data med ökande sampelstorlek. Ger en liten insikt i vad man kan förvänta för korrelation när datan är helt slumpmässig (och när man bör tolka signifikanta p med försiktighet).

<img src="https://github.com/peterdalle/undervisning/blob/master/pearson-r-p-simulation.png" alt="Simulation Pearson r och p-värden" width="500">

## [Simulering av p-värde vid olika effektstorlekar och sampelstorlekar](https://github.com/peterdalle/undervisning/blob/master/simulation-p-values.r)

Simulering av p-värden vid olika effektstorlekar (Cohens d) samt vid olika sampelstorlekar. Användbart för att se hur sampelstorleken liksom effektstorleken påverkar p-värdet (och andelen p < 0.05), vilket är ett sätt att visa vilken power man kan förvänta sig.

<img src="https://github.com/peterdalle/undervisning/blob/master/p-effektstorlek.png" alt="P-värde vid olika effektstorlekar" width="500">

<img src="https://github.com/peterdalle/undervisning/blob/master/p-sampelstorlek.png" alt="P-värde vid olika sampelstorlekar" width="500">

## [Simulering av power vid olika sampelstorlekar](https://github.com/peterdalle/undervisning/blob/master/power-analysis.r)

Simulering av power vid olika sampelstorlekar, medelvärden och varians. Användbart när man ska planera experiment eller dylikt. Ska göra om medelvärdesskillnader till effektstorlekar någon gång i framtiden för att efterlikna Cohen (1988).

<img src="https://github.com/peterdalle/undervisning/blob/master/power.png" alt="Power vid olika sampelstorlekar" width="500">

## Mer

- [Statistiska tester i R](https://github.com/peterdalle/reg) såsom korrelation, regression, variansanalys m.m.
- [Datamängder på nätet att ladda ned](https://peterdalle.github.io/dataset.html).

## Viktiga koncept inom statistiken

- https://en.wikipedia.org/wiki/Central_limit_theorem
- https://en.wikipedia.org/wiki/Law_of_large_numbers
- https://en.wikipedia.org/wiki/Expected_value
- https://en.wikipedia.org/wiki/Regression_toward_the_mean
- https://en.wikipedia.org/wiki/Law_of_averages
- https://sv.wikipedia.org/wiki/Monte_Carlo-metod
- https://en.wikipedia.org/wiki/Statistical_power
- https://en.wikipedia.org/wiki/Infinite_monkey_theorem

Förslag på hur dessa kan visualiseras tas tacksamt emot! [@peterdalle](https://twitter.com/peterdalle)
