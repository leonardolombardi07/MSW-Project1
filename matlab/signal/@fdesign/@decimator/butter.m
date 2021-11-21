function varargout = butter(this, varargin)
%BUTTER   Butterworth IIR digital filter design.
%   H = BUTTER(D) Design a Butterworth IIR digital filter using the
%   specifications in the object D.
%
%   H = BUTTER(D, MATCH) Design a filter and match one band exactly.  MATCH
%   can be either 'passband' or 'stopband' (default).  This flag is only
%   used when designing minimum order Butterworth filters.

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2009/12/28 04:35:16 $

validate_iir_designmethod(this, 'Butterworth')

try
    [varargout{1:nargout}] = privdesigngateway(this, 'butter',...
        'DesignMode','Decimator',varargin{:});
catch e
    error(e.identifier,cleanerrormsg(e.message));
end

% [EOF]