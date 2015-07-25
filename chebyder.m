function chsPrime = chebyder(chs,dim)
%CHEBYDER returns the derivative of Chebyshev series as Chebyshev series.
% CHSPRIME = CHEBYDER(CHS,DIM)
% Takes the set of Chebyshev series CHS along direction DIM (if DIM is not
% specified, it is assumed to be along CHS if it is a vector and 1 if it
% is not a vector) and calculates the derivatives as Chebyshev series which
% are returned as CHSPRIME. Essentially, CHS is an array of Chebyshev
% series vectors in direction DIM. For a single Chebyshev series, CHS is
% just a vector.
%
% Equivalent to polyder.
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

if nargin == 1 || isempty(dim)
    dim = 1;
end

index = find(numel(chs) == size(chs), 1);
if ~isempty(index)
    dim = index;
end

if dim < 1 || dim > ndims(chs)
    error('DIM must be a positive integer not exceeding the dimensionality of CHS.');
end

% Since chs could have arbitrary dimensionality and dim any valid dimension
% for it, standard indexing can't be used. More generic indexing must be
% used. Suppose the matrix A is 2-dimensional. Another way to access the
% entire second row is
%
% B = {2, ':'};
% A(B{:})
%
% A cell array of ':' elements for each dimension will be used. Specific
% indexing will be just setting element dim.

indices = repmat({':'}, 1, ndims(chs));
indices2 = indices;
indices3 = indices;

% Initialize the derivatives to zero. This automatically sets the m-1
% coefficients to zero like they are supposed to be.

chsPrime = zeros(size(chs));

% Set the m-2 to 0 coefficients using the recursion relation
%
% c'_(i-1) = c'_(i+1) + 2*i*c_i      for i = m-1, m-2, ... , 0
%
% with c'_(m+1) = c'_m = 0

% The m-1 coefficients are already zero. Assign the m-2 coefficients.

indices{dim} = size(chs, dim) - 1;
indices2{dim} = size(chs, dim);
chsPrime(indices{:}) = 2*(size(chs,dim)-1)*chs(indices2{:});

% Now do the m-3 to 0 coefficients.

for ii=(size(chs,dim)-2):-1:1
    indices{dim} = ii;
    indices2{dim} = ii+2;
    indices3{dim} = ii+1;
    chsPrime(indices{:}) = chsPrime(indices2{:}) + 2*ii*chs(indices3{:});
end
