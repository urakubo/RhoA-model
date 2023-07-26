%
function InitReacs(model, species, params, TYPE); % TYPE : D1 or D2

	mfilepath=fileparts(which(mfilename));
	addpath(fullfile(mfilepath,'./reacs'));

	%%
	%% RhoA signal, 230719 HU
	%%
	model_RhoA_ROCK_LIMK_Cofilin(model)
	%%
	%%
	%%


	%% DA signal
	%eid = Reac11('DA', 'DA_basal'				, 'kdec_DA', 'kinc_DA', model);
	%eid = Reac11('DA', 'BuffDA'				, 'kon_DA_BuffDA', 'koff_DA_BuffDA', model);


	%% D1R-G-AC signal
	model_D1R_Golf_AC1_AC5(model)
	model_D2R_Gi_AC1(model)


	%% cAMP production -> degradation
	eid = ReacEnz('ATP', 'ActiveAC', 'cAMP'		, 'Km_AC', 'kcat_AC', model);
	eid = ReacEnz('cAMP', 'PDE', 'AMP'			, 'Km_PDE', 'kcat_PDE', model);


	%% PKA_cAMP_PKA_DARPP32 signal
	model_PKA_cAMP_PKA_DARPP32(model,species)


	%% Ca influx 
	%eid = ReacChannel('Ca_ext', 'VGCC', 'Ca'	, 'kinflux_Ca'		, model);
	%eid = ReacOneWay('VGCC', 'VGCC_dummy'		, 'kdeact_VGCC'		, model);

	%% Ca uptake
	%eid = ReacChannel('Ca', 'CaPump', 'Ca_ext'	, 'kpump_Ca'		, model);

	%% Fixed Ca
	set(species{'Ca','Obj'}, 'ConstantAmount', false);
	set(species{'Ca','Obj'}, 'BoundaryCondition', true);


	%% Ca-CaM interaction
	model_Ca_CaM(model)


	%% CaM-CaMKII binding
	model_CaM_CaMKII(model, params)


	%% Ca-CB binding
	eid = Reac21( 'CB'  ,'Ca', 'Ca_CB' 			, 'kon_CB'	, 'koff_CB', model);


	%% CaCaM-AC1 interaction
	model_CaM_AC1(model)


	%% AC activity

	% AC1
	r = addrule(model,'Golf_bound_AC  = (ACsub1_Golf_GTP + ACsub1_Golf_GDP)', 'repeatedAssignment');
	r = addrule(model,'Gi_unbound_AC  = ACsub0-(ACsub2_Gi_GTP + ACsub2_Gi_GDP)', 'repeatedAssignment');	
	r = addrule(model,'ActAC1 = (Gi_unbound_AC/ACsub0) * (Golf_bound_AC/ACsub0) * AC_CaM', 'repeatedAssignment');

	% AC5
	r = addrule(model,'Golf_bound_AC5  = (AC5sub1_Golf_GTP + AC5sub1_Golf_GDP)', 'repeatedAssignment');
	r = addrule(model,'ActAC5 = Golf_bound_AC5','repeatedAssignment'); % If AC5 conc is not Zero.

	% AC1 + AC5
	r   = addrule(model,'ActiveAC = ActAC1 + ActAC5 + BasalAC','repeatedAssignment');


	%% Constant species
	set(species{'ATP','Obj'}, 'ConstantAmount', true);
	% set(species{'DA_basal','Obj'}, 'ConstantAmount', true);
	set(species{'Ca_ext','Obj'}, 'ConstantAmount', true);
	set(species{'VGCC_dummy','Obj'}, 'ConstantAmount', true);


	%% CaM-CN interaction
	model_CaM_CN(model)



