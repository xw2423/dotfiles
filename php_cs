<?php

return (new PhpCsFixer\Config())
    ->setRiskyAllowed(true)
    ->setRules([
        '@Symfony' => true,

        //@Symfony modify
        'concat_space' => [
            'spacing' => 'one',
        ],
        'phpdoc_summary' => false,
        'phpdoc_to_comment' => false,
        'no_superfluous_phpdoc_tags' => false,

        //@Symfony:risky enable
        'combine_nested_dirname' => true,
        'dir_constant' => true,
        'ereg_to_preg' => true,
        'fopen_flag_order' => true,
        'function_to_constant' => true,
        'implode_call' => true,
        'is_null' => true,
        'modernize_types_casting' => true,
        'no_alias_functions' => true,
        'no_useless_sprintf' => true,
        'non_printable_character' => true,
        'set_type_to_cast' => true,
    ])
    ->setCacheFile(__DIR__ . '/.php_cs.cache');
