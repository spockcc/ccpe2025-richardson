function [s, t]=TwoSum(a,b)

% TwoSum  Error free transformation of the sum of two FP numbers
%
% CALL SEQUENCE: [s, t]=TwoSum(a,b)
%
% INPUT:
%   a, b   floating point real numbers
%
% OUTPUT:
%   s, t   two floating point numbers such that
%            s = fl(a+b)         = the computed result
%            t = a + b - fl(a+b) = the corresponding error
%
% ALGORITHM by Donald E. Knuth: "The Art of Computer Programming". Vol. 2.  

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-03-09 Finalized documentation during yearly review

% IF 
% a + b = (a1,a2, 0) +
%         ( 0,b1,b2)
%       = (a1,a2+b1,b2)
% THEN the computed value of s is (a1,a2+b1)
%      the computed value of z is (0,b1)
%      the computed value of s-z is (a1,a2)
%      the computed value of b-z is (0,0,b2)

% IF 
% a + b = ( 0,a1,a2) +
%         (b1,b2,0 ) 
%       = (b1,a1+b2,a2)
% THEN the computed value of 
%      s is (b1,a1+b2)
%      z is (b1,b2)
%      s-z is (0,a1)
%      b-z is 0
%      t is (0,0,a2)

% Compute the sum
s=a+b;

% Compute increment ...
z=s-a;

% Compute the error
t=(a-(s-z))+(b-z);

