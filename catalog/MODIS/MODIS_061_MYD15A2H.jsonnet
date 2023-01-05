local id = 'MODIS/061/MYD15A2H';
local predecessor_id = 'MODIS/006/MYD15A2H';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD15A2H.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local predecessor_filename = predecessor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local predecessor_url = catalog_subdir_url + predecessor_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD15A2H.061: Aqua Leaf Area Index/FPAR 8-Day Global 500m',
  version: 'V061',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD15A2H V6.1 MODIS combined Leaf Area Index (LAI) and
    Fraction of Photosynthetically Active Radiation (FPAR) product is an 8-day
    composite dataset at 500m resolution. The algorithm chooses the \"best\" pixel
    available from all the acquisitions of the Aqua sensor from within the 8-day period.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/624/MOD15_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/90/MOD15_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MYD15A2H)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD15A2H.061',
    },
    ee.link.predecessor(predecessor_id, predecessor_url)
  ],
  keywords: [
    '8_day',
    'aqua',
    'fpar',
    'global',
    'lai',
    'modis',
    'myd15a2h',
    'nasa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD15A2H.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C203669704-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD15A2H.061',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
