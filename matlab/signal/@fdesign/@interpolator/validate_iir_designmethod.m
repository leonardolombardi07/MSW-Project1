function validate_iir_designmethod(this,designMethod)
%VALIDATE_IIR_DESIGNMETHOD

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/12/28 04:35:23 $

if this.InterpolationFactor > 2
    response = this.Response;
    if strcmpi(response,'nyquist') || strcmpi(response,'halfband')
        if strcmpi(response(1),'h')
            response(1) = 'h';
        end        
        error(generatemsgid('InvalidInterpFactor'),...
            ['Interpolator factors greater than 2 are not supported for ',...
            '%s %s interpolator designs.'],designMethod,response);
    end
end
