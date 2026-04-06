{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; GENERATION VERBS SELF-TEST
; Tests: uuid, sequence, resetSequence, nanoid
; Note: These verbs generate unique values, so we test format
;       and uniqueness rather than exact values
; ============================================================

{$const}
; === LENGTH VALUES ===
uuid_length = ##36
nanoid_default_length = ##21

; === REGEX PATTERNS ===
; UUID v4: 8-4-4-4-12 hex chars with version 4 in position 13
; Pattern: xxxxxxxx-xxxx-4xxx-[89ab]xxx-xxxxxxxxxxxx
uuid_pattern = "^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$"
; Nanoid uses URL-safe alphabet: A-Za-z0-9_-
nanoid_pattern = "^[A-Za-z0-9_-]+$"

; === BOOLEAN VALUES ===
bool_true = ?true

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: UUID TESTS
; ============================================================

{_test_uuid_length}
_pass = ##1
actual = %uuid
len = %length @actual
; UUID v4 format: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx (36 chars)
_ = %ifElse %eq @len @$const.uuid_length %accumulate passed ##1 %accumulate failed ##1

{_test_uuid_pattern}
_pass = ##1
; UUID must match v4 pattern: 8-4-4-4-12 hex with version 4
actual = %uuid
matches = %match @actual @$const.uuid_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_uuid_lowercase}
_pass = ##1
; UUID should be lowercase hex
actual = %uuid
lower = %lower @actual
_ = %ifElse %eq @actual @lower %accumulate passed ##1 %accumulate failed ##1

{_test_uuid_unique}
_pass = ##1
; Two UUIDs should be different
uuid1 = %uuid
uuid2 = %uuid
_ = %ifElse %ne @uuid1 @uuid2 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: SEQUENCE TESTS
; ============================================================

{_test_sequence_initial}
_pass = ##2
; First call should return 1 (or starting value)
actual = %sequence "test_seq"
_ = %ifElse %gt @actual ##0 %accumulate passed ##1 %accumulate failed ##1

{_test_sequence_increment}
_pass = ##2
; Second call should be greater
seq1 = %sequence "test_seq2"
seq2 = %sequence "test_seq2"
_ = %ifElse %gt @seq2 @seq1 %accumulate passed ##1 %accumulate failed ##1

{_test_sequence_different_names}
_pass = ##2
; Different sequence names are independent
seqA = %sequence "seq_a"
seqB = %sequence "seq_b"
; Both should be valid positive numbers
validA = %gt @seqA ##0
validB = %gt @seqB ##0
_ = %ifElse %and @validA @validB %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: RESET SEQUENCE TESTS
; ============================================================

{_test_resetSequence}
_pass = ##3
; Get a sequence value
before = %sequence "reset_test"
; Reset it
_reset = %resetSequence "reset_test"
; Next value should be 1 (or starting value) again
after = %sequence "reset_test"
; After should be less than or equal to before (reset happened)
_ = %ifElse %lte @after @before %accumulate passed ##1 %accumulate failed ##1

{_test_resetSequence_specific}
_pass = ##3
; Advance sequence several times
s1 = %sequence "reset_test2"
s2 = %sequence "reset_test2"
s3 = %sequence "reset_test2"
; Reset
_reset = %resetSequence "reset_test2"
; Should be back to start
after = %sequence "reset_test2"
; after should be less than s3
_ = %ifElse %lt @after @s3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: NANOID TESTS
; ============================================================

{_test_nanoid_default_length}
_pass = ##4
actual = %nanoid
len = %length @actual
; Default nanoid is 21 characters
_ = %ifElse %eq @len @$const.nanoid_default_length %accumulate passed ##1 %accumulate failed ##1

{_test_nanoid_pattern}
_pass = ##4
; Nanoid should only contain URL-safe characters: A-Za-z0-9_-
actual = %nanoid
matches = %match @actual @$const.nanoid_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_nanoid_custom_length}
_pass = ##4
actual = %nanoid ##10
len = %length @actual
_ = %ifElse %eq @len ##10 %accumulate passed ##1 %accumulate failed ##1

{_test_nanoid_custom_pattern}
_pass = ##4
; Custom length nanoid should also match URL-safe pattern
actual = %nanoid ##15
matches = %match @actual @$const.nanoid_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_nanoid_unique}
_pass = ##4
; Two nanoids should be different
id1 = %nanoid
id2 = %nanoid
_ = %ifElse %ne @id1 @id2 %accumulate passed ##1 %accumulate failed ##1

{_test_nanoid_is_string}
_pass = ##4
actual = %nanoid
isStr = %isString @actual
_ = %ifElse @isStr %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "generation"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
