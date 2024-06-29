# Transaction API Spec

Headers :

- Authorization : token

## Get AllTransaction API

Endpoint : GET /api/users/transaction

Response Body Success :

```json
{
  "data": {
    "transaction_id": "01",
    "product_name": "Lapangan A",
    "product_type": "field",
    "status": "Berhasil",
    "payment_method": "Gopay",
    "total_amount": "100000",
    "transaction_date": "2024-04-02"
  }
}
```

Response Body Error:

```json
{
  "errors": "Silahkan Login terlebih dahulu"
}
```

## Get Transaction Users API

Endpoint : GET /api/users/current/transaction

Response Body Success :

```json
{
  "data": {
    "transaction_id": "01",
    "product_name": "Lapangan A",
    "product_type": "field",
    "status": "Berhasil",
    "payment_method": "Gopay",
    "total_amount": "100000",
    "transaction_date": "2024-04-02"
  }
}
```

Response Body Error:

```json
{
  "errors": "Silahkan Login terlebih dahulu"
}
```

## Update Transaction API

Endpoint : PATH /api/users/transaction

Request Body :

```json
{
  "data": {
    "transaction_id": "01",
    "product_name": "Lapangan A", //Optional
    "product_type": "field", //Optional
    "status": "Berhasil", //Optional
    "payment_method": "Gopay", //Optional
    "total_amount": "100000", //Optional
    "transaction_date": "2024-04-02" //Optional
  }
}
```

Response Body Success :

```json
{
  "data": {
    "transaction_id": "01",
    "product_name": "Lapangan A",
    "product_type": "field",
    "status": "Berhasil",
    "payment_method": "Gopay",
    "total_amount": "100000",
    "transaction_date": "2024-04-02"
  }
}
```

Response Body Error:

```json
{
  "errors": "Silahkan Login terlebih dahulu"
}
```

## Delete Transaction API

Endpoint : PATH /api/users/transaction

Request Body :

```json
{
  "transaction_id": "01"
}
```

Response Body Success :

```json
{
  "info": "Transaksi berhasil dihapus"
}
```

Response Body Error :

```json
{
  "errors": "ID tidak ditemukan"
}
```
