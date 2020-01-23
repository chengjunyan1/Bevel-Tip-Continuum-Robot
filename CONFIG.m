function [rv]=CONFIG(request)
% DEFAULT UNIT: m
scale=1000; % to mm

% CONFIG:TISSUE
TISSUE_ORIGIN=[0.2 0 0]*scale;
TISSUE_SIZE=[0.5 0.5 0.5]*scale;
k0=0.2181;
k1=1.5;
Q=1; % UNIT: N

% CONFIG:OBSTACLE
OBS_NUM=3;
OBSTACLE1_ORIGIN=[0.4 0.22 0.22]*scale;
OBSTACLE1_SIZE=[0.15 0.15 0.15]*scale;
OBSTACLE2_ORIGIN=[0.23 0.1 0.1]*scale;
OBSTACLE2_SIZE=[0.1 0.1 0.1]*scale;
OBSTACLE3_ORIGIN=[0.5 0.06 0.06]*scale;
OBSTACLE3_SIZE=[0.05 0.05 0.05]*scale;
% ADD NEW OBSTACLE LIKE ABOVE

% CONFIG:TIP
START_POINT=[0 0.25 0.25]*scale;
CONTACT_POINT=[0.2 0.25 0.25]*scale;
TARGET_POINT=[0.6,0.05,0.05]*scale;

% CONFIG:NEEDLE
L=0.3*scale; % needle length L
n=20; % num of bars
E=200*10^9/scale^2; % Young¡¯s modulus, UNIT: N/m^2
I=7.86*10^-14*scale^4; % second moment of inertia, UNIT: m^4

% RETURN VALUE
eval(['rv=' request ';']);

end