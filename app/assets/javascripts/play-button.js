$(function() {
  playButtonListener();
});

function playButtonListener() {
  $(".countries").on("mouseenter", ".country-container", function(event) {
    $(this).children(".play-overlay").show();
  });
  $(".countries").on("mouseleave", ".country-container", function(event) {
    $(this).children(".play-overlay").hide();
  });
}
