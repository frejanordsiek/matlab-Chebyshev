function f = chebyval(ch,x)
%CHEBYVAL evaluates a Chebyshev series at one or more points.
% F = CHEBYVAL(CH,X)
% Evaluates the Chebyshev series CH at the values in X and returns them in
% F.
%
% Equivalent to polyval.
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

% It will be easier to work with x in the form of a column vector.

X = reshape(x,numel(x),1);

% The recursion relation is
%
% d_j = 2x*d_(j+1) - d_(j+2) + c_j
%
% for j = m-1, m-2, ... , 1 with d_(m+1) = d_m = 0 and the final step is
%
% f = x*d_1 - d_2 + c_0 / 2
%
% We need vectors to hold d_j, d_(j+1), and d_(j+2).

d = zeros(numel(X),1);
d_plus1 = d;
d_plus2 = d;

% Do the recursion relationship all the way to j=1.

for ii=(numel(ch)-1):-1:1
    d_plus2 = d_plus1;
    d_plus1 = d;
    d = 2*X.*d_plus1 - d_plus2 + ch(ii+1);
end

% The final step is just f = x*d_1 - d_2 + c_0 / 2 with d as d_1 and
% d_plus1 as d_2.

f = X.*d - d_plus1 + 0.5*ch(1);

% Reshape the output to have the original shape of the input.

f = reshape(f,size(x));
