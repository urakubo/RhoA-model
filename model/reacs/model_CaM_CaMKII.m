function model_CaM_CaMKII(model, params)

	%% CaMKII-CaM binding
	eid = Reac21('CK_N1C2'  , 'Ca' , 'CK_N2C2'				, 'kon_R_N'	,'_2koff_R_N', model);
	eid = Reac21('CK_N2C1'  , 'Ca' , 'CK_N2C2'				, 'kon_R_C'	,'_2koff_R_C', model);
	eid = Reac21('CKp_N1C2' , 'Ca' , 'CKp_N2C2'				, 'kon_R_N'	,'_2koff_R_N', model);
	eid = Reac21('CKp_N2C1' , 'Ca' , 'CKp_N2C2'				, 'kon_R_C'	,'_2koff_R_C', model);

	eid = ReacEnz('CKp', 'PP1', 'CK'						, 'Km_PP1', 'kcat_PP1', model);
	eid = ReacEnz('CKp_N1C2', 'PP1', 'CK_N1C2'				, 'Km_PP1', 'kcat_PP1', model);
	eid = ReacEnz('CKp_N2C1', 'PP1', 'CK_N2C1'				, 'Km_PP1', 'kcat_PP1', model);
	eid = ReacEnz('CKp_N2C2', 'PP1', 'CK_N2C2'				, 'Km_PP1', 'kcat_PP1', model);

	eid = Reac21('N2C2' , 'CK' , 'CK_N2C2'					, 'kon_CK_CaM', 'koff_CK_CaM', model);
	eid = Reac21('N2C1' , 'CK' , 'CK_N2C1'					, 'kon_CK_CaM', 'koff_CK_CaM', model);
	eid = Reac21('N1C2' , 'CK' , 'CK_N1C2'					, 'kon_CK_CaM', 'koff_CK_CaM', model);

	eid = Reac21('CKp', 'N1C2' , 'CKp_N1C2'					, 'kon_CKp_CaM', 'koff_CKp_CaM', model);
	eid = Reac21('CKp', 'N2C1' , 'CKp_N2C1'					, 'kon_CKp_CaM', 'koff_CKp_CaM', model);
	eid = Reac21('CKp', 'N2C2' , 'CKp_N2C2'					, 'kon_CKp_CaM', 'koff_CKp_CaM', model);

	eid = ReacOneWay('CK_N1C2', 'CKp_N1C2'					, 'tmpCK', model);
	eid = ReacOneWay('CK_N2C2', 'CKp_N2C2'					, 'tmpCK', model);
	eid = ReacOneWay('CK_N2C1', 'CKp_N2C1'					, 'tmpCK', model);
	eid = ReacOneWay('CK', 		'CKp'						, 'leakCKp', model);


	%% CaMKII
	set (params{'tmpCK','Obj'}, 'ConstantValue', false);
	r = addrule(model,'TotalCK = CK + CKp + CK_N1C2 + CK_N2C1 + CK_N2C2 + CKp_N1C2 + CKp_N2C1 + CKp_N2C2', 'repeatedAssignment');
	r = addrule(model,'ActiveCK =     CKp + CK_N1C2 + CK_N2C1 + CK_N2C2 + CKp_N1C2 + CKp_N2C1 + CKp_N2C2', 'repeatedAssignment');
	r = addrule(model,'ActiveRatio = ActiveCK/TotalCK', 'repeatedAssignment');
	r = addrule(model,'ActivationFactor = -0.220+1.826*ActiveRatio-0.800*ActiveRatio*ActiveRatio', 'repeatedAssignment');
	r = addrule(model,'tmpCK = tmpCK_Rate*ActivationFactor*(ActivationFactor > 0)', 'repeatedAssignment');
