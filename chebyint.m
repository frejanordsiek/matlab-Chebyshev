function chsInt = chebyint(chs,dim)
%CHEBYINT returns the indefinite integral of Chebyshev series as Chebyshev series.
% CHSINT = CHEBYINT(CHS,DIM)
% Takes the set of Chebyshev series CHS along direction DIM (if DIM is not
% specified, it is assumed to be along CHS if it is a vector and 1 if it
% is not a vector) and calculates the derivatives as Chebyshev series which
% are returned as CHSPRIME. Essentially, CHS is an array of Chebyshev
% series vectors in direction DIM. For a single Chebyshev series, CHS is
% just a vector.
%
% Equivalent to polyint.
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

% Set the coefficients as
%
% C_0 = 0
%
% C_i = (c_(i-1) - c_(i+1))/2i    for i > 0
%
% with c_m = 0

% Initialize the derivatives to zero. This automatically sets the 0'th
% coefficients to zero like they are supposed to be.

chsInt = zeros(size(chs));

% Find the other coefficients.

% Now do the 1 to m-2 coefficients.

for ii=1:(size(chs,dim)-2)
    indices{dim} = ii+1;
    indices2{dim} = ii;
    indices3{dim} = ii+2;
    chsInt(indices{:}) = (chs(indices2{:}) + chs(indices3{:}))/(2*ii);
end

% Do the m-1 coefficient.

indices{dim} = size(chs, dim);
indices2{dim} = size(chs, dim) - 1;
chsInt(indices{:}) = chs(indices2{:},:,:)/(2*(size(chs,dim)-1));
