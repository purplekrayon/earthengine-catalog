local id = 'JRC/GSW1_0/Metadata';
local successor_id = 'JRC/GSW1_2/Metadata';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'JRC Global Surface Water Metadata, v1.0 [deprecated]',
  version: '1.0',
  deprecated: true,
  'gee:type': ee_const.gee_type.image,
  description: |||
    This dataset contains maps of the location and temporal
    distribution of surface water from 1984 to 2015 and provides
    statistics on the extent and change of those water surfaces.
    For more information see the associated journal article: [High-resolution
    mapping of global surface water and its long-term changes](https://www.nature.com/nature/journal/v540/n7633/full/nature20584.html)
    (Nature, 2016) and the online [Data Users Guide](https://storage.googleapis.com/global-surface-water/downloads_ancillary/DataUsersGuidev2.pdf).

    These data were generated using 3,066,102 scenes from Landsat
    5, 7, and 8 acquired between 16 March 1984 and 10 October 2015.
    Each pixel was individually classified into water / non-water
    using an expert system and the results were collated into a monthly
    history for the entire time period and two epochs (1984-1999,
    2000-2015) for change detection.

    This product contains metadata about the observations that went into
    computing The Global Surface Water dataset. Areas where water has never
    been detected are masked.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'geophysical',
    'google',
    'jrc',
    'landsat_derived',
    'surface',
    'water',
  ],
  providers: [
    ee.producer_provider('EC JRC / Google', 'https://global-surface-water.appspot.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-03-16T00:00:00Z', '2015-10-18T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'detections',
        description: 'The number of water detections in the study period.',
      },
      {
        name: 'valid_obs',
        description: 'The number of valid observations in the study period.',
      },
      {
        name: 'total_obs',
        description: 'The total number of available observations (i.e. scenes) in the study period.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Detections/Observations',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              100.0,
            ],
            max: [
              900.0,
            ],
            bands: [
              'detections',
              'valid_obs',
              'total_obs',
            ],
          },
        },
      },
    ],
    detections: {
      minimum: 0.0,
      maximum: 2007.0,
      'gee:estimated_range': true,
    },
    valid_obs: {
      minimum: 0.0,
      maximum: 2076.0,
      'gee:estimated_range': true,
    },
    total_obs: {
      minimum: 0.0,
      maximum: 2417.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Jean-Francois Pekel, Andrew Cottam, Noel Gorelick, Alan S. Belward,
    High-resolution mapping of global surface water and its long-term changes.
    Nature 540, 418-422 (2016). ([doi:10.1038/nature20584](https://doi.org/10.1038/nature20584))
  |||,
  'gee:terms_of_use': |||
    All data here is produced under the Copernicus Programme and is provided
    free of charge, without restriction of use. For the full license
    information see the Copernicus Regulation.

    Publications, models, and data products that make use of these datasets
    must include proper acknowledgement, including citing datasets and the
    journal article as in the following citation.

    If you are using the data as a layer in a published map, please include the
    following attribution text: 'Source: EC JRC/Google'
  |||,
  'gee:user_uploaded': true,
}
