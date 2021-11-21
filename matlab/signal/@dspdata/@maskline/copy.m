function Hcopy = copy(this)
%COPY   Copy this object.

%   Author(s): J. Schickler
%   Copyright 2004 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2004/12/26 22:10:18 $

Hcopy = feval(this.class);

set(Hcopy, 'EnableMask',   this.EnableMask, ...
    'NormalizedFrequency', this.NormalizedFrequency, ...
    'FrequencyVector',     this.FrequencyVector, ...
    'MagnitudeUnits',      this.MagnitudeUnits, ...
    'privMagnitudeVector', this.privMagnitudeVector);

% [EOF]
