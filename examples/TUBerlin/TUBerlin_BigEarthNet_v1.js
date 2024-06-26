var geometry = ee.Geometry.Polygon(
    [[
      [16.656886757418057, 48.27086673747943],
      [16.656886757418057, 48.21359065567954],
      [16.733276070162198, 48.21359065567954],
      [16.733276070162198, 48.27086673747943]]]);

var ic = ee.ImageCollection('TUBerlin/BigEarthNet/v1');

var filtered = ic.filterBounds(geometry);

var tiles = filtered.map(function(image) {
  var labels = ee.List(image.get('labels'));

  var urban = labels.indexOf('Discontinuous urban fabric').gte(0);
  var highlight_urban = ee.Image(urban).toInt().multiply(1000);

  return image.addBands(
      {srcImg: image.select(['B4']).add(highlight_urban), overwrite: true});
});

var image = tiles.mosaic().clip(geometry);

var visParams = {bands: ['B4', 'B3', 'B2'], min: 0, max: 3000};

Map.addLayer(image, visParams);
Map.centerObject(image, 13);
