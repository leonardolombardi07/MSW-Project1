function setspecs(this, varargin)
%SETSPECS   Set the specifications

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/10/16 06:41:30 $
 
if nargin > 1 && ischar(varargin{1})
    if any(strcmpi(varargin{1},{'wt','wt,class'}))
        set(this, 'SpecificationType', varargin{1});
        varargin(1) = [];
    end
end
charIdx = cellfun(@ischar, varargin);
if sum(charIdx) > 0
    this.WeightingType = varargin{1};
    varargin(1) = [];
    charIdx = cellfun(@ischar, varargin);
    if sum(charIdx) > 0
        error(generatemsgid('TooManyInputStrings'),'Invalid input.');
    end
end
if isempty(varargin)
    if strcmpi(this.Specification,'wt,class')
        varargin{1} = 1;
        varargin{2} = this.CurrentSpecs.DefaultFs;
    else
        varargin{1} = this.CurrentSpecs.DefaultFs;
    end        
elseif isequal(length(varargin),1) && strcmpi(this.Specification,'wt,class')
    varargin{2} = this.CurrentSpecs.DefaultFs;
end 
    
setspecs(this.CurrentSpecs, varargin{:});

% [EOF]