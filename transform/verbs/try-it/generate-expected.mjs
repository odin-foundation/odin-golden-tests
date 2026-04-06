#!/usr/bin/env node
/**
 * Generate expected ODIN outputs for all website "Try It" verb examples.
 *
 * Usage: node generate-expected.mjs
 *
 * Reads each verb example JSON from website/static/examples/verbs/,
 * runs the transform through the TypeScript SDK, and writes:
 *   {verb}.input.json
 *   {verb}.transform.odin
 *   {verb}.expected.odin
 *
 * Skips verbs that produce non-deterministic output (today, now).
 */

import { readFileSync, writeFileSync, readdirSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import { parseTransform, executeTransform } from '../../../../typescript/dist/esm/index.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const VERBS_DIR = join(__dirname, '..', '..', '..', '..', '..', 'website', 'static', 'examples', 'verbs');
const OUT_DIR = __dirname;

// Verbs that produce non-deterministic output — skip these
const SKIP_VERBS = new Set(['today', 'now']);

const verbFiles = readdirSync(VERBS_DIR).filter(f => f.endsWith('.json'));
let total = 0;
let skipped = 0;
let errors = 0;

for (const file of verbFiles) {
  const group = JSON.parse(readFileSync(join(VERBS_DIR, file), 'utf8'));

  for (const [verbName, example] of Object.entries(group)) {
    if (SKIP_VERBS.has(verbName)) {
      console.log(`SKIP ${verbName} (non-deterministic)`);
      skipped++;
      continue;
    }

    try {
      // Parse the input
      const sourceData = JSON.parse(example.input);

      // Run the transform with ODIN output
      const transform = parseTransform(example.transform);
      if (transform.target) {
        transform.target.format = 'odin';
      }
      const result = executeTransform(transform, sourceData);

      if (result.errors && result.errors.length > 0) {
        console.error(`ERROR ${verbName}: ${result.errors[0].message}`);
        errors++;
        continue;
      }

      const odinOutput = result.formatted || '';
      if (!odinOutput.trim()) {
        console.error(`EMPTY ${verbName}: no ODIN output`);
        errors++;
        continue;
      }

      // Write the three files
      writeFileSync(join(OUT_DIR, `${verbName}.input.json`), example.input + '\n');
      writeFileSync(join(OUT_DIR, `${verbName}.transform.odin`), example.transform + '\n');
      writeFileSync(join(OUT_DIR, `${verbName}.expected.odin`), odinOutput + '\n');

      console.log(`OK ${verbName}`);
      total++;
    } catch (e) {
      console.error(`ERROR ${verbName}: ${e.message}`);
      errors++;
    }
  }
}

console.log(`\nDone: ${total} generated, ${skipped} skipped, ${errors} errors`);
