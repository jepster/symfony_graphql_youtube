<?php

declare(strict_types=1);

namespace App\Domain;

class ExampleEntity
{
    public function __construct(
        public readonly string $text
    ) {
    }
}
