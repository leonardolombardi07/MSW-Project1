function specs = whichspecs(h)
%WHICHSPECS Determine which specs are required for this class.

%   Author(s): R. Losada
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.2 $  $Date: 2002/04/15 00:32:21 $

% Prop name, data type, default value, listener callback
specs(1) = cell2struct({'Wstop1','udouble',1,[],'magspec'},specfields(h),2);

specs(2) = cell2struct({'Wpass','udouble',1,[],'magspec'},specfields(h),2);

specs(3) = cell2struct({'Wstop2','udouble',1,[],'magspec'},specfields(h),2);



