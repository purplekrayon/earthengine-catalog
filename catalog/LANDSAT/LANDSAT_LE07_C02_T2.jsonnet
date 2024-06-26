local id = 'LANDSAT/LE07/C02/T2';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LE07_C02.libsonnet';

local versions = import 'versions.libsonnet';
local version_table = import 'LE7_T2_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'USGS Landsat 7 Collection 2 Tier 2 Raw Scenes',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 7 Collection 2 Tier 2 DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier2 + landsat.l7_drift,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'c2',
    'etm',
    'global',
    'l7',
    'landsat',
    'le7',
    'radiance',
    't2',
    'tier2',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/land-resources/nli/landsat/landsat-7-data-users-handbook'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1999-05-28T01:05:28Z', null),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
