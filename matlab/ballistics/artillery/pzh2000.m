% 155 mm self-propelled howitzer, Germany, current era

% Data extracted from:
% http://www.navweaps.com/Weapons/WNGER_61-52_MONARC.htm

% Ensure that the shell models are loaded
load shells mcg7;

% Set the mass of the shell
param.mass=44.5;

% Caliber in meters
param.cali=0.155;

% Select projectile type G7 (based on visual comparison by CCKM)
param.drag=@(x)mcg7(x);

% Select standard atmosphere
param.atmo=@(x)atmosisa(x);

% Select standard gravity
param.grav=@(x)9.80665;

% Select muzzle velocity
param.v0=945; 

% Select method and time step for time integration
intp.method='rk1'; intp.dt=2; 

% Select maximum number of timesteps
intp.maxstep=500;

% Print header
fprintf('PzH-2000 firing G7 shells (boat-tail) loaded\n\n');