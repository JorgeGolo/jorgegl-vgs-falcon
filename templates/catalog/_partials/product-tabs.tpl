{block name='product_tabs'}
  <div class="product-info-sections my-4">
    
    {* 1. Descripción del producto *}
    {if $product.description}
      <section class="product-description-section my-5">
        <h3 class="h4 text-primary mb-3">
          {l s='Información del producto' d='Shop.Theme.Catalog'}
        </h3>
        {block name='product_description'}
          {cms_images_block webpEnabled=$webpEnabled}
            <div class="product-description cms-content pt-4">
              {$product.description nofilter}
            </div>
          {/cms_images_block}
        {/block}
      </section>
    {/if}

    {* 2. Ficha técnica / Detalles *}
    {block name='product_details'}
      {include file='catalog/_partials/product-details.tpl'}
    {/block}

    {* 3. Adjuntos / Descargas *}
    {block name='product_attachments'}
      {if $product.attachments}
        <section class="product-attachments-section my-4">
          <h4 class="h5 text-uppercase mb-3">{l s='Download' d='Shop.Theme.Actions'}</h4>
          {foreach from=$product.attachments item=attachment}
            <div class="attachment mb-2">
              <h5><a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name}</a></h5>
              <p>{$attachment.description}</p>
              <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}" class="btn btn-sm btn-outline-primary">
                {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
              </a>
            </div>
          {/foreach}
        </section>
      {/if}
    {/block}

    {* 4. Módulos extra (extraContent) *}
    {foreach from=$product.extraContent item=extra key=extraKey}
      <section class="product-extra-section my-4 {$extra.attr.class}">
        <h4 class="h5 text-uppercase mb-3">{$extra.title}</h4>
        <div class="cms-content">
          {$extra.content nofilter}
        </div>
      </section>
    {/foreach}

  </div>
{/block}