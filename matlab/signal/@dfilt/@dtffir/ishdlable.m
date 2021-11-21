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

%   Copyright 2003-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2006/12/27 21:29:52 $ 

  switch lower(Hb.arithmetic)
   case {'double', 'fixed'}
    result = true;
    errstr = '';
   otherwise
    result = false;
    errstr = sprintf('HDL generation for arithmetic type %s is not supported.',...
                     Hb.arithmetic);
  end
  firlen = length(Hb.numerator);
  if firlen == 1                        % zero order case
     result = false;
     errstr = sprintf('Cannot generate HDL for a zero order filter.'); 
  end
% [EOF]

