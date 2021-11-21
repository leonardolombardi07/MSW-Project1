function p = propstoadd(this)
%PROPSTOADD   Return the properties to add to the parent object.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:23:16 $

p = propstoadd(this.CurrentSpecs);

p = {'Description', 'NumberOfSections', 'DifferentialDelay', p{:}};

% [EOF]
