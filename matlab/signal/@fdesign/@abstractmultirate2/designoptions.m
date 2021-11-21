function dopts = designoptions(this, dmethod)
%DESIGNOPTIONS

%   Author(s): J. Schickler
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2006/11/19 21:45:04 $

if nargin < 2,
    error(generatemsgid('notEnoughInputs'),...
        ['You must specify a design method in order to see available options.\n',...
        'To view a list of possible design methods use: designmethods(%s).'],inputname(1));
end

dopts = designoptions(this.CurrentFDesign, dmethod);

if isempty(fieldnames(dopts))
    return;
end

rcf = getratechangefactors(this);

if ~any(rcf == 1)
    % RSRC
    if ~any(strcmpi('firsrc', dopts.FilterStructure))
        dopts.FilterStructure = {'firsrc'};
    end
elseif rcf(1) < rcf(2)
    % Decimator
    if isempty(intersect({'firdecim', 'firtdecim'}, ...
            dopts.FilterStructure)) || ...
            isequal({'firdecim','firinterp','firtdecim'},...
            intersect(dopts.FilterStructure,{'firinterp','firdecim','firtdecim'}))
        dopts.FilterStructure = {'firdecim', 'firtdecim'};
    end
    if any(strcmpi(designmethods(this, 'iir'), dmethod))
        dopts.FilterStructure = {'iirdecim','iirwdfdecim'};
    end
else
    % Interpolator
    if isempty(intersect({'firinterp', 'fftfirinterp'}, ...
            dopts.FilterStructure)) 
        dopts.FilterStructure = {'firinterp', 'fftfirinterp'};
    elseif isequal({'firdecim','firinterp','firtdecim'},...
            intersect(dopts.FilterStructure,{'firinterp','firdecim','firtdecim'}))
        dopts.FilterStructure = {'firinterp'};
    end
    if any(strcmpi(designmethods(this, 'iir'), dmethod))
        dopts.FilterStructure = {'iirinterp','iirwdfinterp'};
    end
end

dopts.DefaultFilterStructure = dopts.FilterStructure{1};

% [EOF]
