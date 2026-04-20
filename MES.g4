grammar MES;

start: lines EOF;
lines: line*;
line: reference SPACE (text | empty) NEWLINE;

reference: book chapter verse;
book: DIGIT DIGIT;
chapter: DIGIT DIGIT DIGIT;
verse: DIGIT DIGIT DIGIT;

text: segment (SPACE segment)*;
segment: words | correction;
empty: vid SUPPLIED?;

words: word (SPACE word)*;
word: prefix wordAttribute glyph+ suffix;
glyph: (LETTER condition?) | break;
condition: DAMAGED | MISSING;

prefix: altReference? break* REMNANT_LINE? REMNANT_VERSE?;
suffix: REMNANT_VERSE? REMNANT_LINE? break*;
altReference: VERSE_MARKER DIGIT+;
break: (BREAK_PAGE | BREAK_COLUMN | BREAK_LINE) DIGIT*;
wordAttribute: vid? SUPPLIED? abbreviation?;
abbreviation: NOMINA_SACRA | NUMERIC_VALUE;
vid: POSITIVE | NEGATIVE;

correction: (ORIGINAL edit SPACE)? edit (SPACE CORRECTOR edit)*;
edit: OPEN words? CLOSED;

// characters used

NEWLINE: '\r'? '\n';
SPACE: ' ';
DIGIT: [0-9];

VERSE_MARKER: '⋄';
BREAK_PAGE: '\\';
BREAK_COLUMN: '|';
BREAK_LINE: '/';
REMNANT_LINE: '&';
REMNANT_VERSE: '*';

POSITIVE: '+';
NEGATIVE: '-';
SUPPLIED: '~';
NOMINA_SACRA: '=';
NUMERIC_VALUE: '$';
DAMAGED: '%';
MISSING: '^';

LETTER: [\u03b1-\u03c9]  // Greek letter
  | '\u00af'  // MACRON (overline)
  | '\u03db'  // STIGMA
  | '\u03df'  // KOPPA
  | '\u2ce8'  // STAUROGRAM (ligature)
  | '\u03d7'  // KAI (ligature)
  | '\ue001'  // MOU (ligature)
  | '\u0375'  // LOWER NUMERAL SIGN
  | '\ufffd'; // REPLACEMENT (unknown character)

ORIGINAL: 'x';
CORRECTOR: [a-c];
OPEN: '{';
CLOSED: '}';
