local id = 'JRC/GSW1_1/MonthlyRecurrence';
local successor_id = 'JRC/GSW1_3/MonthlyRecurrence';
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
  title: 'JRC Monthly Water Recurrence, v1.1 [deprecated]',
  version: '1.1',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains maps of the location and temporal
    distribution of surface water from 1984 to 2018 and provides
    statistics on the extent and change of those water surfaces.
    For more information see the associated journal article: [High-resolution
    mapping of global surface water and its long-term changes](https://www.nature.com/nature/journal/v540/n7633/full/nature20584.html)
    (Nature, 2016) and the online [Data Users Guide](https://storage.googleapis.com/global-surface-water/downloads_ancillary/DataUsersGuidev2.pdf).

    These data were generated using 3,865,618 scenes from Landsat
    5, 7, and 8 acquired between 16 March 1984 and 31 December 2018.
    Each pixel was individually classified into water / non-water
    using an expert system and the results were collated into a monthly
    history for the entire time period and two epochs (1984-1999,
    2000-2018) for change detection.

    The Monthly Recurrence collection contains 12 images: monthly measures of
    the seasonality of water based on the occurrence values detected in that
    month over all years.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'geophysical',
    'google',
    'history',
    'jrc',
    'landsat_derived',
    'monthly',
    'recurrence',
    'surface',
    'water',
  ],
  providers: [
    ee.producer_provider('EC JRC / Google', 'https://global-surface-water.appspot.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-03-16T00:00:00Z', '2019-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'month',
        description: 'Month',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'monthly_recurrence',
        description: 'The recurrence value expressed as a percentage for this month.',
        'gee:units': '%',
      },
      {
        name: 'has_observations',
        description: 'A flag to indicate if the month has observations.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Observations for the month.',
              bit_count: 1,
              values: [
                {
                  description: 'No valid observations',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'At least 1 valid observation was available',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Monthly Recurrence',
        lookat: {
          lat: -0.835,
          lon: -51.482,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'ffffff',
              'ffbbbb',
              '0000ff',
            ],
            bands: [
              'monthly_recurrence',
            ],
          },
        },
      },
    ],
    monthly_recurrence: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Jean-Francois Pekel, Andrew Cottam, Noel Gorelick, Alan S. Belward,
    High-resolution mapping of global surface water and its long-term changes.
    Nature 540, 418-422 (2016). ([doi:10.1038/nature20584](https://doi.org/10.1038/nature20584))
  |||,
  'gee:interval': {
    type: 'climatological_interval',
    unit: 'month',
    interval: 1,
  },
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
