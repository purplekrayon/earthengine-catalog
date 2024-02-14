local id = 'JAXA/ALOS/PALSAR/YEARLY/FNF';
local subdir = 'JAXA';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global 3-class PALSAR-2/PALSAR Forest/Non-Forest Map',
  'gee:type': ee_const.gee_type.image_collection,
  # TODO(simonf): add version links between this and FNF4 dataset
  # once reprocessed data for earlier years are released and ingested.
  version: 'H',
  description: |||
    A newer version of this dataset with 4 classes for 2017-2020 can be found in
    [JAXA/ALOS/PALSAR/YEARLY/FNF4](JAXA_ALOS_PALSAR_YEARLY_FNF4.html)

    The global forest/non-forest map (FNF) is generated by
    classifying the SAR image (backscattering coefficient) in the
    global 25m resolution PALSAR-2/PALSAR SAR mosaic so that strong and
    low backscatter pixels are assigned as \"forest\" and \"non-forest\",
    respectively. Here, \"forest\" is defined as the natural forest
    with the area larger than 0.5 ha and forest cover over 10%. This
    definition is the same as the Food and Agriculture Organization
    (FAO) definition. Since the radar backscatter from the forest
    depends on the region (climate zone), the classification of
    Forest/Non-Forest is conducted by using a region-dependent
    threshold of backscatter. The classification accuracy is
    checked by using in-situ photos and high-resolution optical
    satellite images. Detailed information is available in the provider's
    [Dataset Description](https://www.eorc.jaxa.jp/ALOS/en/palsar_fnf/DatasetDescription_PALSAR2_Mosaic_FNF_revE.pdf).

    Attention:

    *   Backscatter values may vary significantly from path to path
        over high latitude forest areas. This is due to the change of
        backscattering intensity caused by freezing trees in winter.
        Please note that this may affect the classification of
        forest/non-forest.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'alos',
    'alos2',
    'classification',
    'eroc',
    'forest',
    'jaxa',
    'landcover',
    'palsar',
    'palsar2',
    'sar',
  ],
  providers: [
    ee.producer_provider('JAXA EORC', 'https://www.eorc.jaxa.jp/ALOS/en/dataset/fnf_e.htm'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2007-01-01T00:00:00Z', '2018-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      25.0,
    ],
    'eo:bands': [
      {
        name: 'fnf',
        description: 'Forest/Non-Forest landcover classification',
        'gee:classes': [
          {
            value: 1,
            color: '006400',
            description: 'Forest',
          },
          {
            value: 2,
            color: 'feff99',
            description: 'Non-Forest',
          },
          {
            value: 3,
            color: '0000ff',
            description: 'Water',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Forest/Non-Forest Classification',
        lookat: {
          lat: 37.37,
          lon: 136.85,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              3.0,
            ],
            palette: [
              '006400',
              'feff99',
              '0000ff',
            ],
            bands: [
              'fnf',
            ],
          },
        },
      },
    ],
    fnf: {
      minimum: 1.0,
      maximum: 3.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Masanobu Shimada, Takuya Itoh, Takeshi Motooka, Manabu Watanabe,
    Shiraishi Tomohiro, Rajesh Thapa, and Richard Lucas, "New Global
    Forest/Non-forest Maps from ALOS PALSAR Data (2007-2010)", Remote Sensing
    of Environment, 155, pp. 13-31, December 2014.
    [doi:10.1016/j.rse.2014.04.014.](https://doi.org/10.1016/j.rse.2014.04.014)
  |||,
  'gee:terms_of_use': |||
    JAXA retains ownership of the dataset and cannot guarantee
    any problem caused by or possibly caused by using the datasets.
    Anyone wishing to publish any results using the datasets should
    clearly acknowledge the ownership of the data in the publication.
  |||,
}
