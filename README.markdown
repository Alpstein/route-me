Route-Me: iOS map library (Alpstein fork)
-----------------------------------------

Route-Me is an open source map library that runs natively on iOS.  It's designed to look and feel much like the built-in iOS map library, but it's entirely open, and works with any map source.

Currently, [OpenStreetMap][1], [OpenCycleMap][2], [OpenSeaMap][3], [MapQuest OSM][4], [MapQuest Open Aerial][5] and an offline, database-backed format called DBMap are supported as map sources.

Please note that you are responsible for getting permission to use the map data, and for ensuring your use adheres to the relevant terms of use.

MapBox users might be interested in the [MapBox fork][6], which includes lots of MapBox specific additions to Route-Me.

   [1]: http://www.openstreetmap.org/index.html
   [2]: http://www.opencyclemap.org/
   [3]: http://www.openseamap.org/
   [4]: http://developer.mapquest.com/web/products/open/map
   [5]: http://developer.mapquest.com/web/products/open/map
   [6]: http://mapbox.com/mapbox-ios-sdk


Installation
------------

As Route-Me is undergoing some significant changes, the recommended course of action is to clone a copy of the repository:

      git://github.com/Alpstein/route-me.git

Or, [download the trunk][dl].

Then, update the submodules:

      git submodule update --init

After this, copy or alias all the resources in the MapView/Map/Resources folder to your project.

See the 'samples' subdirectory for usage examples.

There are three subdirectories - MapView, Proj4, and samples. Proj4 is a support class used to do map projections. The MapView project contains only the route-me map library. "samples" contains some ready-to-build projects which you may use as starting points for your own applications, and also some engineering test cases. `samples/MarkerMurder` and `samples/ProgrammaticMap` are the best places to look, to see how to embed a Route-Me map in your application.

See License.txt for license details. In any app that uses the Route-Me library, include the following text on your "preferences" or "about" screen: "Uses Route-Me map library, (c) 2008-2013 Route-Me Contributors". Your data provider will have additional attribution requirements.


   [dl]: https://github.com/Alpstein/route-me/zipball/release
   
   
News, Support and Contributing
------------------------------

Join our [mailing list][list] for news and to communicate with project members and other users:

To report bugs and help fix them, please use the [issue tracker][tracker]

[list]: http://groups.google.com/group/route-me-map
[tracker]: https://github.com/Alpstein/route-me/issues


Major changes in this fork (Alpstein/route-me)
----------------------------------------------

* RMMapView and RMMapContents have been merged into one file

* The map uses an UIScrollView with a CATiledLayer for better performance

* Tile cache refactoring

* Tile source refactoring

* Support for tile sources with multiple layers (e.g. OpenSeaMap)

* Support for multiple tile sources on the map

* Numerous performance improvements

* Markers have been refactored into a MKMapView-like system, with annotations and on-demand markers

* Automatic annotation clustering

* Snapshots from the map

* Requires iOS 5 or greater, Xcode 4.3 or greater, and Automatic Reference Counting (ARC). 


Dependent Libraries
-------------------

Route-Me makes use of several sub-libraries, listed below. See License.txt for more detailed information about Route-Me and Proj4 and see the individual license files in the sub-libraries for more information on each. 

 * [FMDB](https://github.com/ccgus/fmdb) by Gus Mueller (SQLite for caching)
 * [SMCalloutView](https://github.com/nfarina/calloutview) by Nick Farina (annotation callouts)
