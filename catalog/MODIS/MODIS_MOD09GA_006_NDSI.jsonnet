local id = 'MODIS/MOD09GA_006_NDSI';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'MODIS Terra Daily NDSI',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Normalized Difference Snow Index is used to
    identify snow, based on its characteristically higher reflectance in
    the visible portion of the spectrum compared to the mid-IR.  NDSI is
    computed using the Green and Mid-IR bands, and has a range of -1.0 to
    1.0. See
    [Riggs et al. (1994)](https://doi.org/10.1109/IGARSS.1994.399618)
    for details. This product is generated from the MODIS/006/MOD09GA surface reflectance composites.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'modis',
    'ndsi',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: {
    'eo:bands': [
      {
        name: 'NDSI',
        description: 'Normalized Difference Snow Index',
        gsd: 463.312716528,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Colorized',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            palette: [
              '000088',
              '0000FF',
              '8888FF',
              'FFFFFF',
            ],
            bands: [
              'NDSI',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  'gee:is_derived': true,
}
