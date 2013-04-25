class window.AppViewModel
  constructor: ->
  
    _.bindAll(@, 'afterBinding')
    window.app = @

    Videos = Backbone.Collection.extend
      url: "http://gdata.youtube.com/feeds/api/users/patricktangolf/uploads?v=2&alt=jsonc"
      parse: (response) ->
        response.data.items
    
    @videos = new Videos()
    @videos.fetch
      success: (collection, response) ->
        console.log response
    @active_url = ko.observable(window.location.hash)
    return
  
  afterBinding: (vm, el) ->
    @router = @createRouter(el)
    Backbone.history.bind('route', => @active_url(window.location.hash))
    Backbone.history.start({hashChange: true})
  
  loadPage: (el) ->
    if @active_el 
      $(@active_el).hide('slow');
      ko.removeNode(@active_el)
    $('.page').append(@active_el = el).hide().fadeIn()
    $(el).addClass('active')
  
  createRouter: ->
    router = new Backbone.Router()
    @active_el = null
    router.route('', null, => @loadPage(kb.renderTemplate('home', {}))) 
    router.route('news', null, => @loadPage(kb.renderTemplate('news', {}))) 
    router.route('achievement', null, => @loadPage(kb.renderTemplate('achievement', {}))) 

    router.route('video', null, => @loadPage(kb.renderTemplate('video_list', new VideosViewModel(@videos)))) 
    
    router.route('video/:id', null, (id) => 
      @loadPage(kb.renderTemplate('video',{id: id}))) 

    router.route('photo', null, => @loadPage(kb.renderTemplate('photo', {}))) 
    router.route('contact', null, => @loadPage(kb.renderTemplate('contact', {}))) 

    
    return router

class window.VideoViewModel extends kb.ViewModel
  constructor: (model) ->
    super(model, {keys: ['description', 'title', 'thumbnail', 'id']})
    
    
window.VideosViewModel = (videos) ->
  #console.log(videos)
  @videos = kb.collectionObservable(videos, {view_model: VideoViewModel})
  return
