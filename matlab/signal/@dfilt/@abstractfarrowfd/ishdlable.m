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
%   See also FARROW, GENERATEHDL.

%   Author(s): M. Chugh
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:11 $ 

  switch lower(Hb.arithmetic)
   case {'double', 'fixed'}
    result = true;
    errstr = '';
   otherwise
    result = false;
    errstr = sprintf('HDL generation for arithmetic type %s is not supported.',...
                     Hb.arithmetic);
  end