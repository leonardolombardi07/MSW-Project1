function varargout = ellip(this, varargin)
%ELLIP   Elliptic or Cauer digital filter design.
%   H = ELLIP(D) Design an Elliptic digital filter using the specifications
%   in the object D.
%
%   H = ELLIP(D, MATCH) Design a filter and match one band exactly.  MATCH
%   can be either 'passband' 'stopband' or 'both' (default).  This flag is
%   only used when designing minimum order Elliptic filters.

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2009/12/28 04:35:17 $

validate_iir_designmethod(this,'elliptical')

try
    [varargout{1:nargout}] = privdesigngateway(this, 'ellip', ...
        'DesignMode','Decimator',varargin{:});
catch e
    error(e.identifier,cleanerrormsg(e.message));
end
