<?php

declare(strict_types=1);

namespace App\Test\Unit\Domain;

use App\Domain\ExampleEntity;
use App\Domain\ExampleResolver;
use PHPUnit\Framework\Attributes\CoversClass;
use PHPUnit\Framework\Attributes\UsesClass;
use PHPUnit\Framework\TestCase;

#[CoversClass(ExampleResolver::class)]
#[UsesClass(ExampleEntity::class)]
class ExampleResolverTest extends TestCase
{
    public function testResolve(): void
    {
        $exampleResolver = new ExampleResolver();
        self::assertInstanceOf(ExampleEntity::class, $exampleResolver->resolve());
    }
}
