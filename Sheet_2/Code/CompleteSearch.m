function [nOptimalSolutions] = CompleteSearch( a, b, c )
%COMPLETESEARCH
%   Search all configuration space for optimal solutions of the DDP
%   specified by sequences a, b, c in input.
%   Returns number of optimal solutions.

% Save memory
if max([a, b]) < 65535
    a = uint16(a);
    b = uint16(b);
end

nOptimalSolutions = 0;

permA = perms(a);
permB = perms(b);

nA = size(permA,1);
nB = size(permB,1);

h = waitbar(0, 'Please wait...');
for aa = 1:nA
    
    tic
    currentA = permA(aa,:);
    
    parfor bb = 1:nB
        if isequal(c,DigestAB(currentA,permB(bb,:)));
            nOptimalSolutions = nOptimalSolutions + 1;
        end
    end
    waitbar(aa/nA, h);
    toc
end
close(h);



toc

end