<!--- @@Copyright: Copyright (c) 2011 ImageAid. All rights reserved. --->
<!--- @@License: Free :) --->
<cfsetting enablecfoutputonly="true">
	<h1>StatesAndCountries for Wheels v1.0</h1>
	<p>A very basic plugin to access queries for US states, Canadian provinces, and Countries. I created this because I cannot recall an application that I've built over the years that did not need a State or Country drop-down in some form somewhere in the application.</p>
	<p>The plugin comes with three asset files: us_states.xml, canadian_provinces.xml, and countries.xml. The three aforementioned XML files are read and queries for US states, Canadian provinces, and countries are created and then stored in the application scope whenever you call a specific method for the first time (subsequent calls will pull the data from the application scope).</p>
	<h2>Usage</h2>                                                                                                                          
	<p>
		This plugin provides four methods for use in your controllers: <tt>getUSStates()</tt>, <tt>getCanadianProvinces()</tt>, <tt>getUSStatesAndCanadianProvinces()</tt> <tt>getCountries()</tt>. All methods do not accept parameters and all return a query. Each row in the returned query has two columns: <tt>name</tt> and <tt>abbreviation</tt>. 
	</p>                                                                                                                                                           
	<h2>Examples</h2>
	<p>Once installed, the plugin is quite easy to use. In the desired controller(s), call the plugin method you want to access.</p>
	<pre>
&lt;cfscript&gt;
	// this is an excerpt from a controller called Users
	function new(){
	    usStates = getUSStates();
		countries = getCountries();
		user = model("User").new();
		renderPage(layout="admin");
	}
&lt;/cfscript&gt;
	</pre>
	<p>
		In the relevant view, you could loop over the queries and output the data or use the queries in a select() call along the lines of the following:
	</p>
	<pre>
&lt;cfoutput&gt;
    &lt;div class="form_field"&gt;
      #select(objectName='user', property='state', label='State', options=usStates, valueField="abbreviation", textField="name")#
    &lt;/div&gt;
	&lt;div class="form_field"&gt;
      #select(objectName='user', property='state', label='State', options=countries, valueField="abbreviation", textField="name")#
    &lt;/div&gt;
&lt;/cfoutput&gt;
	</pre>
	<h2>Credits</h2>
	<p>SimpleFlickr was created by <a href="http://craigkaminsky.posterous.com">Craig Kaminsky</a> of <a href="http://www.imageaid.net">ImageAid, Incorporated</a>.                                               
<cfsetting enablecfoutputonly="false">	