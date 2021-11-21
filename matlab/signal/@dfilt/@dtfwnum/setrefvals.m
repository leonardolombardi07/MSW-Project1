function setrefvals(this, refvals)
%SETREFVALS   Set reference values.

%   Author(s): R. Losada
%   Copyright 2003 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2003/12/06 16:03:39 $

rcnames = refcoefficientnames(this);

set(this,rcnames,refvals);


% [EOF]
