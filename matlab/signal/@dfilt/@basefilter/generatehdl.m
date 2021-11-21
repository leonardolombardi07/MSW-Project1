function generatehdl(filterobj, varargin)
%GENERATEHDL Generate HDL.

%   Copyright 2003-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $  $Date: 2009/02/18 02:25:33 $ 

  [cando, errstr] = ishdlable(filterobj);
  if ~cando
    error(generatemsgid('unsupportedarch'), errstr);
  end

  % Add filter object variable name to varargin 
  if ~any(strcmpi(varargin,'name'))
    varargin(end+1) = {'name'};
    if ~isempty(inputname(1))
        varargin(end+1) = {inputname(1)};
    else
        error(generatemsgid('genhdlcalledwithconst'), 'First argument of ''generatehdl'' command must be handle of a filter object.');
    end
  end
  
  if any(strcmpi(fieldnames(get(filterobj)),'Arithmetic')) %all but cascades
      if (strcmpi(get(filterobj, 'Arithmetic'), 'fixed') && filterobj.InputWordLength == 1)
          error(generatemsgid('OneBitInputNotSupported'), ...
              'HDL code generation for filters with 1 bit InputWordLength is not supported.');
      end
  elseif strcmpi(get(filterobj.Stage(1), 'Arithmetic'), 'fixed') && filterobj.Stage(1).InputWordLength == 1
      error(generatemsgid('OneBitInputNotSupported'), ...
          'HDL code generation for filters with 1 bit InputWordLength is not supported.');
  end
  
  privgeneratehdl(filterobj,varargin{:});

% [EOF]

