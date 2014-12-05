$(function() {
  createSliders();

});

function createSliders() {
  $("year-slider").slider({
    min: 1955,
    max: 2014,
    value: 2014,
    slide: changeYearLabel
  });
  $("#year-number").val( $("#year-slider").slider("value"));
}

function changeYearLabel(event, ui) {
  $("#year-number").val( ui.value );
}


var map = L.map('map').setView([0, 0], 2);


L.tileLayer('http://{s}.tiles.mapbox.com/v3/ctarakajian.kd10e6g3/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18
}).addTo(map);

var countryStyle = {
    'color': '#000',
    'weight': 1,
    'opacity': 0.5
};

L.geoJson(subunits, {
    onEachFeature: popup,
    style: countryStyle
}).addTo(map);

function popup(feature, layer) {
    if (feature.properties && feature.properties.name) {
        layer.bindPopup(feature.properties.name);
    }
}