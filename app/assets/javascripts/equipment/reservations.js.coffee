# Place all the behaviors and hooks related to the matching contdoller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $.ajax({
    url: "/equipment/devices.js",
    dataType: 'json',
    success: (devices) ->
      fill_table(devices)
  })

  fill_table = (devices) ->
    for device in devices
      row = "<td>0</td>"
      row += "<td>#{device.model}</td>"
      row += "<td>#{device.company}</td>"
      row += "<td>#{device.kind}</td>"
      console.log row
      $('#devices > tbody:last')
        .append("<tr>#{row}</tr>");

