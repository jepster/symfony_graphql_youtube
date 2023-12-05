<?php

declare(strict_types=1);

namespace App\Domain;

use GraphQL\Type\Definition\ResolveInfo;
use Overblog\GraphQLBundle\Definition\Resolver\QueryInterface;

class GreetingResolver implements QueryInterface
{
    public function __invoke(ResolveInfo $info, mixed $value): mixed
    {
        $method = $info->fieldName;

        if (!isset($info->variableValues['name'])) {
            return $this->$method($value);
        } else {
            return $this->$method($value, $info->variableValues['name']);
        }
    }

    public function resolve(): GreetingEntity
    {
        return new GreetingEntity('Hi,');
    }

    public function text(GreetingEntity $entity, string $name = ''): string
    {
        return $entity->greeting . ' ' . $name . '!';
    }
}
