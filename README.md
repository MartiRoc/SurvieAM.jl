# SurvieAM

## Installation:

### 1-ère Méthode par le RPEL uniquement

Taper "]" puis *Entrée* dans le RPEL de Julia (julia>) pour accéder au package manager mode du RPEL (>pkg), taper ensuite :

`add "https://github.com/MartiRoc/SurvieAM.jl.git"`

Cela va ajouter le package à l'environnement de travail et le précompiler (cela peut prendre quelques minutes). Attention ce n'est pas tout à fait l'adresse de ce dépôt, ne pas oublier le ".git" à la fin. Sortir ensuite du package manager mode (*Ctrl + C* sur windows, ou *Backspace* devant >pkg). Taper ensuite dans le RPEL de Julia, 

`using SurvieAM`

puis *Entrée*. Le package et les fonctions qu'il contient sont maintenant disponibles.

### 2-ième Méthode en utilisant Pkg.jl

Dans un script ou dans le RPEL de Julia, resp. insérer ou enchainer les instructions suivantes : 

`using Pkg` \
`Pkg.add(url = "https://github.com/MartiRoc/SurvieAM.jl.git")` \
`using SurvieAM`

Comme pour la 1-ère méthode, les deux premières instructions servent à ajouter à l'environnement de travail le package et le précompiler, cela peut prendre quelques minutes. 

### Remarque

Une fois que le package a été ajouté à l'environnement de travail, seule l'instruction `using SurvieAM` est nécessaire pour commencer à l'utiliser dans cet environnement. 
