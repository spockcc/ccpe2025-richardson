% 88 mm anti-aircraft gun, Germany, WWII
% Data extracted from:
% https://en.wikipedia.org/wiki/8.8_cm_Flak_18/36/37/41

% Load McCoy's model of a G6 type projectile.
load shells mcg6

% Set the mass of the shell
param.mass=9.2;

% Caliber in meters
param.cali=0.088;

% Select projectile type G6 (based on visual comparison by CCKM)
param.drag=@(x)mcg6(x);

% Select standard atmosphere
param.atmo=@(x)atmosisa(x);

% Select standard gravity
param.grav=@(x)9.80665;

% Select muzzle velocity
param.v0=840; 

% Select method and time step for integration
intp.method='rk1'; intp.dt=0.25; 

% Select maximum number of timesteps
intp.maxstep=800;

% Print header
fprintf('Flak 36 anti-aircraft gun firing G6 shells loaded\n\n');