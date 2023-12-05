<?php

declare(strict_types=1);

namespace App\Domain;

class GreetingEntity
{
    public function __construct(
        public readonly string $greeting
    ) {
    }
}
