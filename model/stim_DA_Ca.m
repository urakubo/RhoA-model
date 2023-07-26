%
function dict = stim_DA_Ca(model, species);

	% Stepwise stims of DA and Ca (0.1 Hz, 15 times)
	% inter stimulus interval (ISI) = 10.0 s
	prerun      = 2000.0;
	ISI         = 10.0;
	duration_DA = 0.4;
	duration_Ca = 1.0;
	Toffset_Ca  = 0.0;
	Toffset_DA  = 1.0;

	% prerun   = addparameter(model, 'prerun', prerun);
	
	dict = dictionary;
	dict('prerun') = addparameter(model, 'prerun', prerun);
	dict('ISI')    = addparameter(model, 'ISI'   , ISI);
	
	dict('duration_DA') = addparameter(model, 'duration_DA' , duration_DA);
	dict('Toffset_DA')  = addparameter(model, 'Toffset_DA'  , Toffset_DA);
	dict('DA_basal')    = addparameter(model, 'DA_basal', 0.0);
	dict('DA_stim')     = addparameter(model, 'DA_stim' , 1.0);

	dict('duration_Ca') = addparameter(model, 'duration_Ca' , duration_Ca);
	dict('Toffset_Ca')  = addparameter(model, 'Toffset_Ca'  , Toffset_Ca);
	dict('Ca_basal')    = addparameter(model, 'Ca_basal', 0.0);
	dict('Ca_stim')     = addparameter(model, 'Ca_stim' , 0.8);

	%
	e1 = addevent(model,'time>0', 'Ca = Ca_basal' );
	for i = 0:14;
		stim_start = sprintf('time>=prerun+Toffset_Ca+%d*ISI',i);
		stim_stop  = sprintf('time>=prerun+Toffset_Ca+%d*ISI + duration_Ca',i);
		e1   = addevent(model, stim_start, 'Ca = Ca_stim'  );
		e1   = addevent(model, stim_stop , 'Ca = Ca_basal' );
	end
	set(species{'DA','Obj'}, 'ConstantAmount', false);
	set(species{'DA','Obj'}, 'BoundaryCondition', true);

	%
	e1 = addevent(model,'time>0', 'DA = DA_basal' );
	for i = 0:14;
		stim_start = sprintf('time>=prerun+Toffset_DA+%d*ISI',i);
		stim_stop  = sprintf('time>=prerun+Toffset_DA+%d*ISI + duration_DA',i);
		e1   = addevent(model, stim_start, 'DA = DA_stim'  );
		e1   = addevent(model, stim_stop , 'DA = DA_basal' );
	end
	
	
