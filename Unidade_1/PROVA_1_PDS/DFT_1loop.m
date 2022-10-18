function Y = DFT_1loop(x)
%   DFT implemented in a nested loop
    N = length(x);
    n =  (0:N-1)';
    Wn = exp(-j*2*pi/N*n); %#ok<*IJCL>
    for k = 0:(N-1)
        Y(k+1)  = x*(Wn.^k); %#ok<*AGROW>
    end
end

