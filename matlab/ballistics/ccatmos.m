function [T, a, P, rho] = ccatmos(h)

% A stripped down version of atmosisa that disables all checks
%
% CALL SEQUENCE: [T, a, P, rho] = ccatmos(h)
% 
% INPUT:
%   h      array of heights above sealevel
%   
% OUTPUT:
%   
%   T     array, temperature in Kelvin
%   a     array, speed of sound in m/s
%   P     array, pressure in Pascal
%   rho   array, density in kg/m^3
%
% MINIMAL WORKING EXAMPLE: TODO
%
% WARNING: You use it at your own risk.
% This function is for educational purposes only. 
% This only models the atmosphere between 0 and 20000 m.
%
% It is a stripped down version of atmoslapse obtained by disabling *all*
% checks of the input parameters. This is useful when calling the function
% millions of times during simulations.

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2025-12-05  Extracted from built-in atmoslapse

% Parameters extracted from atmosisa
g=9.80665;
gamma=1.4;
R=287.0531;
L=0.0065;
hts=11000;
htp=20000;
rho0=1.225;
P0=101325;
T0=288.15;
H0=0;

% These statements are all extracted from atmoslapse
h(h > htp) = htp;
h(h < H0) = H0;
hGrThHTS = (h > hts);

h_tmp = h;
h_tmp(hGrThHTS) = hts;

T = T0 - L*h_tmp;

expon = ones(size(h));
expon(hGrThHTS) = exp(g./(R*T(hGrThHTS)).*(hts - h(hGrThHTS)));

a = sqrt(T*gamma*R);

theta = T/T0;

P = P0*theta.^(g/(L*R)).*expon;
rho = rho0*theta.^((g/(L*R))-1.0).*expon;