$ ->
  $description = $('.description')
  $signature = $('.signature')
  $stage = $('.stage')
  $('.details').attr('contenteditable', true)

  hideProduct = ($produkt, speed) ->
    speed ? speed : 'normal'
    $produkt.name       = $produkt.attr("name")
    $produkt.details    = $produkt.next(".details")
    $produkt.removeIcon = $produkt.details.children('.icon-remove-sign')

    # disable animations if speed is set to 'fast'
    if speed is 'fast' then $produkt.details.addClass('disable-animations')

    # blend out product
    $produkt.removeIcon.hide()
    $produkt.details.removeClass('active').addClass('inactive')
    $produkt.removeClass('active')

    # unblur background image
    callback = -> $stage.removeClass('inactive')
    setTimeout callback, 100

    # fade in default content
    $description.css(opacity: 1).removeClass('inactive')
    $signature.css(opacity: 1).removeClass('inactive')

    # update url to enable deep links
    window.history.pushState { state: 'root' }, 'MfM Institut - Marktforschung für Medien', '/'

    # reenable animations
    if speed is 'fast'
      callback = -> $produkt.details.removeClass('disable-animations')
      setTimeout callback, 200



  showProduct = ($produkt, speed) ->
    speed ? speed : 'normal'
    $produkt.name       = $produkt.attr("name")
    $produkt.details    = $produkt.next(".details")
    $produkt.removeIcon = $produkt.details.children('.icon-remove-sign')

    # disable animations if speed is set to 'fast'
    if speed is 'fast' then $produkt.details.addClass('disable-animations')

    # fade out default content
    $description.css(opacity: 0)
    $signature.css(opacity: 0)

    # blend in product
    $produkt.addClass('active')
    $produkt.details.removeClass('inactive').addClass('active')
    $produkt.removeIcon.show()

    # blur background image
    callback = -> $stage.addClass('inactive')
    setTimeout callback, 100

    # update url to enable deep links
    window.history.pushState { state: $produkt.name }, $produkt.name, $produkt.name

    # reenable animations
    if speed is 'fast'
      callback = -> $produkt.details.removeClass('disable-animations')
      setTimeout callback, 200



  $(document).on 'click', '.icon-remove-sign', -> hideProduct($('.details.active').prev('.produkt'))


  $(".produkt").click ->
    $produkt = $(this)
    $produkt.details = $produkt.next('.details')

    # Wenn das angeklickte Produkt bereits sichtbar ist, dann deaktiviere das Produkt
    if $('.details.active').length and $produkt.hasClass('active')
      hideProduct $produkt

    # Wenn es ein aktives Produkt gibt und das aktive Produkt NICHT das angeklickte ist
    # dann verstecke das sichtbare Produkt und aktiviere das angeklickte Produkt
    else if $('.details.active').length and !$produkt.hasClass('active')
      hideProduct $('.details.active').prev(), 'fast'
      showProduct $produkt

    else
      showProduct $produkt


  # really simple hardcoded router
  switch window.location.pathname.substr(1)
    when 'produktoptimierung'  then showProduct($('.optimierung'),  'fast') unless $('#optimierung').is('.active')
    when 'produktprofilierung' then showProduct($('.profilierung'), 'fast') unless $('#profilierung').is('.active')
    when 'produktentwicklung'  then showProduct($('.entwicklung'),  'fast') unless $('#entwicklung').is('.active')
