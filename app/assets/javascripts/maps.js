
var map = L.map('map').setView([20, 0], 2);


L.tileLayer('http://{s}.tiles.mapbox.com/v3/ctarakajian.kd10e6g3/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18
}).addTo(map);

var countryStyle = {
    'color': '#000',
    'weight': 1,
    'opacity': 0.5
};

L.geoJson(countries, {
    onEachFeature: popup,
    style: countryStyle
}).addTo(map);

function popup(feature, layer) {
    if (feature.properties && feature.properties.name) {
        layer.bindPopup(feature.properties.name);
    }
}

function getSongsForCurrentWeek() {
  var year = $("#year-slider").slider("value");
  var week = $("#week-slider").slider("value");
  var url = "/api/years/2014/" + year + "/48/" + week
  $.ajax(url, {

  });


}