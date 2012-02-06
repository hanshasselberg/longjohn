$ ->
  if $('.alert.alert-error.full')[0]
    $('#scan').submit (e) ->
      $('.alert').hide()
      e.preventDefault()
      barcode = $('#scan input[type=text]').val()
      console.log(barcode)
      for tr in $('tbody tr')
        barcodes = jQuery.parseJSON($(tr).attr("data-barcodes"))
        console.log(tr)
        console.log(barcodes)
        if barcodes
          if (barcodes.indexOf(barcode) != -1)
            picked = jQuery.parseJSON($(tr).attr('data-picked'))
            if picked.indexOf(barcode) == -1
              if picked.length < parseInt($(tr).attr('data-total'))
                picked.push(barcode)
                $(tr).attr('data-picked', JSON.stringify(picked).replace('"', '\"'))
                $('.count', tr).text(picked.length)
              else
                $('.alert.alert-error.full').show()
            else
              $('.alert.alert-info').show()
            $('#scan input[type=text]').val('').focus()
            return
      $('.alert.alert-error.not-found').show()

    $('form.pick_up').submit (e) ->
      barcodes = []
      for tr in $('tr')
        barcodes.push(jQuery.parseJSON($(tr).attr('data-picked')))
      $('#device_barcodes').val(barcodes)

