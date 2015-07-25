function p = cheby2poly(ch)
%CHEBY2POLY returns a Chebyshev series as a polynomial.
% P = CHEBY2POLY(CH)
% Returns the Chebyshev series CH as a single polynomial in P.
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

% Get the polynomials for all chebyshev polynomials up to the order of the
% series.

ps = nchebs(numel(ch)-1);

% Due to the way the chebyshev series is generated, the coefficient of the
% first row of ps (corresponding to T_0) is ch(1)/2. To make the final step
% easier, that element will be divided in place.

ch(1) = 0.5*ch(1);

% Multiply each row of ps by the appropriate coefficient (the i'th entry of
% ch is for the i'th row of ps) and sum over rows to get p.

p = sum(repmat(reshape(ch,numel(ch),1),1,numel(ch)).*ps);
