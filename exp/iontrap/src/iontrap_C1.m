% Iontrap with dampning
% Runge-Kutta methods
% C1 cut-off function

% PROGRAMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  Spring 2024  Initial programming and testing
%  2025-01-12   Adapted from PPAM paper

% Set the main path
mpath="exp/iontrap/";

% Set the data path
dpath=strcat(mpath,"dat/");
dname=strcat(dpath,"iontrap_C1.mat");

% Set the figure path
fpath=strcat(mpath,'fig/');
fname=strcat(fpath,'iontrap_C1.eps');

% Check if raw data exists
if ~isfile(dname)

    % Run experiment from scratch
    fprintf("Generating raw data\n");

    % Seed the generator
    seed=2024; rng(seed);

    % Set the number of particles
    n=4;

    % Set the spatial dimension
    dim=3;

    % Set the leading dimension of the arrays
    ld=n*dim;

    % Generate position and velocities
    q0=rand(ld,1)-rand(ld,1); p0=zeros(ld,1);

    % Set the charges
    charge=ones(n,1)/16;

    % Set the mass of the particles
    mass=ones(n,1);
    
    % Generate initial state
    x0=[q0; p0];

    % Spring constant
    spring=5;

    % Dampning
    damp=2;

    % Scaling factor for columb potential
    scale=1;

    % Set cutoff parameters
    rho=0.1462; rho1=0.5*rho; rho2=0.95*rho; 
    
    % Set C1 cutoff function
    cut=@(x)1-trans3(rho1,rho2,1,x);

    % Set the forcefield: coulomb force + springs + dampning
    f=@(q,p)modified_coulomb_force(dim,n,charge,q,scale,cut)-spring*q-damp*p;

    % Set the function that drives the ODE
    g=@(t,x)[x(ld+1:2*ld,1); f(x(1:ld,1),x(ld+1:2*ld,1))];

    % The length of the simulation
    T=5;

    % Number of methods
    nm=4;

    % Define list of integration methods
    tit=cell(4,1);
    tit{1}='rk1';
    tit{2}='rk2';
    tit{3}='rk3';
    tit{4}='rk4';

    % Set the order of the primary error term
    order=[1; 2; 3; 4];

    % Number of samples
    N1=512;

    % Number of approximations A_h
    kmax=12;

    % Allocate space for the raw data
    raw=zeros(2*ld,N1+1,kmax,nm);

    % Compute the number of experiments
    nexp=nm*kmax;
    
    % Loop over the different methods
    for j=1:nm
        % Select the method
        method=tit{j};
        % Set steps between samples
        N2=1;
        % Loop over the different timestep sizes
        for k=1:kmax
            % Progress
            cnt=k+(j-1)*kmax; 
            % Display progress indicator
            fprintf('Experiment %2d of %2d\n',cnt,nexp);            
            % Run the simulation
            [t, y]=rk(g,0,T,x0,N1,N2,method);
            % Save the state vectors
            raw(:,:,k,j)=y;
            % Prepare for the next iteration
            N2=N2*2;
        end
    end
    
    % Save all data
    save(dname);

    % Skip a line
    fprintf('\n');
else
    fprintf("Loading raw data\n");

    % Load data
    load(dname);

    % Allocate space for the kinetic energy
    kin=zeros(kmax,nm);

    % Allocate space for Richardson's tables
    table=zeros(kmax,4,nm);

    % Parameters for printing
    tp=table_param('rdif',table(:,:,1));

    % Get a new figure
    fig=frame("n",40);

    % Loop over the methods
    for j=1:nm

        % Loop over the time steps
        for k=1:kmax
            % Extract state vectors
            y=raw(:,:,k,j);
            % Exact state vector at the end of the sim
            aux=y(:,end);
            % Extract positions and velocities
            q=aux(1:ld); v=aux(ld+1:end);
            % Compute kinetic energy
            kin(k,j)=kinetic_energy(dim,n,mass,v);
        end

        % Apply Richardson extrapolation
        table(:,:,j)=richardson(kin(:,j),order(j));

        % Compute force at the end of last simulation
        val=norm(f(q,v));

        % Display information
        fprintf("Norm of force    = %e\n",val);
        fprintf("Kinetic energy   = %e\n",kin(kmax,j));
        fprintf("Richardson's table for the kinetic energy\n");
        print_table(table(:,:,j),tp);

        % Plot Richardson's fraction
        subplot(1,nm,j); plt=plot_fraction(table(:,:,j),order(j));

        % Set title
        tit=['p = ' num2str(order(j),'%2d')]; title(tit);
 
        % New line
        fprintf("\n");
    end

    % Save the graphics
    saveas(fig,fname,'epsc');
end