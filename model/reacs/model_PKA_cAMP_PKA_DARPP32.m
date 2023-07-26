function model_PKA_cAMP_PKA_DARPP32(model,species)
	
	% cAMP-PKA associ
	eid = Reac21('R2C2', 		'cAMP', 'R2C2cAMP'  		, 'kon_A'	 , '_16koff_A', model);
	eid = Reac21('R2C2cAMP', 	'cAMP', 'R2C2cAMP2' 		, 'kon_A'	 , '_4koff_A', model);
	eid = Reac21('R2C2cAMP2',   'cAMP', 'R2C2cAMP3'  		, '_4kon_A' , 'koff_A', model);
	eid = Reac21('R2C2cAMP3', 	'cAMP', 'R2C2cAMP4' 		, '_16kon_A' , 'koff_A', model);

	eid = Reac12('R2C2cAMP4',   'Ct', 'R2C1cAMP4'  			, '_2koff_C'	, 'kon_C', model);
	eid = Reac12('R2C1cAMP4', 	'Ct', 'R2C0cAMP4' 			, 'koff_C'	, '_2kon_C', model);

	% Epac_cAMP associ
	set(species{'Epac_cAMP','Obj'}, 'ConstantAmount', false);
	set(species{'Epac_cAMP','Obj'}, 'BoundaryCondition', true);
	r = addrule(model,'Epac_cAMP = Epac * cAMP / (Kd_Epac + cAMP)','repeatedAssignment');

	% DARPP32-PP1 interaction
	eid = ReacEnz('D34p', 		'PP2B',	'D' 				, 'Km_T34DP',		'kcat_T34DP', model);
	eid = ReacEnz('D' 	, 		'Ct',	'D34p' 				, 'Km_T34P' ,		'kcat_T34P' , model);
	eid = ReacEnz('D34p_PP1', 	'PP2B',	'D_PP1' 			, 'Km_T34DP',		'kcat_T34DP', model);
	eid = ReacEnz('D_PP1' ,		'Ct',	'D34p_PP1' 			, 'Km_T34P' , 		'kcat_T34P' , model);
	eid = Reac21('D34p', 		'PP1',	'D34p_PP1' 			, 'kon_D32p_PP1',	'koff_D32p_PP1', model);
	eid = Reac12('D_PP1',		'D',	'PP1'	  			, 'koff_D32_PP1',	'Zero', model);

	r = addrule(model,'D34p_tot  = D34p_PP1 + D34p', 'repeatedAssignment');
