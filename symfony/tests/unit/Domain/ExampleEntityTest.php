<?php

declare(strict_types=1);

namespace App\Test\Unit\Domain;

use App\Domain\ExampleEntity;
use PHPUnit\Framework\Attributes\CoversClass;
use PHPUnit\Framework\TestCase;

#[CoversClass(ExampleEntity::class)]
class ExampleEntityTest extends TestCase
{
    public function testInit(): void
    {
        $exampleEntity = new ExampleEntity('Lorem ipsum dolor sit amet');
        self::assertInstanceOf(ExampleEntity::class, $exampleEntity);
    }
}
