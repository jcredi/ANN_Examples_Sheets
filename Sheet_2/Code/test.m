for i = 1:length(solutions)
    plot(solutions(i).energy);
    ylim([0 1000]);
    pause
end  
close all