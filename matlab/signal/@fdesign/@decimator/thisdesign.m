function varargout = thisdesign(this, method, varargin)
%DESIGN   

%   Author(s): J. Schickler
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $  $Date: 2007/05/23 19:13:39 $

% Parse the inputs for the filterstructure for fir designs
if ~any(strcmpi(method,designmethods(this,'iir'))),
    [struct, varargin] = parsestruct(this, 'firdecim', method, varargin{:});
end

n = nargout;
if n == 0
    n = 1;
end

% Call the DESIGN method of the contained FDesign object.
if strcmpi(method, 'multisection')
    [varargout{1:n}] = design(this.CurrentFDesign, 'multisection', this.DecimationFactor);
else
    [varargout{1:n}] = design(this.CurrentFDesign, method, varargin{:});
end

Hm = varargout{1};

% If the filter is not already in an interpolation object, use one.
if ~isa(Hm, 'mfilt.abstractmultirate')
    
    M = get(this, 'DecimationFactor');
    
    % Get the coefficients from the filter.
    b = tf(Hm);
    
    % Cache the FMETHOD object handle.
    hfmethod = Hm.getfmethod;

    Hm = feval(['mfilt.' struct], M, b);
    Hm.setfmethod(hfmethod);
    
    varargout{1} = Hm;
end

% [EOF]
