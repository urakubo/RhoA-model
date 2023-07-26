function model_D2R_Gi_AC1(model)

	% DA-D2R binding => Gi
	eid = Reac21('DA', 'D2R', 'DA_D2R'						, 'kf_DA_D2R', 'kb_DA_D2R', model);

	% Gi_Gbc associ
	eid = Reac21('Gi_GDP', 'Gbc', 'Gi_Gbc' 					, 'kon_Gbc_Gi', 'Zero' , model);

	% DA_D2R; Gi production
	eid = ReacEnz2('Gi_Gbc', 'DA_D2R', 'Gbc', 'Gi_GTP'		, 'Km_exch_Gi', 'kcat_exch_Gi', model);

	% Hydro1, Hydro2
	eid = ReacEnz('Gi_GTP', 'RGS', 'Gi_GDP'					, 'Km_hyd_Gi' , 'kcat_hyd_Gi' , model);

	% Gi_GTP binding to AC1
	eid = Reac21('Gi_GTP', 'ACsub2', 'ACsub2_Gi_GTP'		, 'kon_AC_GiGTP', 'koff_AC_GiGTP', model);
	eid = Reac12('ACsub2_Gi_GDP'   , 'ACsub2' , 'Gi_GDP'	, 'koff_AC_GiGDP', 'kon_AC_GiGDP', model);
	eid = ReacEnz('ACsub2_Gi_GTP', 'RGS', 'ACsub2_Gi_GDP'	, 'Km_hyd_Gi' , 'kcat_hyd_Gi' , model);

	r = addrule(model,'AllGi = Gi_Gbc + Gi_GTP + Gi_GDP + ACsub2_Gi_GTP + ACsub2_Gi_GDP', 'repeatedAssignment');
