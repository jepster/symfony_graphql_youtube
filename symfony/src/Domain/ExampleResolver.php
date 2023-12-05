<?php

declare(strict_types=1);

namespace App\Domain;

use GraphQL\Type\Definition\ResolveInfo;
use Overblog\GraphQLBundle\Definition\Resolver\QueryInterface;

class ExampleResolver implements QueryInterface
{
    public function __invoke(ResolveInfo $info, mixed $value): mixed
    {
        $method = $info->fieldName;

        return $this->$method($value);
    }

    public function resolve(): ExampleEntity
    {
        return new ExampleEntity('My example text.');
    }

    public function text(ExampleEntity $entity): string
    {
        return $entity->text;
    }
}
