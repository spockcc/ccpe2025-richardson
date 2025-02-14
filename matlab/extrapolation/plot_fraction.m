function plt=plot_fraction(data,p)

% Plot the evolution of Richardson's fraction
%
% CALL SEQUENCE: plot_fraction(data,p)
%     
% INPUT:
%   data   array returned by a call to richardson
%   p      the order of the method
% 
% OUTPUT
%   a handler to a plot of Richardson's fraction
%
% MINIMAL WORKING EXAMPLE: rdif_mwe1

% PROGRAMMING by Carl Christian K. Mikkelsen (spock@cs.umu.se)
%   2024-03-08 Extracted from old version of rdif_mwe1
%   2025-01-11 Added marker, size, color and axis control

% Plot the development of Richardson's fraction
plt=plot(data(:,1),log2(abs(2^p-data(:,3))));

% Marker, size and color
plt(1).Marker='o';
plt(1).MarkerSize=10;
plt(1).MarkerFaceColor="b";
plt(1).LineWidth=2;
ax=gca(); ax.FontSize=18;

% Labels
xlabel('k'); ylabel('log_{2}(abs(2^p - F_h))');

% Grids
grid on; grid minor;