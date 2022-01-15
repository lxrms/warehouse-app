# README

## Sobre o Projeto

Este é um projeto de exercício da turma 7 do programa Quero Ser Dev da Locaweb. O projeto consiste num sistema de gestão de galpões e de seus respectivos estoques de produtos.



## API

### Galpões

#### Listar todos galpões

**Requisição:**

```
GET /api/v1/warehouses
```

**Resposta:**

```
Status: 200 (OK)

[
  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
  }
]

```

#### Criar um galpão

**Requisição:**

```
POST /api/v1/warehouses
```

**Parâmetros:**

```
{
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "address": "Avenida dos Galpões, 1000",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
}
```

**Resposta:**

```
Status: 201 (Criado)

{
  "id": 10,
  "name": "Maceió",
  "code": "MCZ",
  "description": "Ótimo galpão numa linda cidade",
  "city": "Maceió",
  "state": "AL",
  "postal_code": "57050-000",
  "total_area": 10000,
  "useful_area": 8000
}
``` 