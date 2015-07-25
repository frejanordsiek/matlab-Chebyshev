function p = nthcheby(n)
%NTHCHEBY returns the N'th Chebyshev polynomial as a polynomial.
% P = NTHCHEBY(N)
% Returns the N'th Chebyshev polynomial as a polynomial P. N must be a
% non-negative integer.
%
% References:
%   1)  WH Press et al. Numberical Recipes: The Art of Scientific
%       Computing. Cambridge University Press. 3rd Edition. 2007
%
%
%
% Copyright 2012 Freja Nordsiek
% 
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%     http://www.apache.org/licenses/LICENSE-2.0
% 
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.



% Handle the two special cases that don't need the recurrence relation
% (n = 0,1).

if n < 0
    error('N must be non-negative.');
elseif n == 0
    p = 1;
elseif n == 1
    p = [1 0];
else
    
    % The recurrence relationship must be used.
    %
    % T_n(x) = 2*x*T_(n-1)(x) - T_(n-2)(x)
    
    % Pre-allocate the polynomials for T_(i-2), T_(i-1), and T_i.
    
    p_minus2 = zeros(1,n+1);
    p_minus = p_minus2;
    p = p_minus;
    
    % Initially set T_(i-1) = 1 and T_i = x so that in the loop, they will
    % be back assigned one step and things will get going.

    p_minus(end) = 1;
    p(end-1) = 1;
    
    % Do each iteration of the recursion relation by setting T_(n-1) ->
    % T_(i-2), T_i -> T_(i-2) and calculate the new T_i
    
    for ii=2:n
        p_minus2 = p_minus;
        p_minus = p;
        p = [2*p_minus(2:end), 0] - p_minus2;
    end
    
end
