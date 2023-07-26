function model_RhoA_ROCK_LIMK_Cofilin(model)

	% CaMKII-ArchGEF2
	eid = ReacEnz(   'ArhGEF2'  , 'ActiveCK',	'ArhGEF2p', 'Km_ArhGEF2' , 'kcat_ArchGEF2_phospho' , model);
	eid = ReacOneWay('ArhGEF2p' , 'ArhGEF2' , 'kcat_ArhGEF2_dephospho'	, model);

	% GTPase-activating cycle of RhoA
	eid = ReacEnz('RhoA_GDP', 'ArhGEF2p', 'RhoA_GTP', 'Km_RhoA_ArhGEF2', 'kcat_RhoA_exch' , model);
	eid = ReacEnz('RhoA_GTP', 'RhoGAP'  , 'RhoA_GDP', 'Km_RhoA_RhoGAP' , 'kcat_RhoA_hydro', model);

	% RhoA-ROCK binding
	eid = Reac21(  'RhoA_GTP' , 'ROCK' , 'RhoA_ROCK', 'kon_RhoA_ROCK', 'koff_RhoA_ROCK', model);

	% LIMK phosphorylation cycle
	eid = ReacEnz(   'LIMK' , 'RhoA_ROCK', 'LIMKp', 'Km_LIMK_ROCK', 'kcat_LIMK_phospho' , model);
	eid = ReacOneWay('LIMKp', 'LIMK'     , 'kcat_LIMK_dephospho', model);

	% Cofilin phosphorylation cycle
	eid = ReacEnz('Cofilin'  , 'LIMKp'  , 'Cofilin_p', 'Km_Cofilin_LIMK', 'kcat_Cofilin_phospho'  , model);
	eid = ReacEnz('Cofilin_p','ActiveCN', 'Cofilin'  , 'Km_Cofilin_CN'  , 'kcat_Cofilin_dephospho', model);


% Molecules:
% ArhGEF2, ArhGEF2p,	: ARHGEF2 
% RhoA_GDP, RhoA_GTP,	: RHOA
% RhoGAP,
% ROCK, RhoA_GTP_ROCK,	: ROCK2 (hippocampus; Molecular Brain 14: 169, 2021). ROCK1
% LIMK, LIMKp,			: LIMK1, LIMK2
% Cofilin, Cofilin_p	: Cofilin1, Cofilin2
% Slingshot Protein Phosphatase 1: Ssh
%
% Kinetic constants:
% 'Km_ArhGEF2' , 'kcat_ArchGEF2_phospho',
% 'kcat_ArhGEF2_dephospho',
% 'Km_RhoA_ArhGEF2', 'kcat_RhoA_exch' ,
% 'Km_RhoA_RhoGAP' , 'kcat_RhoA_hydro',
% 'kon_RhoA_ROCK', 'koff_RhoA_ROCK', 
% 'Km_LIMK_ROCK', 'kcat_LIMK_phospho',
% 'kcat_LIMK_dephospho',
% 'Km_Cofilin_LIMK', 'kcat_Cofilin_phospho'
% 'Km_Cofilin_CN'  , 'kcat_Cofilin_dephospho'

