<div class="pagination-block row align-items-center mt-4 mb-2">
  
  <!-- Columna del texto de resumen -->
  <div class="col-md-5 text-center text-md-left mb-3 mb-md-0">
    <span class="pagination-summary">
      {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=['%from%' => $pagination.items_shown_from ,'%to%' => $pagination.items_shown_to, '%total%' => $pagination.total_items]}
    </span>
  </div>

  <!-- Columna de los botones de paginación -->
  <div class="col-md-7 d-flex justify-content-center justify-content-md-end pr-0">
    <nav aria-label="Paginación de productos">
      <ul class="pagination mb-0">
        {foreach from=$pagination.pages item="page"}
          <li class="page-item{if $page.current} active{/if}{if $page.type === 'spacer' || !$page.clickable} disabled{/if}">
            {if $page.type === 'spacer'}
              <span class="page-link">&hellip;</span>
            {else}
              <a
                rel="{if $page.type === 'previous'}prev{elseif $page.type === 'next'}next{else}nofollow{/if}"
                href="{if $page.clickable}{$page.url}{else}#{/if}"
                class="page-link {if $page.type === 'previous'}page-link--prev{elseif $page.type === 'next'}page-link--next{/if} {if !$page.clickable}disabled{/if} js-search-link"
                {if !$page.clickable}tabindex="-1" aria-disabled="true"{/if}
              >
                {if $page.type === 'previous'}
                  {l s='Previous' d='Shop.Theme.Actions'}
                {elseif $page.type === 'next'}
                  {l s='Next' d='Shop.Theme.Actions'}
                {else}
                  {$page.page}
                {/if}
              </a>
            {/if}
          </li>
        {/foreach}
      </ul>
    </nav>
  </div>

</div>