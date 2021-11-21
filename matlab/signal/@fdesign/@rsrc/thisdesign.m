function varargout = thisdesign(this, method, varargin)
%DESIGN   

%   Author(s): J. Schickler
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.8 $  $Date: 2007/12/14 15:11:39 $

validatercf(this);

% Parse the inputs for the filterstructure.
[struct, varargin] = parsestruct(this, 'firsrc', method, varargin{:});

n = nargout;
if n == 0
    n = 1;
end

% Call the DESIGN method of the contained FDesign object.
[varargout{1:n}] = design(this.CurrentFDesign,method, varargin{:});

Hm = varargout{1};

% If the filter is not already in an interpolation object, use one.
if ~isa(Hm, 'mfilt.abstractmultirate')
    
    L = get(this, 'InterpolationFactor');
    M = get(this, 'DecimationFactor');
    
    % Get the coefficients from the filter.
    b = tf(Hm);  
    
    % Scale the coefficients by the interpolation factor to compensate for
    % the gain of upsampling.
    b = b*L;
    
    % Cache the FMETHOD object handle.
    hfmethod = Hm.getfmethod;

    Hm = feval(['mfilt.' struct], L, M, b);
    Hm.setfmethod(hfmethod);
    
    varargout{1} = Hm;
end

% [EOF]
