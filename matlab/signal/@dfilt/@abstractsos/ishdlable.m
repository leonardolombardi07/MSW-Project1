function [result, errstr] = ishdlable(Hb)
%ISHDLABLE True if HDL can be generated for the filter object.
%   ISHDLABLE(Hd) determines if HDL code generation is supported for the
%   filter object Hd and returns true or false.
%
%   The determination is based on the filter structure and the 
%   arithmetic property of the filter.
%
%   The optional second return value is a string that specifies why HDL
%   could not be generated for the filter object Hd.
%
%   See also DFILT, GENERATEHDL.

%   Copyright 2003-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2009/01/20 15:34:57 $ 

  checksv(Hb);
  switch lower(Hb.arithmetic)
   case {'double', 'fixed'}
    result = true;
    errstr = '';
   otherwise
    result = false;
    errstr = sprintf('HDL generation for arithmetic type %s is not supported.',...
                     Hb.arithmetic);
  end
 filterorders = secorder(Hb);
 if any(filterorders == 0)
     result = false;
     errstr = sprintf('Cannot generate HDL for filter with any zero order section.');
 end
% [EOF]

