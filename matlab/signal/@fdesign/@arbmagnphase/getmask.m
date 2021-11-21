function [F, A, P] = getmask(this, fcns, rcf, specs)
%GETMASK   Get the mask.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/08/20 13:26:10 $

w = warning('off');
[F, A] = getmask(this.CurrentSpecs);
P = fcns.getarbphase(angle(A));
A = fcns.getarbmag(abs(A)); % Convert units
F = F*fcns.getfs()/2;
warning(w);

% [EOF]
