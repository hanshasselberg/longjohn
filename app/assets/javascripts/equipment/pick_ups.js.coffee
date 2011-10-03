$ ->
  $('form.scan').submit (e) ->
    $('.alert-message').hide()
    e.preventDefault()
    barcode = $('input[type=text]').val()
    for tr in $('tr')
      barcodes = jQuery.parseJSON($(tr).attr("data-barcodes"))
      if barcodes
        if (barcodes.indexOf(barcode) != -1)
          picked = jQuery.parseJSON($(tr).attr('data-picked'))
          if picked.indexOf(barcode) == -1
            if picked.length < parseInt($(tr).attr('data-total'))
              picked.push(barcode)
              $(tr).attr('data-picked', JSON.stringify(picked).replace('"', '\"'))
              $('.count', tr).text(picked.length)
            else
              $('.alert-message.error.full').show()
          else
            $('.alert-message.warn').show()
          $('input[type=text]').val('').focus()
          return
    $('.alert-message.error.not-found').show()

