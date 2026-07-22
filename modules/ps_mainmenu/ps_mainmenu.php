<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class Ps_MainMenuOverride extends Ps_MainMenu
{
    /**
     * Anulamos la salida en displayTop para que NO pinte el menú junto al buscador
     */
    public function hookDisplayTop($params)
    {
        return '';
    }

    /**
     * Habilitamos la respuesta para displayNavFullWidth
     */
    public function hookDisplayNavFullWidth($params)
    {
        return $this->renderWidget('displayNavFullWidth', $params);
    }

    /**
     * Sobrescribimos renderWidget para asegurarnos de que si PrestaShop 
     * lo llama como Widget genérico desde displayTop, solo pinte en fullwidth
     */
    public function renderWidget($hookName = null, array $configuration = [])
    {
        // Si la llamada viene del hook displayTop (o cualquier otro que no sea FullWidth), bloqueamos
        if ($hookName === 'displayTop') {
            return '';
        }

        return parent::renderWidget($hookName, $configuration);
    }
}