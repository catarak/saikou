moment().format();

function findNextSaturday(week, year) {
    return moment().year(year).week(week).day("Saturday");
}

function toWeekString(date) {
    return date.format("dddd, MMMM Do");
}

function currentWeek() {
    return moment().week();
}