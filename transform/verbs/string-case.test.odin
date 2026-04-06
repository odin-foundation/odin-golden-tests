{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; =============================================================================
; Self-Test: String Case Conversion Verbs
; Tests: camelCase, snakeCase, kebabCase, pascalCase
; Uses multi-pass to chain conversions and verify round-trip consistency
; =============================================================================

{$const}
; --- Basic Inputs ---
hyphenated = "hello-world"
snake = "hello_world"
camel = "helloWorld"
pascal = "HelloWorld"
spaced = "hello world"

; --- Expected Results ---
; Pass 1: Basic conversions
exp_camel_from_hyphen = "helloWorld"
exp_snake_from_camel = "hello_world"
exp_kebab_from_snake = "hello-world"
exp_pascal_from_kebab = "HelloWorld"

; Pass 2: Cross-conversion consistency
exp_camel_from_snake = "helloWorld"
exp_snake_from_pascal = "hello_world"
exp_kebab_from_camel = "hello-world"
exp_pascal_from_spaced = "HelloWorld"

; Pass 3: Edge cases
empty = ""
single = "a"
allcaps = "ABC"
exp_camel_empty = ""
exp_snake_single = "a"
exp_kebab_allcaps = "a-b-c"

{$accumulator}
passed = ##0
failed = ##0
pass1_done = ?false
pass2_done = ?false

; =============================================================================
; PASS 1: Basic Conversions
; =============================================================================

{_test_camel_from_hyphen}
_pass = ##1
actual = %camelCase @$const.hyphenated
_ = %ifElse %eq @actual @$const.exp_camel_from_hyphen %accumulate passed ##1 %accumulate failed ##1

{_test_snake_from_camel}
_pass = ##1
actual = %snakeCase @$const.camel
_ = %ifElse %eq @actual @$const.exp_snake_from_camel %accumulate passed ##1 %accumulate failed ##1

{_test_kebab_from_snake}
_pass = ##1
actual = %kebabCase @$const.snake
_ = %ifElse %eq @actual @$const.exp_kebab_from_snake %accumulate passed ##1 %accumulate failed ##1

{_test_pascal_from_kebab}
_pass = ##1
actual = %pascalCase @$const.hyphenated
_ = %ifElse %eq @actual @$const.exp_pascal_from_kebab %accumulate passed ##1 %accumulate failed ##1

{_mark_pass1}
_pass = ##1
_ = %set pass1_done ?true

; =============================================================================
; PASS 2: Cross-Conversion Consistency
; =============================================================================

{_test_camel_from_snake}
_pass = ##2
actual = %camelCase @$const.snake
_ = %ifElse %eq @actual @$const.exp_camel_from_snake %accumulate passed ##1 %accumulate failed ##1

{_test_snake_from_pascal}
_pass = ##2
actual = %snakeCase @$const.pascal
_ = %ifElse %eq @actual @$const.exp_snake_from_pascal %accumulate passed ##1 %accumulate failed ##1

{_test_kebab_from_camel}
_pass = ##2
actual = %kebabCase @$const.camel
_ = %ifElse %eq @actual @$const.exp_kebab_from_camel %accumulate passed ##1 %accumulate failed ##1

{_test_pascal_from_spaced}
_pass = ##2
actual = %pascalCase @$const.spaced
_ = %ifElse %eq @actual @$const.exp_pascal_from_spaced %accumulate passed ##1 %accumulate failed ##1

{_mark_pass2}
_pass = ##2
_ = %set pass2_done ?true

; =============================================================================
; PASS 3: Edge Cases + Chained Conversions
; =============================================================================

{_test_empty_string}
_pass = ##3
actual = %camelCase @$const.empty
_ = %ifElse %eq @actual @$const.exp_camel_empty %accumulate passed ##1 %accumulate failed ##1

{_test_single_char}
_pass = ##3
actual = %snakeCase @$const.single
_ = %ifElse %eq @actual @$const.exp_snake_single %accumulate passed ##1 %accumulate failed ##1

{_test_allcaps}
_pass = ##3
actual = %kebabCase @$const.allcaps
_ = %ifElse %eq @actual @$const.exp_kebab_allcaps %accumulate passed ##1 %accumulate failed ##1

; Chain: hyphenated -> camel -> snake -> kebab (should get back to hyphenated)
{_test_roundtrip}
_pass = ##3
step1 = %camelCase @$const.hyphenated
step2 = %snakeCase @step1
step3 = %kebabCase @step2
; hello-world -> helloWorld -> hello_world -> hello-world
_ = %ifElse %eq @step3 @$const.hyphenated %accumulate passed ##1 %accumulate failed ##1

; Chain: use logic verbs to verify types
{_test_type_check}
_pass = ##3
result = %camelCase @$const.hyphenated
is_string = %isString @result
_ = %ifElse @is_string %accumulate passed ##1 %accumulate failed ##1

; =============================================================================
; OUTPUT: Test Results
; =============================================================================

{TestResult}
verb = "string-case"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
pass1_complete = "@$accumulator.pass1_done"
pass2_complete = "@$accumulator.pass2_done"
