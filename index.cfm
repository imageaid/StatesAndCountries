<!--- @@Copyright: Copyright (c) 2011 ImageAid. All rights reserved. --->
<!--- @@License: Free :) --->
<cfsetting enablecfoutputonly="true">
	<h1>StatesAndCountries for Wheels v0.1.0</h1>
	<p>A very basic plugin to access arrays of US states, Canadian provinces, and Countries. I created this because I cannot recall an application that I've built over the years that did not need a State or Country drop-down in some form somewhere in the application. The plugin comes with three asset files: us_states.xml, canadian_provinces.xml, and countries.xml. When the plugin is initialized, these three XML files are read and the arrays for US states, Canadian provinces, and countries are created. From there, it's as simple as calling one of the get methods of the plugin, all of which return a two-dimensional array that contains the name of the element (be it a state, province or country) and the standard 2 character code for said element (e.g., US for the United States).</p>
	<h2>Usage</h2>                                                                                                                          
	<p>
		This plugin provides four methods for use in your controllers: <tt>getUSStates()</tt>, <tt>getCanadianProvinces()</tt>, <tt>getUSStatesAndCanadianProvinces()</tt> <tt>getCountries()</tt>. All methods do not accept parameters and all return an array. Each element in the returned array is a structure that contains two keys: <tt>name</tt> and <tt>abbreviation</tt>. 
	</p>                                                                                                                                                           
	<h2>Examples</h2>
	<p>Once installed, the plugin is quite easy to use. In the desired controller(s), call the plugin method you want to access.</p>
	<pre>
&lt;cfscript&gt;
	// this is an excerpt from a controller called Destinations (taken from a mountain guides web site)
	function show(){
	    destination = model("Destination").findOne(where="link_name='#lcase(link_name)#'");
	    // **This is a temporary hack ... see note at end of section for details
		$setSimpleFlickrConfig(argumentCollection=get("flickr")); // configure the SimpleFlickr plugin with the correct access data
        try{
			// call the plugin's getFlickrPhotoSetPhotos to grab the photos from the Flickr API call
            slideshow = getFlickrPhotoSetPhotos(photosetID = destination.flickr_set_id);
			// or, if you wanted to get your photos by a tag or tags, you could try one of the following
			slideshow = getFlickrPhotosByTags(tags = "puppies,dogs,beer",tagMode="any");
			// or ...
			slideshow = getFlickrPhotosByTags(tags = "coldfusion,cfml",tagMode="all",userUserID=false);
        }
        catch(Any e){
			// return an empty array if we encountered any problems with the Flickr API call.
            slideshow = [];
        }
	}
&lt;/cfscript&gt;
	</pre>
	<p>
		In the relevant view(s), you could loop over the arrays and output the images with something along the lines of the following:
	</p>
	<pre>
&lt;cfoutput&gt;
    &lt;div id="slider"&gt;
        &lt;cfloop array="#arguments.slideshow#" index="photo"&gt;
          #imageTag(source=photo.url, title=photo.title)#
        &lt;/cfloop&gt;
    &lt;/div&gt;
&lt;/cfoutput&gt;
	</pre>
	<h2>Credits</h2>
	<p>SimpleFlickr was created by <a href="http://craigkaminsky.posterous.com">Craig Kaminsky</a> of <a href="http://www.imageaid.net">ImageAid, Incorporated</a>.                                               
<cfsetting enablecfoutputonly="false">	