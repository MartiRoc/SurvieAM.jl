module SurvieAM

using DataFrames

function f(x,y)

    x+y
    
end

df_test = DataFrame(
    duree = [8,8,13,18,23,52,63,63,70,76,180,195,210,220,365,632,700,852,1296,1296,1328,1460,1976,1990,2240],
    statut = [repeat([1],14);[0,1,1,0,1];repeat([0],6)],
    traitement = [1,1,2,2,2,1,1,1,2,2,2,2,2,1,1,2,2,1,2,1,1,1,1,2,2],
    fonction = [["A", "N"];repeat(["A"],6);repeat(["N"],17)]
)

export f, df_test

end
