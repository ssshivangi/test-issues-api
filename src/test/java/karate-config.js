function fn() {
	var config = { };
	var env = karate.env;
	karate.log('Environment test is running :'+env);
	karate.configure('connectTimeout',60000);
	karate.configure('readTimeout', 60000);

	//To run APIs in different environment, Base path can be added depending on environment
	if(env == 'Test'){
		config={
			env:'Test',
			baseUrl:'https://gitlab.com/api/v4/projects/38809690/',
			token:'glpat-TEFkYoiN5MpybMG1GaYq'
	    }
	} else if(env == 'Acceptance'){
		config={
			env:'Acceptance',
			baseUrl:'https://gitlab.com/api/v4/projects/38809690/',
			token:'glpat-TEFkYoiN5MpybMG1GaYq'
	    }
	}else {
		config={
			env:'Dev',
			baseUrl:'https://gitlab.com/api/v4/projects/38809690/',
			token:'glpat-TEFkYoiN5MpybMG1GaYq'
		}
	}
  return config;
}
