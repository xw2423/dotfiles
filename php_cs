<?php

return PhpCsFixer\Config::create()
    ->setRiskyAllowed(true)
    ->setRules([
        '@Symfony' => true,

        //@Symfony modify
        'concat_space' => [
            'spacing' => 'one',
        ],
        'phpdoc_summary' => false,
        'no_superfluous_phpdoc_tags' => false,

        //@Symfony:risky enable
        'dir_constant' => true,
        'ereg_to_preg' => true,
        'function_to_constant' => true,
        'implode_call' => true,
        'is_null' => true,
        'modernize_types_casting' => true,
        'non_printable_character' => true,
        'no_alias_functions' => true,
        'set_type_to_cast' => true,
    ])
    ->setCacheFile(__DIR__ . '/.php_cs.cache');

// vim: ft=php
