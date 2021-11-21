function setspecs(this, B, varargin)
%SETSPECS   Set the specs.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:25:17 $

if nargin < 2
    return;
end

if ischar(B)
    error(generatemsgid('invalidInput'), ...
        'The first input must be a scalar number (Band).');
end

set(this, 'Band', B);

abstract_setspecs(this, varargin{:});

% [EOF]
