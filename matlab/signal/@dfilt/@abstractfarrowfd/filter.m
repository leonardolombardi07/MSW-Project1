function y = filter(this,x,dim)
%FILTER   

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2007/12/14 15:06:49 $

error(nargchk(1,3,nargin,'struct'));

if nargin<2, x = []; end
if nargin<3, dim=[]; end

if isempty(x), 
  y = x;
  return; 
end

s = size(x);
[x,perm,nshifts] = shiftdata(x,dim);
s_shift = size(x); % New size
x = reshape(x,size(x,1),[]); % Force into 2-D

% At this point, x is a 2-D matrix and we always filter along the columns
[Mx,Nx] = size(x);
if log2(Mx*Nx)>31, 
    error(generatemsgid('InvalidInput'), 'The input of the filter must contain at most 2^31 elements.');
end

nchannels = this.nchannels;

if ~this.PersistentMemory,
    % Reset the filter
    reset(this);
else
	if ~isempty(nchannels) && Nx ~= nchannels
		error(generatemsgid('InvalidDimensions'),'The number of channels cannot change when ''PersistentMemory'' is ''true''.');
	end
end

% Set number of channels
this.nchannels = Nx;

zi = this.HiddenStates;
% Expand the states for the multichannel case
zi = ziexpand(this,x,zi);

[y,zf] = secfilter(this,x,this.privfracdelay,zi);
this.NumSamplesProcessed = this.NumSamplesProcessed+Mx*Nx;

this.HiddenStates = zf;

if isempty(dim),
    dim = find(s>1,1,'first');
    if isempty(dim), dim = 1; end
end
ly = size(y,1);
s(dim) = ly;
s_shift(1) = ly;
y = reshape(y,s_shift); % Back to N-D array
y = unshiftdata(y,perm,nshifts);

y = reshape(y,s);

% [EOF]
