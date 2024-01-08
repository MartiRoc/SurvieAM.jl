# SurvieAM

## Description

Package élaboré dans le cadre de l'UE Optimisation-Julia-Python du M2 SSD de l'Université Grenoble-Alpes. Il a pour but l'analyse de survie et contient :

- *KM(time::Vector{}, status::Vector{}, group::Vector{} = nothing)* : qui calcule l'estimateur de Kaplan-Meier de la fonction de survie.

  En entrée, *time* encode les temps de survie, *status* indique la censure ou non du temps de survie (0 → censure, 1 → non-censure) et *group* est un argument facultatif qui encode l'appartenance à des groupes des arguments précédents. Dans le cas où ce dernier argument est renseigné la fonction calcule autant d'estimateurs de Kaplan-Meier qu'il y a de facteurs (groupes) dans le vecteur *group*. Tous les arguments (le facultatif s'il est renseigné) doivent posséder la même dimension.

  En sortie on obtient une DataFrame à deux colonnes *temps* & *S_KM*. Si des groupes sont renseignés dans la variable *group* la fonction retourne un tuple nommé : .a, .b, .c, ... , où chaque élément est une DataFrame *temps* & *S_KM* pour chacun des facteurs de la variable *group* (l'équivalence .a, .b, ... <--> facteur1, facteur2, ... est affichée à l'appel de la fonction).

- *Log_Rank(times, status, group, approx_pval = 1000000)* : qui réalise le test du Log-Rank (Mantel-Haenszel test → sans pondération).

  En entrée, *times*, *status* et *group* sont équivalents aux arguments à renseigner pour la fonction *KM* ci-dessus. Cependant, cette fois *group* est un argument obligatoire et doit être binaire. La dernière variable *approx-pval* est liée à l'approximation réalisée par la fonction dans le calcul de la p-valeur. En effet $p_{val} = \mathbb{P}(T> \\Chi_{2})$

## Installation:

### 1-ère Méthode par le RPEL uniquement

Taper "]" puis *Entrée* dans le RPEL de Julia (julia>) pour accéder au package manager mode du RPEL (>pkg), taper ensuite :

`add "https://github.com/MartiRoc/SurvieAM.jl.git"`

Cela va ajouter le package à l'environnement de travail et le précompiler. Attention ce n'est pas tout à fait l'adresse de ce dépôt, ne pas oublier le ".git" à la fin. Sortir ensuite du package manager mode (*Ctrl + C* sur windows, ou *Backspace* devant >pkg). Taper ensuite dans le RPEL de Julia, 

`using SurvieAM`

puis *Entrée*. Le package et les fonctions qu'il contient sont maintenant disponibles.

### 2-ième Méthode en utilisant Pkg.jl

Dans un script ou dans le RPEL de Julia, resp. insérer ou enchainer les instructions suivantes : 

`using Pkg` \
`Pkg.add(url = "https://github.com/MartiRoc/SurvieAM.jl.git")` \
`using SurvieAM`

Comme pour la 1-ère méthode, les deux premières instructions servent à ajouter à l'environnement de travail le package et le précompiler. 
