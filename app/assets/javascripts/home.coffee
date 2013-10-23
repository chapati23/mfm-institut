$ ->
  $description = $('.description')
  $signature = $('.signature')
  $stage = $('.stage')
  $('.details').attr('contenteditable', true)

  hideSection = ($section, speed) ->
    speed ? speed : 'normal'
    $section.name       = $section.attr("name")
    $section.details    = $section.next(".details")
    $section.removeIcon = $section.details.children('.icon-remove-sign')

    # disable animations if speed is set to 'fast'
    if speed is 'fast' then $section.details.addClass('disable-animations')

    # blend out product
    $section.removeIcon.hide()
    $section.details.removeClass('active').addClass('inactive')
    $section.removeClass('active')

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
      callback = -> $section.details.removeClass('disable-animations')
      setTimeout callback, 200



  showSection = ($section, speed) ->
    speed ? speed : 'normal'
    $section.name       = $section.attr("name")
    $section.details    = $section.next(".details")
    $section.removeIcon = $section.details.children('.icon-remove-sign')

    # disable animations if speed is set to 'fast'
    if speed is 'fast' then $section.details.addClass('disable-animations')

    # fade out default content
    $description.css(opacity: 0)
    $signature.css(opacity: 0)

    # blend in product
    $section.addClass('active')
    $section.details.removeClass('inactive').addClass('active')
    $section.removeIcon.show()

    # blur background image
    callback = -> $stage.addClass('inactive')
    setTimeout callback, 100

    # update url to enable deep links
    window.history.pushState { state: $section.name }, $section.name, $section.name

    # reenable animations
    if speed is 'fast'
      callback = -> $section.details.removeClass('disable-animations')
      setTimeout callback, 200



  $(document).on 'click', '.icon-remove-sign', -> hideSection($('.details.active').prev('.section'))


  $(".section").click ->
    $section = $(this)
    $section.details = $section.next('.details')

    # Wenn das angeklickte Produkt bereits sichtbar ist, dann deaktiviere das Produkt
    if $('.details.active').length and $section.hasClass('active')
      hideSection $section

    # Wenn es ein aktives Produkt gibt und das aktive Produkt NICHT das angeklickte ist
    # dann verstecke das sichtbare Produkt und aktiviere das angeklickte Produkt
    else if $('.details.active').length and !$section.hasClass('active')
      hideSection $('.details.active').prev(), 'fast'
      showSection $section

    else
      showSection $section


  $('.impressum').click (event) -> event.preventDefault()


  # really simple hardcoded router
  switch window.location.pathname.substr(1)
    when 'produktoptimierung'  then showSection($('.optimierung'),  'fast') unless $('#optimierung').is('.active')
    when 'produktprofilierung' then showSection($('.profilierung'), 'fast') unless $('#profilierung').is('.active')
    when 'produktentwicklung'  then showSection($('.entwicklung'),  'fast') unless $('#entwicklung').is('.active')
    when 'impressum'           then showSection($('.impressum'),    'fast') unless $('#impressum').is('.active')
