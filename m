Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E829382E27D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:15:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVEO-0004nt-00; Mon, 15 Jan 2024 17:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rPVEJ-0004nC-Ae
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:14:51 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rPVEG-0003XZ-Dr
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:14:51 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7bc332d49f6so373178439f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705356886; x=1705961686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/HeK5vPJKWBkTx7JLUhTfnhb+d4YImcuGO6eQigEBE=;
 b=KwF2d7OFOAps+pNB1QYiNCA6k/ikaMgHJHb3EHeE1qAI1igOlIg39/hwnDCsxCSEBN
 uPAF74xssqn6ibIXQzV85ax6/LpkGIb//RAvgPGXgIy1Qeqsbam4pbkDhnEDxjnMFskq
 LGassWEZZPriPWSK3350Z8S6nkYt6k7qR9/LhVBbf1QeU7/JLDmeyH+gd5MYlLQ50zQo
 Ieu2AOdYVZ6iulPLKzSF8DEc3vjkYfL8KXN9miFuSVIhyjJ8oFr4J9FtHdZH9gDqTd+E
 pckou/ixUlvlXfQ4vYNNa3zy2ucoLpF7kYwjf92twbMEFvMdc30GUhZLkLsqtNir2w6n
 HtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705356886; x=1705961686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/HeK5vPJKWBkTx7JLUhTfnhb+d4YImcuGO6eQigEBE=;
 b=a7CyPRBqDIkEQejJSwErOh4aDjYOuk1hw6oWHHrgwXxDikPcYg1WXDrxa3biXmhzIb
 AJ2c7galocsWw1ER5p7KKyrJk/6alJkvAxzKeTI0avxrJFYe63OpbJVIP6dse01dBUSN
 UgS4UT6lX49R9NCK4Ozct+1k/9LUfbR5g9sz7qEIKSRluCFG8HvhKjB6oeEO0zv1dDTo
 PRFX0CoBQ6nb8CQPXXIgeUgOF7W0/XPMTXoTnReWis0IyclrDuIMAmwXvGTiq45DvXlE
 4JU0RJUy66NULAZTZxjWn59wqp920Yf98p9CVM7WQa9fmQ91V/CX8wMh9Xr1Oo8e2sU5
 AQrg==
X-Gm-Message-State: AOJu0Yx/WwzGMcO6Hst1E+DXNT150XRwY9y0N3s/ll5sNwCNs1mp9Uka
 2ccg11f36gx4kmFzSdHcWQcjfRz6zSq4nw==
X-Google-Smtp-Source: AGHT+IEB9omzo++/pz6KPHHGUa3Um6NrGFQoSC1SWcL9UdWiuvdGgJgXD7GbfVsmTsSSa5GaIenL+w==
X-Received: by 2002:a6b:5d1e:0:b0:7bf:5766:1d67 with SMTP id
 r30-20020a6b5d1e000000b007bf57661d67mr69228iob.27.1705356886303; 
 Mon, 15 Jan 2024 14:14:46 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 gm25-20020a0566382b9900b0046df77733acsm2579705jab.102.2024.01.15.14.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:14:45 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 1/3] Hexagon (target/hexagon) Use QEMU decodetree (32-bit
 instructions)
Date: Mon, 15 Jan 2024 15:14:41 -0700
Message-Id: <20240115221443.365287-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115221443.365287-1-ltaylorsimpson@gmail.com>
References: <20240115221443.365287-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd31.google.com
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

The Decodetree Specification can be found here
https://www.qemu.org/docs/master/devel/decodetree.html

Covers all 32-bit instructions, including HVX

We generate separate decoders for each instruction class.  The reason
will be more apparent in the next patch in this series.

We add 2 new scripts
    gen_decodetree.py        Generate the input to decodetree.py
    gen_trans_funcs.py       Generate the trans_* functions used by the
                             output of decodetree.py

Since the functions generated by decodetree.py take DisasContext * as an
argument, we add the argument to a couple of functions that didn't need
it previously.  We also set the insn field in DisasContext during decode
because it is used by the trans_* functions.

There is a g_assert_not_reached() in decode_insns() in decode.c to
verify we never try to use the old decoder on 32-bit instructions

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Brian Cain <bcain@quicinc.com>
---
 target/hexagon/decode.h           |   5 +-
 target/hexagon/decode.c           |  54 ++++++++-
 target/hexagon/translate.c        |   4 +-
 target/hexagon/README             |  13 +-
 target/hexagon/gen_decodetree.py  | 190 ++++++++++++++++++++++++++++++
 target/hexagon/gen_trans_funcs.py | 132 +++++++++++++++++++++
 target/hexagon/meson.build        |  55 +++++++++
 7 files changed, 439 insertions(+), 14 deletions(-)
 create mode 100755 target/hexagon/gen_decodetree.py
 create mode 100755 target/hexagon/gen_trans_funcs.py

diff --git a/target/hexagon/decode.h b/target/hexagon/decode.h
index c66f5ea64d..3f3012b978 100644
--- a/target/hexagon/decode.h
+++ b/target/hexagon/decode.h
@@ -21,12 +21,13 @@
 #include "cpu.h"
 #include "opcodes.h"
 #include "insn.h"
+#include "translate.h"
 
 void decode_init(void);
 
 void decode_send_insn_to(Packet *packet, int start, int newloc);
 
-int decode_packet(int max_words, const uint32_t *words, Packet *pkt,
-                  bool disas_only);
+int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
+                  Packet *pkt, bool disas_only);
 
 #endif
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 946c55cc71..bddad1f75e 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -52,6 +52,34 @@ DEF_REGMAP(R_8,   8,  0, 1, 2, 3, 4, 5, 6, 7)
 #define DECODE_MAPPED_REG(OPNUM, NAME) \
     insn->regno[OPNUM] = DECODE_REGISTER_##NAME[insn->regno[OPNUM]];
 
+/* Helper functions for decode_*_generated.c.inc */
+#define DECODE_MAPPED(NAME) \
+static int decode_mapped_reg_##NAME(DisasContext *ctx, int x) \
+{ \
+    return DECODE_REGISTER_##NAME[x]; \
+}
+DECODE_MAPPED(R_16)
+DECODE_MAPPED(R_8)
+
+/* Helper function for decodetree_trans_funcs_generated.c.inc */
+static int shift_left(DisasContext *ctx, int x, int n, int immno)
+{
+    int ret = x;
+    Insn *insn = ctx->insn;
+    if (!insn->extension_valid ||
+        insn->which_extended != immno) {
+        ret <<= n;
+    }
+    return ret;
+}
+
+/* Include the generated decoder for 32 bit insn */
+#include "decode_normal_generated.c.inc"
+#include "decode_hvx_generated.c.inc"
+
+/* Include the generated helpers for the decoder */
+#include "decodetree_trans_funcs_generated.c.inc"
+
 typedef struct {
     const struct DectreeTable *table_link;
     const struct DectreeTable *table_link_b;
@@ -550,7 +578,8 @@ apply_extender(Packet *pkt, int i, uint32_t extender)
     int immed_num;
     uint32_t base_immed;
 
-    immed_num = opcode_which_immediate_is_extended(pkt->insn[i].opcode);
+    immed_num = pkt->insn[i].which_extended;
+    g_assert(immed_num == opcode_which_immediate_is_extended(pkt->insn[i].opcode));
     base_immed = pkt->insn[i].immed[immed_num];
 
     pkt->insn[i].immed[immed_num] = extender | fZXTN(6, 32, base_immed);
@@ -762,12 +791,19 @@ decode_insns_tablewalk(Insn *insn, const DectreeTable *table,
 }
 
 static unsigned int
-decode_insns(Insn *insn, uint32_t encoding)
+decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
 {
     const DectreeTable *table;
     if (parse_bits(encoding) != 0) {
+        if (decode_normal(ctx, encoding) ||
+            decode_hvx(ctx, encoding)) {
+            insn->generate = opcode_genptr[insn->opcode];
+            insn->iclass = iclass_bits(encoding);
+            return 1;
+        }
         /* Start with PP table - 32 bit instructions */
         table = &dectree_table_DECODE_ROOT_32;
+        g_assert_not_reached();
     } else {
         /* start with EE table - duplex instructions */
         table = &dectree_table_DECODE_ROOT_EE;
@@ -916,8 +952,8 @@ decode_set_slot_number(Packet *pkt)
  * or number of words used on success
  */
 
-int decode_packet(int max_words, const uint32_t *words, Packet *pkt,
-                  bool disas_only)
+int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
+                  Packet *pkt, bool disas_only)
 {
     int num_insns = 0;
     int words_read = 0;
@@ -930,9 +966,11 @@ int decode_packet(int max_words, const uint32_t *words, Packet *pkt,
     memset(pkt, 0, sizeof(*pkt));
     /* Try to build packet */
     while (!end_of_packet && (words_read < max_words)) {
+        Insn *insn = &pkt->insn[num_insns];
+        ctx->insn = insn;
         encoding32 = words[words_read];
         end_of_packet = is_packet_end(encoding32);
-        new_insns = decode_insns(&pkt->insn[num_insns], encoding32);
+        new_insns = decode_insns(ctx, insn, encoding32);
         g_assert(new_insns > 0);
         /*
          * If we saw an extender, mark next word extended so immediate
@@ -1006,9 +1044,13 @@ int decode_packet(int max_words, const uint32_t *words, Packet *pkt,
 int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
                         GString *buf)
 {
+    DisasContext ctx;
     Packet pkt;
 
-    if (decode_packet(nwords, words, &pkt, true) > 0) {
+    memset(&ctx, 0, sizeof(DisasContext));
+    ctx.pkt = &pkt;
+
+    if (decode_packet(&ctx, nwords, words, &pkt, true) > 0) {
         snprint_a_pkt_disas(buf, &pkt, words, pc);
         return pkt.encod_pkt_size_in_bytes;
     } else {
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 666c061180..95579ae243 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1033,10 +1033,10 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         return;
     }
 
-    if (decode_packet(nwords, words, &pkt, false) > 0) {
+    ctx->pkt = &pkt;
+    if (decode_packet(ctx, nwords, words, &pkt, false) > 0) {
         pkt.pc = ctx->base.pc_next;
         HEX_DEBUG_PRINT_PKT(&pkt);
-        ctx->pkt = &pkt;
         gen_start_packet(ctx);
         for (i = 0; i < pkt.num_insns; i++) {
             ctx->insn = &pkt.insn[i];
diff --git a/target/hexagon/README b/target/hexagon/README
index 69b2ffe9bb..1b2a4d0eac 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -189,11 +189,16 @@ the packet, and we mark the implicit writes.  After the analysis is performed,
 we initialize the result register for each of the predicated assignments.
 
 In addition to instruction semantics, we use a generator to create the decode
-tree.  This generation is also a two step process.  The first step is to run
-target/hexagon/gen_dectree_import.c to produce
+tree.  This generation is a four step process.
+Step 1 is to run target/hexagon/gen_dectree_import.c to produce
     <BUILD_DIR>/target/hexagon/iset.py
-This file is imported by target/hexagon/dectree.py to produce
-    <BUILD_DIR>/target/hexagon/dectree_generated.h.inc
+Step 2 is to import iset.py into target/hexagon/gen_decodetree.py to produce
+    <BUILD_DIR>/target/hexagon/normal_decode_generated
+    <BUILD_DIR>/target/hexagon/hvx_decode_generated
+Step 3 is to process the above files with QEMU's decodetree.py to produce
+    <BUILD_DIR>/target/hexagon/decode_*_generated.c.inc
+Step 4 is to import iset.py into target/hexagon/gen_trans_funcs.py to produce
+    <BUILD_DIR>/target/hexagon/decodetree_trans_funcs_generated.c.inc
 
 *** Key Files ***
 
diff --git a/target/hexagon/gen_decodetree.py b/target/hexagon/gen_decodetree.py
new file mode 100755
index 0000000000..9634554142
--- /dev/null
+++ b/target/hexagon/gen_decodetree.py
@@ -0,0 +1,190 @@
+#!/usr/bin/env python3
+
+##
+##  Copyright (c) 2024 Taylor Simpson <ltaylorsimpson@gmail.com>
+##
+##  This program is free software; you can redistribute it and/or modify
+##  it under the terms of the GNU General Public License as published by
+##  the Free Software Foundation; either version 2 of the License, or
+##  (at your option) any later version.
+##
+##  This program is distributed in the hope that it will be useful,
+##  but WITHOUT ANY WARRANTY; without even the implied warranty of
+##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+##  GNU General Public License for more details.
+##
+##  You should have received a copy of the GNU General Public License
+##  along with this program; if not, see <http://www.gnu.org/licenses/>.
+##
+
+import io
+import re
+
+import sys
+import textwrap
+import iset
+import hex_common
+
+encs = {
+    tag: "".join(reversed(iset.iset[tag]["enc"].replace(" ", "")))
+    for tag in iset.tags
+    if iset.iset[tag]["enc"] != "MISSING ENCODING"
+}
+
+
+regre = re.compile(r"((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)")
+immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
+
+
+def ordered_unique(l):
+    return sorted(set(l), key=l.index)
+
+num_registers = {"R": 32, "V": 32}
+
+operand_letters = {
+    "P",
+    "i",
+    "I",
+    "r",
+    "s",
+    "t",
+    "u",
+    "v",
+    "w",
+    "x",
+    "y",
+    "z",
+    "d",
+    "e",
+    "f",
+    "g",
+}
+
+#
+# These instructions have unused operand letters in their encoding
+# They don't correspond to actual operands in the instruction semantics
+# We will mark them as ignored in QEMU decodetree
+#
+tags_with_unused_d_encoding = {
+    "R6_release_at_vi",
+    "R6_release_st_vi",
+    "S4_stored_rl_at_vi",
+    "S4_stored_rl_st_vi",
+    "S2_storew_rl_at_vi",
+    "S2_stored_rl_at_vi",
+    "S2_storew_rl_st_vi",
+}
+
+tags_with_unused_t_encoding = {
+    "R6_release_at_vi",
+    "R6_release_st_vi",
+}
+
+def skip_tag(tag, class_to_decode):
+    enc_class = iset.iset[tag]["enc_class"]
+    return enc_class != class_to_decode
+
+
+##
+## Generate the QEMU decodetree file for each instruction in class_to_decode
+##     For A2_add: Rd32=add(Rs32,Rt32)
+##     We produce:
+##     %A2_add_Rd   0:5
+##     %A2_add_Rs   16:5
+##     %A2_add_Rt   8:5
+##     @A2_add  11110011000.......-.....---..... Rd=%A2_add_Rd Rs=%A2_add_Rs Rt=%A2_add_Rt %PP
+##     A2_add   ..................-.....---..... @A2_add
+##
+def gen_decodetree_file(f, class_to_decode):
+    f.write(f"## DO NOT MODIFY - This file is generated by {sys.argv[0]}\n\n")
+    f.write("%PP\t14:2\n\n")
+    for tag in sorted(encs.keys(), key=iset.tags.index):
+        if skip_tag(tag, class_to_decode):
+            continue
+
+        enc = encs[tag]
+        enc_str = "".join(reversed(encs[tag]))
+        f.write(("#" * 80) + "\n"
+                f"## {tag}:\t{enc_str}\n"
+                "##\n")
+
+
+        regs = ordered_unique(regre.findall(iset.iset[tag]["syntax"]))
+        imms = ordered_unique(immre.findall(iset.iset[tag]["syntax"]))
+
+        # Write the field definitions for the registers
+        for regno, reg in enumerate(regs):
+            reg_type, reg_id, _, reg_enc_size = reg
+            reg_letter = reg_id[0]
+            reg_num_choices = int(reg_enc_size.rstrip("S"))
+            reg_mapping = reg_type + "".join("_" for letter in reg_id) + \
+                          reg_enc_size
+            reg_enc_fields = re.findall(reg_letter + "+", enc)
+
+            # Check for some errors
+            if len(reg_enc_fields) == 0:
+                raise Exception(f"{tag} missing register field!")
+            if len(reg_enc_fields) > 1:
+                raise Exception(f"{tag} has split register field!")
+            reg_enc_field = reg_enc_fields[0]
+            if 2 ** len(reg_enc_field) != reg_num_choices:
+                raise Exception(f"{tag} has incorrect register field width!")
+
+            f.write(f"%{tag}_{reg_type}{reg_id}\t"
+                    f"{enc.index(reg_enc_field)}:{len(reg_enc_field)}")
+
+            if (reg_type in num_registers and
+                reg_num_choices != num_registers[reg_type]):
+                f.write(f"\t!function=decode_mapped_reg_{reg_mapping}")
+            f.write("\n")
+
+        # Write the field definitions for the immediates
+        for imm in imms:
+            immno = 1 if imm[0].isupper() else 0
+            imm_type = imm[0]
+            imm_width = int(imm[1])
+            imm_letter = "i" if imm_type.islower() else "I"
+            fields = []
+            sign_mark = "s" if imm_type.lower() in "sr" else ""
+            for m in reversed(list(re.finditer(imm_letter + "+", enc))):
+                fields.append(f"{m.start()}:{sign_mark}{m.end() - m.start()}")
+                sign_mark = ""
+            field_str = " ".join(fields)
+            f.write(f"%{tag}_{imm_type}{imm_letter}\t{field_str}\n")
+
+        ## Handle instructions with unused encoding letters
+        ## Change the unused letters to ignored
+        if tag in tags_with_unused_d_encoding:
+            enc_str = enc_str.replace("d", "-")
+        if tag in tags_with_unused_t_encoding:
+            enc_str = enc_str.replace("t", "-")
+
+        # Replace the operand letters with .
+        for x in operand_letters:
+            enc_str = enc_str.replace(x, ".")
+
+        # Write the instruction format
+        f.write(f"@{tag}\t{enc_str}")
+        for reg in regs:
+            reg_type = reg[0]
+            reg_id = reg[1]
+            f.write(f" {reg_type}{reg_id}=%{tag}_{reg_type}{reg_id}")
+        for imm in imms:
+            imm_type = imm[0]
+            imm_letter = "i" if imm_type.islower() else "I"
+            f.write(f" {imm_type}{imm_letter}=%{tag}_{imm_type}{imm_letter}")
+
+        f.write(" %PP\n")
+
+         # Replace the 0s and 1s with .
+        enc_str = enc_str.replace("0", ".").replace("1", ".")
+
+        # Write the instruction pattern
+        f.write(f"{tag}\t{enc_str} @{tag}\n")
+
+
+if __name__ == "__main__":
+    hex_common.read_semantics_file(sys.argv[1])
+    class_to_decode = sys.argv[2]
+    with open(sys.argv[3], "w") as f:
+        gen_decodetree_file(f, class_to_decode)
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
new file mode 100755
index 0000000000..c907131009
--- /dev/null
+++ b/target/hexagon/gen_trans_funcs.py
@@ -0,0 +1,132 @@
+#!/usr/bin/env python3
+
+##
+##  Copyright (c) 2024 Taylor Simpson <ltaylorsimpson@gmail.com>
+##
+##  This program is free software; you can redistribute it and/or modify
+##  it under the terms of the GNU General Public License as published by
+##  the Free Software Foundation; either version 2 of the License, or
+##  (at your option) any later version.
+##
+##  This program is distributed in the hope that it will be useful,
+##  but WITHOUT ANY WARRANTY; without even the implied warranty of
+##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+##  GNU General Public License for more details.
+##
+##  You should have received a copy of the GNU General Public License
+##  along with this program; if not, see <http://www.gnu.org/licenses/>.
+##
+
+import io
+import re
+
+import sys
+import textwrap
+import iset
+import hex_common
+
+encs = {
+    tag: "".join(reversed(iset.iset[tag]["enc"].replace(" ", "")))
+    for tag in iset.tags
+    if iset.iset[tag]["enc"] != "MISSING ENCODING"
+}
+
+
+regre = re.compile(r"((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)")
+immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
+
+
+def ordered_unique(l):
+    return sorted(set(l), key=l.index)
+
+
+def skip_tag(tag, classes):
+    enc_class = iset.iset[tag]["enc_class"]
+    return enc_class not in classes
+
+
+def code_fmt(txt):
+    return textwrap.indent(textwrap.dedent(txt), "    ")
+
+open_curly = "{"
+close_curly = "}"
+
+def mark_which_imm_extended(f, tag):
+    immre = re.compile(r"IMMEXT\([rRsSuUm]")
+    imm = immre.findall(hex_common.semdict[tag])
+    if len(imm) == 0:
+        # No extended operand found
+        return
+    letter = re.split("\\(", imm[0])[1]
+    f.write(code_fmt(f"""\
+        insn->which_extended = {0 if letter.islower() else 1};
+    """))
+
+##
+## Generate the QEMU decodetree trans_<tag> function for each instruction
+##     For A2_add: Rd32=add(Rs32,Rt32)
+##     We produce:
+##     static bool trans_A2_add(DisasContext *ctx, arg_A2_add *args)
+##     {
+##         Insn *insn = ctx->insn;
+##         insn->opcode = A2_add;
+##         insn->regno[0] = args->Rd;
+##         insn->regno[1] = args->Rs;
+##         insn->regno[2] = args->Rt;
+##         return true;
+##     }
+##
+def gen_trans_funcs(f, classes):
+    f.write(f"/* DO NOT MODIFY - This file is generated by {sys.argv[0]} */\n\n")
+    for tag in sorted(encs.keys(), key=iset.tags.index):
+        if skip_tag(tag, classes):
+            continue
+
+        regs = ordered_unique(regre.findall(iset.iset[tag]["syntax"]))
+        imms = ordered_unique(immre.findall(iset.iset[tag]["syntax"]))
+
+        f.write(textwrap.dedent(f"""\
+            static bool trans_{tag}(DisasContext *ctx, arg_{tag} *args)
+            {open_curly}
+                Insn *insn = ctx->insn;
+                insn->opcode = {tag};
+        """))
+
+        regno = 0
+        for reg in regs:
+            reg_type = reg[0]
+            reg_id = reg[1]
+            f.write(code_fmt(f"""\
+                insn->regno[{regno}] = args->{reg_type}{reg_id};
+            """))
+            regno += 1
+
+        if len(imms) != 0:
+            mark_which_imm_extended(f, tag)
+
+        for imm in imms:
+            imm_type = imm[0]
+            imm_letter = "i" if imm_type.islower() else "I"
+            immno = 0 if imm_type.islower() else 1
+            imm_shift = int(imm[2]) if imm[2] else 0
+            if imm_shift:
+                f.write(code_fmt(f"""\
+                    insn->immed[{immno}] =
+                        shift_left(ctx, args->{imm_type}{imm_letter},
+                                   {imm_shift}, {immno});
+                """))
+            else:
+                f.write(code_fmt(f"""\
+                    insn->immed[{immno}] = args->{imm_type}{imm_letter};
+                """))
+
+        f.write(textwrap.dedent(f"""\
+                return true;
+            {close_curly}
+        """))
+
+
+if __name__ == "__main__":
+    hex_common.read_semantics_file(sys.argv[1])
+    with open(sys.argv[2], "w") as f:
+        gen_trans_funcs(f, { "NORMAL", "EXT_mmvec" })
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index da8e608d00..831bd5716a 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -133,6 +133,61 @@ dectree_generated = custom_target(
 )
 hexagon_ss.add(dectree_generated)
 
+#
+# Generate the input to the QEMU decodetree.py script
+#
+normal_decode_generated = custom_target(
+    'normal_decode_generated',
+    output: 'normal_decode_generated',
+    depends: [iset_py, semantics_generated],
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files('gen_decodetree.py'), semantics_generated, 'NORMAL', '@OUTPUT@'],
+)
+hexagon_ss.add(normal_decode_generated)
+
+hvx_decode_generated = custom_target(
+    'hvx_decode_generated',
+    output: 'hvx_decode_generated',
+    depends: [iset_py, semantics_generated],
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files('gen_decodetree.py'), semantics_generated, 'EXT_mmvec', '@OUTPUT@'],
+)
+hexagon_ss.add(hvx_decode_generated)
+
+#
+# Run the QEMU decodetree.py script to produce the instruction decoder
+#
+decodetree_py = meson.current_source_dir() / '../../scripts/decodetree.py'
+decode_normal_generated = custom_target(
+    'decode_normal_generated.c.inc',
+    output: 'decode_normal_generated.c.inc',
+    input: normal_decode_generated,
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files(decodetree_py), normal_decode_generated, '--static-decode=decode_normal', '-o', '@OUTPUT@'],
+)
+hexagon_ss.add(decode_normal_generated)
+
+decode_hvx_generated = custom_target(
+    'decode_hvx_generated.c.inc',
+    output: 'decode_hvx_generated.c.inc',
+    input: hvx_decode_generated,
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files(decodetree_py), hvx_decode_generated, '--static-decode=decode_hvx', '-o', '@OUTPUT@'],
+)
+hexagon_ss.add(decode_hvx_generated)
+
+#
+# Generate the trans_* functions that the decoder will use
+#
+decodetree_trans_funcs_generated = custom_target(
+    'decodetree_trans_funcs_generated.c.inc',
+    output: 'decodetree_trans_funcs_generated.c.inc',
+    depends: [iset_py, semantics_generated],
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files('gen_trans_funcs.py'), semantics_generated, '@OUTPUT@'],
+)
+hexagon_ss.add(decodetree_trans_funcs_generated)
+
 hexagon_ss.add(files(
     'cpu.c',
     'translate.c',
-- 
2.34.1


