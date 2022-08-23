function fn () {
	var config = {};
	var env = karate.env;
	karate.log('Environment test is running :'+env);
	karate.configure('connectTimeout',60000);
	karate.configure('readTimeout', 60000);
	//To run APIs in different environment, Base path can be added depending on environment
	if(env == 'Test'){
		config={
				url:'https://gitlab.com/api/v4/projects/',
				env:'Test'
	    }
	} else if(env == 'Acceptance'){
		config={
				env:'Acceptance',
				url:'https://gitlab.com/api/v4/projects/'
	    }
	} else {
		config={
				env:'Dev',
				url:'https://gitlab.com/api/v4/projects/'
	    }
	}
	
  return config;
}
