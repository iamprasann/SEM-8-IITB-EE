function mpc = case6_FBMC
x = 200;
%CASE3SC    Power flow data for 3-bus system used in [1].
%   Please see CASEFORMAT for details on the case file format.
%
%   The semidefinite relaxation of the OPF problem successfully solves 
%   case3sc with a value of 60 MVA for the line-flow limit on the line from
%   bus 3 to bus 2. The semidefinite relaxation fails to give a physically
%   meaningful solution to case3sc with a value of 50 MVA for the line-flow
%   limit on this line. See [1] for further details.
%
%   [1] B.C. Lesieutre, D.K. Molzahn, A.R. Borden, and C.L. DeMarco,
%       "Examining the Limits of the Application of Semidefinite 
%       Programming to Power Flow Problems," In 49th Annual Allerton 
%       Conference on Communication, Control, and Computing, 2011,
%       September 28-30 2011.

mpc.version = '2';

%-----  Power Flow Data  -----%%
% system MVA base
mpc.baseMVA = 100;
    
% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1	    3	    0	0	0	0	1	    1	0	345	    1	    1.1	    0.9;
	2	    1	    0	0	0	0	1	    1	0	345     1   	1.1 	0.9;
	3	    1	    x	0	0	0	1	    1	0	345     1	    1.1 	0.9;
	4	    1	    0	0	0	0	1	    1	0	345     1   	1.1 	0.9;
	5	    1	    x	0	0	0	1	    1	0	345     1	    1.1 	0.9;
	6	    1	    x	0	0	0	1	    1	0	345     1   	1.1 	0.9;
	];  

% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	0	0	900	    -900	1	100	    1	    1e3	    0	    0	0	0	    0   	0   	0   	0   	    0   	0   	0   	0;
	2	0	0	900   	-900    1	100	    1	    1e3	    0	    0	0	0	    0	    0	    0	    0	        0	    0	    0	    0;
    4	0	0	900	    -900	1	100	    1	    1e3	    0	    0	0	0	    0   	0   	0   	0   	    0   	0   	0   	0;
	];

% branch data
%	fbus	tbus	r	    x	    b	    rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
    1	    2	    0	    0.0576	0.0 	70  70  70	0	0	1	-360	360;
	1	    3	    0	    0.0920	0.0     0	0	0	0	0	1	-360	360;
    2	    3   	0	    0.0586	0.0	    0	0	0	0	0	1	-360	360;
    1	    6	    0	    0.1008	0.0 	200	200	200	0	0	1	-360	360;
	2	    5	    0	    0.0625	0.0     250	250	250	0	0	1	-360	360;
    4	    5   	0	    0.1610	0.0	    0	0	0	0	0	1	-360	360;
    4	    6	    0	    0.0850	0.0 	0	0	0	0	0	1	-360	360;
	5	    6	    0	    0.1720	0.0     100	100	100	0	0	1	-360	360;
    ];

% area data
%	area	refbus
mpc.areas = [
	1	1; 
];

% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	0	    0	        3	0.002	3.5 0;
	2	0	    0	        3	0.005	5.0 0;
    2	0	    0   	    3	0.003	4.5 0;
];