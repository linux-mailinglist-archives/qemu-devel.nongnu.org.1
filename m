Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE75E82E27E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:15:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVET-0004oi-3c; Mon, 15 Jan 2024 17:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rPVEO-0004nv-50
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:14:56 -0500
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rPVEJ-0003Y1-BV
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:14:54 -0500
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7bee874fcc2so326001639f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705356889; x=1705961689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8wo/RPxXScMVeeAROuFZucFMmZJv5CfYuVyEBlXbJ0=;
 b=PDWnFeMZy4XpykfoKAKUdd52xcTkwXbIsKhYyil/inSXqFtWun+8yeffutF+6kcd34
 P4W+uCWvq4uCHWjBPsa37volVzT/tuCxKc0CQN6l89RW9CpOQKPOT9jd4PwpJM7AqPM8
 WsXmmlHcMtw+xQzK17Ui8vWqYfdJghkVH5IjuCt9+RMIOwWaaq6xyIXpOkbLZEsSR6LD
 eibleB4LP/ofzwlMMoBoGxtNu2XxzAdW1XkxJsHOBVT6Udat7EAl8rCkAorwCmxbkTNT
 QIl5J6ybSoY1Wzz/eugxEJaL9XGYl2AJxlN2XUOHWwrOU7qFPOnl0PjiVDqiBXDL9wmf
 0DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705356889; x=1705961689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8wo/RPxXScMVeeAROuFZucFMmZJv5CfYuVyEBlXbJ0=;
 b=PmUTmDrdtwWPjznZLbIGhi3zc6ZfqAPa8sL3Sikad0AyuOM3B7Xs31JpR15W9uDIJ0
 GiNNrAoHAVSFMJObgEsfIXGekjJ9lMg6nsQ1ltDzTRU3S7kivYkIrt+2QmoK8QXyzGJp
 L51fXjvlqDKRY4ic5Sqdtx5WTmlPep27LkQWUo6rImuiKJPisUugSPTOU6WvcD/RvEHG
 QvAJYhah6APOjq55CIGmrwkUxWRqXCITv9xzwVliGG9VSuJM2a6/nX8FYdf3nt+PgNNQ
 eSePLWm8he3fdche7kIemaYpDNgclBVj1QzkeGHmxDtPzbvwpX6qHaOwGVUJ67yQo/9C
 zm/A==
X-Gm-Message-State: AOJu0YxVahI5OGkKKhIy55eEoLhgschwJ0F7CJz+2LSGBGLrA+hC8Xb7
 IshhqR6vesGCRigln9Is8IH37OODjZFrFA==
X-Google-Smtp-Source: AGHT+IEKGgfq5UMS4AY857M50zZJOLUs2SwmQ7ahMxzP5EksWSg4bAVkV13csQtadLTPfLAyyize7Q==
X-Received: by 2002:a6b:7318:0:b0:7be:e620:98ef with SMTP id
 e24-20020a6b7318000000b007bee62098efmr7787250ioh.7.1705356889271; 
 Mon, 15 Jan 2024 14:14:49 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 gm25-20020a0566382b9900b0046df77733acsm2579705jab.102.2024.01.15.14.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:14:48 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 3/3] Hexagon (target/hexagon) Remove old dectree.py
Date: Mon, 15 Jan 2024 15:14:43 -0700
Message-Id: <20240115221443.365287-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115221443.365287-1-ltaylorsimpson@gmail.com>
References: <20240115221443.365287-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Now that we are using QEMU decodetree.py, remove the old decoder

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Brian Cain <bcain@quicinc.com>
---
 target/hexagon/opcodes.h            |   2 -
 target/hexagon/decode.c             | 344 ------------------------
 target/hexagon/gen_dectree_import.c |  49 ----
 target/hexagon/opcodes.c            |  29 --
 target/hexagon/dectree.py           | 403 ----------------------------
 target/hexagon/meson.build          |  12 -
 6 files changed, 839 deletions(-)
 delete mode 100755 target/hexagon/dectree.py

diff --git a/target/hexagon/opcodes.h b/target/hexagon/opcodes.h
index 6e90e00fe2..fa7e321950 100644
--- a/target/hexagon/opcodes.h
+++ b/target/hexagon/opcodes.h
@@ -53,6 +53,4 @@ extern const OpcodeEncoding opcode_encodings[XX_LAST_OPCODE];
 
 void opcode_init(void);
 
-int opcode_which_immediate_is_extended(Opcode opcode);
-
 #endif
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 160b23a895..a40210ca1e 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -88,175 +88,6 @@ static int shift_left(DisasContext *ctx, int x, int n, int immno)
 /* Include the generated helpers for the decoder */
 #include "decodetree_trans_funcs_generated.c.inc"
 
-typedef struct {
-    const struct DectreeTable *table_link;
-    const struct DectreeTable *table_link_b;
-    Opcode opcode;
-    enum {
-        DECTREE_ENTRY_INVALID,
-        DECTREE_TABLE_LINK,
-        DECTREE_SUBINSNS,
-        DECTREE_EXTSPACE,
-        DECTREE_TERMINAL
-    } type;
-} DectreeEntry;
-
-typedef struct DectreeTable {
-    unsigned int (*lookup_function)(int startbit, int width, uint32_t opcode);
-    unsigned int size;
-    unsigned int startbit;
-    unsigned int width;
-    const DectreeEntry table[];
-} DectreeTable;
-
-#define DECODE_NEW_TABLE(TAG, SIZE, WHATNOT) \
-    static const DectreeTable dectree_table_##TAG;
-#define TABLE_LINK(TABLE)                     /* NOTHING */
-#define TERMINAL(TAG, ENC)                    /* NOTHING */
-#define SUBINSNS(TAG, CLASSA, CLASSB, ENC)    /* NOTHING */
-#define EXTSPACE(TAG, ENC)                    /* NOTHING */
-#define INVALID()                             /* NOTHING */
-#define DECODE_END_TABLE(...)                 /* NOTHING */
-#define DECODE_MATCH_INFO(...)                /* NOTHING */
-#define DECODE_LEGACY_MATCH_INFO(...)         /* NOTHING */
-#define DECODE_OPINFO(...)                    /* NOTHING */
-
-#include "dectree_generated.h.inc"
-
-#undef DECODE_OPINFO
-#undef DECODE_MATCH_INFO
-#undef DECODE_LEGACY_MATCH_INFO
-#undef DECODE_END_TABLE
-#undef INVALID
-#undef TERMINAL
-#undef SUBINSNS
-#undef EXTSPACE
-#undef TABLE_LINK
-#undef DECODE_NEW_TABLE
-#undef DECODE_SEPARATOR_BITS
-
-#define DECODE_SEPARATOR_BITS(START, WIDTH) NULL, START, WIDTH
-#define DECODE_NEW_TABLE_HELPER(TAG, SIZE, FN, START, WIDTH) \
-    static const DectreeTable dectree_table_##TAG = { \
-        .size = SIZE, \
-        .lookup_function = FN, \
-        .startbit = START, \
-        .width = WIDTH, \
-        .table = {
-#define DECODE_NEW_TABLE(TAG, SIZE, WHATNOT) \
-    DECODE_NEW_TABLE_HELPER(TAG, SIZE, WHATNOT)
-
-#define TABLE_LINK(TABLE) \
-    { .type = DECTREE_TABLE_LINK, .table_link = &dectree_table_##TABLE },
-#define TERMINAL(TAG, ENC) \
-    { .type = DECTREE_TERMINAL, .opcode = TAG  },
-#define SUBINSNS(TAG, CLASSA, CLASSB, ENC) \
-    { \
-        .type = DECTREE_SUBINSNS, \
-        .table_link = &dectree_table_DECODE_SUBINSN_##CLASSA, \
-        .table_link_b = &dectree_table_DECODE_SUBINSN_##CLASSB \
-    },
-#define EXTSPACE(TAG, ENC) { .type = DECTREE_EXTSPACE },
-#define INVALID() { .type = DECTREE_ENTRY_INVALID, .opcode = XX_LAST_OPCODE },
-
-#define DECODE_END_TABLE(...) } };
-
-#define DECODE_MATCH_INFO(...)                /* NOTHING */
-#define DECODE_LEGACY_MATCH_INFO(...)         /* NOTHING */
-#define DECODE_OPINFO(...)                    /* NOTHING */
-
-#include "dectree_generated.h.inc"
-
-#undef DECODE_OPINFO
-#undef DECODE_MATCH_INFO
-#undef DECODE_LEGACY_MATCH_INFO
-#undef DECODE_END_TABLE
-#undef INVALID
-#undef TERMINAL
-#undef SUBINSNS
-#undef EXTSPACE
-#undef TABLE_LINK
-#undef DECODE_NEW_TABLE
-#undef DECODE_NEW_TABLE_HELPER
-#undef DECODE_SEPARATOR_BITS
-
-static const DectreeTable dectree_table_DECODE_EXT_EXT_noext = {
-    .size = 1, .lookup_function = NULL, .startbit = 0, .width = 0,
-    .table = {
-        { .type = DECTREE_ENTRY_INVALID, .opcode = XX_LAST_OPCODE },
-    }
-};
-
-static const DectreeTable *ext_trees[XX_LAST_EXT_IDX];
-
-static void decode_ext_init(void)
-{
-    int i;
-    for (i = EXT_IDX_noext; i < EXT_IDX_noext_AFTER; i++) {
-        ext_trees[i] = &dectree_table_DECODE_EXT_EXT_noext;
-    }
-    for (i = EXT_IDX_mmvec; i < EXT_IDX_mmvec_AFTER; i++) {
-        ext_trees[i] = &dectree_table_DECODE_EXT_EXT_mmvec;
-    }
-}
-
-typedef struct {
-    uint32_t mask;
-    uint32_t match;
-} DecodeITableEntry;
-
-#define DECODE_NEW_TABLE(TAG, SIZE, WHATNOT)  /* NOTHING */
-#define TABLE_LINK(TABLE)                     /* NOTHING */
-#define TERMINAL(TAG, ENC)                    /* NOTHING */
-#define SUBINSNS(TAG, CLASSA, CLASSB, ENC)    /* NOTHING */
-#define EXTSPACE(TAG, ENC)                    /* NOTHING */
-#define INVALID()                             /* NOTHING */
-#define DECODE_END_TABLE(...)                 /* NOTHING */
-#define DECODE_OPINFO(...)                    /* NOTHING */
-
-#define DECODE_MATCH_INFO_NORMAL(TAG, MASK, MATCH) \
-    [TAG] = { \
-        .mask = MASK, \
-        .match = MATCH, \
-    },
-
-#define DECODE_MATCH_INFO_NULL(TAG, MASK, MATCH) \
-    [TAG] = { .match = ~0 },
-
-#define DECODE_MATCH_INFO(...) DECODE_MATCH_INFO_NORMAL(__VA_ARGS__)
-#define DECODE_LEGACY_MATCH_INFO(...) /* NOTHING */
-
-static const DecodeITableEntry decode_itable[XX_LAST_OPCODE] = {
-#include "dectree_generated.h.inc"
-};
-
-#undef DECODE_MATCH_INFO
-#define DECODE_MATCH_INFO(...) DECODE_MATCH_INFO_NULL(__VA_ARGS__)
-
-#undef DECODE_LEGACY_MATCH_INFO
-#define DECODE_LEGACY_MATCH_INFO(...) DECODE_MATCH_INFO_NORMAL(__VA_ARGS__)
-
-static const DecodeITableEntry decode_legacy_itable[XX_LAST_OPCODE] = {
-#include "dectree_generated.h.inc"
-};
-
-#undef DECODE_OPINFO
-#undef DECODE_MATCH_INFO
-#undef DECODE_LEGACY_MATCH_INFO
-#undef DECODE_END_TABLE
-#undef INVALID
-#undef TERMINAL
-#undef SUBINSNS
-#undef EXTSPACE
-#undef TABLE_LINK
-#undef DECODE_NEW_TABLE
-#undef DECODE_SEPARATOR_BITS
-
-void decode_init(void)
-{
-    decode_ext_init();
-}
-
 void decode_send_insn_to(Packet *packet, int start, int newloc)
 {
     Insn tmpinsn;
@@ -587,7 +418,6 @@ apply_extender(Packet *pkt, int i, uint32_t extender)
     uint32_t base_immed;
 
     immed_num = pkt->insn[i].which_extended;
-    g_assert(immed_num == opcode_which_immediate_is_extended(pkt->insn[i].opcode));
     base_immed = pkt->insn[i].immed[immed_num];
 
     pkt->insn[i].immed[immed_num] = extender | fZXTN(6, 32, base_immed);
@@ -630,174 +460,6 @@ static SlotMask get_valid_slots(const Packet *pkt, unsigned int slot)
     }
 }
 
-#define DECODE_NEW_TABLE(TAG, SIZE, WHATNOT)     /* NOTHING */
-#define TABLE_LINK(TABLE)                        /* NOTHING */
-#define TERMINAL(TAG, ENC)                       /* NOTHING */
-#define SUBINSNS(TAG, CLASSA, CLASSB, ENC)       /* NOTHING */
-#define EXTSPACE(TAG, ENC)                       /* NOTHING */
-#define INVALID()                                /* NOTHING */
-#define DECODE_END_TABLE(...)                    /* NOTHING */
-#define DECODE_MATCH_INFO(...)                   /* NOTHING */
-#define DECODE_LEGACY_MATCH_INFO(...)            /* NOTHING */
-
-#define DECODE_REG(REGNO, WIDTH, STARTBIT) \
-    insn->regno[REGNO] = ((encoding >> STARTBIT) & ((1 << WIDTH) - 1));
-
-#define DECODE_IMPL_REG(REGNO, VAL) \
-    insn->regno[REGNO] = VAL;
-
-#define DECODE_IMM(IMMNO, WIDTH, STARTBIT, VALSTART) \
-    insn->immed[IMMNO] |= (((encoding >> STARTBIT) & ((1 << WIDTH) - 1))) << \
-                          (VALSTART);
-
-#define DECODE_IMM_SXT(IMMNO, WIDTH) \
-    insn->immed[IMMNO] = ((((int32_t)insn->immed[IMMNO]) << (32 - WIDTH)) >> \
-                          (32 - WIDTH));
-
-#define DECODE_IMM_NEG(IMMNO, WIDTH) \
-    insn->immed[IMMNO] = -insn->immed[IMMNO];
-
-#define DECODE_IMM_SHIFT(IMMNO, SHAMT)                                 \
-    if ((!insn->extension_valid) || \
-        (insn->which_extended != IMMNO)) { \
-        insn->immed[IMMNO] <<= SHAMT; \
-    }
-
-#define DECODE_OPINFO(TAG, BEH) \
-    case TAG: \
-        { BEH  } \
-        break; \
-
-/*
- * Fill in the operands of the instruction
- * dectree_generated.h.inc has a DECODE_OPINFO entry for each opcode
- * For example,
- *     DECODE_OPINFO(A2_addi,
- *          DECODE_REG(0,5,0)
- *          DECODE_REG(1,5,16)
- *          DECODE_IMM(0,7,21,9)
- *          DECODE_IMM(0,9,5,0)
- *          DECODE_IMM_SXT(0,16)
- * with the macros defined above, we'll fill in a switch statement
- * where each case is an opcode tag.
- */
-static void
-decode_op(Insn *insn, Opcode tag, uint32_t encoding)
-{
-    insn->immed[0] = 0;
-    insn->immed[1] = 0;
-    insn->opcode = tag;
-    if (insn->extension_valid) {
-        insn->which_extended = opcode_which_immediate_is_extended(tag);
-    }
-
-    switch (tag) {
-#include "dectree_generated.h.inc"
-    default:
-        break;
-    }
-
-    insn->generate = opcode_genptr[tag];
-
-    insn->iclass = iclass_bits(encoding);
-}
-
-#undef DECODE_REG
-#undef DECODE_IMPL_REG
-#undef DECODE_IMM
-#undef DECODE_IMM_SHIFT
-#undef DECODE_OPINFO
-#undef DECODE_MATCH_INFO
-#undef DECODE_LEGACY_MATCH_INFO
-#undef DECODE_END_TABLE
-#undef INVALID
-#undef TERMINAL
-#undef SUBINSNS
-#undef EXTSPACE
-#undef TABLE_LINK
-#undef DECODE_NEW_TABLE
-#undef DECODE_SEPARATOR_BITS
-
-static unsigned int
-decode_subinsn_tablewalk(Insn *insn, const DectreeTable *table,
-                         uint32_t encoding)
-{
-    unsigned int i;
-    Opcode opc;
-    if (table->lookup_function) {
-        i = table->lookup_function(table->startbit, table->width, encoding);
-    } else {
-        i = extract32(encoding, table->startbit, table->width);
-    }
-    if (table->table[i].type == DECTREE_TABLE_LINK) {
-        return decode_subinsn_tablewalk(insn, table->table[i].table_link,
-                                        encoding);
-    } else if (table->table[i].type == DECTREE_TERMINAL) {
-        opc = table->table[i].opcode;
-        if ((encoding & decode_itable[opc].mask) != decode_itable[opc].match) {
-            return 0;
-        }
-        decode_op(insn, opc, encoding);
-        return 1;
-    } else {
-        return 0;
-    }
-}
-
-static unsigned int get_insn_a(uint32_t encoding)
-{
-    return extract32(encoding, 0, 13);
-}
-
-static unsigned int get_insn_b(uint32_t encoding)
-{
-    return extract32(encoding, 16, 13);
-}
-
-static unsigned int
-decode_insns_tablewalk(Insn *insn, const DectreeTable *table,
-                       uint32_t encoding)
-{
-    unsigned int i;
-    unsigned int a, b;
-    Opcode opc;
-    if (table->lookup_function) {
-        i = table->lookup_function(table->startbit, table->width, encoding);
-    } else {
-        i = extract32(encoding, table->startbit, table->width);
-    }
-    if (table->table[i].type == DECTREE_TABLE_LINK) {
-        return decode_insns_tablewalk(insn, table->table[i].table_link,
-                                      encoding);
-    } else if (table->table[i].type == DECTREE_SUBINSNS) {
-        a = get_insn_a(encoding);
-        b = get_insn_b(encoding);
-        b = decode_subinsn_tablewalk(insn, table->table[i].table_link_b, b);
-        a = decode_subinsn_tablewalk(insn + 1, table->table[i].table_link, a);
-        if ((a == 0) || (b == 0)) {
-            return 0;
-        }
-        return 2;
-    } else if (table->table[i].type == DECTREE_TERMINAL) {
-        opc = table->table[i].opcode;
-        if ((encoding & decode_itable[opc].mask) != decode_itable[opc].match) {
-            if ((encoding & decode_legacy_itable[opc].mask) !=
-                decode_legacy_itable[opc].match) {
-                return 0;
-            }
-        }
-        decode_op(insn, opc, encoding);
-        return 1;
-    } else if (table->table[i].type == DECTREE_EXTSPACE) {
-        /*
-         * For now, HVX will be the only coproc
-         */
-        return decode_insns_tablewalk(insn, ext_trees[EXT_IDX_mmvec], encoding);
-    } else {
-        return 0;
-    }
-}
-
 /*
  * Section 10.3 of the Hexagon V73 Programmer's Reference Manual
  *
@@ -858,7 +520,6 @@ static uint16_t get_slot1_subinsn(uint32_t encoding)
 static unsigned int
 decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
 {
-    const DectreeTable *table;
     if (parse_bits(encoding) != 0) {
         if (decode_normal(ctx, encoding) ||
             decode_hvx(ctx, encoding)) {
@@ -866,8 +527,6 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
             insn->iclass = iclass_bits(encoding);
             return 1;
         }
-        /* Start with PP table - 32 bit instructions */
-        table = &dectree_table_DECODE_ROOT_32;
         g_assert_not_reached();
     } else {
         uint32_t iclass = get_duplex_iclass(encoding);
@@ -889,11 +548,8 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
                 return 2;
             }
         }
-        /* start with EE table - duplex instructions */
-        table = &dectree_table_DECODE_ROOT_EE;
         g_assert_not_reached();
     }
-    return decode_insns_tablewalk(insn, table, encoding);
 }
 
 static void decode_add_endloop_insn(Insn *insn, int loopnum)
diff --git a/target/hexagon/gen_dectree_import.c b/target/hexagon/gen_dectree_import.c
index ee354677fd..87f20c14f1 100644
--- a/target/hexagon/gen_dectree_import.c
+++ b/target/hexagon/gen_dectree_import.c
@@ -56,24 +56,6 @@ const char * const opcode_syntax[XX_LAST_OPCODE] = {
 #undef EXTINSN
 };
 
-const char * const opcode_rregs[] = {
-#define REGINFO(TAG, REGINFO, RREGS, WREGS) RREGS,
-#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)  /* nothing */
-#include "op_regs_generated.h.inc"
-    NULL
-#undef REGINFO
-#undef IMMINFO
-};
-
-const char * const opcode_wregs[] = {
-#define REGINFO(TAG, REGINFO, RREGS, WREGS) WREGS,
-#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)  /* nothing */
-#include "op_regs_generated.h.inc"
-    NULL
-#undef REGINFO
-#undef IMMINFO
-};
-
 const OpcodeEncoding opcode_encodings[] = {
 #define DEF_ENC32(TAG, ENCSTR) \
     [TAG] = { .encoding = ENCSTR },
@@ -130,8 +112,6 @@ static void gen_iset_table(FILE *out)
         fprintf(out, "\t\'%s\' : {\n", opcode_names[i]);
         fprintf(out, "\t\t\'tag\' : \'%s\',\n", opcode_names[i]);
         fprintf(out, "\t\t\'syntax\' : \'%s\',\n", opcode_syntax[i]);
-        fprintf(out, "\t\t\'rregs\' : \'%s\',\n", opcode_rregs[i]);
-        fprintf(out, "\t\t\'wregs\' : \'%s\',\n", opcode_wregs[i]);
         fprintf(out, "\t\t\'enc\' : \'%s\',\n", get_opcode_enc(i));
         fprintf(out, "\t\t\'enc_class\' : \'%s\',\n", get_opcode_enc_class(i));
         fprintf(out, "\t},\n");
@@ -150,33 +130,6 @@ static void gen_tags_list(FILE *out)
     fprintf(out, "];\n\n");
 }
 
-static void gen_enc_ext_spaces_table(FILE *out)
-{
-    fprintf(out, "enc_ext_spaces = {\n");
-#define DEF_EXT_SPACE(SPACEID, ENCSTR) \
-    fprintf(out, "\t\'%s\' : \'%s\',\n", #SPACEID, ENCSTR);
-#include "imported/encode.def"
-#undef DEF_EXT_SPACE
-    fprintf(out, "};\n\n");
-}
-
-static void gen_subinsn_groupings_table(FILE *out)
-{
-    fprintf(out, "subinsn_groupings = {\n");
-#define DEF_PACKED32(TAG, TYPEA, TYPEB, ENCSTR) \
-    do { \
-        fprintf(out, "\t\'%s\' : {\n", #TAG); \
-        fprintf(out, "\t\t\'name\' : \'%s\',\n", #TAG); \
-        fprintf(out, "\t\t\'class_a\' : \'%s\',\n", #TYPEA); \
-        fprintf(out, "\t\t\'class_b\' : \'%s\',\n", #TYPEB); \
-        fprintf(out, "\t\t\'enc\' : \'%s\',\n", ENCSTR); \
-        fprintf(out, "\t},\n"); \
-    } while (0);
-#include "imported/encode.def"
-#undef DEF_PACKED32
-    fprintf(out, "};\n\n");
-}
-
 int main(int argc, char *argv[])
 {
     FILE *outfile;
@@ -193,8 +146,6 @@ int main(int argc, char *argv[])
 
     gen_iset_table(outfile);
     gen_tags_list(outfile);
-    gen_enc_ext_spaces_table(outfile);
-    gen_subinsn_groupings_table(outfile);
 
     fclose(outfile);
     return 0;
diff --git a/target/hexagon/opcodes.c b/target/hexagon/opcodes.c
index 35d790cdd5..1f7f3def38 100644
--- a/target/hexagon/opcodes.c
+++ b/target/hexagon/opcodes.c
@@ -111,33 +111,4 @@ void opcode_init(void)
 #include "op_attribs_generated.h.inc"
 #undef OP_ATTRIB
 #undef ATTRIBS
-
-    decode_init();
-}
-
-
-#define NEEDLE "IMMEXT("
-
-int opcode_which_immediate_is_extended(Opcode opcode)
-{
-    const char *p;
-
-    g_assert(opcode < XX_LAST_OPCODE);
-    g_assert(GET_ATTRIB(opcode, A_EXTENDABLE));
-
-    p = opcode_short_semantics[opcode];
-    p = strstr(p, NEEDLE);
-    g_assert(p);
-    p += strlen(NEEDLE);
-    while (isspace(*p)) {
-        p++;
-    }
-    /* lower is always imm 0, upper always imm 1. */
-    if (islower(*p)) {
-        return 0;
-    } else if (isupper(*p)) {
-        return 1;
-    } else {
-        g_assert_not_reached();
-    }
 }
diff --git a/target/hexagon/dectree.py b/target/hexagon/dectree.py
deleted file mode 100755
index 3b32948a04..0000000000
--- a/target/hexagon/dectree.py
+++ /dev/null
@@ -1,403 +0,0 @@
-#!/usr/bin/env python3
-
-##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
-##
-##  This program is free software; you can redistribute it and/or modify
-##  it under the terms of the GNU General Public License as published by
-##  the Free Software Foundation; either version 2 of the License, or
-##  (at your option) any later version.
-##
-##  This program is distributed in the hope that it will be useful,
-##  but WITHOUT ANY WARRANTY; without even the implied warranty of
-##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-##  GNU General Public License for more details.
-##
-##  You should have received a copy of the GNU General Public License
-##  along with this program; if not, see <http://www.gnu.org/licenses/>.
-##
-
-import io
-import re
-
-import sys
-import iset
-
-encs = {
-    tag: "".join(reversed(iset.iset[tag]["enc"].replace(" ", "")))
-    for tag in iset.tags
-    if iset.iset[tag]["enc"] != "MISSING ENCODING"
-}
-
-enc_classes = set([iset.iset[tag]["enc_class"] for tag in encs.keys()])
-subinsn_enc_classes = set(
-    [enc_class for enc_class in enc_classes if enc_class.startswith("SUBINSN_")]
-)
-ext_enc_classes = set(
-    [
-        enc_class
-        for enc_class in enc_classes
-        if enc_class not in ("NORMAL", "16BIT") and not enc_class.startswith("SUBINSN_")
-    ]
-)
-
-try:
-    subinsn_groupings = iset.subinsn_groupings
-except AttributeError:
-    subinsn_groupings = {}
-
-for tag, subinsn_grouping in subinsn_groupings.items():
-    encs[tag] = "".join(reversed(subinsn_grouping["enc"].replace(" ", "")))
-
-dectree_normal = {"leaves": set()}
-dectree_16bit = {"leaves": set()}
-dectree_subinsn_groupings = {"leaves": set()}
-dectree_subinsns = {name: {"leaves": set()} for name in subinsn_enc_classes}
-dectree_extensions = {name: {"leaves": set()} for name in ext_enc_classes}
-
-for tag in encs.keys():
-    if tag in subinsn_groupings:
-        dectree_subinsn_groupings["leaves"].add(tag)
-        continue
-    enc_class = iset.iset[tag]["enc_class"]
-    if enc_class.startswith("SUBINSN_"):
-        if len(encs[tag]) != 32:
-            encs[tag] = encs[tag] + "0" * (32 - len(encs[tag]))
-        dectree_subinsns[enc_class]["leaves"].add(tag)
-    elif enc_class == "16BIT":
-        if len(encs[tag]) != 16:
-            raise Exception(
-                'Tag "{}" has enc_class "{}" and not an encoding '
-                + "width of 16 bits!".format(tag, enc_class)
-            )
-        dectree_16bit["leaves"].add(tag)
-    else:
-        if len(encs[tag]) != 32:
-            raise Exception(
-                'Tag "{}" has enc_class "{}" and not an encoding '
-                + "width of 32 bits!".format(tag, enc_class)
-            )
-        if enc_class == "NORMAL":
-            dectree_normal["leaves"].add(tag)
-        else:
-            dectree_extensions[enc_class]["leaves"].add(tag)
-
-faketags = set()
-for tag, enc in iset.enc_ext_spaces.items():
-    faketags.add(tag)
-    encs[tag] = "".join(reversed(enc.replace(" ", "")))
-    dectree_normal["leaves"].add(tag)
-
-faketags |= set(subinsn_groupings.keys())
-
-
-def every_bit_counts(bitset):
-    for i in range(1, len(next(iter(bitset)))):
-        if len(set([bits[:i] + bits[i + 1 :] for bits in bitset])) == len(bitset):
-            return False
-    return True
-
-
-def auto_separate(node):
-    tags = node["leaves"]
-    if len(tags) <= 1:
-        return
-    enc_width = len(encs[next(iter(tags))])
-    opcode_bit_for_all = [
-        all([encs[tag][i] in "01" for tag in tags]) for i in range(enc_width)
-    ]
-    opcode_bit_is_0_for_all = [
-        opcode_bit_for_all[i] and all([encs[tag][i] == "0" for tag in tags])
-        for i in range(enc_width)
-    ]
-    opcode_bit_is_1_for_all = [
-        opcode_bit_for_all[i] and all([encs[tag][i] == "1" for tag in tags])
-        for i in range(enc_width)
-    ]
-    differentiator_opcode_bit = [
-        opcode_bit_for_all[i]
-        and not (opcode_bit_is_0_for_all[i] or opcode_bit_is_1_for_all[i])
-        for i in range(enc_width)
-    ]
-    best_width = 0
-    for width in range(4, 0, -1):
-        for lsb in range(enc_width - width, -1, -1):
-            bitset = set([encs[tag][lsb : lsb + width] for tag in tags])
-            if all(differentiator_opcode_bit[lsb : lsb + width]) and (
-                len(bitset) == len(tags) or every_bit_counts(bitset)
-            ):
-                best_width = width
-                best_lsb = lsb
-                caught_all_tags = len(bitset) == len(tags)
-                break
-        if best_width != 0:
-            break
-    if best_width == 0:
-        raise Exception(
-            "Could not find a way to differentiate the encodings "
-            + "of the following tags:\n{}".format("\n".join(tags))
-        )
-    if caught_all_tags:
-        for width in range(1, best_width):
-            for lsb in range(enc_width - width, -1, -1):
-                bitset = set([encs[tag][lsb : lsb + width] for tag in tags])
-                if all(differentiator_opcode_bit[lsb : lsb + width]) and len(
-                    bitset
-                ) == len(tags):
-                    best_width = width
-                    best_lsb = lsb
-                    break
-            else:
-                continue
-            break
-    node["separator_lsb"] = best_lsb
-    node["separator_width"] = best_width
-    node["children"] = []
-    for value in range(2**best_width):
-        child = {}
-        bits = "".join(reversed("{:0{}b}".format(value, best_width)))
-        child["leaves"] = set(
-            [tag for tag in tags if encs[tag][best_lsb : best_lsb + best_width] == bits]
-        )
-        node["children"].append(child)
-    for child in node["children"]:
-        auto_separate(child)
-
-
-auto_separate(dectree_normal)
-auto_separate(dectree_16bit)
-if subinsn_groupings:
-    auto_separate(dectree_subinsn_groupings)
-for dectree_subinsn in dectree_subinsns.values():
-    auto_separate(dectree_subinsn)
-for dectree_ext in dectree_extensions.values():
-    auto_separate(dectree_ext)
-
-for tag in faketags:
-    del encs[tag]
-
-
-def table_name(parents, node):
-    path = parents + [node]
-    root = path[0]
-    tag = next(iter(node["leaves"]))
-    if tag in subinsn_groupings:
-        enc_width = len(subinsn_groupings[tag]["enc"].replace(" ", ""))
-    else:
-        tag = next(iter(node["leaves"] - faketags))
-        enc_width = len(encs[tag])
-    determining_bits = ["_"] * enc_width
-    for parent, child in zip(path[:-1], path[1:]):
-        lsb = parent["separator_lsb"]
-        width = parent["separator_width"]
-        value = parent["children"].index(child)
-        determining_bits[lsb : lsb + width] = list(
-            reversed("{:0{}b}".format(value, width))
-        )
-    if tag in subinsn_groupings:
-        name = "DECODE_ROOT_EE"
-    else:
-        enc_class = iset.iset[tag]["enc_class"]
-        if enc_class in ext_enc_classes:
-            name = "DECODE_EXT_{}".format(enc_class)
-        elif enc_class in subinsn_enc_classes:
-            name = "DECODE_SUBINSN_{}".format(enc_class)
-        else:
-            name = "DECODE_ROOT_{}".format(enc_width)
-    if node != root:
-        name += "_" + "".join(reversed(determining_bits))
-    return name
-
-
-def print_node(f, node, parents):
-    if len(node["leaves"]) <= 1:
-        return
-    name = table_name(parents, node)
-    lsb = node["separator_lsb"]
-    width = node["separator_width"]
-    print(
-        "DECODE_NEW_TABLE({},{},DECODE_SEPARATOR_BITS({},{}))".format(
-            name, 2**width, lsb, width
-        ),
-        file=f,
-    )
-    for child in node["children"]:
-        if len(child["leaves"]) == 0:
-            print("INVALID()", file=f)
-        elif len(child["leaves"]) == 1:
-            (tag,) = child["leaves"]
-            if tag in subinsn_groupings:
-                class_a = subinsn_groupings[tag]["class_a"]
-                class_b = subinsn_groupings[tag]["class_b"]
-                enc = subinsn_groupings[tag]["enc"].replace(" ", "")
-                if "RESERVED" in tag:
-                    print("INVALID()", file=f)
-                else:
-                    print(
-                        'SUBINSNS({},{},{},"{}")'.format(tag, class_a, class_b, enc),
-                        file=f,
-                    )
-            elif tag in iset.enc_ext_spaces:
-                enc = iset.enc_ext_spaces[tag].replace(" ", "")
-                print('EXTSPACE({},"{}")'.format(tag, enc), file=f)
-            else:
-                enc = "".join(reversed(encs[tag]))
-                print('TERMINAL({},"{}")'.format(tag, enc), file=f)
-        else:
-            print("TABLE_LINK({})".format(table_name(parents + [node], child)), file=f)
-    print(
-        "DECODE_END_TABLE({},{},DECODE_SEPARATOR_BITS({},{}))".format(
-            name, 2**width, lsb, width
-        ),
-        file=f,
-    )
-    print(file=f)
-    parents.append(node)
-    for child in node["children"]:
-        print_node(f, child, parents)
-    parents.pop()
-
-
-def print_tree(f, tree):
-    print_node(f, tree, [])
-
-
-def print_match_info(f):
-    for tag in sorted(encs.keys(), key=iset.tags.index):
-        enc = "".join(reversed(encs[tag]))
-        mask = int(re.sub(r"[^1]", r"0", enc.replace("0", "1")), 2)
-        match = int(re.sub(r"[^01]", r"0", enc), 2)
-        suffix = ""
-        print(
-            "DECODE{}_MATCH_INFO({},0x{:x}U,0x{:x}U)".format(suffix, tag, mask, match),
-            file=f,
-        )
-
-
-regre = re.compile(r"((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)")
-immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
-
-
-def ordered_unique(l):
-    return sorted(set(l), key=l.index)
-
-
-implicit_registers = {"SP": 29, "FP": 30, "LR": 31}
-
-num_registers = {"R": 32, "V": 32}
-
-
-def print_op_info(f):
-    for tag in sorted(encs.keys(), key=iset.tags.index):
-        enc = encs[tag]
-        print(file=f)
-        print("DECODE_OPINFO({},".format(tag), file=f)
-        regs = ordered_unique(regre.findall(iset.iset[tag]["syntax"]))
-        imms = ordered_unique(immre.findall(iset.iset[tag]["syntax"]))
-        regno = 0
-        for reg in regs:
-            reg_type = reg[0]
-            reg_letter = reg[1][0]
-            reg_num_choices = int(reg[3].rstrip("S"))
-            reg_mapping = reg[0] + "".join(["_" for letter in reg[1]]) + reg[3]
-            reg_enc_fields = re.findall(reg_letter + "+", enc)
-            if len(reg_enc_fields) == 0:
-                raise Exception('Tag "{}" missing register field!'.format(tag))
-            if len(reg_enc_fields) > 1:
-                raise Exception('Tag "{}" has split register field!'.format(tag))
-            reg_enc_field = reg_enc_fields[0]
-            if 2 ** len(reg_enc_field) != reg_num_choices:
-                raise Exception(
-                    'Tag "{}" has incorrect register field width!'.format(tag)
-                )
-            print(
-                "        DECODE_REG({},{},{})".format(
-                    regno, len(reg_enc_field), enc.index(reg_enc_field)
-                ),
-                file=f,
-            )
-            if reg_type in num_registers and reg_num_choices != num_registers[reg_type]:
-                print(
-                    "        DECODE_MAPPED_REG({},{})".format(regno, reg_mapping),
-                    file=f,
-                )
-            regno += 1
-
-        def implicit_register_key(reg):
-            return implicit_registers[reg]
-
-        for reg in sorted(
-            set(
-                [
-                    r
-                    for r in (
-                        iset.iset[tag]["rregs"].split(",")
-                        + iset.iset[tag]["wregs"].split(",")
-                    )
-                    if r in implicit_registers
-                ]
-            ),
-            key=implicit_register_key,
-        ):
-            print(
-                "        DECODE_IMPL_REG({},{})".format(regno, implicit_registers[reg]),
-                file=f,
-            )
-            regno += 1
-        if imms and imms[0][0].isupper():
-            imms = reversed(imms)
-        for imm in imms:
-            if imm[0].isupper():
-                immno = 1
-            else:
-                immno = 0
-            imm_type = imm[0]
-            imm_width = int(imm[1])
-            imm_shift = imm[2]
-            if imm_shift:
-                imm_shift = int(imm_shift)
-            else:
-                imm_shift = 0
-            if imm_type.islower():
-                imm_letter = "i"
-            else:
-                imm_letter = "I"
-            remainder = imm_width
-            for m in reversed(list(re.finditer(imm_letter + "+", enc))):
-                remainder -= m.end() - m.start()
-                print(
-                    "        DECODE_IMM({},{},{},{})".format(
-                        immno, m.end() - m.start(), m.start(), remainder
-                    ),
-                    file=f,
-                )
-            if remainder != 0:
-                if imm[2]:
-                    imm[2] = ":" + imm[2]
-                raise Exception(
-                    'Tag "{}" has an incorrect number of '
-                    + 'encoding bits for immediate "{}"'.format(tag, "".join(imm))
-                )
-            if imm_type.lower() in "sr":
-                print("        DECODE_IMM_SXT({},{})".format(immno, imm_width), file=f)
-            if imm_type.lower() == "n":
-                print("        DECODE_IMM_NEG({},{})".format(immno, imm_width), file=f)
-            if imm_shift:
-                print(
-                    "        DECODE_IMM_SHIFT({},{})".format(immno, imm_shift), file=f
-                )
-        print(")", file=f)
-
-
-if __name__ == "__main__":
-    with open(sys.argv[1], "w") as f:
-        print_tree(f, dectree_normal)
-        print_tree(f, dectree_16bit)
-        if subinsn_groupings:
-            print_tree(f, dectree_subinsn_groupings)
-        for name, dectree_subinsn in sorted(dectree_subinsns.items()):
-            print_tree(f, dectree_subinsn)
-        for name, dectree_ext in sorted(dectree_extensions.items()):
-            print_tree(f, dectree_ext)
-        print_match_info(f)
-        print_op_info(f)
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 1bd1ebcba1..fb480afc03 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -122,18 +122,6 @@ hexagon_ss.add(iset_py)
 
 #
 # Step 4
-# We use the dectree.py script to generate the decode tree header file
-#
-dectree_generated = custom_target(
-    'dectree_generated.h.inc',
-    output: 'dectree_generated.h.inc',
-    depends: [iset_py],
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files('dectree.py'), '@OUTPUT@'],
-)
-hexagon_ss.add(dectree_generated)
-
-#
 # Generate the input to the QEMU decodetree.py script
 #
 normal_decode_generated = custom_target(
-- 
2.34.1


