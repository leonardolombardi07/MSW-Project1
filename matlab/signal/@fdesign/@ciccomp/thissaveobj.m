function s = thissaveobj(this)
%THISSAVEOBJ   Save this object.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/04/04 16:59:33 $

s.DifferentialDelay = this.DifferentialDelay;
s.NumberOfSections  = this.NumberOfSections;

% [EOF]
