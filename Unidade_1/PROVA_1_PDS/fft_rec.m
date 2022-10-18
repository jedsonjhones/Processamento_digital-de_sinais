function y = fft_rec(x)
    N = length(x);
    Wn = exp(-2*pi*1i/N).^(0:N/2-1);
    
    if N == 16
        y = DFT_1loop(x);
%         y = x*[1 1;1 -1];
    else
        Gk = fft_rec(x(1:2:(N-1)));
        
        Hk = fft_rec(x(2:2:N));
        
        y = [ Gk + Wn .* Hk , Gk - Wn .* Hk ];
    end
end

%% Reference
% Wörner, Stefan. “Fast Fourier Transform Numerical Analysis Seminar.” (2008).
% https://pdfs.semanticscholar.org/e037/fa9e0c007acd637a68abcfd6b61ff0d7b1b2.pdf?_ga=2.101236865.1683294949.1597843230-241693516.1576712658