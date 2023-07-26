function model_CaM_CN(model)
	% Ca-CaM binding
	r21 = [	"CN_N0C0" ,"Ca", "CN_N1C0" , "_2kon_CN_T_N", "koff_CN_T_N";
			"CN_N1C0" ,"Ca", "CN_N2C0" , "kon_CN_R_N"  , "_2koff_CN_R_N";
			"CN_N0C0" ,"Ca", "CN_N0C1" , "_2kon_CN_T_C", "koff_CN_T_C";
			"CN_N0C1" ,"Ca", "CN_N0C2" , "kon_CN_R_C"  , "_2koff_CN_R_C";
			%
			"CN_N1C0" ,"Ca", "CN_N1C1" , "_2kon_CN_T_C", "koff_CN_T_C";
			"CN_N0C1" ,"Ca", "CN_N1C1" , "_2kon_CN_T_N", "koff_CN_T_N";
			"CN_N1C1" ,"Ca", "CN_N2C1" , "kon_CN_R_N"  , "_2koff_CN_R_N";
			"CN_N1C1" ,"Ca", "CN_N1C2" , "kon_CN_R_C"  , "_2koff_CN_R_C";
			%
			"CN_N0C2" ,"Ca", "CN_N1C2" , "_2kon_CN_T_N", "koff_CN_T_N";
			"CN_N2C0" ,"Ca", "CN_N2C1" , "_2kon_CN_T_C", "koff_CN_T_C";
			"CN_N1C2" ,"Ca", "CN_N2C2" , "kon_CN_R_N"  , "_2koff_CN_R_N";
			"CN_N2C1" ,"Ca", "CN_N2C2" , "kon_CN_R_C"  , "_2koff_CN_R_C";
			%
			"N0C0" 	, "CN" , "CN_N0C0","kon_CN_N0C0" , "koff_CN_N0C0";
			"N1C0" 	, "CN" , "CN_N1C0","kon_CN_N1C0" , "koff_CN_N1C0";
			"N2C0" 	, "CN" , "CN_N2C0","kon_CN_N2C0" , "koff_CN_N2C0";
			%
			"N0C1" 	, "CN" , "CN_N0C1","kon_CN_N0C1" , "koff_CN_N0C1";
			"N1C1" 	, "CN" , "CN_N1C1","kon_CN_N1C1" , "koff_CN_N1C1";
			"N2C1" 	, "CN" , "CN_N2C1","kon_CN_N2C1" , "koff_CN_N2C1";
			%
			"N0C2" 	, "CN" , "CN_N0C2","kon_CN_N0C0" , "koff_CN_N0C2";
			"N1C2" 	, "CN" , "CN_N1C2","kon_CN_N1C2" , "koff_CN_N1C2";
			"N2C2" 	, "CN" , "CN_N2C2","kon_CN_N2C2" , "koff_CN_N2C2"
			];
	for i = 1:size(r21,1)
		eid = Reac21(r21(i,1) ,r21(i,2), r21(i,3), r21(i,4), r21(i,5), model);
	end
	r = addrule(model,'ActiveCN = CN_N0C0 + CN_N1C0 + CN_N2C0 + CN_N0C1 + CN_N1C1 + CN_N2C1 + CN_N0C2 + CN_N1C2 + CN_N2C2', 'repeatedAssignment');
