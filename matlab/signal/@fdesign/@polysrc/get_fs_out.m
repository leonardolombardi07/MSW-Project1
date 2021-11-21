function fs_out = get_fs_out(this, fs_out)
%GET_FS_OUT   PreGet function for the 'fs_out' property.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/11/17 22:44:15 $

if this.NormalizedFrequency
    fs = [];
else
    fs_out = this.Fs/this.DecimationFactor;
end

% [EOF]
