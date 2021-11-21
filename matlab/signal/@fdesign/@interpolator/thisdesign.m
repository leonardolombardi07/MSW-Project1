function varargout = thisdesign(this, method, varargin)
%DESIGN   

%   Author(s): J. Schickler
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $  $Date: 2007/05/23 19:13:43 $

% Parse the inputs for the filterstructure for fir designs
if ~any(strcmpi(method,designmethods(this,'iir'))),
    [struct, varargin] = parsestruct(this, 'firinterp', method, varargin{:});
end

n = nargout;
if n == 0
    n = 1;
end

% Call the DESIGN method of the contained FDesign object.
if strcmpi(method, 'multisection')
    [varargout{1:n}] = design(this.CurrentFDesign, this.InterpolationFactor);
else
    [varargout{1:n}] = design(this.CurrentFDesign, method, varargin{:});
end

Hm = varargout{1};

% If the filter is not already in an interpolation object, use one.
if ~isa(Hm, 'mfilt.abstractmultirate')
    
    L = get(this, 'InterpolationFactor');
    
    % Get the coefficients from the filter.
    b = tf(Hm);
    
    % Scale the coefficients by the interpolation factor to compensate for
    % the gain of upsampling.
    b = b*L;
    
    % Cache the FMETHOD object handle.
    hfmethod = Hm.getfmethod;

    Hm = feval(['mfilt.' struct], L, b);
    Hm.setfmethod(hfmethod);
    
    varargout{1} = Hm;
end

% [EOF]
