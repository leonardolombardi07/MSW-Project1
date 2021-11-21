function [Vp,Yp] = nlminputnoutput(this,L,M)
%NLMINPUTNOUTPUT   

%   Author(s): R. Losada
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/11/19 21:44:34 $

% Where are going to filter so work with copy
Hc = copy(this); 
Hc.PersistentMemory = false; % Make sure to avoid initial conditions

[vp,Vp] = nlmgeninput(this,M,L);

% Rescale input to be in input quantizer range
[vp,Vp] = nlmrescaleinput(get_filterquantizer(this),vp,Vp);

v = [vp; vp]; % Avoid transients?
 
v = quantizeinput(get_filterquantizer(this),v);

y = filter(Hc,v);      % Applying v to the system under test

y = double(y);         % Cast

y = y(M+1:2*M,:);        % Selecting and transforming the last period
  
Yp = fft(y);

% [EOF]
