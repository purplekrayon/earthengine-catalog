local id = 'USGS/NLCD_RELEASES/2019_REL/RCMAP/V5/COVER';
local subdir = 'USGS/NLCD_RELEASES';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local template = import 'RCMAP.libsonnet';

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

template + {
  id: id,
  title: 'RCMAP Rangeland Component Timeseries v5 (1985-2021)',
  version: 'v5',
  links: ee.standardLinks(subdir, id) + [
  ],
  providers: [
    ee.producer_provider('United States Geological Survey and Bureau of Land Management', 'https://www.mrlc.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
}
