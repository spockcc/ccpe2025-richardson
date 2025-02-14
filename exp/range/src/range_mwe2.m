% Find the point of impact of a shell fired from a gun

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-03-07 Initial programing and testing
%   2024-12-04 Updated to handle improved calls sequence
%   2025-02-09 Improved documentation

% Clear workspace
clear;

% Set the main path
mpath="exp/range/";

% Set the data path
dpath=strcat(mpath,"dat/");
dname=strcat(dpath,"range_mwe2.mat");

% Set the figure path
fpath=strcat(mpath,'fig/');
fname(1)=strcat(fpath,'range_mwe2.eps');

% Check if raw data exists
if ~isfile(dname)

    % C-infinity shells
    make_shells('smooth');

    % Load the gun
    pzh2000;

    % Set the elevation of the barrel of the gun
    theta=60*pi/180;

    % Define the starting time
    t0=0;

    % Define the initial condition
    x0=[0; 0; param.v0*cos(theta); param.v0*sin(theta)];

    % Define the function that drives the differential equation
    f=@(t,x)shell4a(param,t,x);

    % Define the event function, i.e., isolate the y coordinate
    g=@(x)x(2);

    % Set the maximum number of events
    K=1;

    % Set method and order
    intp.method='rk2'; p=2;

    % Fire the shell and search for the point of impact
    [t, tra0, count, idx]=event_location(f,t0,x0,intp,g,K);

    % Number of approximations
    kmax=12;

    % Approximations
    A=zeros(kmax,1);

    % Start the clock
    tic;
    for i=1:kmax
        % Run event location routine
        [t, tra, count, idx]=event_location(f,t0,x0,intp,g,K);
        % Save range assuming that all went well
        A(i)=tra(1,end);
        h(i)=intp.dt;
        % Prepare for the next iteration
        intp.dt=intp.dt/2;
        intp.maxstep=intp.maxstep*2;
    end

    % Stop the clock
    toc;

    % Save all data
    save(dname);

    % Skip a line
    fprintf('\n');
else
    fprintf("Loading raw data\n");

    % Load data
    load(dname);

     % Handler to figure
    fig=frame('nw',40);

    % Plot the entire trajectory
    pl=plot(tra0(1,:),tra0(2,:),tra0(1,:),tra0(2,:));

    % Change the line width
    pl(1).LineWidth=2;

    % Set the dots
    pl(2).LineStyle='none';
    pl(2).Marker='o';
    pl(2).MarkerFaceColor='r';
    pl(2).MarkerSize=8;

    % Labels
    xlabel('x (meter)'); ylabel('y (meter)');

    % Grids
    grid on; grid minor;

    % Apply Richardson's analysis to the data
    data=richardson(A,p);
    
    % Obtain parameters for formatting the table
    tp=table_param('rdif',data);
    
    % Print the table
    print_table(data,tp);

    % Plot the evolution of F_h and R_h
    fig=rplot2(data,2);

    % Save plot of F_h and R_h
    exportgraphics(fig,fname);
    
end
