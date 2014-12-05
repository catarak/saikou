$(function() {
  createYearSlider();
  createWeekSlider();
});

function createYearSlider() {
  $("#year-slider").slider({
    min: 1955,
    max: 2014,
    value: 2014,
    slide: changeYearLabel
  });
  $("#year-number").text( $("#year-slider").slider("value"));
}

function createWeekSlider() {
  $("#week-slider").slider({
    min: 0,
    max: 53,
    value: currentWeek(),
    slide: changeWeekLabel
  });
  var year = $("#year-slider").slider("value");
  var week = $("#week-slider").slider("value");
  var weekDayString = toWeekString(findNextSaturday(week, year));
  $('#week-number').text(weekDayString);
}

function changeYearLabel(event, ui) {
  $("#year-number").text( ui.value );

  var year = ui.value
  var week = $("#week-slider").slider("value");
  var weekDayString = toWeekString(findNextSaturday(week, year));
  $('#week-number').text(weekDayString);  
}

function changeWeekLabel(event, ui) {
  var year = $("#year-slider").slider("value");
  var week = ui.value 
  var weekDayString = toWeekString(findNextSaturday(week, year));
  $('#week-number').text(weekDayString);
}

