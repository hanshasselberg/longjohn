$ ->
  unless $('.alert.alert-error.full')[0]
    $('#scan').submit (e) ->
      $('.alert').hide()
      e.preventDefault()
      barcode = $('#scan input[type=text]').val()
      console.log(barcode)
      for tr in $('tbody tr')
        picked = jQuery.parseJSON($(tr).attr('data-picked'))
        console.log(tr)
        console.log(picked)
        if picked
          console.log(picked.indexOf(barcode))
          if (picked.indexOf(barcode) != -1)
            returned = jQuery.parseJSON($(tr).attr('data-returned'))
            if returned.indexOf(barcode) == -1
              returned.push(barcode)
              $(tr).attr('data-returned', JSON.stringify(returned).replace('"', '\"'))
              $('.count', tr).text(returned.length)
            else
              $('.alert.alert-info').show()
            $('.scan input[type=text]').val('').focus()
            return
      $('.alert.alert-error.not-found').show()

    $('form.return').submit (e) ->
      barcodes = []
      for tr in $('tr')
        barcodes.push(jQuery.parseJSON($(tr).attr('data-returned')))
      $('#device_barcodes').val(barcodes)

