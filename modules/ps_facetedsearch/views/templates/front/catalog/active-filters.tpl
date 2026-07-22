{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
<section id="js-active-search-filters">
  {if $activeFilters|count}
    <div class="active-filters-container d-flex align-items-center flex-wrap mb-4">
      
      {block name='active_filters_title'}
        <span class="active-filters-title mr-3 font-weight-bold">
          {l s='Active filters' d='Shop.Theme.Global'}
        </span>
      {/block}

      <ul class="active-filters-list list-unstyled d-flex align-items-center flex-wrap m-0 p-0">
        {foreach from=$activeFilters item="filter"}
          {block name='active_filters_item'}
            <li class="active-filter-item my-1 mr-2">
              <a class="btn btn-sm btn-outline-primary rounded-pill js-search-link d-flex align-items-center" 
                 href="{$filter.nextEncodedFacetsURL}" 
                 rel="nofollow">
                {l s='%1$s:' d='Shop.Theme.Catalog' sprintf=[$filter.facetLabel]} {$filter.label} 
                <span class="close-filter ml-1 align-middle">&times;</span>
              </a>
            </li>
          {/block}
        {/foreach}
      </ul>

    </div>
  {/if}
</section>
