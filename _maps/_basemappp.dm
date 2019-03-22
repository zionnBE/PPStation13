//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#define FORCE_MAP "_maps/ppstation.json"

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\generic\City_of_Cogs.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\PPStation\ppstation.dmm"

		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
