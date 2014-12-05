var map = new L.Map('map', {
    scrollWheelZoom: false,
    touchZoom: false,
    doubleClickZoom: false,
    zoomControl: false,
    dragging: false
}).setView([20, 0], 2);

var mapTileLayer = new L.TileLayer('http://{s}.tiles.mapbox.com/v3/ctarakajian.kd10e6g3/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18
});

map.addLayer(mapTileLayer);

var defaultStyle = {
    'color': '#000',
    'weight': 1,
    'opacity': 0.5,
    fill: false
};

var highlightStyle = {
    fill: true,
    weight: 2,
    color: '#FFF',
    fillColor: '#F00',
    fillOpacity: 0.7
};

var countryLayerGroup = new L.LayerGroup();

var onEachFeature = function(feature, layer) {
    layer.setStyle(defaultStyle);
    (function(layer, properties) {
        layer.on("mouseover", function (e) {
            // Change the style to the highlighted version
            layer.setStyle(highlightStyle);
            //layer.bindPopup(feature.properties.name);
            //layer.openPopup();
        });
        layer.on("mouseout", function (e) {
            // Start by reverting the style back
            layer.setStyle(defaultStyle); 
            //layer.closePopup();
            //layer.unbindPopup(feature.properties.name);
        });
    })(layer, feature.properties);
};

for (var key in countries) {
  addCountryLayer(key, defaultStyle);
}
countryLayerGroup.addTo(map);
 
//map is officially initialized HERE

function addCountryLayer(countryName, style) {
  var layer = L.geoJson(countries[countryName], {
    onEachFeature: onEachFeature,
    style: style
  });
  countryLayerGroup.addLayer(layer);
}




//get songs
$(function() {
  $("#get-songs").click(function() {
    getSongsForCurrentWeek();
    //edit map
  });
});

function getSongsForCurrentWeek() {
  var year = $("#year-slider").slider("value");
  var week = $("#week-slider").slider("value");
  var url = "/api/years/" + year + "/weeks/" + week + "/songs"
  $.getJSON( url, function( data ) {
    updateCountriesWithSongs(data)
  });
}

function updateCountriesWithSongs(data) {
  // while (layers.length > 0) {
  //   map.removeLayer(layers[0]);
  //   //layers[0].clearLayers();
  //   layers.shift();
  // }
  countryLayerGroup.clearLayers();


  data.countries.forEach(function(country) {
    addCountryLayer(country.name, highlightStyle); 
  });
  // for (var country in data.countries) {
  //   addCountryLayer(country.name, highlightStyle); 
  // }
  countryLayerGroup.addTo(map);
  debugger;
}
















