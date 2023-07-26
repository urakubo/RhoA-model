%%%
%%%
%%%

function [model, dict] = setup_msn(Tstop);

%	TYPE = 'D2'; DAbasal = 0.5;
	TYPE = 'D1'; DAbasal = 0.0;
	SVRspine = 30;
	%%
	%% MSN
	%%
	init_species = InitSpecies(SVRspine);
	init_params  = InitParams(SVRspine);
	[model, species, params] = DefineModel(init_species, init_params, Tstop);
	InitReacs(model, species, params, TYPE);

	%%
	%% Set event
	%%
	switch TYPE
   		case {'D1','D1_Pav'}
      		set(species{'D2R','Obj'}, 'InitialAmount', 0);
      		set(species{'A2AR','Obj'}, 'InitialAmount', 0);
   		case 'D2'
      		set(species{'D1R','Obj'}, 'InitialAmount', 0);
      		set(species{'AC5sub0','Obj'}, 'InitialAmount', 0);
      		set(species{'AC5sub1','Obj'}, 'InitialAmount', 0);
      		set(species{'AC5sub2','Obj'}, 'InitialAmount', 0);
		end
	
	dict = stim_DA_Ca(model, species);

