$ ->
  unless $('.alert.alert-error.full')[0]
    $('#scan', 'span.returns').submit (e) ->
      $('.alert').hide()
      e.preventDefault()
      barcode = $('#scan input[type=text]').val()
      for tr in $('tbody tr')
        picked = jQuery.parseJSON($(tr).attr('data-picked'))
        if picked
          if (picked.indexOf(barcode) != -1)
            $(tr).removeClass("hidden")
            returned = jQuery.parseJSON($(tr).attr('data-returned'))
            if returned.indexOf(barcode) == -1
              returned.push(barcode)
              $(tr).attr('data-returned', JSON.stringify(returned).replace('"', '\"'))
              $('.count', tr).text(returned.length)
            else
              $('.alert.alert-info').show()
            $('#scan input[type=text]').val('').focus()
            return
      $('.alert.alert-error.not-found').show()

    $('form.return').submit (e) ->
      barcodes = []
      for tr in $('tr')
        barcodes.push(jQuery.parseJSON($(tr).attr('data-returned')))
      $('#device_barcodes').val(barcodes)

