{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; ENCODING VERBS SELF-TEST
; Tests: base64Encode, base64Decode, urlEncode, urlDecode,
;        jsonEncode, jsonDecode, hexEncode, hexDecode,
;        md5, sha1, sha256, sha512, crc32
; ============================================================

{$const}
; === REGEX PATTERNS ===
; Base64 pattern: A-Za-z0-9+/= (standard base64 charset)
base64_pattern = "^[A-Za-z0-9+/]+=*$"
; Hex pattern: lowercase hex digits only
hex_pattern = "^[0-9a-f]+$"
; SHA256 pattern: exactly 64 lowercase hex characters
sha256_pattern = "^[0-9a-f]{64}$"
; URL encoded pattern: allows %XX encoding
url_encoded_pattern = "(%[0-9A-Fa-f]{2})"

; === BASE64 TEST VALUES ===
plain_hello = "Hello"
base64_hello = "SGVsbG8="
plain_world = "World"
base64_world = "V29ybGQ="
plain_test = "Test123"
base64_test = "VGVzdDEyMw=="

; === URL ENCODING TEST VALUES ===
plain_url = "hello world"
encoded_url = "hello%20world"
plain_special = "a=1&b=2"
encoded_special = "a%3D1%26b%3D2"

; === HEX TEST VALUES ===
plain_abc = "ABC"
hex_abc = "414243"
plain_hex_test = "test"
hex_test = "74657374"

; === JSON TEST VALUES ===
json_obj = "{\"name\":\"test\"}"
json_arr = "[1,2,3]"

; === HASH EXPECTED VALUES ===
; MD5 of "hello" (32 hex chars)
md5_hello = "5d41402abc4b2a76b9719d911017c592"
md5_pattern = "^[0-9a-f]{32}$"

; SHA-1 of "hello" (40 hex chars)
sha1_hello = "aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d"
sha1_pattern = "^[0-9a-f]{40}$"

; SHA-256 of "hello" (64 hex chars)
sha256_hello = "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"

; SHA-512 of "hello" (128 hex chars)
sha512_hello = "9b71d224bd62f3785d96d46ad3ea3d73319bfbc2890caadae2dff72519673ca72323c3d99ba5c11d7c7acc6e14b8c5da0c4663475c2e5c3adef46f73bcdec043"
sha512_pattern = "^[0-9a-f]{128}$"

; CRC-32 of "hello" (8 hex chars)
crc32_hello = "3610a686"
; CRC-32 of "123456789" (standard test vector)
crc32_test_vector = "cbf43926"
crc32_pattern = "^[0-9a-f]{8}$"

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: BASE64 ENCODE TESTS
; ============================================================

{_test_base64_encode_hello}
_pass = ##1
actual = %base64Encode @$const.plain_hello
_ = %ifElse %eq @actual @$const.base64_hello %accumulate passed ##1 %accumulate failed ##1

{_test_base64_encode_world}
_pass = ##1
actual = %base64Encode @$const.plain_world
_ = %ifElse %eq @actual @$const.base64_world %accumulate passed ##1 %accumulate failed ##1

{_test_base64_encode_test}
_pass = ##1
actual = %base64Encode @$const.plain_test
_ = %ifElse %eq @actual @$const.base64_test %accumulate passed ##1 %accumulate failed ##1

{_test_base64_encode_pattern}
_pass = ##1
; Base64 output should only contain valid base64 characters
actual = %base64Encode @$const.plain_hello
matches = %match @actual @$const.base64_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: BASE64 DECODE TESTS
; ============================================================

{_test_base64_decode_hello}
_pass = ##2
actual = %base64Decode @$const.base64_hello
_ = %ifElse %eq @actual @$const.plain_hello %accumulate passed ##1 %accumulate failed ##1

{_test_base64_decode_world}
_pass = ##2
actual = %base64Decode @$const.base64_world
_ = %ifElse %eq @actual @$const.plain_world %accumulate passed ##1 %accumulate failed ##1

{_test_base64_roundtrip}
_pass = ##2
encoded = %base64Encode @$const.plain_test
decoded = %base64Decode @encoded
_ = %ifElse %eq @decoded @$const.plain_test %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: URL ENCODE TESTS
; ============================================================

{_test_url_encode_space}
_pass = ##3
actual = %urlEncode @$const.plain_url
_ = %ifElse %eq @actual @$const.encoded_url %accumulate passed ##1 %accumulate failed ##1

{_test_url_encode_special}
_pass = ##3
actual = %urlEncode @$const.plain_special
_ = %ifElse %eq @actual @$const.encoded_special %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: URL DECODE TESTS
; ============================================================

{_test_url_decode_space}
_pass = ##4
actual = %urlDecode @$const.encoded_url
_ = %ifElse %eq @actual @$const.plain_url %accumulate passed ##1 %accumulate failed ##1

{_test_url_decode_special}
_pass = ##4
actual = %urlDecode @$const.encoded_special
_ = %ifElse %eq @actual @$const.plain_special %accumulate passed ##1 %accumulate failed ##1

{_test_url_roundtrip}
_pass = ##4
encoded = %urlEncode @$const.plain_url
decoded = %urlDecode @encoded
_ = %ifElse %eq @decoded @$const.plain_url %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: HEX ENCODE TESTS
; ============================================================

{_test_hex_encode_abc}
_pass = ##5
actual = %hexEncode @$const.plain_abc
_ = %ifElse %eq @actual @$const.hex_abc %accumulate passed ##1 %accumulate failed ##1

{_test_hex_encode_test}
_pass = ##5
actual = %hexEncode @$const.plain_hex_test
_ = %ifElse %eq @actual @$const.hex_test %accumulate passed ##1 %accumulate failed ##1

{_test_hex_encode_pattern}
_pass = ##5
; Hex output should only contain lowercase hex digits
actual = %hexEncode @$const.plain_abc
matches = %match @actual @$const.hex_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_hex_encode_even_length}
_pass = ##5
; Hex encoding should produce even number of characters (2 per byte)
actual = %hexEncode @$const.plain_abc
len = %length @actual
isEven = %eq %mod @len ##2 ##0
_ = %ifElse @isEven %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: HEX DECODE TESTS
; ============================================================

{_test_hex_decode_abc}
_pass = ##6
actual = %hexDecode @$const.hex_abc
_ = %ifElse %eq @actual @$const.plain_abc %accumulate passed ##1 %accumulate failed ##1

{_test_hex_decode_test}
_pass = ##6
actual = %hexDecode @$const.hex_test
_ = %ifElse %eq @actual @$const.plain_hex_test %accumulate passed ##1 %accumulate failed ##1

{_test_hex_roundtrip}
_pass = ##6
encoded = %hexEncode @$const.plain_abc
decoded = %hexDecode @encoded
_ = %ifElse %eq @decoded @$const.plain_abc %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 7: JSON ENCODE/DECODE TESTS
; ============================================================

{_test_json_decode_obj}
_pass = ##7
actual = %jsonDecode @$const.json_obj
hasName = %has @actual "name"
_ = %ifElse @hasName %accumulate passed ##1 %accumulate failed ##1

{_test_json_decode_arr}
_pass = ##7
actual = %jsonDecode @$const.json_arr
count = %count @actual
_ = %ifElse %eq @count ##3 %accumulate passed ##1 %accumulate failed ##1

{_test_json_encode_obj}
_pass = ##7
obj = "{\"a\": ##1}"
encoded = %jsonEncode @obj
; Encoded should be a string representation
isStr = %isString @encoded
_ = %ifElse @isStr %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 8: SHA256 TESTS
; ============================================================

{_test_sha256_hello}
_pass = ##8
actual = %sha256 "hello"
_ = %ifElse %eq @actual @$const.sha256_hello %accumulate passed ##1 %accumulate failed ##1

{_test_sha256_consistent}
_pass = ##8
; Same input should produce same hash
hash1 = %sha256 "test"
hash2 = %sha256 "test"
_ = %ifElse %eq @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_sha256_different}
_pass = ##8
; Different inputs should produce different hashes
hash1 = %sha256 "hello"
hash2 = %sha256 "world"
_ = %ifElse %ne @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_sha256_pattern}
_pass = ##8
; SHA256 should produce exactly 64 lowercase hex characters
actual = %sha256 "test"
matches = %match @actual @$const.sha256_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_sha256_length}
_pass = ##8
; SHA256 hash is always 64 characters (256 bits / 4 bits per hex char)
actual = %sha256 "any input"
len = %length @actual
_ = %ifElse %eq @len ##64 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 9: MD5 TESTS
; ============================================================

{_test_md5_hello}
_pass = ##9
actual = %md5 "hello"
_ = %ifElse %eq @actual @$const.md5_hello %accumulate passed ##1 %accumulate failed ##1

{_test_md5_consistent}
_pass = ##9
; Same input should produce same hash
hash1 = %md5 "test"
hash2 = %md5 "test"
_ = %ifElse %eq @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_md5_different}
_pass = ##9
; Different inputs should produce different hashes
hash1 = %md5 "hello"
hash2 = %md5 "world"
_ = %ifElse %ne @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_md5_pattern}
_pass = ##9
; MD5 should produce exactly 32 lowercase hex characters
actual = %md5 "test"
matches = %match @actual @$const.md5_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_md5_length}
_pass = ##9
; MD5 hash is always 32 characters (128 bits / 4 bits per hex char)
actual = %md5 "any input"
len = %length @actual
_ = %ifElse %eq @len ##32 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 10: SHA-1 TESTS
; ============================================================

{_test_sha1_hello}
_pass = ##10
actual = %sha1 "hello"
_ = %ifElse %eq @actual @$const.sha1_hello %accumulate passed ##1 %accumulate failed ##1

{_test_sha1_consistent}
_pass = ##10
; Same input should produce same hash
hash1 = %sha1 "test"
hash2 = %sha1 "test"
_ = %ifElse %eq @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_sha1_different}
_pass = ##10
; Different inputs should produce different hashes
hash1 = %sha1 "hello"
hash2 = %sha1 "world"
_ = %ifElse %ne @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_sha1_pattern}
_pass = ##10
; SHA-1 should produce exactly 40 lowercase hex characters
actual = %sha1 "test"
matches = %match @actual @$const.sha1_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_sha1_length}
_pass = ##10
; SHA-1 hash is always 40 characters (160 bits / 4 bits per hex char)
actual = %sha1 "any input"
len = %length @actual
_ = %ifElse %eq @len ##40 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 11: SHA-512 TESTS
; ============================================================

{_test_sha512_hello}
_pass = ##11
actual = %sha512 "hello"
_ = %ifElse %eq @actual @$const.sha512_hello %accumulate passed ##1 %accumulate failed ##1

{_test_sha512_consistent}
_pass = ##11
; Same input should produce same hash
hash1 = %sha512 "test"
hash2 = %sha512 "test"
_ = %ifElse %eq @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_sha512_different}
_pass = ##11
; Different inputs should produce different hashes
hash1 = %sha512 "hello"
hash2 = %sha512 "world"
_ = %ifElse %ne @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_sha512_pattern}
_pass = ##11
; SHA-512 should produce exactly 128 lowercase hex characters
actual = %sha512 "test"
matches = %match @actual @$const.sha512_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_sha512_length}
_pass = ##11
; SHA-512 hash is always 128 characters (512 bits / 4 bits per hex char)
actual = %sha512 "any input"
len = %length @actual
_ = %ifElse %eq @len ##128 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 12: CRC-32 TESTS
; ============================================================

{_test_crc32_hello}
_pass = ##12
actual = %crc32 "hello"
_ = %ifElse %eq @actual @$const.crc32_hello %accumulate passed ##1 %accumulate failed ##1

{_test_crc32_test_vector}
_pass = ##12
; Standard CRC-32 test vector: "123456789" should produce cbf43926
actual = %crc32 "123456789"
_ = %ifElse %eq @actual @$const.crc32_test_vector %accumulate passed ##1 %accumulate failed ##1

{_test_crc32_consistent}
_pass = ##12
; Same input should produce same checksum
hash1 = %crc32 "test"
hash2 = %crc32 "test"
_ = %ifElse %eq @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_crc32_different}
_pass = ##12
; Different inputs should produce different checksums
hash1 = %crc32 "hello"
hash2 = %crc32 "world"
_ = %ifElse %ne @hash1 @hash2 %accumulate passed ##1 %accumulate failed ##1

{_test_crc32_pattern}
_pass = ##12
; CRC-32 should produce exactly 8 lowercase hex characters
actual = %crc32 "test"
matches = %match @actual @$const.crc32_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_crc32_length}
_pass = ##12
; CRC-32 is always 8 characters (32 bits / 4 bits per hex char)
actual = %crc32 "any input"
len = %length @actual
_ = %ifElse %eq @len ##8 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "encoding"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
