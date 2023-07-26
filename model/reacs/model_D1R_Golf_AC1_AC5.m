function model_D1R_Golf_AC1_AC5(model)
	
	% DA_D1R associ
	eid = Reac21('DA', 'D1R', 'DA_D1R'						, 'kf_DA_D1R', 'kb_DA_D1R', model);

	% Golf_Gbc associ
	eid = Reac21('Golf_GDP', 'Gbc', 'Golf_Gbc' 				, 'kon_Gbc_Golf', 'Zero' , model);

	% DA_D1R, DA_A2AR; Golf production
	eid = ReacEnz2('Golf_Gbc', 'DA_D1R', 'Gbc', 'Golf_GTP'	, 'Km_exch_Golf', 'kcat_exch_Golf', model);
	eid = ReacEnz2('Golf_Gbc', 'A2AR', 'Gbc', 'Golf_GTP'	, 'Km_exch_Golf', 'kcat_exch_Golf_A2AR', model);

	% Hydro1, Hydro2
	eid = ReacOneWay('Golf_GTP', 'Golf_GDP'					, 'kcat_hyd_Golf', model);

	% Golf_GTP binding to AC1
	eid = Reac21('Golf_GTP', 'ACsub1', 'ACsub1_Golf_GTP'	, 'kon_AC_GolfGTP', 'koff_AC_GolfGTP', model);
	eid = Reac12('ACsub1_Golf_GDP', 'ACsub1', 'Golf_GDP'	, 'koff_AC_GolfGDP', 'kon_AC_GolfGDP', model);
	eid = ReacOneWay('ACsub1_Golf_GTP', 'ACsub1_Golf_GDP'	, 	'kcat_hyd_Golf', model);

	% Golf_GTP binding to AC5
	eid = Reac21('Golf_GTP', 'AC5sub1', 'AC5sub1_Golf_GTP'	, 'kon_AC5_GolfGTP' , 'koff_AC5_GolfGTP', model);
	eid = Reac12('AC5sub1_Golf_GDP', 'AC5sub1', 'Golf_GDP'	, 'koff_AC5_GolfGDP', 'kon_AC5_GolfGDP', model);
	eid = ReacOneWay('AC5sub1_Golf_GTP', 'AC5sub1_Golf_GDP'	, 'kcat_hyd_Golf', model);

	r = addrule(model,'AllGolf = Golf_Gbc + Golf_GTP + Golf_GDP + ACsub1_Golf_GTP + ACsub1_Golf_GDP', 'repeatedAssignment');
