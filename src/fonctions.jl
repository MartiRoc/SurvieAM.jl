##################################### Données fictives

df_test = DataFrame(
    duree = [8,8,13,18,23,52,63,63,70,76,180,195,210,220,365,632,700,852,1296,1296,1328,1460,1976,1990,2240],
    statut = [repeat([1],14);[0,1,1,0,1];repeat([0],6)],
    traitement = [1,1,2,2,2,1,1,1,2,2,2,2,2,1,1,2,2,1,2,1,1,1,1,2,2],
    fonction = [["A", "N"];repeat(["A"],6);repeat(["N"],17)]
)

##################################### Estimateur de kaplan-Meier

function KM(time, status, group = nothing)
    
    data = DataFrame(duree = time, statut = status, groupe = group)
    sort!(data, :duree)

    if isnothing(group)
        S_KM = [1.0]  # va contenir les estimations aux temps t_i (t_0 OK car = 1)
        i = 1  # incrément des temps
        temps = unique(data.duree)  # t_1, t_2, ..., t_n
        N = length(data.duree)  # total d'individus

        # boucle sur les temps
        for j in 1:length(temps)
            # nb de décès à t_i
            d_j = length(data[(data.duree .== temps[j]) .& (data.statut .== 1), 1])
            # nb d'ind à risque juste avant t_i
            R_j = N - length(data[(data.duree .< temps[j]), 1])
            # S_KM(t_i) par récurrence
            push!(S_KM, (1 - (d_j / R_j)) * S_KM[j])
        end

        temps = [0; temps]
        return df_resultat = DataFrame(temps=temps, S_KM=S_KM)

    else 
        facteurs = unique(data.groupe)
        n = length(facteurs)
        resultats = []


        for j in facteurs
            data_temp = data[data.groupe .== j, : ]
            S_KM_j = KM(data_temp.duree, data_temp.statut)
            resultats = [resultats ; [S_KM_j]]
        end

        symbols_tuple_sortie = Tuple(Symbol.(collect('a':'a'+(n-1))))
        res = NamedTuple{symbols_tuple_sortie}(resultats)
        println("\nTuple de sortie $symbols_tuple_sortie <--> groupes $facteurs \n")

        return res

    end

end

##################################### Test du Log_Rank

function Log_Rank(times, status, group, approx_pval = 1000000)
    data = DataFrame(duree = times, statut = status, groupes = group)
    sort!(data, :duree)
    
    g1 = unique(data.groupes)[1]  
    g2 = unique(data.groupes)[2]  

    R_i_1 = length(data[data.groupes .== g1, 1])  # nb sujets à risque au temps 0 grp1
    R_i_2 = length(data[data.groupes .== g2, 1])  # nb sujets à risque au temps 0 grp2
    T_i = unique(data.duree)  # toutes les durées d’intérêt groupes confondus
    U = []  # partie de la statistique de test (numérateur)
    V = []  # partie de la statistique de test (dénominateur)

    for i in 1:length(T_i)
        ##### Grandeurs groupe 2 #####
        
        # décès au temps i
        d_i_2 = length(data[(data.duree .== T_i[i]) .& (data.groupes .== g2) .& (data.statut .== 1), 1])
        # censures au temps i
        c_i_2 = length(data[(data.duree .== T_i[i]) .& (data.groupes .== g2) .& (data.statut .== 0), 1])
        
        ##### Grandeurs groupe 1 #####
        
        # décès au temps i
        d_i_1 = length(data[(data.duree .== T_i[i]) .& (data.groupes .== g1) .& (data.statut .== 1), 1])
        # censures au temps i 
        c_i_1 = length(data[(data.duree .== T_i[i]) .& (data.groupes .== g1) .& (data.statut .== 0), 1])
        # décès attendus au temps i
        e_i_1 = (R_i_1 / (R_i_1 + R_i_2)) * (d_i_1 + d_i_2)
        
        ##### Pour la statistique de test #####
        
        # Pour le numérateur de la statistique de test
        push!(U, d_i_1 - e_i_1)
        # Pour le dénominateur de la statistique de test
        d_i = d_i_1 + d_i_2
        R_i = R_i_1 + R_i_2
        push!(V, d_i * ((R_i - d_i) / (R_i - 1)) * ((R_i_1 * R_i_2) / (R_i^2)))
        
        ##### Actualisation des sujets exposés au risque #####
        R_i_1 -= d_i_1 + c_i_1
        R_i_2 -= d_i_2 + c_i_2
    end

    ##### Statistique de test #####
    U = sum(U)
    V = filter(!isnan, V)
    V = sum(V)
    stat_T = (U^2) / V

    ##### p-valeur #####
    # Approximation CCDF de Chi2_1 : pval = P(chi2_1 > stat_T)
    pval = sum((randn(approx_pval).^2) .> stat_T)/approx_pval

    ##### Résultat #####

    res = NamedTuple{(:T, :pval)}([stat_T, pval])

    return res

end
