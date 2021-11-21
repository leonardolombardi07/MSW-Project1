function thiscopy(this, hOldObject)
%THISCOPY   Copy properties specific to the fdesign.ciccomp class.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.8.1 $  $Date: 2005/08/04 18:03:38 $

set(this, 'DifferentialDelay', hOldObject.DifferentialDelay, ...
    'NumberOfSections', hOldObject.NumberOfSections);

% [EOF]
