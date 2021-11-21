function varargout = multistage(this, varargin)
%MULTISTAGE   Design a multistage equiripple decimator.

%   Author(s): J. Schickler
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2007/12/14 15:11:18 $

% Make sure that MULTISTAGE is valid for this set of specifications.
if ~isdesignmethod(this, 'multistage')
    errid = generatemsgid('invalidMethod');
    errmsg    = sprintf('MULTISTAGE is not defined for the specification: ''%s''.', ...
        this.Specification);
    error(errid,errmsg);
end

% Parse the inputs for the multirate filter structure.
[filtstruct, varargin] = parsestruct(this, 'firdecim', 'multistage', varargin{:});

dfactor = get(this, 'DecimationFactor');

Hm = multistage(this.CurrentFDesign, varargin{:}, 'rcf', -dfactor,...
    'FilterStructure',filtstruct);

% Use THIS object instead of the 'CurrentFDesign'.
Hm.setfdesign(this);

if nargout
    varargout = {Hm};
else
    if this.NormalizedFrequency,
        inputs = {'NormalizedFrequency', 'On'};
    else
        inputs = {'Fs', this.Fs};
    end

    fvtool(Hm, inputs{:});
end

% [EOF]
