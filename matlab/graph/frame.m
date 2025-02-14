function fig=frame(quad, topmargin)

% Returns a handler to a new figure in one of four quadrants
%
% CALL SEQUENCE: fig=frame(quadrant)
%
% INPUT: 
%   quad       string, specifies the quadrant of the screen:
%                  
%                      nw | ne
%                      ---+----
%                      sw | se
%   topmargin  integer, leave spce (pixels) for system menu 
% OUTPUT:
%   fig     handler to a new figure which fills the quadrant quad
%
% MINIMAL WORKING EXAMPLE: range_rkx_mwe1

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-03-16  Initial programming and testing.

% Get the corners of the screen
screen=get(groot,'Screensize'); 

% Get the width and height of the screen (pixels)
width=screen(3); height=screen(4);

% Get a handler to a new figure
fig=figure();

% Default scalar
s=0.5;
switch lower(quad)
    case 'nw'
        % NW corner
        a=0; b=height/2-topmargin;
    case 'ne'        
        % NE corner
        a=width/2; b=height/2-topmargin;
    case 'sw'         
        % SW corner
        a=0; b=0;
    case 'se'
        % SE corner
        a=width/2; b=0;
    case 'n'
        a=0; b=height/2-topmargin; s=1;
end
       
% Set the position of the desired window
set(fig,'Position',[a b width*s height/2]);