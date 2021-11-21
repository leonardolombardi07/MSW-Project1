function varargout = validate(this, nsections, diffdelay)
%VALIDATE   Returns true if the states are valid.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2004/08/10 02:08:22 $

if nargin < 3
    
    % If we are not given the differential delay, assume that the first
    % comb of the first channel is the correct size.
    diffdelay = length(this.Comb(1,1).Value);
    if nargin < 2
        
        % if we are not given the number of sections, assume that the
        % length of the first channel's integrator is correct.
        nsections = size(this.Integrator, 1);
    end
end

b      = true;
errstr = '';
errid  = '';

% Check that both the Integrator and Comb have the correct # of channels
if size(this.Integrator, 2) ~= size(this.Comb, 2)
    b = false;
    errstr = 'The number of channels in the Comb must match the number of channels in the Integrator.';
    errid = 'nchannelsMismatch';
end

% If this channel's Integrator or Comb length is not equal to
% NSections, error out.
if size(this.Integrator, 1) ~= nsections || ...
        size(this.Comb, 1) ~= nsections
    b      = false;
    errstr = 'Length of the Integrator and Comb states must match the number of sections.';
    errid  = 'lengthMismatch';
end
    
% Check that each section's comb has a number of values equal to the
% differential delay.
for indx = 1:size(this.Comb, 1)
    for jndx = 1:size(this.Comb, 2)
        if length(this.Comb(indx, jndx).Value) ~= diffdelay
            b      = false;
            errstr = 'The number of rows of the Comb states must match the differential delay times the number of sections.';
            errid  = 'lengthMismatch';
        end
    end
end

% If outputs are requested, return the error condition, otherwise error.
if nargout
    varargout = {b, errstr, errid};
else
    if ~b
        error(generatemsgid(errid), errstr);
    end
end

% [EOF]
