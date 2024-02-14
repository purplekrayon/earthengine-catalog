var noaa_viirs = ee.ImageCollection('NASA/LANCE/NOAA20_VIIRS/C2')
                   .filter(ee.Filter.date('2023-10-08', '2023-10-30'))
var band_vis = {
  min: [
    280.0,
  ],
  max: [
    400.0,
  ],
  palette: ['yellow', 'orange', 'red', 'white', 'darkred'],
  bands: [
    'Bright_ti4',
  ],
}
Map.setCenter(-113.2487, 59.3943, 8);
Map.addLayer(noaa_viirs, band_vis, 'NOAA nrt firms')