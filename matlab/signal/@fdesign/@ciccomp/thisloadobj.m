function thisloadobj(this, s)
%THISLOADOBJ   Load this object.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/04/04 16:59:32 $

set(this, 'DifferentialDelay', s.DifferentialDelay, ...
    'NumberOfSections', s.NumberOfSections);

% [EOF]
