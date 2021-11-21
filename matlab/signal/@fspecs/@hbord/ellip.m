function Hd = ellip(this, varargin)
%ELLIP Elliptic digital filter design.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/10/23 18:48:39 $

Hd = design(this, 'ellip', varargin{:});
h = getfmethod(Hd);

if ishp(this),
    if isa(Hd,'mfilt.abstractmultirate'),
        error(generatemsgid('InvalidStructure'), ...
            'Multirate highpass halfband IIR filters are not supported.');
    end
    Hd = iirlp2hp(Hd,.5,.5);
    % Reset the contained FMETHOD.
    Hd.setfmethod(h);
end