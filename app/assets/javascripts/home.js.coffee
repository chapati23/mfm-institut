# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  #$('li').attr('contenteditable', true)

  hideProduct = ($produkt, $details) ->
    $details.removeClass('active').addClass('inactive')
    $produkt.removeClass('active')

  showProduct = ($produkt, $details) ->
    $produkt.addClass('active')
    $details.removeClass('inactive').addClass('active')


  $(".produkt").click ->
    $produkt = $(this)
    $details = $produkt.next('.details')

    # Wenn das angeklickte Produkt bereits sichtbar ist, dann deaktiviere das Produkt
    if $('.details.active').length and $produkt.hasClass('active')
      hideProduct($produkt, $details)

    # Wenn es ein aktives Produkt gibt und das aktive Produkt NICHT das angeklickte ist
    # dann verstecke das sichtbare Produkt und aktiviere das angeklickte Produkt
    else if $('.details.active').length and !$produkt.hasClass('active')
      $activeDetails = $('.details.active').css(transitionDelay: '0', transitionDuration: '0').removeClass('active').addClass('inactive')
      setTimeout ->
        $activeDetails.css(transition: "")
      , 200
      $('.produkt.active').removeClass('active')
      showProduct($produkt, $details)

      $details.click -> hideProduct($produkt, $details)

    else
      showProduct($produkt, $details)
      $details.click -> hideProduct($produkt, $details)
