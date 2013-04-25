App = Ember.Application.create();

App.Router.map(function() {
  this.route("about");
  this.route("schedule");
  this.route("achievements");
  this.route("contact");
});



$(function(){
	
	$('.nav').click(function(){
		$('body').scrollTo(0, 500, {easing:'swing'} );
		$('.top-bg').fadeOut(function(){
			$('.top-bg').css('background-image', "url('./img/pat_2_bw.jpg')").fadeIn();
		})
		setTimeout(function(){
			$('body').scrollTo('400px', 500, {easing:'swing'} );
		}, 1000);
		// $('body').scrollTo('450px', 500, {easing:'swing'} );

	})
})
