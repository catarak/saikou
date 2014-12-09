var MAX_YEAR = currentYear();
var MIN_YEAR = 1958;

$(function() {
  createYearSlider();
  createWeekSlider();

  var week = $("#week-slider").slider("value");
  var year = $("#year-slider").slider("value");
  getSongsForCurrentWeek(week, year);

  randomDateListener();
});

function createYearSlider() {
  $("#year-slider").slider({
    min: 1958,
    max: currentYear(),
    value: currentYear(),
    slide: changeYearLabel
  });
  $("#year-number").text( $("#year-slider").slider("value"));
}

function createWeekSlider() {
  $("#week-slider").slider({
    min: 0,
    max: currentWeek(),
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

  if (year === currentYear()) {
    $("#week-slider").slider("option","max", currentWeek()); 
  }
  else {
    $("#week-slider").slider("option","max", weeksInYear(year)); 
  }

  getSongsForCurrentWeek(week, year);
}

function changeWeekLabel(event, ui) {
  var year = $("#year-slider").slider("value");
  var week = ui.value 
  var weekDayString = toWeekString(findNextSaturday(week, year));
  $('#week-number').text(weekDayString);

  getSongsForCurrentWeek(week, year);
}

function randomDateListener() {
  
}

