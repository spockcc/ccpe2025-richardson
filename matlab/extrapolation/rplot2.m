function fig = rplot2(data,p)

% Plot Richardson's fraction, error estimate and the true error if available
%
% CALL SEQUENCE:

% INPUT:
%   data  matrix, with 4 or 6 columns
%   p     the perceived order of the method
%
% OUTPUT:
%   fig   array of handlers to 1 or 2 figures
%
% MINIMAL WORKING EXAMPLE: todo

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  2024-01-16  Adapted from plot_fraction from 5dv231

% Get the number of columns
n=size(data,2);

% Set fontsize
fs=42;

% Set markersize
ms=10;

% Set linewidth
lw=4;

% Get a wide frame
fig=frame('n',40);

if (n==4)

    % The target is unknown, so plot Rh and Fh only

    % Tiled layout
    subplot(1,2,1);

    % Plot Richardson's error estimate Rh
    plt=plot(data(:,1),log2(abs(data(:,4))));

    % Marker, size and color
    plt.Marker='o';
    plt.MarkerSize=ms;
    plt.MarkerFaceColor="b";
    plt.LineWidth=lw;
    ax=gca(); ax.FontSize=fs;

    % Labels
    xlabel('k'); ylabel("log_2(abs(R_h))");
    
    % Grids
    grid on; grid minor;

    % Move to next tile
    subplot(1,2,2);

    % Plot the evolution of Richardson's fraction Fh
    plt=plot(data(:,1),log2(abs(2^p-data(:,3))));

    % Format lines and markers
    plt.Marker='o';
    plt.MarkerSize=ms;
    plt.MarkerFaceColor="b";
    plt.LineWidth=lw;

    % Axis font size
    ax=gca(); ax.FontSize=fs;

    % Label(s)
    xlabel("k"); ylabel('log_{2}(abs(2^p - F_h))');

    % Grids
    grid on; grid minor;

end

if (n==6)

    % The target is known, so plot Eh, (Eh-Rh)/Eh and Fh

    % Tiled layout
    subplot(1,2,1);

    % Plot Eh and (Eh-Rh)/Eh
    plt=plot(data(:,1),log2(abs(data(:,5))),data(:,1),log2(abs(data(:,6))));

    % Format lines and markers
    plt(1).Marker='o';
    plt(1).MarkerSize=ms;
    plt(1).MarkerFaceColor="b";
    plt(1).LineWidth=lw;
    plt(2).Marker='s';
    plt(2).MarkerSize=ms;
    plt(2).MarkerFaceColor="r";
    plt(2).LineWidth=lw;
    plt(2).LineStyle=':';
    ax=gca(); ax.FontSize=fs;

    % Label(s)
    xlabel("k");

    % Grids
    grid on; grid minor;
    %ax.GridLineWidth=2;
    %ax.MinorGridLineWidth=2;

    % Legend
    legend('log_2(abs(E_h))','log_2(abs((E_h-R_h)/E_h))','Location','southwest');

    % Move to next tile
    subplot(1,2,2);

    % Plot the evolution of Richardson's fraction Fh
    plt=plot(data(:,1),log2(abs(2^p-data(:,3))));

    % Format lines and markers
    plt.Marker='o';
    plt.MarkerSize=ms;
    plt.MarkerFaceColor="b";
    plt.LineWidth=lw;

    % Axis font size
    ax=gca(); ax.FontSize=fs;

    % Label(s)
    xlabel("k"); ylabel('log_{2}(abs(2^p - F_h))');

    % Grids
    grid on; grid minor;

end