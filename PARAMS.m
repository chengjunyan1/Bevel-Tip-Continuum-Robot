function [rv]=PARAMS(request,V)

global CONTACT_OFFSET

% READ PARAMS
if nargin==1
    eval(['rv=' request ';'])
end

% WRITE PARAMS
if nargin==2
    eval([request '=V;'])
end

end