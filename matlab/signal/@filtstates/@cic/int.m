function intvalue = int(this)
%INT   Return the integer.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2004/07/28 04:37:30 $

% Loop over each channel.
[b, errstr, errid] = validate(this);
if ~b
    error(generatemsgid(errid), errstr);
end

[nsections nchannels] = size(this.Integrator);

intvalue = {};

for indx = 1:nchannels
    for jndx = 1:nsections
        intvalue{end+1} = [int(this.Integrator(jndx, indx)); ...
            int(this.Comb(jndx, indx))];
    end
end

% Line up the channels in a row.
intvalue = [intvalue{:}];

% [EOF]
