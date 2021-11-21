function varargout = iirlinphase(this,varargin)
%IIRLINPHASE   

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2009/12/28 04:35:22 $

validate_iir_designmethod(this,'IIR linear phase')

try
    [varargout{1:nargout}] = privdesigngateway(this, 'iirlinphase', ...
        'DesignMode','Interpolator',varargin{:});
catch e
    error(e.identifier,cleanerrormsg(e.message));
end



% [EOF]
