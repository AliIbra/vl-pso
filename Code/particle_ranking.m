function rankedPar = particle_ranking(nPop, particle)

par_rank = [];
for idx=1:nPop
    par_acc = particle(idx).Accuracy;
    par_rank = [par_rank; [idx, par_acc]];
end
rankedPar = sortrows(par_rank, 2);
end