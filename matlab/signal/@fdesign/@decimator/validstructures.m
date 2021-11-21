function vs = validstructures(this, dm)
%VALIDSTRUCTURES   Returns the valid structures for the design method.

%   Author(s): J. Schickler
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2006/06/27 23:35:49 $

% If we are not given a design method, return a structure.
if nargin < 2
    
    % Loop over all the design methods and call VALIDSTRUCTURES.
    d = designmethods(this);
    for indx = 1:length(d)
        vs.(d{indx}) = validstructures(this, d{indx});
    end
else

    firmethods = designmethods(this, 'fir');
    iirmethods = designmethods(this, 'iir');

    if any(strcmpi(firmethods, dm))
        vs = {'firdecim', 'firtdecim'};
    elseif any(strcmpi(iirmethods, dm))
        vs = {'iirdecim', 'iirwdfdecim'};
    else
        error(generatemsgid('InvalidMethod'), ...
            '''%s'' is not a valid design method.', dm);
    end
end

% [EOF]
