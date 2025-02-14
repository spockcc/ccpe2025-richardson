function fig = rplot(data,p)

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

if (n==4 || n==6)

    % Make a new figure
    fig(1)=frame("nw",40);

    % Plot the evolution of Richardson's fraction
    plt=plot(data(:,1),log2(abs(2^p-data(:,3))));

    % Marker, size and color
    plt.Marker='o';
    plt.MarkerSize=10;
    plt.MarkerFaceColor="b";
    plt.LineWidth=4;
    ax=gca(); ax.FontSize=fs;

    % Labels
    xlabel('k'); ylabel('log_{2}(abs(2^p - F_h))');

    % Grids
    grid on; grid minor;
    %ax.GridLineWidth=2;
    %ax.MinorGridLineWidth=2;

    % Make a second figure
    fig(2)=frame("ne",40);

    % Test the number of columns
    switch(n)
        case 4
            plt=plot(data(:,1),log2(abs(data(:,4))));

            % Format lines and markers
            plt(1).Marker='o';
            plt(1).MarkerSize=10;
            plt(1).MarkerFaceColor="b";
            plt(1).LineWidth=2;
         
            % Axis font size
            ax=gca(); ax.FontSize=fs;

            % Label(s)
            xlabel("k"); ylabel("log_2(abs(R_h))");

            % Grids
            grid on; grid minor;
            %ax.GridLineWidth=2;
            %ax.MinorGridLineWidth=2;

        case 6

            plt=plot(data(:,1),log2(abs(data(:,5))),data(:,1),log2(abs(data(:,6))));

            % Format lines and markers
            plt(1).Marker='o';
            plt(1).MarkerSize=10;
            plt(1).MarkerFaceColor="b";
            plt(1).LineWidth=2;
            plt(2).Marker='s';
            plt(2).MarkerSize=10;
            plt(2).MarkerFaceColor="r";
            plt(2).LineWidth=4;
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
    end
end