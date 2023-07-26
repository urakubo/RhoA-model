function model_CaM_AC1(model)


	% Ca/CaM + AC <=> AC-CaM binding state 1 (AC1)
	eid = Reac21('N0C0' ,'ACsub3', 'AC1_N0C0'  	, 'kon_AC_CaM_g_b2_b1', 'koff_AC_CaM', model);
	eid = Reac21('N0C1' ,'ACsub3', 'AC1_N0C1'  	, 'kon_AC_CaM_g_b2'   , 'koff_AC_CaM', model);
	eid = Reac21('N0C2' ,'ACsub3', 'AC1_N0C2'  	, 'kon_AC_CaM_g'      , 'koff_AC_CaM', model);
	
	eid = Reac21('N1C0' ,'ACsub3', 'AC1_N1C0'  	, 'kon_AC_CaM_g_b2_b1', 'koff_AC_CaM', model);
	eid = Reac21('N1C1' ,'ACsub3', 'AC1_N1C1'  	, 'kon_AC_CaM_g_b2'   , 'koff_AC_CaM', model);
	eid = Reac21('N1C2' ,'ACsub3', 'AC1_N1C2'  	, 'kon_AC_CaM_g'      , 'koff_AC_CaM', model);
	
	eid = Reac21('N2C0' ,'ACsub3', 'AC1_N2C0'  	, 'kon_AC_CaM_b2_b1'  , 'koff_AC_CaM', model);
	eid = Reac21('N2C1' ,'ACsub3', 'AC1_N2C1'  	, 'kon_AC_CaM_b2'     , 'koff_AC_CaM', model);
	eid = Reac21('N2C2' ,'ACsub3', 'AC1_N2C2'  	, 'kon_AC_CaM'        , 'koff_AC_CaM', model);

	eid = Reac21('AC1_N0C0' ,'Ca', 'AC1_N1C0'  	, '_2kon_T_N'	, 'koff_T_N'		, model);
	eid = Reac21('AC1_N1C0' ,'Ca', 'AC1_N2C0'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC1_N0C0' ,'Ca', 'AC1_N0C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC1_N0C1' ,'Ca', 'AC1_N0C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);
	eid = Reac21('AC1_N1C0' ,'Ca', 'AC1_N1C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC1_N0C1' ,'Ca', 'AC1_N1C1'  	, '_2kon_T_N'	, 'koff_T_N'		, model);

	eid = Reac21('AC1_N1C1' ,'Ca', 'AC1_N2C1'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC1_N1C1' ,'Ca', 'AC1_N1C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);
	eid = Reac21('AC1_N0C2' ,'Ca', 'AC1_N1C2'  	, '_2kon_T_N'	, 'koff_T_N'		, model);
	eid = Reac21('AC1_N2C0' ,'Ca', 'AC1_N2C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC1_N1C2' ,'Ca', 'AC1_N2C2'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC1_N2C1' ,'Ca', 'AC1_N2C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);


	% AC-CaM binding state 1 (AC1) <=> AC-CaM binding state 2 (AC2)
	eid = Reac11('AC1_N0C0' , 'AC2_N0C0'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC1_N0C1' , 'AC2_N0C1'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC1_N0C2' , 'AC2_N0C2'  	, 'kup_AC', 'kdown_AC', model);
	
	eid = Reac11('AC1_N1C0' , 'AC2_N1C0'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC1_N1C1' , 'AC2_N1C1'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC1_N1C2' , 'AC2_N1C2'  	, 'kup_AC', 'kdown_AC', model);
	
	eid = Reac11('AC1_N2C0' , 'AC2_N2C0'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC1_N2C1' , 'AC2_N2C1'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC1_N2C2' , 'AC2_N2C2'  	, 'kup_AC', 'kdown_AC', model);

	eid = Reac21('AC2_N0C0' ,'Ca', 'AC2_N1C0'  	, '_2kon_T_N'	, 'koff_T_N'		, model);
	eid = Reac21('AC2_N1C0' ,'Ca', 'AC2_N2C0'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC2_N0C0' ,'Ca', 'AC2_N0C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC2_N0C1' ,'Ca', 'AC2_N0C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);
	eid = Reac21('AC2_N1C0' ,'Ca', 'AC2_N1C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC2_N0C1' ,'Ca', 'AC2_N1C1'  	, '_2kon_T_N'	, 'koff_T_N'		, model);

	eid = Reac21('AC2_N1C1' ,'Ca', 'AC2_N2C1'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC2_N1C1' ,'Ca', 'AC2_N1C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);
	eid = Reac21('AC2_N0C2' ,'Ca', 'AC2_N1C2'  	, '_2kon_T_N'	, 'koff_T_N'		, model);
	eid = Reac21('AC2_N2C0' ,'Ca', 'AC2_N2C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC2_N1C2' ,'Ca', 'AC2_N2C2'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC2_N2C1' ,'Ca', 'AC2_N2C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);


	% AC-CaM binding state 2 (AC2) <=> AC-CaM binding state 3 (AC3)
	eid = Reac11('AC2_N0C0' , 'AC3_N0C0'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC2_N0C1' , 'AC3_N0C1'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC2_N0C2' , 'AC3_N0C2'  	, 'kup_AC', 'kdown_AC', model);

	eid = Reac11('AC2_N1C0' , 'AC3_N1C0'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC2_N1C1' , 'AC3_N1C1'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC2_N1C2' , 'AC3_N1C2'  	, 'kup_AC', 'kdown_AC', model);

	eid = Reac11('AC2_N2C0' , 'AC3_N2C0'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC2_N2C1' , 'AC3_N2C1'  	, 'kup_AC', 'kdown_AC', model);
	eid = Reac11('AC2_N2C2' , 'AC3_N2C2'  	, 'kup_AC', 'kdown_AC', model);

	eid = Reac21('AC3_N0C0' ,'Ca', 'AC3_N1C0'  	, '_2kon_T_N'	, 'koff_T_N'		, model);
	eid = Reac21('AC3_N1C0' ,'Ca', 'AC3_N2C0'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC3_N0C0' ,'Ca', 'AC3_N0C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC3_N0C1' ,'Ca', 'AC3_N0C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);
	eid = Reac21('AC3_N1C0' ,'Ca', 'AC3_N1C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC3_N0C1' ,'Ca', 'AC3_N1C1'  	, '_2kon_T_N'	, 'koff_T_N'		, model);

	eid = Reac21('AC3_N1C1' ,'Ca', 'AC3_N2C1'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC3_N1C1' ,'Ca', 'AC3_N1C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);
	eid = Reac21('AC3_N0C2' ,'Ca', 'AC3_N1C2'  	, '_2kon_T_N'	, 'koff_T_N'		, model);
	eid = Reac21('AC3_N2C0' ,'Ca', 'AC3_N2C1'  	, '_2kon_T_C'	, 'koff_T_C_b1'		, model);
	eid = Reac21('AC3_N1C2' ,'Ca', 'AC3_N2C2'  	, 'kon_R_N'		, '_2koff_R_N_g'	, model);
	eid = Reac21('AC3_N2C1' ,'Ca', 'AC3_N2C2'  	, 'kon_R_C'		, '_2koff_R_C_b2'	, model);

	tmp = 'AC_CaM = AC3_N0C0 + AC3_N0C1 + AC3_N0C2 + AC3_N1C0 + AC3_N1C1 + AC3_N1C2 + AC3_N2C0 + AC3_N2C1 + AC3_N2C2';
	r = addrule(model, tmp,'repeatedAssignment');
