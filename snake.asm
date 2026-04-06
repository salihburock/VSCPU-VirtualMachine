0: BZJi 3 20 // Goto init
//$REGISTERS_SECTION
1: 1734 // SP
2: 1734 // BP
3: 0 // CONST_ZERO
4: 1 // CONST_ONE
5: 0 // CONST_NEG_ONE (computed)
6: 0 // reserved
7: 0 // reserved
8: 0 // reserved
9: 0 // reserved
10: 0 // reserved
11: 0 // reserved
12: 0 // reserved
13: 0 // reserved
14: 0 // TEMP1
15: 0 // TEMP2
16: 0 // TEMP3
17: 0 // TEMP4
18: 0 // TEMP5
19: 0 // TEMP6
//$TEXT_SECTION
20: NAND 5 3 // CONST_NEG_ONE = ~(0&0)
21: BZJi 3 22 // Goto main
22: ADDi 1 1 // alloc 'length'
23: ADDi 1 1 // alloc 'dir'
24: ADDi 1 1 // alloc 'next_dir'
25: ADDi 1 1 // alloc 'apple_x'
26: ADDi 1 1 // alloc 'apple_y'
27: ADDi 1 1 // alloc 'game_over'
28: ADDi 1 1 // alloc 'i'
29: ADDi 1 1 // alloc 'head_x'
30: ADDi 1 1 // alloc 'head_y'
31: ADDi 1 1 // alloc 'tail_x'
32: ADDi 1 1 // alloc 'tail_y'
33: ADDi 1 1 // alloc 'pos'
34: ADDi 1 1 // alloc 'delay_counter'
35: ADDi 1 1 // alloc 'input_locked'
36: ADDi 1 1 // alloc 'ate_apple'
37: CPi 14 15000 // 15000
38: CPi 18 1725 // screen
39: CPIi 18 14 // screen
40: CPi 14 16025 // 16025
41: CPi 18 1727 // key_a
42: CPIi 18 14 // key_a
43: CPi 14 16026 // 16026
44: CPi 18 1728 // key_s
45: CPIi 18 14 // key_s
46: CPi 14 16027 // 16027
47: CPi 18 1729 // key_d
48: CPIi 18 14 // key_d
49: CPi 14 16024 // 16024
50: CPi 18 1726 // key_w
51: CPIi 18 14 // key_w
52: CPi 14 10000 // 10000
53: CPi 18 1730 // snake_x
54: CPIi 18 14 // snake_x
55: CPi 14 11000 // 11000
56: CPi 18 1731 // snake_y
57: CPIi 18 14 // snake_y
58: CP 14 3 // 0
59: CP 18 2 // i
60: ADDi 18 6 // off
61: CPIi 18 14 // st
62: CP 18 2 // i
63: ADDi 18 6 // off
64: CPI 14 18 // ld
65: CPIi 1 14 // push lhs
66: ADDi 1 1 // SP++
67: CPi 14 1024 // 1024
68: CP 15 14 // rhs
69: ADD 1 5 // SP--
70: CPI 14 1 // pop lhs
71: LT 14 15 // <
72: CPi 18 106 // for exit (P)
73: BZJ 18 14 // for exit
74: CP 14 3 // 0
75: CPIi 1 14 // push val
76: ADDi 1 1 // SP++
77: CPi 18 1725 // screen
78: CPI 14 18 // screen
79: CP 18 14 // ptr
80: CPIi 1 18 // push base
81: ADDi 1 1 // SP++
82: CP 18 2 // i
83: ADDi 18 6 // off
84: CPI 14 18 // ld
85: ADD 1 5 // SP--
86: CPI 18 1 // pop base
87: ADD 18 14 // +idx
88: ADD 1 5 // SP--
89: CPI 14 1 // pop val
90: CPIi 18 14 // []=
91: CP 18 2 // i
92: ADDi 18 6 // off
93: CPI 14 18 // ld
94: CPIi 1 14 // push lhs
95: ADDi 1 1 // SP++
96: CP 14 4 // 1
97: CP 15 14 // rhs
98: ADD 1 5 // SP--
99: CPI 14 1 // pop lhs
100: ADD 14 15 // +
101: CP 18 2 // i
102: ADDi 18 6 // off
103: CPIi 18 14 // st
104: CPi 18 62 // for
105: BZJi 18 0 // loop
106: CPi 14 3 // 3
107: CP 18 2 // length
108: CPIi 18 14 // st
109: CPi 14 15 // 15
110: CPIi 1 14 // push val
111: ADDi 1 1 // SP++
112: CPi 18 1730 // snake_x
113: CPI 14 18 // snake_x
114: CP 18 14 // ptr
115: CPIi 1 18 // push base
116: ADDi 1 1 // SP++
117: CP 14 3 // 0
118: ADD 1 5 // SP--
119: CPI 18 1 // pop base
120: ADD 18 14 // +idx
121: ADD 1 5 // SP--
122: CPI 14 1 // pop val
123: CPIi 18 14 // []=
124: CPi 14 15 // 15
125: CPIi 1 14 // push val
126: ADDi 1 1 // SP++
127: CPi 18 1731 // snake_y
128: CPI 14 18 // snake_y
129: CP 18 14 // ptr
130: CPIi 1 18 // push base
131: ADDi 1 1 // SP++
132: CP 14 3 // 0
133: ADD 1 5 // SP--
134: CPI 18 1 // pop base
135: ADD 18 14 // +idx
136: ADD 1 5 // SP--
137: CPI 14 1 // pop val
138: CPIi 18 14 // []=
139: CPi 14 14 // 14
140: CPIi 1 14 // push val
141: ADDi 1 1 // SP++
142: CPi 18 1730 // snake_x
143: CPI 14 18 // snake_x
144: CP 18 14 // ptr
145: CPIi 1 18 // push base
146: ADDi 1 1 // SP++
147: CP 14 4 // 1
148: ADD 1 5 // SP--
149: CPI 18 1 // pop base
150: ADD 18 14 // +idx
151: ADD 1 5 // SP--
152: CPI 14 1 // pop val
153: CPIi 18 14 // []=
154: CPi 14 15 // 15
155: CPIi 1 14 // push val
156: ADDi 1 1 // SP++
157: CPi 18 1731 // snake_y
158: CPI 14 18 // snake_y
159: CP 18 14 // ptr
160: CPIi 1 18 // push base
161: ADDi 1 1 // SP++
162: CP 14 4 // 1
163: ADD 1 5 // SP--
164: CPI 18 1 // pop base
165: ADD 18 14 // +idx
166: ADD 1 5 // SP--
167: CPI 14 1 // pop val
168: CPIi 18 14 // []=
169: CPi 14 13 // 13
170: CPIi 1 14 // push val
171: ADDi 1 1 // SP++
172: CPi 18 1730 // snake_x
173: CPI 14 18 // snake_x
174: CP 18 14 // ptr
175: CPIi 1 18 // push base
176: ADDi 1 1 // SP++
177: CPi 14 2 // 2
178: ADD 1 5 // SP--
179: CPI 18 1 // pop base
180: ADD 18 14 // +idx
181: ADD 1 5 // SP--
182: CPI 14 1 // pop val
183: CPIi 18 14 // []=
184: CPi 14 15 // 15
185: CPIi 1 14 // push val
186: ADDi 1 1 // SP++
187: CPi 18 1731 // snake_y
188: CPI 14 18 // snake_y
189: CP 18 14 // ptr
190: CPIi 1 18 // push base
191: ADDi 1 1 // SP++
192: CPi 14 2 // 2
193: ADD 1 5 // SP--
194: CPI 18 1 // pop base
195: ADD 18 14 // +idx
196: ADD 1 5 // SP--
197: CPI 14 1 // pop val
198: CPIi 18 14 // []=
199: CPi 14 2 // 2
200: CP 18 2 // dir
201: ADDi 18 1 // off
202: CPIi 18 14 // st
203: CPi 14 2 // 2
204: CP 18 2 // next_dir
205: ADDi 18 2 // off
206: CPIi 18 14 // st
207: CP 14 3 // 0
208: CP 18 2 // i
209: ADDi 18 6 // off
210: CPIi 18 14 // st
211: CP 18 2 // i
212: ADDi 18 6 // off
213: CPI 14 18 // ld
214: CPIi 1 14 // push lhs
215: ADDi 1 1 // SP++
216: CP 18 2 // length
217: CPI 14 18 // ld
218: CP 15 14 // rhs
219: ADD 1 5 // SP--
220: CPI 14 1 // pop lhs
221: LT 14 15 // <
222: CPi 18 296 // for exit (P)
223: BZJ 18 14 // for exit
224: CPi 18 1731 // snake_y
225: CPI 14 18 // snake_y
226: CP 18 14 // ptr
227: CPIi 1 18 // push base
228: ADDi 1 1 // SP++
229: CP 18 2 // i
230: ADDi 18 6 // off
231: CPI 14 18 // ld
232: ADD 1 5 // SP--
233: CPI 18 1 // pop base
234: ADD 18 14 // +idx
235: CPI 14 18 // ld[]
236: CPIi 1 14 // push lhs
237: ADDi 1 1 // SP++
238: CPi 14 32 // 32
239: CP 15 14 // rhs
240: ADD 1 5 // SP--
241: CPI 14 1 // pop lhs
242: MUL 14 15 // *
243: CPIi 1 14 // push lhs
244: ADDi 1 1 // SP++
245: CPi 18 1730 // snake_x
246: CPI 14 18 // snake_x
247: CP 18 14 // ptr
248: CPIi 1 18 // push base
249: ADDi 1 1 // SP++
250: CP 18 2 // i
251: ADDi 18 6 // off
252: CPI 14 18 // ld
253: ADD 1 5 // SP--
254: CPI 18 1 // pop base
255: ADD 18 14 // +idx
256: CPI 14 18 // ld[]
257: CP 15 14 // rhs
258: ADD 1 5 // SP--
259: CPI 14 1 // pop lhs
260: ADD 14 15 // +
261: CP 18 2 // pos
262: ADDi 18 11 // off
263: CPIi 18 14 // st
264: CP 14 4 // 1
265: CPIi 1 14 // push val
266: ADDi 1 1 // SP++
267: CPi 18 1725 // screen
268: CPI 14 18 // screen
269: CP 18 14 // ptr
270: CPIi 1 18 // push base
271: ADDi 1 1 // SP++
272: CP 18 2 // pos
273: ADDi 18 11 // off
274: CPI 14 18 // ld
275: ADD 1 5 // SP--
276: CPI 18 1 // pop base
277: ADD 18 14 // +idx
278: ADD 1 5 // SP--
279: CPI 14 1 // pop val
280: CPIi 18 14 // []=
281: CP 18 2 // i
282: ADDi 18 6 // off
283: CPI 14 18 // ld
284: CPIi 1 14 // push lhs
285: ADDi 1 1 // SP++
286: CP 14 4 // 1
287: CP 15 14 // rhs
288: ADD 1 5 // SP--
289: CPI 14 1 // pop lhs
290: ADD 14 15 // +
291: CP 18 2 // i
292: ADDi 18 6 // off
293: CPIi 18 14 // st
294: CPi 18 211 // for
295: BZJi 18 0 // loop
296: CPi 14 22 // 22
297: CP 18 2 // apple_x
298: ADDi 18 3 // off
299: CPIi 18 14 // st
300: CPi 14 15 // 15
301: CP 18 2 // apple_y
302: ADDi 18 4 // off
303: CPIi 18 14 // st
304: CP 18 2 // apple_y
305: ADDi 18 4 // off
306: CPI 14 18 // ld
307: CPIi 1 14 // push lhs
308: ADDi 1 1 // SP++
309: CPi 14 32 // 32
310: CP 15 14 // rhs
311: ADD 1 5 // SP--
312: CPI 14 1 // pop lhs
313: MUL 14 15 // *
314: CPIi 1 14 // push lhs
315: ADDi 1 1 // SP++
316: CP 18 2 // apple_x
317: ADDi 18 3 // off
318: CPI 14 18 // ld
319: CP 15 14 // rhs
320: ADD 1 5 // SP--
321: CPI 14 1 // pop lhs
322: ADD 14 15 // +
323: CP 18 2 // pos
324: ADDi 18 11 // off
325: CPIi 18 14 // st
326: CP 14 4 // 1
327: CPIi 1 14 // push val
328: ADDi 1 1 // SP++
329: CPi 18 1725 // screen
330: CPI 14 18 // screen
331: CP 18 14 // ptr
332: CPIi 1 18 // push base
333: ADDi 1 1 // SP++
334: CP 18 2 // pos
335: ADDi 18 11 // off
336: CPI 14 18 // ld
337: ADD 1 5 // SP--
338: CPI 18 1 // pop base
339: ADD 18 14 // +idx
340: ADD 1 5 // SP--
341: CPI 14 1 // pop val
342: CPIi 18 14 // []=
343: CP 14 3 // 0
344: CP 18 2 // game_over
345: ADDi 18 5 // off
346: CPIi 18 14 // st
347: CP 18 2 // game_over
348: ADDi 18 5 // off
349: CPI 14 18 // ld
350: CPIi 1 14 // push lhs
351: ADDi 1 1 // SP++
352: CP 14 3 // 0
353: CP 15 14 // rhs
354: ADD 1 5 // SP--
355: CPI 14 1 // pop lhs
356: CP 16 15 // sub
357: NAND 16 16 // ~
358: ADDi 16 1 // -src
359: ADD 14 16 // a-b
360: CPi 18 365 // eq (P)
361: BZJ 18 14 // eq
362: CPi 14 0 // ne
363: CPi 18 366 // eq end (P)
364: BZJi 18 0 // eq end
365: CPi 14 1 // eq
366: CPi 18 1654 // wh exit (P)
367: BZJ 18 14 // wh exit
368: CP 14 3 // 0
369: CP 18 2 // input_locked
370: ADDi 18 13 // off
371: CPIi 18 14 // st
372: CP 14 3 // 0
373: CP 18 2 // delay_counter
374: ADDi 18 12 // off
375: CPIi 18 14 // st
376: CP 18 2 // delay_counter
377: ADDi 18 12 // off
378: CPI 14 18 // ld
379: CPIi 1 14 // push lhs
380: ADDi 1 1 // SP++
381: CPi 14 150 // 150
382: CP 15 14 // rhs
383: ADD 1 5 // SP--
384: CPI 14 1 // pop lhs
385: LT 14 15 // <
386: CPi 18 727 // for exit (P)
387: BZJ 18 14 // for exit
388: CPi 18 1729 // key_d
389: CPI 14 18 // key_d
390: CP 18 14
391: CPI 14 18 // deref
392: CPIi 1 14 // push lhs
393: ADDi 1 1 // SP++
394: CP 14 3 // 0
395: CP 15 14 // rhs
396: ADD 1 5 // SP--
397: CPI 14 1 // pop lhs
398: CP 16 15 // sub
399: NAND 16 16 // ~
400: ADDi 16 1 // -src
401: ADD 14 16 // a-b
402: CPi 18 407 // eq (P)
403: BZJ 18 14 // eq
404: CPi 14 0 // ne
405: CPi 18 408 // eq end (P)
406: BZJi 18 0 // eq end
407: CPi 14 1 // eq
408: CPi 18 469 // if else (P)
409: BZJ 18 14 // if else
410: CP 18 2 // input_locked
411: ADDi 18 13 // off
412: CPI 14 18 // ld
413: CPIi 1 14 // push lhs
414: ADDi 1 1 // SP++
415: CP 14 3 // 0
416: CP 15 14 // rhs
417: ADD 1 5 // SP--
418: CPI 14 1 // pop lhs
419: CP 16 15 // sub
420: NAND 16 16 // ~
421: ADDi 16 1 // -src
422: ADD 14 16 // a-b
423: CPi 18 428 // eq (P)
424: BZJ 18 14 // eq
425: CPi 14 0 // ne
426: CPi 18 429 // eq end (P)
427: BZJi 18 0 // eq end
428: CPi 14 1 // eq
429: CPi 18 460 // if else (P)
430: BZJ 18 14 // if else
431: CP 18 2 // dir
432: ADDi 18 1 // off
433: CPI 14 18 // ld
434: CPIi 1 14 // push lhs
435: ADDi 1 1 // SP++
436: CPi 14 3 // 3
437: CP 15 14 // rhs
438: ADD 1 5 // SP--
439: CPI 14 1 // pop lhs
440: CP 16 15 // sub
441: NAND 16 16 // ~
442: ADDi 16 1 // -src
443: ADD 14 16 // a-b
444: CPi 18 449 // ne? (P)
445: BZJ 18 14 // ne?
446: CP 14 5 // ne->-1
447: CPi 18 450 // ne end (P)
448: BZJi 18 0 // ne end
449: CPi 14 0 // eq->0
450: CPi 18 460 // if else (P)
451: BZJ 18 14 // if else
452: CP 14 4 // 1
453: CP 18 2 // next_dir
454: ADDi 18 2 // off
455: CPIi 18 14 // st
456: CP 14 4 // 1
457: CP 18 2 // input_locked
458: ADDi 18 13 // off
459: CPIi 18 14 // st
460: CP 14 4 // 1
461: CPIi 1 14 // push val
462: ADDi 1 1 // SP++
463: CPi 18 1729 // key_d
464: CPI 14 18 // key_d
465: CP 18 14 // addr
466: ADD 1 5 // SP--
467: CPI 14 1 // pop val
468: CPIi 18 14 // *=
469: CPi 18 1728 // key_s
470: CPI 14 18 // key_s
471: CP 18 14
472: CPI 14 18 // deref
473: CPIi 1 14 // push lhs
474: ADDi 1 1 // SP++
475: CP 14 3 // 0
476: CP 15 14 // rhs
477: ADD 1 5 // SP--
478: CPI 14 1 // pop lhs
479: CP 16 15 // sub
480: NAND 16 16 // ~
481: ADDi 16 1 // -src
482: ADD 14 16 // a-b
483: CPi 18 488 // eq (P)
484: BZJ 18 14 // eq
485: CPi 14 0 // ne
486: CPi 18 489 // eq end (P)
487: BZJi 18 0 // eq end
488: CPi 14 1 // eq
489: CPi 18 550 // if else (P)
490: BZJ 18 14 // if else
491: CP 18 2 // input_locked
492: ADDi 18 13 // off
493: CPI 14 18 // ld
494: CPIi 1 14 // push lhs
495: ADDi 1 1 // SP++
496: CP 14 3 // 0
497: CP 15 14 // rhs
498: ADD 1 5 // SP--
499: CPI 14 1 // pop lhs
500: CP 16 15 // sub
501: NAND 16 16 // ~
502: ADDi 16 1 // -src
503: ADD 14 16 // a-b
504: CPi 18 509 // eq (P)
505: BZJ 18 14 // eq
506: CPi 14 0 // ne
507: CPi 18 510 // eq end (P)
508: BZJi 18 0 // eq end
509: CPi 14 1 // eq
510: CPi 18 541 // if else (P)
511: BZJ 18 14 // if else
512: CP 18 2 // dir
513: ADDi 18 1 // off
514: CPI 14 18 // ld
515: CPIi 1 14 // push lhs
516: ADDi 1 1 // SP++
517: CP 14 3 // 0
518: CP 15 14 // rhs
519: ADD 1 5 // SP--
520: CPI 14 1 // pop lhs
521: CP 16 15 // sub
522: NAND 16 16 // ~
523: ADDi 16 1 // -src
524: ADD 14 16 // a-b
525: CPi 18 530 // ne? (P)
526: BZJ 18 14 // ne?
527: CP 14 5 // ne->-1
528: CPi 18 531 // ne end (P)
529: BZJi 18 0 // ne end
530: CPi 14 0 // eq->0
531: CPi 18 541 // if else (P)
532: BZJ 18 14 // if else
533: CPi 14 2 // 2
534: CP 18 2 // next_dir
535: ADDi 18 2 // off
536: CPIi 18 14 // st
537: CP 14 4 // 1
538: CP 18 2 // input_locked
539: ADDi 18 13 // off
540: CPIi 18 14 // st
541: CP 14 4 // 1
542: CPIi 1 14 // push val
543: ADDi 1 1 // SP++
544: CPi 18 1728 // key_s
545: CPI 14 18 // key_s
546: CP 18 14 // addr
547: ADD 1 5 // SP--
548: CPI 14 1 // pop val
549: CPIi 18 14 // *=
550: CPi 18 1727 // key_a
551: CPI 14 18 // key_a
552: CP 18 14
553: CPI 14 18 // deref
554: CPIi 1 14 // push lhs
555: ADDi 1 1 // SP++
556: CP 14 3 // 0
557: CP 15 14 // rhs
558: ADD 1 5 // SP--
559: CPI 14 1 // pop lhs
560: CP 16 15 // sub
561: NAND 16 16 // ~
562: ADDi 16 1 // -src
563: ADD 14 16 // a-b
564: CPi 18 569 // eq (P)
565: BZJ 18 14 // eq
566: CPi 14 0 // ne
567: CPi 18 570 // eq end (P)
568: BZJi 18 0 // eq end
569: CPi 14 1 // eq
570: CPi 18 631 // if else (P)
571: BZJ 18 14 // if else
572: CP 18 2 // input_locked
573: ADDi 18 13 // off
574: CPI 14 18 // ld
575: CPIi 1 14 // push lhs
576: ADDi 1 1 // SP++
577: CP 14 3 // 0
578: CP 15 14 // rhs
579: ADD 1 5 // SP--
580: CPI 14 1 // pop lhs
581: CP 16 15 // sub
582: NAND 16 16 // ~
583: ADDi 16 1 // -src
584: ADD 14 16 // a-b
585: CPi 18 590 // eq (P)
586: BZJ 18 14 // eq
587: CPi 14 0 // ne
588: CPi 18 591 // eq end (P)
589: BZJi 18 0 // eq end
590: CPi 14 1 // eq
591: CPi 18 622 // if else (P)
592: BZJ 18 14 // if else
593: CP 18 2 // dir
594: ADDi 18 1 // off
595: CPI 14 18 // ld
596: CPIi 1 14 // push lhs
597: ADDi 1 1 // SP++
598: CP 14 4 // 1
599: CP 15 14 // rhs
600: ADD 1 5 // SP--
601: CPI 14 1 // pop lhs
602: CP 16 15 // sub
603: NAND 16 16 // ~
604: ADDi 16 1 // -src
605: ADD 14 16 // a-b
606: CPi 18 611 // ne? (P)
607: BZJ 18 14 // ne?
608: CP 14 5 // ne->-1
609: CPi 18 612 // ne end (P)
610: BZJi 18 0 // ne end
611: CPi 14 0 // eq->0
612: CPi 18 622 // if else (P)
613: BZJ 18 14 // if else
614: CPi 14 3 // 3
615: CP 18 2 // next_dir
616: ADDi 18 2 // off
617: CPIi 18 14 // st
618: CP 14 4 // 1
619: CP 18 2 // input_locked
620: ADDi 18 13 // off
621: CPIi 18 14 // st
622: CP 14 4 // 1
623: CPIi 1 14 // push val
624: ADDi 1 1 // SP++
625: CPi 18 1727 // key_a
626: CPI 14 18 // key_a
627: CP 18 14 // addr
628: ADD 1 5 // SP--
629: CPI 14 1 // pop val
630: CPIi 18 14 // *=
631: CPi 18 1726 // key_w
632: CPI 14 18 // key_w
633: CP 18 14
634: CPI 14 18 // deref
635: CPIi 1 14 // push lhs
636: ADDi 1 1 // SP++
637: CP 14 3 // 0
638: CP 15 14 // rhs
639: ADD 1 5 // SP--
640: CPI 14 1 // pop lhs
641: CP 16 15 // sub
642: NAND 16 16 // ~
643: ADDi 16 1 // -src
644: ADD 14 16 // a-b
645: CPi 18 650 // eq (P)
646: BZJ 18 14 // eq
647: CPi 14 0 // ne
648: CPi 18 651 // eq end (P)
649: BZJi 18 0 // eq end
650: CPi 14 1 // eq
651: CPi 18 712 // if else (P)
652: BZJ 18 14 // if else
653: CP 18 2 // input_locked
654: ADDi 18 13 // off
655: CPI 14 18 // ld
656: CPIi 1 14 // push lhs
657: ADDi 1 1 // SP++
658: CP 14 3 // 0
659: CP 15 14 // rhs
660: ADD 1 5 // SP--
661: CPI 14 1 // pop lhs
662: CP 16 15 // sub
663: NAND 16 16 // ~
664: ADDi 16 1 // -src
665: ADD 14 16 // a-b
666: CPi 18 671 // eq (P)
667: BZJ 18 14 // eq
668: CPi 14 0 // ne
669: CPi 18 672 // eq end (P)
670: BZJi 18 0 // eq end
671: CPi 14 1 // eq
672: CPi 18 703 // if else (P)
673: BZJ 18 14 // if else
674: CP 18 2 // dir
675: ADDi 18 1 // off
676: CPI 14 18 // ld
677: CPIi 1 14 // push lhs
678: ADDi 1 1 // SP++
679: CPi 14 2 // 2
680: CP 15 14 // rhs
681: ADD 1 5 // SP--
682: CPI 14 1 // pop lhs
683: CP 16 15 // sub
684: NAND 16 16 // ~
685: ADDi 16 1 // -src
686: ADD 14 16 // a-b
687: CPi 18 692 // ne? (P)
688: BZJ 18 14 // ne?
689: CP 14 5 // ne->-1
690: CPi 18 693 // ne end (P)
691: BZJi 18 0 // ne end
692: CPi 14 0 // eq->0
693: CPi 18 703 // if else (P)
694: BZJ 18 14 // if else
695: CP 14 3 // 0
696: CP 18 2 // next_dir
697: ADDi 18 2 // off
698: CPIi 18 14 // st
699: CP 14 4 // 1
700: CP 18 2 // input_locked
701: ADDi 18 13 // off
702: CPIi 18 14 // st
703: CP 14 4 // 1
704: CPIi 1 14 // push val
705: ADDi 1 1 // SP++
706: CPi 18 1726 // key_w
707: CPI 14 18 // key_w
708: CP 18 14 // addr
709: ADD 1 5 // SP--
710: CPI 14 1 // pop val
711: CPIi 18 14 // *=
712: CP 18 2 // delay_counter
713: ADDi 18 12 // off
714: CPI 14 18 // ld
715: CPIi 1 14 // push lhs
716: ADDi 1 1 // SP++
717: CP 14 4 // 1
718: CP 15 14 // rhs
719: ADD 1 5 // SP--
720: CPI 14 1 // pop lhs
721: ADD 14 15 // +
722: CP 18 2 // delay_counter
723: ADDi 18 12 // off
724: CPIi 18 14 // st
725: CPi 18 376 // for
726: BZJi 18 0 // loop
727: CP 18 2 // next_dir
728: ADDi 18 2 // off
729: CPI 14 18 // ld
730: CP 18 2 // dir
731: ADDi 18 1 // off
732: CPIi 18 14 // st
733: CPi 18 1730 // snake_x
734: CPI 14 18 // snake_x
735: CP 18 14 // ptr
736: CPIi 1 18 // push base
737: ADDi 1 1 // SP++
738: CP 18 2 // length
739: CPI 14 18 // ld
740: CPIi 1 14 // push lhs
741: ADDi 1 1 // SP++
742: CP 14 4 // 1
743: CP 15 14 // rhs
744: ADD 1 5 // SP--
745: CPI 14 1 // pop lhs
746: CP 16 15 // sub
747: NAND 16 16 // ~
748: ADDi 16 1 // -src
749: ADD 14 16 // a-b
750: ADD 1 5 // SP--
751: CPI 18 1 // pop base
752: ADD 18 14 // +idx
753: CPI 14 18 // ld[]
754: CP 18 2 // tail_x
755: ADDi 18 9 // off
756: CPIi 18 14 // st
757: CPi 18 1731 // snake_y
758: CPI 14 18 // snake_y
759: CP 18 14 // ptr
760: CPIi 1 18 // push base
761: ADDi 1 1 // SP++
762: CP 18 2 // length
763: CPI 14 18 // ld
764: CPIi 1 14 // push lhs
765: ADDi 1 1 // SP++
766: CP 14 4 // 1
767: CP 15 14 // rhs
768: ADD 1 5 // SP--
769: CPI 14 1 // pop lhs
770: CP 16 15 // sub
771: NAND 16 16 // ~
772: ADDi 16 1 // -src
773: ADD 14 16 // a-b
774: ADD 1 5 // SP--
775: CPI 18 1 // pop base
776: ADD 18 14 // +idx
777: CPI 14 18 // ld[]
778: CP 18 2 // tail_y
779: ADDi 18 10 // off
780: CPIi 18 14 // st
781: CP 18 2 // length
782: CPI 14 18 // ld
783: CPIi 1 14 // push lhs
784: ADDi 1 1 // SP++
785: CP 14 4 // 1
786: CP 15 14 // rhs
787: ADD 1 5 // SP--
788: CPI 14 1 // pop lhs
789: CP 16 15 // sub
790: NAND 16 16 // ~
791: ADDi 16 1 // -src
792: ADD 14 16 // a-b
793: CP 18 2 // i
794: ADDi 18 6 // off
795: CPIi 18 14 // st
796: CP 18 2 // i
797: ADDi 18 6 // off
798: CPI 14 18 // ld
799: CPIi 1 14 // push lhs
800: ADDi 1 1 // SP++
801: CP 14 3 // 0
802: CP 15 14 // rhs
803: ADD 1 5 // SP--
804: CPI 14 1 // pop lhs
805: LT 15 14 // >
806: CP 14 15
807: CPi 18 903 // for exit (P)
808: BZJ 18 14 // for exit
809: CPi 18 1730 // snake_x
810: CPI 14 18 // snake_x
811: CP 18 14 // ptr
812: CPIi 1 18 // push base
813: ADDi 1 1 // SP++
814: CP 18 2 // i
815: ADDi 18 6 // off
816: CPI 14 18 // ld
817: CPIi 1 14 // push lhs
818: ADDi 1 1 // SP++
819: CP 14 4 // 1
820: CP 15 14 // rhs
821: ADD 1 5 // SP--
822: CPI 14 1 // pop lhs
823: CP 16 15 // sub
824: NAND 16 16 // ~
825: ADDi 16 1 // -src
826: ADD 14 16 // a-b
827: ADD 1 5 // SP--
828: CPI 18 1 // pop base
829: ADD 18 14 // +idx
830: CPI 14 18 // ld[]
831: CPIi 1 14 // push val
832: ADDi 1 1 // SP++
833: CPi 18 1730 // snake_x
834: CPI 14 18 // snake_x
835: CP 18 14 // ptr
836: CPIi 1 18 // push base
837: ADDi 1 1 // SP++
838: CP 18 2 // i
839: ADDi 18 6 // off
840: CPI 14 18 // ld
841: ADD 1 5 // SP--
842: CPI 18 1 // pop base
843: ADD 18 14 // +idx
844: ADD 1 5 // SP--
845: CPI 14 1 // pop val
846: CPIi 18 14 // []=
847: CPi 18 1731 // snake_y
848: CPI 14 18 // snake_y
849: CP 18 14 // ptr
850: CPIi 1 18 // push base
851: ADDi 1 1 // SP++
852: CP 18 2 // i
853: ADDi 18 6 // off
854: CPI 14 18 // ld
855: CPIi 1 14 // push lhs
856: ADDi 1 1 // SP++
857: CP 14 4 // 1
858: CP 15 14 // rhs
859: ADD 1 5 // SP--
860: CPI 14 1 // pop lhs
861: CP 16 15 // sub
862: NAND 16 16 // ~
863: ADDi 16 1 // -src
864: ADD 14 16 // a-b
865: ADD 1 5 // SP--
866: CPI 18 1 // pop base
867: ADD 18 14 // +idx
868: CPI 14 18 // ld[]
869: CPIi 1 14 // push val
870: ADDi 1 1 // SP++
871: CPi 18 1731 // snake_y
872: CPI 14 18 // snake_y
873: CP 18 14 // ptr
874: CPIi 1 18 // push base
875: ADDi 1 1 // SP++
876: CP 18 2 // i
877: ADDi 18 6 // off
878: CPI 14 18 // ld
879: ADD 1 5 // SP--
880: CPI 18 1 // pop base
881: ADD 18 14 // +idx
882: ADD 1 5 // SP--
883: CPI 14 1 // pop val
884: CPIi 18 14 // []=
885: CP 18 2 // i
886: ADDi 18 6 // off
887: CPI 14 18 // ld
888: CPIi 1 14 // push lhs
889: ADDi 1 1 // SP++
890: CP 14 4 // 1
891: CP 15 14 // rhs
892: ADD 1 5 // SP--
893: CPI 14 1 // pop lhs
894: CP 16 15 // sub
895: NAND 16 16 // ~
896: ADDi 16 1 // -src
897: ADD 14 16 // a-b
898: CP 18 2 // i
899: ADDi 18 6 // off
900: CPIi 18 14 // st
901: CPi 18 796 // for
902: BZJi 18 0 // loop
903: CPi 18 1730 // snake_x
904: CPI 14 18 // snake_x
905: CP 18 14 // ptr
906: CPIi 1 18 // push base
907: ADDi 1 1 // SP++
908: CP 14 3 // 0
909: ADD 1 5 // SP--
910: CPI 18 1 // pop base
911: ADD 18 14 // +idx
912: CPI 14 18 // ld[]
913: CP 18 2 // head_x
914: ADDi 18 7 // off
915: CPIi 18 14 // st
916: CPi 18 1731 // snake_y
917: CPI 14 18 // snake_y
918: CP 18 14 // ptr
919: CPIi 1 18 // push base
920: ADDi 1 1 // SP++
921: CP 14 3 // 0
922: ADD 1 5 // SP--
923: CPI 18 1 // pop base
924: ADD 18 14 // +idx
925: CPI 14 18 // ld[]
926: CP 18 2 // head_y
927: ADDi 18 8 // off
928: CPIi 18 14 // st
929: CP 18 2 // dir
930: ADDi 18 1 // off
931: CPI 14 18 // ld
932: CPIi 1 14 // push lhs
933: ADDi 1 1 // SP++
934: CP 14 3 // 0
935: CP 15 14 // rhs
936: ADD 1 5 // SP--
937: CPI 14 1 // pop lhs
938: CP 16 15 // sub
939: NAND 16 16 // ~
940: ADDi 16 1 // -src
941: ADD 14 16 // a-b
942: CPi 18 947 // eq (P)
943: BZJ 18 14 // eq
944: CPi 14 0 // ne
945: CPi 18 948 // eq end (P)
946: BZJi 18 0 // eq end
947: CPi 14 1 // eq
948: CPi 18 966 // if else (P)
949: BZJ 18 14 // if else
950: CP 18 2 // head_y
951: ADDi 18 8 // off
952: CPI 14 18 // ld
953: CPIi 1 14 // push lhs
954: ADDi 1 1 // SP++
955: CP 14 4 // 1
956: CP 15 14 // rhs
957: ADD 1 5 // SP--
958: CPI 14 1 // pop lhs
959: CP 16 15 // sub
960: NAND 16 16 // ~
961: ADDi 16 1 // -src
962: ADD 14 16 // a-b
963: CP 18 2 // head_y
964: ADDi 18 8 // off
965: CPIi 18 14 // st
966: CP 18 2 // dir
967: ADDi 18 1 // off
968: CPI 14 18 // ld
969: CPIi 1 14 // push lhs
970: ADDi 1 1 // SP++
971: CP 14 4 // 1
972: CP 15 14 // rhs
973: ADD 1 5 // SP--
974: CPI 14 1 // pop lhs
975: CP 16 15 // sub
976: NAND 16 16 // ~
977: ADDi 16 1 // -src
978: ADD 14 16 // a-b
979: CPi 18 984 // eq (P)
980: BZJ 18 14 // eq
981: CPi 14 0 // ne
982: CPi 18 985 // eq end (P)
983: BZJi 18 0 // eq end
984: CPi 14 1 // eq
985: CPi 18 1000 // if else (P)
986: BZJ 18 14 // if else
987: CP 18 2 // head_x
988: ADDi 18 7 // off
989: CPI 14 18 // ld
990: CPIi 1 14 // push lhs
991: ADDi 1 1 // SP++
992: CP 14 4 // 1
993: CP 15 14 // rhs
994: ADD 1 5 // SP--
995: CPI 14 1 // pop lhs
996: ADD 14 15 // +
997: CP 18 2 // head_x
998: ADDi 18 7 // off
999: CPIi 18 14 // st
1000: CP 18 2 // dir
1001: ADDi 18 1 // off
1002: CPI 14 18 // ld
1003: CPIi 1 14 // push lhs
1004: ADDi 1 1 // SP++
1005: CPi 14 2 // 2
1006: CP 15 14 // rhs
1007: ADD 1 5 // SP--
1008: CPI 14 1 // pop lhs
1009: CP 16 15 // sub
1010: NAND 16 16 // ~
1011: ADDi 16 1 // -src
1012: ADD 14 16 // a-b
1013: CPi 18 1018 // eq (P)
1014: BZJ 18 14 // eq
1015: CPi 14 0 // ne
1016: CPi 18 1019 // eq end (P)
1017: BZJi 18 0 // eq end
1018: CPi 14 1 // eq
1019: CPi 18 1034 // if else (P)
1020: BZJ 18 14 // if else
1021: CP 18 2 // head_y
1022: ADDi 18 8 // off
1023: CPI 14 18 // ld
1024: CPIi 1 14 // push lhs
1025: ADDi 1 1 // SP++
1026: CP 14 4 // 1
1027: CP 15 14 // rhs
1028: ADD 1 5 // SP--
1029: CPI 14 1 // pop lhs
1030: ADD 14 15 // +
1031: CP 18 2 // head_y
1032: ADDi 18 8 // off
1033: CPIi 18 14 // st
1034: CP 18 2 // dir
1035: ADDi 18 1 // off
1036: CPI 14 18 // ld
1037: CPIi 1 14 // push lhs
1038: ADDi 1 1 // SP++
1039: CPi 14 3 // 3
1040: CP 15 14 // rhs
1041: ADD 1 5 // SP--
1042: CPI 14 1 // pop lhs
1043: CP 16 15 // sub
1044: NAND 16 16 // ~
1045: ADDi 16 1 // -src
1046: ADD 14 16 // a-b
1047: CPi 18 1052 // eq (P)
1048: BZJ 18 14 // eq
1049: CPi 14 0 // ne
1050: CPi 18 1053 // eq end (P)
1051: BZJi 18 0 // eq end
1052: CPi 14 1 // eq
1053: CPi 18 1071 // if else (P)
1054: BZJ 18 14 // if else
1055: CP 18 2 // head_x
1056: ADDi 18 7 // off
1057: CPI 14 18 // ld
1058: CPIi 1 14 // push lhs
1059: ADDi 1 1 // SP++
1060: CP 14 4 // 1
1061: CP 15 14 // rhs
1062: ADD 1 5 // SP--
1063: CPI 14 1 // pop lhs
1064: CP 16 15 // sub
1065: NAND 16 16 // ~
1066: ADDi 16 1 // -src
1067: ADD 14 16 // a-b
1068: CP 18 2 // head_x
1069: ADDi 18 7 // off
1070: CPIi 18 14 // st
1071: CP 18 2 // head_x
1072: ADDi 18 7 // off
1073: CPI 14 18 // ld
1074: CPIi 1 14 // push val
1075: ADDi 1 1 // SP++
1076: CPi 18 1730 // snake_x
1077: CPI 14 18 // snake_x
1078: CP 18 14 // ptr
1079: CPIi 1 18 // push base
1080: ADDi 1 1 // SP++
1081: CP 14 3 // 0
1082: ADD 1 5 // SP--
1083: CPI 18 1 // pop base
1084: ADD 18 14 // +idx
1085: ADD 1 5 // SP--
1086: CPI 14 1 // pop val
1087: CPIi 18 14 // []=
1088: CP 18 2 // head_y
1089: ADDi 18 8 // off
1090: CPI 14 18 // ld
1091: CPIi 1 14 // push val
1092: ADDi 1 1 // SP++
1093: CPi 18 1731 // snake_y
1094: CPI 14 18 // snake_y
1095: CP 18 14 // ptr
1096: CPIi 1 18 // push base
1097: ADDi 1 1 // SP++
1098: CP 14 3 // 0
1099: ADD 1 5 // SP--
1100: CPI 18 1 // pop base
1101: ADD 18 14 // +idx
1102: ADD 1 5 // SP--
1103: CPI 14 1 // pop val
1104: CPIi 18 14 // []=
1105: CP 18 2 // head_x
1106: ADDi 18 7 // off
1107: CPI 14 18 // ld
1108: CPIi 1 14 // push lhs
1109: ADDi 1 1 // SP++
1110: CP 14 3 // 0
1111: CP 15 14 // rhs
1112: ADD 1 5 // SP--
1113: CPI 14 1 // pop lhs
1114: LT 14 15 // <
1115: CPi 18 1121 // if else (P)
1116: BZJ 18 14 // if else
1117: CP 14 4 // 1
1118: CP 18 2 // game_over
1119: ADDi 18 5 // off
1120: CPIi 18 14 // st
1121: CP 18 2 // head_x
1122: ADDi 18 7 // off
1123: CPI 14 18 // ld
1124: CPIi 1 14 // push lhs
1125: ADDi 1 1 // SP++
1126: CPi 14 31 // 31
1127: CP 15 14 // rhs
1128: ADD 1 5 // SP--
1129: CPI 14 1 // pop lhs
1130: LT 15 14 // >
1131: CP 14 15
1132: CPi 18 1138 // if else (P)
1133: BZJ 18 14 // if else
1134: CP 14 4 // 1
1135: CP 18 2 // game_over
1136: ADDi 18 5 // off
1137: CPIi 18 14 // st
1138: CP 18 2 // head_y
1139: ADDi 18 8 // off
1140: CPI 14 18 // ld
1141: CPIi 1 14 // push lhs
1142: ADDi 1 1 // SP++
1143: CPi 14 31 // 31
1144: CP 15 14 // rhs
1145: ADD 1 5 // SP--
1146: CPI 14 1 // pop lhs
1147: LT 15 14 // >
1148: CP 14 15
1149: CPi 18 1155 // if else (P)
1150: BZJ 18 14 // if else
1151: CP 14 4 // 1
1152: CP 18 2 // game_over
1153: ADDi 18 5 // off
1154: CPIi 18 14 // st
1155: CP 18 2 // head_y
1156: ADDi 18 8 // off
1157: CPI 14 18 // ld
1158: CPIi 1 14 // push lhs
1159: ADDi 1 1 // SP++
1160: CPi 14 31 // 31
1161: CP 15 14 // rhs
1162: ADD 1 5 // SP--
1163: CPI 14 1 // pop lhs
1164: LT 15 14 // >
1165: CP 14 15
1166: CPi 18 1172 // if else (P)
1167: BZJ 18 14 // if else
1168: CP 14 4 // 1
1169: CP 18 2 // game_over
1170: ADDi 18 5 // off
1171: CPIi 18 14 // st
1172: CP 14 4 // 1
1173: CP 18 2 // i
1174: ADDi 18 6 // off
1175: CPIi 18 14 // st
1176: CP 18 2 // i
1177: ADDi 18 6 // off
1178: CPI 14 18 // ld
1179: CPIi 1 14 // push lhs
1180: ADDi 1 1 // SP++
1181: CP 18 2 // length
1182: CPI 14 18 // ld
1183: CP 15 14 // rhs
1184: ADD 1 5 // SP--
1185: CPI 14 1 // pop lhs
1186: LT 14 15 // <
1187: CPi 18 1272 // for exit (P)
1188: BZJ 18 14 // for exit
1189: CP 18 2 // head_x
1190: ADDi 18 7 // off
1191: CPI 14 18 // ld
1192: CPIi 1 14 // push lhs
1193: ADDi 1 1 // SP++
1194: CPi 18 1730 // snake_x
1195: CPI 14 18 // snake_x
1196: CP 18 14 // ptr
1197: CPIi 1 18 // push base
1198: ADDi 1 1 // SP++
1199: CP 18 2 // i
1200: ADDi 18 6 // off
1201: CPI 14 18 // ld
1202: ADD 1 5 // SP--
1203: CPI 18 1 // pop base
1204: ADD 18 14 // +idx
1205: CPI 14 18 // ld[]
1206: CP 15 14 // rhs
1207: ADD 1 5 // SP--
1208: CPI 14 1 // pop lhs
1209: CP 16 15 // sub
1210: NAND 16 16 // ~
1211: ADDi 16 1 // -src
1212: ADD 14 16 // a-b
1213: CPi 18 1218 // eq (P)
1214: BZJ 18 14 // eq
1215: CPi 14 0 // ne
1216: CPi 18 1219 // eq end (P)
1217: BZJi 18 0 // eq end
1218: CPi 14 1 // eq
1219: CPi 18 1257 // if else (P)
1220: BZJ 18 14 // if else
1221: CP 18 2 // head_y
1222: ADDi 18 8 // off
1223: CPI 14 18 // ld
1224: CPIi 1 14 // push lhs
1225: ADDi 1 1 // SP++
1226: CPi 18 1731 // snake_y
1227: CPI 14 18 // snake_y
1228: CP 18 14 // ptr
1229: CPIi 1 18 // push base
1230: ADDi 1 1 // SP++
1231: CP 18 2 // i
1232: ADDi 18 6 // off
1233: CPI 14 18 // ld
1234: ADD 1 5 // SP--
1235: CPI 18 1 // pop base
1236: ADD 18 14 // +idx
1237: CPI 14 18 // ld[]
1238: CP 15 14 // rhs
1239: ADD 1 5 // SP--
1240: CPI 14 1 // pop lhs
1241: CP 16 15 // sub
1242: NAND 16 16 // ~
1243: ADDi 16 1 // -src
1244: ADD 14 16 // a-b
1245: CPi 18 1250 // eq (P)
1246: BZJ 18 14 // eq
1247: CPi 14 0 // ne
1248: CPi 18 1251 // eq end (P)
1249: BZJi 18 0 // eq end
1250: CPi 14 1 // eq
1251: CPi 18 1257 // if else (P)
1252: BZJ 18 14 // if else
1253: CP 14 4 // 1
1254: CP 18 2 // game_over
1255: ADDi 18 5 // off
1256: CPIi 18 14 // st
1257: CP 18 2 // i
1258: ADDi 18 6 // off
1259: CPI 14 18 // ld
1260: CPIi 1 14 // push lhs
1261: ADDi 1 1 // SP++
1262: CP 14 4 // 1
1263: CP 15 14 // rhs
1264: ADD 1 5 // SP--
1265: CPI 14 1 // pop lhs
1266: ADD 14 15 // +
1267: CP 18 2 // i
1268: ADDi 18 6 // off
1269: CPIi 18 14 // st
1270: CPi 18 1176 // for
1271: BZJi 18 0 // loop
1272: CP 18 2 // game_over
1273: ADDi 18 5 // off
1274: CPI 14 18 // ld
1275: CPIi 1 14 // push lhs
1276: ADDi 1 1 // SP++
1277: CP 14 4 // 1
1278: CP 15 14 // rhs
1279: ADD 1 5 // SP--
1280: CPI 14 1 // pop lhs
1281: CP 16 15 // sub
1282: NAND 16 16 // ~
1283: ADDi 16 1 // -src
1284: ADD 14 16 // a-b
1285: CPi 18 1290 // eq (P)
1286: BZJ 18 14 // eq
1287: CPi 14 0 // ne
1288: CPi 18 1291 // eq end (P)
1289: BZJi 18 0 // eq end
1290: CPi 14 1 // eq
1291: CPi 18 1295 // if else (P)
1292: BZJ 18 14 // if else
1293: CPi 18 1654 // break (P)
1294: BZJi 18 0 // break
1295: CP 14 3 // 0
1296: CP 18 2 // ate_apple
1297: ADDi 18 14 // off
1298: CPIi 18 14 // st
1299: CP 18 2 // head_x
1300: ADDi 18 7 // off
1301: CPI 14 18 // ld
1302: CPIi 1 14 // push lhs
1303: ADDi 1 1 // SP++
1304: CP 18 2 // apple_x
1305: ADDi 18 3 // off
1306: CPI 14 18 // ld
1307: CP 15 14 // rhs
1308: ADD 1 5 // SP--
1309: CPI 14 1 // pop lhs
1310: CP 16 15 // sub
1311: NAND 16 16 // ~
1312: ADDi 16 1 // -src
1313: ADD 14 16 // a-b
1314: CPi 18 1319 // eq (P)
1315: BZJ 18 14 // eq
1316: CPi 14 0 // ne
1317: CPi 18 1320 // eq end (P)
1318: BZJi 18 0 // eq end
1319: CPi 14 1 // eq
1320: CPi 18 1553 // if else (P)
1321: BZJ 18 14 // if else
1322: CP 18 2 // head_y
1323: ADDi 18 8 // off
1324: CPI 14 18 // ld
1325: CPIi 1 14 // push lhs
1326: ADDi 1 1 // SP++
1327: CP 18 2 // apple_y
1328: ADDi 18 4 // off
1329: CPI 14 18 // ld
1330: CP 15 14 // rhs
1331: ADD 1 5 // SP--
1332: CPI 14 1 // pop lhs
1333: CP 16 15 // sub
1334: NAND 16 16 // ~
1335: ADDi 16 1 // -src
1336: ADD 14 16 // a-b
1337: CPi 18 1342 // eq (P)
1338: BZJ 18 14 // eq
1339: CPi 14 0 // ne
1340: CPi 18 1343 // eq end (P)
1341: BZJi 18 0 // eq end
1342: CPi 14 1 // eq
1343: CPi 18 1553 // if else (P)
1344: BZJ 18 14 // if else
1345: CP 14 4 // 1
1346: CP 18 2 // ate_apple
1347: ADDi 18 14 // off
1348: CPIi 18 14 // st
1349: CP 18 2 // length
1350: CPI 14 18 // ld
1351: CPIi 1 14 // push lhs
1352: ADDi 1 1 // SP++
1353: CP 14 4 // 1
1354: CP 15 14 // rhs
1355: ADD 1 5 // SP--
1356: CPI 14 1 // pop lhs
1357: ADD 14 15 // +
1358: CP 18 2 // length
1359: CPIi 18 14 // st
1360: CP 18 2 // tail_x
1361: ADDi 18 9 // off
1362: CPI 14 18 // ld
1363: CPIi 1 14 // push val
1364: ADDi 1 1 // SP++
1365: CPi 18 1730 // snake_x
1366: CPI 14 18 // snake_x
1367: CP 18 14 // ptr
1368: CPIi 1 18 // push base
1369: ADDi 1 1 // SP++
1370: CP 18 2 // length
1371: CPI 14 18 // ld
1372: CPIi 1 14 // push lhs
1373: ADDi 1 1 // SP++
1374: CP 14 4 // 1
1375: CP 15 14 // rhs
1376: ADD 1 5 // SP--
1377: CPI 14 1 // pop lhs
1378: CP 16 15 // sub
1379: NAND 16 16 // ~
1380: ADDi 16 1 // -src
1381: ADD 14 16 // a-b
1382: ADD 1 5 // SP--
1383: CPI 18 1 // pop base
1384: ADD 18 14 // +idx
1385: ADD 1 5 // SP--
1386: CPI 14 1 // pop val
1387: CPIi 18 14 // []=
1388: CP 18 2 // tail_y
1389: ADDi 18 10 // off
1390: CPI 14 18 // ld
1391: CPIi 1 14 // push val
1392: ADDi 1 1 // SP++
1393: CPi 18 1731 // snake_y
1394: CPI 14 18 // snake_y
1395: CP 18 14 // ptr
1396: CPIi 1 18 // push base
1397: ADDi 1 1 // SP++
1398: CP 18 2 // length
1399: CPI 14 18 // ld
1400: CPIi 1 14 // push lhs
1401: ADDi 1 1 // SP++
1402: CP 14 4 // 1
1403: CP 15 14 // rhs
1404: ADD 1 5 // SP--
1405: CPI 14 1 // pop lhs
1406: CP 16 15 // sub
1407: NAND 16 16 // ~
1408: ADDi 16 1 // -src
1409: ADD 14 16 // a-b
1410: ADD 1 5 // SP--
1411: CPI 18 1 // pop base
1412: ADD 18 14 // +idx
1413: ADD 1 5 // SP--
1414: CPI 14 1 // pop val
1415: CPIi 18 14 // []=
1416: CP 18 2 // apple_x
1417: ADDi 18 3 // off
1418: CPI 14 18 // ld
1419: CPIi 1 14 // push lhs
1420: ADDi 1 1 // SP++
1421: CPi 14 11 // 11
1422: CP 15 14 // rhs
1423: ADD 1 5 // SP--
1424: CPI 14 1 // pop lhs
1425: ADD 14 15 // +
1426: CP 18 2 // apple_x
1427: ADDi 18 3 // off
1428: CPIi 18 14 // st
1429: CP 18 2 // apple_x
1430: ADDi 18 3 // off
1431: CPI 14 18 // ld
1432: CPIi 1 14 // push lhs
1433: ADDi 1 1 // SP++
1434: CPi 14 32 // 32
1435: CP 15 14 // rhs
1436: ADD 1 5 // SP--
1437: CPI 14 1 // pop lhs
1438: LT 14 15 // a<b
1439: CPi 18 1444 // lnot (P)
1440: BZJ 18 14 // lnot
1441: CPi 14 0 // nz->0
1442: CPi 18 1445 // lnot end (P)
1443: BZJi 18 0 // lnot end
1444: CPi 14 1 // z->1
1445: CPi 18 1465 // wh exit (P)
1446: BZJ 18 14 // wh exit
1447: CP 18 2 // apple_x
1448: ADDi 18 3 // off
1449: CPI 14 18 // ld
1450: CPIi 1 14 // push lhs
1451: ADDi 1 1 // SP++
1452: CPi 14 32 // 32
1453: CP 15 14 // rhs
1454: ADD 1 5 // SP--
1455: CPI 14 1 // pop lhs
1456: CP 16 15 // sub
1457: NAND 16 16 // ~
1458: ADDi 16 1 // -src
1459: ADD 14 16 // a-b
1460: CP 18 2 // apple_x
1461: ADDi 18 3 // off
1462: CPIi 18 14 // st
1463: CPi 18 1429 // wh loop
1464: BZJi 18 0 // loop
1465: CP 18 2 // apple_y
1466: ADDi 18 4 // off
1467: CPI 14 18 // ld
1468: CPIi 1 14 // push lhs
1469: ADDi 1 1 // SP++
1470: CPi 14 7 // 7
1471: CP 15 14 // rhs
1472: ADD 1 5 // SP--
1473: CPI 14 1 // pop lhs
1474: ADD 14 15 // +
1475: CP 18 2 // apple_y
1476: ADDi 18 4 // off
1477: CPIi 18 14 // st
1478: CP 18 2 // apple_y
1479: ADDi 18 4 // off
1480: CPI 14 18 // ld
1481: CPIi 1 14 // push lhs
1482: ADDi 1 1 // SP++
1483: CPi 14 32 // 32
1484: CP 15 14 // rhs
1485: ADD 1 5 // SP--
1486: CPI 14 1 // pop lhs
1487: LT 14 15 // a<b
1488: CPi 18 1493 // lnot (P)
1489: BZJ 18 14 // lnot
1490: CPi 14 0 // nz->0
1491: CPi 18 1494 // lnot end (P)
1492: BZJi 18 0 // lnot end
1493: CPi 14 1 // z->1
1494: CPi 18 1514 // wh exit (P)
1495: BZJ 18 14 // wh exit
1496: CP 18 2 // apple_y
1497: ADDi 18 4 // off
1498: CPI 14 18 // ld
1499: CPIi 1 14 // push lhs
1500: ADDi 1 1 // SP++
1501: CPi 14 32 // 32
1502: CP 15 14 // rhs
1503: ADD 1 5 // SP--
1504: CPI 14 1 // pop lhs
1505: CP 16 15 // sub
1506: NAND 16 16 // ~
1507: ADDi 16 1 // -src
1508: ADD 14 16 // a-b
1509: CP 18 2 // apple_y
1510: ADDi 18 4 // off
1511: CPIi 18 14 // st
1512: CPi 18 1478 // wh loop
1513: BZJi 18 0 // loop
1514: CP 18 2 // apple_y
1515: ADDi 18 4 // off
1516: CPI 14 18 // ld
1517: CPIi 1 14 // push lhs
1518: ADDi 1 1 // SP++
1519: CPi 14 32 // 32
1520: CP 15 14 // rhs
1521: ADD 1 5 // SP--
1522: CPI 14 1 // pop lhs
1523: MUL 14 15 // *
1524: CPIi 1 14 // push lhs
1525: ADDi 1 1 // SP++
1526: CP 18 2 // apple_x
1527: ADDi 18 3 // off
1528: CPI 14 18 // ld
1529: CP 15 14 // rhs
1530: ADD 1 5 // SP--
1531: CPI 14 1 // pop lhs
1532: ADD 14 15 // +
1533: CP 18 2 // pos
1534: ADDi 18 11 // off
1535: CPIi 18 14 // st
1536: CP 14 4 // 1
1537: CPIi 1 14 // push val
1538: ADDi 1 1 // SP++
1539: CPi 18 1725 // screen
1540: CPI 14 18 // screen
1541: CP 18 14 // ptr
1542: CPIi 1 18 // push base
1543: ADDi 1 1 // SP++
1544: CP 18 2 // pos
1545: ADDi 18 11 // off
1546: CPI 14 18 // ld
1547: ADD 1 5 // SP--
1548: CPI 18 1 // pop base
1549: ADD 18 14 // +idx
1550: ADD 1 5 // SP--
1551: CPI 14 1 // pop val
1552: CPIi 18 14 // []=
1553: CP 18 2 // ate_apple
1554: ADDi 18 14 // off
1555: CPI 14 18 // ld
1556: CPIi 1 14 // push lhs
1557: ADDi 1 1 // SP++
1558: CP 14 3 // 0
1559: CP 15 14 // rhs
1560: ADD 1 5 // SP--
1561: CPI 14 1 // pop lhs
1562: CP 16 15 // sub
1563: NAND 16 16 // ~
1564: ADDi 16 1 // -src
1565: ADD 14 16 // a-b
1566: CPi 18 1571 // eq (P)
1567: BZJ 18 14 // eq
1568: CPi 14 0 // ne
1569: CPi 18 1572 // eq end (P)
1570: BZJi 18 0 // eq end
1571: CPi 14 1 // eq
1572: CPi 18 1613 // if else (P)
1573: BZJ 18 14 // if else
1574: CP 18 2 // tail_y
1575: ADDi 18 10 // off
1576: CPI 14 18 // ld
1577: CPIi 1 14 // push lhs
1578: ADDi 1 1 // SP++
1579: CPi 14 32 // 32
1580: CP 15 14 // rhs
1581: ADD 1 5 // SP--
1582: CPI 14 1 // pop lhs
1583: MUL 14 15 // *
1584: CPIi 1 14 // push lhs
1585: ADDi 1 1 // SP++
1586: CP 18 2 // tail_x
1587: ADDi 18 9 // off
1588: CPI 14 18 // ld
1589: CP 15 14 // rhs
1590: ADD 1 5 // SP--
1591: CPI 14 1 // pop lhs
1592: ADD 14 15 // +
1593: CP 18 2 // pos
1594: ADDi 18 11 // off
1595: CPIi 18 14 // st
1596: CP 14 3 // 0
1597: CPIi 1 14 // push val
1598: ADDi 1 1 // SP++
1599: CPi 18 1725 // screen
1600: CPI 14 18 // screen
1601: CP 18 14 // ptr
1602: CPIi 1 18 // push base
1603: ADDi 1 1 // SP++
1604: CP 18 2 // pos
1605: ADDi 18 11 // off
1606: CPI 14 18 // ld
1607: ADD 1 5 // SP--
1608: CPI 18 1 // pop base
1609: ADD 18 14 // +idx
1610: ADD 1 5 // SP--
1611: CPI 14 1 // pop val
1612: CPIi 18 14 // []=
1613: CP 18 2 // head_y
1614: ADDi 18 8 // off
1615: CPI 14 18 // ld
1616: CPIi 1 14 // push lhs
1617: ADDi 1 1 // SP++
1618: CPi 14 32 // 32
1619: CP 15 14 // rhs
1620: ADD 1 5 // SP--
1621: CPI 14 1 // pop lhs
1622: MUL 14 15 // *
1623: CPIi 1 14 // push lhs
1624: ADDi 1 1 // SP++
1625: CP 18 2 // head_x
1626: ADDi 18 7 // off
1627: CPI 14 18 // ld
1628: CP 15 14 // rhs
1629: ADD 1 5 // SP--
1630: CPI 14 1 // pop lhs
1631: ADD 14 15 // +
1632: CP 18 2 // pos
1633: ADDi 18 11 // off
1634: CPIi 18 14 // st
1635: CP 14 4 // 1
1636: CPIi 1 14 // push val
1637: ADDi 1 1 // SP++
1638: CPi 18 1725 // screen
1639: CPI 14 18 // screen
1640: CP 18 14 // ptr
1641: CPIi 1 18 // push base
1642: ADDi 1 1 // SP++
1643: CP 18 2 // pos
1644: ADDi 18 11 // off
1645: CPI 14 18 // ld
1646: ADD 1 5 // SP--
1647: CPI 18 1 // pop base
1648: ADD 18 14 // +idx
1649: ADD 1 5 // SP--
1650: CPI 14 1 // pop val
1651: CPIi 18 14 // []=
1652: CPi 18 347 // wh loop
1653: BZJi 18 0 // loop
1654: CP 14 3 // 0
1655: CP 18 2 // i
1656: ADDi 18 6 // off
1657: CPIi 18 14 // st
1658: CP 18 2 // i
1659: ADDi 18 6 // off
1660: CPI 14 18 // ld
1661: CPIi 1 14 // push lhs
1662: ADDi 1 1 // SP++
1663: CPi 14 1024 // 1024
1664: CP 15 14 // rhs
1665: ADD 1 5 // SP--
1666: CPI 14 1 // pop lhs
1667: LT 14 15 // <
1668: CPi 18 1702 // for exit (P)
1669: BZJ 18 14 // for exit
1670: CP 14 4 // 1
1671: CPIi 1 14 // push val
1672: ADDi 1 1 // SP++
1673: CPi 18 1725 // screen
1674: CPI 14 18 // screen
1675: CP 18 14 // ptr
1676: CPIi 1 18 // push base
1677: ADDi 1 1 // SP++
1678: CP 18 2 // i
1679: ADDi 18 6 // off
1680: CPI 14 18 // ld
1681: ADD 1 5 // SP--
1682: CPI 18 1 // pop base
1683: ADD 18 14 // +idx
1684: ADD 1 5 // SP--
1685: CPI 14 1 // pop val
1686: CPIi 18 14 // []=
1687: CP 18 2 // i
1688: ADDi 18 6 // off
1689: CPI 14 18 // ld
1690: CPIi 1 14 // push lhs
1691: ADDi 1 1 // SP++
1692: CP 14 4 // 1
1693: CP 15 14 // rhs
1694: ADD 1 5 // SP--
1695: CPI 14 1 // pop lhs
1696: ADD 14 15 // +
1697: CP 18 2 // i
1698: ADDi 18 6 // off
1699: CPIi 18 14 // st
1700: CPi 18 1658 // for
1701: BZJi 18 0 // loop
1702: CP 14 4 // 1
1703: CPi 18 1707 // wh exit (P)
1704: BZJ 18 14 // wh exit
1705: CPi 18 1702 // wh loop
1706: BZJi 18 0 // loop
1707: CP 14 3 // 0
1708: CP 1 2 // SP=BP
1709: ADD 1 5 // SP--
1710: CPI 2 1 // pop old BP
1711: ADD 1 5 // SP--
1712: CPI 15 1 // pop RA
1713: CPIi 1 14 // push ret
1714: ADDi 1 1 // SP++
1715: BZJi 15 0 // return
1716: CP 1 2 // SP=BP
1717: ADD 1 5 // SP--
1718: CPI 2 1 // pop old BP
1719: ADD 1 5 // SP--
1720: CPI 15 1 // pop RA
1721: CPIi 1 3 // push ret 0
1722: ADDi 1 1 // SP++
1723: BZJi 15 0 // return
1724: BZJi 3 1724 // HALT
//$DATA_SECTION
1725: 0 // g'screen'
1726: 0 // g'key_w'
1727: 0 // g'key_a'
1728: 0 // g'key_s'
1729: 0 // g'key_d'
1730: 0 // g'snake_x'
1731: 0 // g'snake_y'
1732: 1724 // $RA_main
1733: 0 // $OLDBP_main
//$STACK_SECTION // $BASE_main = 1734
