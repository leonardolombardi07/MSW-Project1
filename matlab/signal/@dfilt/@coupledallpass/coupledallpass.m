function varargout = coupledallpass(varargin)
%COUPLEDALLPASS Coupled-allpass filter virtual class.
%   COUPLEDALLPASS is a virtual class---it is never intended to be instantiated.
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.4.4.3 $  $Date: 2007/12/14 15:07:49 $

msg = sprintf('COUPLEDALLPASS is not a filter structure.');
if ~isempty(msg), error(generatemsgid('SigErr'),msg); end
