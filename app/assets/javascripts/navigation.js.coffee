$ ->
  $("body").bind "click", (e) ->
    $('.dropdown-toggle, .menu').parent("li").removeClass("open")

  $(".dropdown-toggle, .menu").click (e) ->
    $('.dropdown').removeClass('open')
    $(this).parent("li").toggleClass('open')
    return false

