var map;
var mapTileLayer;
var countryLayerGroup = new L.LayerGroup();

var defaultStyle = {
    'color': '#000',
    'weight': .3,
    'opacity': 0.5,
    fill: false
};

var highlightStyle = {
    fill: true,
    weight: 2,
    color: '#FFF',
    fillColor: '#FFEB99',
    fillOpacity: 0.5
};

function init() {
  map = new L.Map('map', {
      scrollWheelZoom: false,
      touchZoom: false,
      doubleClickZoom: false,
      zoomControl: false,
      dragging: false
  }).setView([20, 0], 2);

  mapTileLayer = new L.TileLayer('http://{s}.tiles.mapbox.com/v3/ctarakajian.kd10e6g3/{z}/{x}/{y}.png', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: 18
  });

  map.addLayer(mapTileLayer);

  for (var key in countries) {
      addCountryLayer(key, defaultStyle);
  }
  countryLayerGroup.addTo(map);

}

var onEachFeature = function(feature, layer) {
    layer.setStyle(highlightStyle);
    (function(layer, properties) {
        layer.on("mouseover", function (e) {
            // Change the style to the highlighted version
            //layer.setStyle(highlightStyle);
            //layer.bindPopup(feature.properties.name);
            //layer.openPopup();
        });
        layer.on("mouseout", function (e) {
            // Start by reverting the style back
            //layer.setStyle(defaultStyle); 
            //layer.closePopup();
            //layer.unbindPopup(feature.properties.name);
        });
        layer.on("click", function (e) {
          var popupText = "<b>" + feature.properties.name +"</b><br>" + feature.properties.chart + "<br>"
                          + feature.properties.song + "<br>" + feature.properties.artist
          layer.bindPopup(popupText);
          //var popup = L.popup().setLatLng(e.latlng)

        });
    })(layer, feature.properties);
};
 
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

function getSongsForCurrentWeek(week, year) {
  // var year = $("#year-slider").slider("value");
  // var week = $("#week-slider").slider("value") - 1;
  var url = "http://saikou-api.herokuapp.com/api/v1/years/" + year + "/weeks/" + (week - 1) + "/songs"
  $.getJSON( url, function( data ) {
    updateCountriesWithSongs(data)
  }).error(function() {
    clearAllCountries();
  });
}

function clearAllCountries() {
  countryLayerGroup.clearLayers();
  $(".countries").empty();
}

function updateCountriesWithSongs(data) {
  clearAllCountries();

  data.countries.forEach(function(country) {
    addCountryLayer(country.name, highlightStyle);
    var countryProperties = countries[country.name].features[0].properties;
    countryProperties.chart = country.charts[0].name
    countryProperties.song = country.charts[0].song.name
    countryProperties.artist = country.charts[0].song.artist
    addCountryToSongsTable(countryProperties);
  });

  countryLayerGroup.addTo(map);
}

function addCountryToSongsTable(countryProperties) {
    //do all that magic here
    //country
    //song
    //artist
    //source
    html = '<div class="country-container">' +
              '<span class="country-name">' + countryProperties.name +'</span><br>' +
              '<span class="song">'+ countryProperties.song +'</span><br>' +  
              '<span class="artist">by '+ countryProperties.artist +'</span><br>' + 
              '<span class="chart">source: ' + countryProperties.chart + '</span>' +
           '</div>';
    $(".countries").append(html);
}


init();















