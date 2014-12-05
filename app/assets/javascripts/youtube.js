$(document).ready(function(){

  // user clicks button with cursor
  $(".countries").on("click", ".country-container", function() {
    var song = $(this).children(".song").text();
    var artist = $(this).children(".artist").text().slice(3);
    var query = artist + " - " + song;
    videoSearch(query);
  });

  function videoSearch(query){
    $.ajax({
      type: "GET", 
      url: "/play_song", 
      data: {search_keyword: query}
    }).done(function(results){
      modal.open({content: results});
    });
  };

});


