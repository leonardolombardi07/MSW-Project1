function verifyautoscalability(this)
%VERIFYAUTOSCALABILITY   

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:58 $

error(generatemsgid('NotSupported'), ...
    'The AUTOSCALE function is not supported for FARROW.FD filters.');

% [EOF]
