function ps = nchebys(n)
%NCHEBYS returns the first N Chebyshev polynomials as polynomials.
% PS = NCHEBYS(N)
% Returns the first N Chebyshev polynomials as polynomials in PS where the
% first row is T_0, the second T_1, and so on. N must be a non-negative
% integer.
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
    ps = 1;
elseif n == 1
    ps = [0 1;1 0];
else
    
    % The recurrence relationship must be used.
    %
    % T_n(x) = 2*x*T_(n-1)(x) - T_(n-2)(x)
    
    % Pre-allocate ps for all n+1 polynomials.
    
    ps = zeros(n+1,n+1);
    
    % Set the first two polynomials T_0 = 1 and T_1 = x.
    
    ps(1,end) = 1;
    ps(2,end-1) = 1;
    
    % Do each iteration of the recursion relation.
    
    for ii=2:n
        ps(ii+1,:) = [2*ps(ii,2:end), 0] - ps(ii-1,:);
    end
    
end
