%% Turns a matrix in to latex code for a table.

plusMinus=['$\pm$';'$\pm$';'$\pm$';'$\pm$';'$\pm$';'$\pm$';'$\pm$';'$\pm$'];
and=[' & ';' & ';' & ';' & ';' & ';' & ';' & ';' & '];
hLine=[' \\ \hline';' \\ \hline';' \\ \hline';' \\ \hline';' \\ \hline';' \\ \hline';' \\ \hline';' \\ \hline'];
betaLine=['$\beta=0.$';'$\beta=0$.';'$\beta=0.$';'$\beta=0.$';'$\beta=0.$';'$\beta=0.$';'$\beta=0.$';'$\beta=0.$'];
stdMatrix = sem_500';
orderMean = m_all_mean_500';
nyMatris=[betaLine and];
for i=1:6
    disp('1')
    nyMatris=[nyMatris num2str(orderMean(:,i),3) plusMinus num2str(stdMatrix(:,i),3) and];
end
disp('2')

nyMatris=[nyMatris hLine];
