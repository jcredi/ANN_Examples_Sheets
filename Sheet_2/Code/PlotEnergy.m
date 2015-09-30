function [f1, f2, f3, which] = PlotEnergy(solutions)
%PLOTENERGY

% randomly pick 3 chains
which = randi(length(solutions),[1 2]);
which = sort(which);

% if moving average
span = 5000;

smooth1 = smooth(solutions(which(1)).energy, span);
smooth2 = smooth(solutions(which(2)).energy, span);
smooth3 = smooth(solutions(which(3)).energy, span);

figure('units','normalized','outerposition',[0 0 1 1]);
f1 = plot(smooth1, 'LineWidth', 2);
hold on
f2 = plot(smooth2, 'LineWidth', 2);
f3 = plot(smooth3, 'LineWidth', 2);
hold off

% if all data points
% figure('units','normalized','outerposition',[0 0 1 1]);
% f1 = plot(solutions(which(1)).energy, 'LineWidth', 1.5);
% hold on
% f2 = plot(solutions(which(2)).energy, 'LineWidth', 1.5);
% f3 = plot(solutions(which(3)).energy, 'LineWidth', 1.5);
% hold off

set(gcf,'color','w');
set(gca,'fontsize', 28);

xlabel('Iteration');
ylabel('Energy');
pbaspect([1.618 1 1]);

for k = 1:3
    if solutions(which(k)).isOptimal
        converged{k} = ' (optimal found)';
    else
        converged{k} = ' (optimal not found)';
    end
end

str1 = ['Run ',num2str(which(1)), converged{1}];
str2 = ['Run ',num2str(which(2)), converged{2}];
str3 = ['Run ',num2str(which(3)), converged{3}];

legend([f1, f2, f3], str1, str2, str3);

end