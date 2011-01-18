<!--- @@Copyright: Copyright (c) 2011 ImageAid. All rights reserved. --->
<!--- @@License: Free :). Whatever. It's just a stupid little helper plugin --->
<cfcomponent output="false" mixin="controller">
	
	<cfproperty name="us_states" type="string" displayname="US States" hint="I am a two-dimensional array representing all US states" />
	<cfproperty name="canadian_provinces" type="string" displayname="Canadian Provinces" hint="I am a two-dimensional array representing all Canadian Provinces" />
	<cfproperty name="countries" type="string" displayname="Countries" hint="I am a two-dimensional array representing all countries" />
	
	<cffunction access="public" returntype="StatesAndCountries" name="init">
		<cfscript>
			this.version = "1.1,1.1.1";//sets the Wheels versions the plugin is compatible with. 
			return this;
		</cfscript> 
	</cffunction>
	
	<cffunction name="getUSStates" returntype="query" access="public" output="false" displayname="getUSStates" hint="I return an array of structures for US states">
		<cfscript>			
			return $loadElements("us_states");
		</cfscript>
	</cffunction> 
	
	<cffunction name="getCanadianProvinces" returntype="query" access="public" output="false" displayname="getCanadianProvinces" hint="I return an array of structures for Canadian provinces">
		<cfscript> 
			return $loadElements("canadian_provinces");
		</cfscript>
	</cffunction>
	
	<cffunction name="getUSStatesAndCanadianProvinces" returntype="query" access="public" output="false" displayname="getUSStatesAndCanadianProvinces" hint="I return an array of structures for US states and Canadian provinces">
		<cfscript>			
			return $loadElements("us_states_and_canadian_provinces");
		</cfscript>
	</cffunction>
	
	<cffunction name="getCountries" returntype="query" access="public" output="false" displayname="getCountries" hint="I return an array of structures countries">
		<cfscript>			
			return $loadElements("countries");
		</cfscript>
	</cffunction>
	
	<!--- PRIVATE METHODS -- sort of --->
	<cffunction name="$loadElements" access="public" returntype="query" output="false" displayname="$loadElements" hint="I setup the arrays">
		<cfargument name="item_to_load" type="string" required="false" default="us_states" displayname="item_to_load" hint="I represend the items to load" />
		<cfscript>
			var us_states_xml = xmlNew();
			var canadian_provinces_xml = xmlNew();
			var countries_xml = xmlNew();
			variables.us_states = queryNew("name,abbreviation");
			variables.canadian_provinces = queryNew("name,abbreviation");
			variables.countries = queryNew("name,abbreviation");
		</cfscript>
		<cfswitch expression="#trim(lcase(arguments.item_to_load))#">
			<cfcase value="us_states">
				<cffile action="read" file="assets/us_states.xml" variable="us_states_content" />  
				<cfscript>					         
					if(!structKeyExists(application,"usStates")){
						application.usStates = variables.us_states;
						us_states_xml = xmlParse(us_states_content);
						for(i = 1; i lte arrayLen(us_states_xml.XMLChildren[1].XMLChildren); i = i + 1){
							variables.us_states[i].name = us_states_xml.XMLChildren[1].XMLChildren[i].XMLChildren[1].xmlText;
							variables.us_states[i].abbreviation = us_states_xml.XMLChildren[1].XMLChildren[i].XMLChildren[2].xmlText;
						}
					}
					return application.usStates;
				</cfscript>
			</cfcase> 
			<cfcase value="canadian_provinces">
				<cffile action="read" file="assets/canadian_provinces.xml" variable="canadian_provinces_content" />
				<cfscript>        
					if(!structKeyExists(application,"canadianProvinces")){
						application.canadianProvinces = variables.canadian_provinces;
						canadian_provinces_xml = xmlParse(canadian_provinces_content);
						for(i = 1; i lte arrayLen(canadian_provinces_xml.XMLChildren[1].XMLChildren); i = i + 1){
							variables.canadian_provinces[i].name = canadian_provinces_xml.XMLChildren[1].XMLChildren[i].XMLChildren[1].xmlText;
							variables.canadian_provinces[i].abbreviation = canadian_provinces_xml.XMLChildren[1].XMLChildren[i].XMLChildren[2].xmlText;
						}
					}         
					return application.canadianProvinces;                                
				</cfscript>
			</cfcase>
			<cfcase value="us_states_and_canadian_provinces">
				
				<cfscript>
					if(!structKeyExists(application,"usStatesAndCanadianProvinces")){
						us_states_xml = xmlParse(us_states_content);
						canadian_provinces_xml = xmlParse(canadian_provinces_content);
						for(i = 1; i lte arrayLen(us_states_xml.XMLChildren[1].XMLChildren); i = i + 1){
							variables.us_states[i].name = us_states_xml.XMLChildren[1].XMLChildren[i].XMLChildren[1].xmlText;
							variables.us_states[i].abbreviation = us_states_xml.XMLChildren[1].XMLChildren[i].XMLChildren[2].xmlText;
						}
						for(i = 1; i lte arrayLen(canadian_provinces_xml.XMLChildren[1].XMLChildren); i = i + 1){
							variables.canadian_provinces[i].name = canadian_provinces_xml.XMLChildren[1].XMLChildren[i].XMLChildren[1].xmlText;
							variables.canadian_provinces[i].abbreviation = canadian_provinces_xml.XMLChildren[1].XMLChildren[i].XMLChildren[2].xmlText;
						}                                                 
					}  
					return application.usStatesAndCanadianProvinces; 
				</cfscript>
			</cfcase>
			<cfcase value="countries">
				<cffile action="read" file="assets/countries.xml" variable="countries_content" /> 
				<cfscript>                                                 
					if(!structKeyExists(application,"countries")){
						countries_xml = xmlParse(countries_content); 
						for(i = 1; i lte arrayLen(countries_xml.XMLChildren[1].XMLChildren); i = i + 1){
							variables.countries[i].name = countries_xml.XMLChildren[1].XMLChildren[i].xmlText;
							variables.countries[i].abbreviation = countries_xml.XMLChildren[1].XMLChildren[i].XMLAttributes.code;
						}           
						application.countries = variables.countries;				
					}                                
					return application.countries;
				</cfscript>
			</cfcase>
		</cfswitch>		                      
	</cffunction>
	
</cfcomponent>