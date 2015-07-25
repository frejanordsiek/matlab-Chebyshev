function z = chebyzeros(n)
%CHEBYZEROS returns the zeros of the N'th Chebyshev polynomial.
% Z = CHEBYZEROS(N)
% Returns the zeros of the N'th Chebyshev polynomial in Z. N must be a
% non-negative integer.
%
% Equivalent to roots.
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

% z = cos(pi*(k+0.5)/n) for k=0,1, ... , n-1

if n < 0
    error('N must be non-negative.');
else
    z = cos(pi*((0:(n-1)) + 0.5)/n);
end
