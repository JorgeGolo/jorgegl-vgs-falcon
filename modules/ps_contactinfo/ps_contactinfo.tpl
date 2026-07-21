<div class="col-md-5 col-12 mb-lg-4 footer-contact-info d-flex flex-column justify-content-end">

  {* Mantenemos el contenedor colapsable si quieres soporte móvil o renderizado directo *}
  <div class="footer-contact-list">
    
    {* 1. Teléfono *}
    {if $contact_infos.phone}
      <div class="contact-item d-flex align-items-center mb-3">
        <i class="material-icons mr-2">&#xE0CD;</i>
        <a href="tel:{$contact_infos['phone']|replace:' ':''}" class="text-reset">
          {$contact_infos.phone}
        </a>
      </div>
    {/if}

    {* 2. Email *}
    {if $contact_infos.email && $display_email}
      <div class="contact-item d-flex align-items-center mb-3">
        <i class="material-icons mr-2">&#xE0E6;</i>
        {mailto address=$contact_infos.email encode="javascript"}
      </div>
    {/if}

    {* 3. Dirección *}
    {if $contact_infos.address.formatted}
      <div class="contact-item d-flex align-items-start mb-0">
        <i class="material-icons mr-2 mt-1">&#xE0C8;</i>
        <div class="address-text">
          {$contact_infos.address.formatted nofilter}
        </div>
      </div>
    {/if}

  </div>

</div>