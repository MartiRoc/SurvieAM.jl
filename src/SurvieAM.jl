module SurvieAM

using Pkg
Pkg.add("DataFrames")
Pkg.add("Plots")

using DataFrames
using Plots

include("Fonctions.jl")

export df_test
export KM
export Log_Rank

end
