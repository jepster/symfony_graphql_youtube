<?php

declare(strict_types=1);

namespace App;

class ExampleEntity
{
    public function __construct(
        public readonly string $text
    ) {
    }
}
