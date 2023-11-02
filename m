Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E05787DFB47
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 21:11:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qye1J-0004O6-49; Thu, 02 Nov 2023 16:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qye1H-0004NM-Cm
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 16:10:23 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qye1F-0006tR-VF
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 16:10:23 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1dcfe9cd337so664324fac.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698955820; x=1699560620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5FNvjn0ATHflRyMpKMII8LXHmYInbpSNP8db9bDXig=;
 b=KaXWFLWNwNfwWTd3/AeTqlau+laoTIMvwDiSeSbqCbrMWOD8LtYmbvbWHNsxoJzPeZ
 Hm/7ilcjzpbAszIAh06j41tq0TGB5jykQRAyiX0OzoXdEaOLrjhlJ/7HV5MPA4Q1GFZq
 caH2r+0+4oMQ55aMZM3DfE6WkOuH0O3D1/ARuV83yTHbdni2KppdFeqMjatCqT/lg3Pj
 kvdNUbLKmhAoB6cisXFasFLxuNREZa1PJGH2jWcTgJWzzi141qShzsRsaQrJNQI9e249
 ZOfM7ytC9zM7iLtVKgyXkfbjgjn1tCOqZK7O45C0xzoKWlFtMXnh8oDl9suCZvsj7Fjr
 gBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698955820; x=1699560620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5FNvjn0ATHflRyMpKMII8LXHmYInbpSNP8db9bDXig=;
 b=muIoMvCfQIkLL9WB+OZff826M12nWLBAnG8nArTmEwzKT585EK4Ww7UIizVFQ5xot4
 ZVowdJK6cTVEpCICLDmEYEBvkEV6h6/W9dFHEmiJQ9eOCe7nf4zR3Gh9YAh8LoNKNuoN
 YWRm/C4dypC7dPiBzQazdLLeJjHzypXXVFEJELMmmrCkaRtW2Qx4JQTET01pchktnBMr
 0gLmvGjWyVV7f672amB+rcNTjCZFvn/6zlWhv+mkfF9gaiqX8/G/lZRJUHDbOWIByUkt
 iGb5JLL9eTpTWFoXGhidO3WbkeDgqgcGawZ+x2pdY0rw8huLYURbAkmE3hkUkrogIvzA
 cdrA==
X-Gm-Message-State: AOJu0Yx3mz7uDZQRDSnIOQxcu1Fyx/yT0Rp+kRtdmoJodo7WcelvkJ1A
 QuIbu8NDzflKG/ftvqbQPwcmefjY17g=
X-Google-Smtp-Source: AGHT+IELFP0IYIEgLw2K78iacyY9c3/ewZWJnjQ0UoQ8zERXTBEufjTHZNKYgxFwCHjNqL4IXep4yQ==
X-Received: by 2002:a05:6870:35d0:b0:1ea:2447:5181 with SMTP id
 c16-20020a05687035d000b001ea24475181mr18864447oak.9.1698955820036; 
 Thu, 02 Nov 2023 13:10:20 -0700 (PDT)
Received: from taylor-ubuntu.austin.rr.com (cpe-68-203-8-61.austin.res.rr.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 z9-20020a056870e14900b001e98b1544fesm63543oaa.9.2023.11.02.13.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 13:10:19 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PATCH 3/3] Hexagon (target/hexagon) Enable more short-circuit
 packets (HVX)
Date: Thu,  2 Nov 2023 14:10:06 -0600
Message-Id: <20231102201006.33143-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102201006.33143-1-ltaylorsimpson@gmail.com>
References: <20231102201006.33143-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: test/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, EMPTY_MESSAGE=2.32,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Look for read-after-write instead of overlap of reads and writes
HVX instructions with helpers have pass-by-reference semantics, so
we check for overlaps of reads and writes within the same instruction.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h          | 88 +++++++++++++++++++++++------
 target/hexagon/translate.c          | 58 ++-----------------
 target/hexagon/gen_analyze_funcs.py | 51 +++++++++++------
 target/hexagon/hex_common.py        | 10 ++++
 4 files changed, 120 insertions(+), 87 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 7bb19ee672..7f47db71e8 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -50,23 +50,27 @@ typedef struct DisasContext {
     int tmp_vregs_num[VECTOR_TEMPS_MAX];
     int vreg_log[NUM_VREGS];
     int vreg_log_idx;
+    DECLARE_BITMAP(vregs_written, NUM_VREGS);
+    DECLARE_BITMAP(insn_vregs_written, NUM_VREGS);
     DECLARE_BITMAP(vregs_updated_tmp, NUM_VREGS);
     DECLARE_BITMAP(vregs_updated, NUM_VREGS);
     DECLARE_BITMAP(vregs_select, NUM_VREGS);
     DECLARE_BITMAP(predicated_future_vregs, NUM_VREGS);
     DECLARE_BITMAP(predicated_tmp_vregs, NUM_VREGS);
-    DECLARE_BITMAP(vregs_read, NUM_VREGS);
+    DECLARE_BITMAP(insn_vregs_read, NUM_VREGS);
     int qreg_log[NUM_QREGS];
     int qreg_log_idx;
-    DECLARE_BITMAP(qregs_read, NUM_QREGS);
+    DECLARE_BITMAP(qregs_written, NUM_QREGS);
+    DECLARE_BITMAP(insn_qregs_written, NUM_QREGS);
+    DECLARE_BITMAP(insn_qregs_read, NUM_QREGS);
     bool pre_commit;
     bool need_commit;
     TCGCond branch_cond;
     target_ulong branch_dest;
     bool is_tight_loop;
     bool short_circuit;
-    bool has_hvx_helper;
     bool read_after_write;
+    bool has_hvx_overlap;
     TCGv new_value[TOTAL_PER_THREAD_REGS];
     TCGv new_pred_value[NUM_PREGS];
     TCGv pred_written;
@@ -146,10 +150,25 @@ intptr_t ctx_future_vreg_off(DisasContext *ctx, int regnum,
 intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
                           int num, bool alloc_ok);
 
+static inline void ctx_start_hvx_insn(DisasContext *ctx)
+{
+    bitmap_zero(ctx->insn_vregs_written, NUM_VREGS);
+    bitmap_zero(ctx->insn_vregs_read, NUM_VREGS);
+    bitmap_zero(ctx->insn_qregs_written, NUM_QREGS);
+    bitmap_zero(ctx->insn_qregs_read, NUM_QREGS);
+}
+
 static inline void ctx_log_vreg_write(DisasContext *ctx,
                                       int rnum, VRegWriteType type,
-                                      bool is_predicated)
+                                      bool is_predicated, bool has_helper)
 {
+    if (has_helper) {
+        set_bit(rnum, ctx->insn_vregs_written);
+        if (test_bit(rnum, ctx->insn_vregs_read)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    set_bit(rnum, ctx->vregs_written);
     if (type != EXT_TMP) {
         if (!test_bit(rnum, ctx->vregs_updated)) {
             ctx->vreg_log[ctx->vreg_log_idx] = rnum;
@@ -175,42 +194,77 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
 
 static inline void ctx_log_vreg_write_pair(DisasContext *ctx,
                                            int rnum, VRegWriteType type,
-                                           bool is_predicated)
+                                           bool is_predicated, bool has_helper)
 {
-    ctx_log_vreg_write(ctx, rnum ^ 0, type, is_predicated);
-    ctx_log_vreg_write(ctx, rnum ^ 1, type, is_predicated);
+    ctx_log_vreg_write(ctx, rnum ^ 0, type, is_predicated, has_helper);
+    ctx_log_vreg_write(ctx, rnum ^ 1, type, is_predicated, has_helper);
 }
 
-static inline void ctx_log_vreg_read(DisasContext *ctx, int rnum)
+static inline void ctx_log_vreg_read(DisasContext *ctx, int rnum,
+                                     bool has_helper)
 {
-    set_bit(rnum, ctx->vregs_read);
+    if (has_helper) {
+        set_bit(rnum, ctx->insn_vregs_read);
+        if (test_bit(rnum, ctx->insn_vregs_written)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    if (test_bit(rnum, ctx->vregs_written)) {
+        ctx->read_after_write = true;
+    }
 }
 
-static inline void ctx_log_vreg_read_new(DisasContext *ctx, int rnum)
+static inline void ctx_log_vreg_read_new(DisasContext *ctx, int rnum,
+                                         bool has_helper)
 {
     g_assert(is_gather_store_insn(ctx) ||
              test_bit(rnum, ctx->vregs_updated) ||
              test_bit(rnum, ctx->vregs_select) ||
              test_bit(rnum, ctx->vregs_updated_tmp));
-    set_bit(rnum, ctx->vregs_read);
+    if (has_helper) {
+        set_bit(rnum, ctx->insn_vregs_read);
+        if (test_bit(rnum, ctx->insn_vregs_written)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    if (is_gather_store_insn(ctx)) {
+        ctx->read_after_write = true;
+    }
 }
 
-static inline void ctx_log_vreg_read_pair(DisasContext *ctx, int rnum)
+static inline void ctx_log_vreg_read_pair(DisasContext *ctx, int rnum,
+                                          bool has_helper)
 {
-    ctx_log_vreg_read(ctx, rnum ^ 0);
-    ctx_log_vreg_read(ctx, rnum ^ 1);
+    ctx_log_vreg_read(ctx, rnum ^ 0, has_helper);
+    ctx_log_vreg_read(ctx, rnum ^ 1, has_helper);
 }
 
 static inline void ctx_log_qreg_write(DisasContext *ctx,
-                                      int rnum)
+                                      int rnum, bool has_helper)
 {
+    if (has_helper) {
+        set_bit(rnum, ctx->insn_qregs_written);
+        if (test_bit(rnum, ctx->insn_qregs_read)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    set_bit(rnum, ctx->qregs_written);
     ctx->qreg_log[ctx->qreg_log_idx] = rnum;
     ctx->qreg_log_idx++;
 }
 
-static inline void ctx_log_qreg_read(DisasContext *ctx, int qnum)
+static inline void ctx_log_qreg_read(DisasContext *ctx,
+                                     int qnum, bool has_helper)
 {
-    set_bit(qnum, ctx->qregs_read);
+    if (has_helper) {
+        set_bit(qnum, ctx->insn_qregs_read);
+        if (test_bit(qnum, ctx->insn_qregs_written)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    if (test_bit(qnum, ctx->qregs_written)) {
+        ctx->read_after_write = true;
+    }
 }
 
 extern TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 9dab26ee17..3545480080 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -378,60 +378,10 @@ static bool need_commit(DisasContext *ctx)
         return true;
     }
 
-    if (pkt->num_insns == 1) {
-        if (pkt->pkt_has_hvx) {
-            /*
-             * The HVX instructions with generated helpers use
-             * pass-by-reference, so they need the read/write overlap
-             * check below.
-             * The HVX instructions with overrides are OK.
-             */
-            if (!ctx->has_hvx_helper) {
-                return false;
-            }
-        } else {
-            return false;
-        }
-    }
-
-    if (ctx->read_after_write) {
+    if (ctx->read_after_write || ctx->has_hvx_overlap) {
         return true;
     }
 
-    /* Check for overlap between HVX reads and writes */
-    for (int i = 0; i < ctx->vreg_log_idx; i++) {
-        int vnum = ctx->vreg_log[i];
-        if (test_bit(vnum, ctx->vregs_read)) {
-            return true;
-        }
-    }
-    if (!bitmap_empty(ctx->vregs_updated_tmp, NUM_VREGS)) {
-        int i = find_first_bit(ctx->vregs_updated_tmp, NUM_VREGS);
-        while (i < NUM_VREGS) {
-            if (test_bit(i, ctx->vregs_read)) {
-                return true;
-            }
-            i = find_next_bit(ctx->vregs_updated_tmp, NUM_VREGS, i + 1);
-        }
-    }
-    if (!bitmap_empty(ctx->vregs_select, NUM_VREGS)) {
-        int i = find_first_bit(ctx->vregs_select, NUM_VREGS);
-        while (i < NUM_VREGS) {
-            if (test_bit(i, ctx->vregs_read)) {
-                return true;
-            }
-            i = find_next_bit(ctx->vregs_select, NUM_VREGS, i + 1);
-        }
-    }
-
-    /* Check for overlap between HVX predicate reads and writes */
-    for (int i = 0; i < ctx->qreg_log_idx; i++) {
-        int qnum = ctx->qreg_log[i];
-        if (test_bit(qnum, ctx->qregs_read)) {
-            return true;
-        }
-    }
-
     return false;
 }
 
@@ -453,8 +403,8 @@ static void mark_implicit_pred_reads(DisasContext *ctx)
 static void analyze_packet(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
-    ctx->has_hvx_helper = false;
     ctx->read_after_write = false;
+    ctx->has_hvx_overlap = false;
     for (int i = 0; i < pkt->num_insns; i++) {
         Insn *insn = &pkt->insn[i];
         ctx->insn = insn;
@@ -485,13 +435,13 @@ static void gen_start_packet(DisasContext *ctx)
     ctx->future_vregs_idx = 0;
     ctx->tmp_vregs_idx = 0;
     ctx->vreg_log_idx = 0;
+    bitmap_zero(ctx->vregs_written, NUM_VREGS);
     bitmap_zero(ctx->vregs_updated_tmp, NUM_VREGS);
     bitmap_zero(ctx->vregs_updated, NUM_VREGS);
     bitmap_zero(ctx->vregs_select, NUM_VREGS);
     bitmap_zero(ctx->predicated_future_vregs, NUM_VREGS);
     bitmap_zero(ctx->predicated_tmp_vregs, NUM_VREGS);
-    bitmap_zero(ctx->vregs_read, NUM_VREGS);
-    bitmap_zero(ctx->qregs_read, NUM_QREGS);
+    bitmap_zero(ctx->qregs_written, NUM_QREGS);
     ctx->qreg_log_idx = 0;
     for (i = 0; i < STORES_MAX; i++) {
         ctx->store_width[i] = 0;
diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index 40b9473c44..4541174590 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -52,7 +52,10 @@ def analyze_read(f, tag, regtype, regid, regno):
         if regtype in {"R",  "C"}:
             f.write(f"    ctx_log_reg_read_pair(ctx, {regN});\n")
         elif regtype == "V":
-            f.write(f"    ctx_log_vreg_read_pair(ctx, {regN});\n")
+            f.write(
+                f"    ctx_log_vreg_read_pair(ctx, {regN}, "
+                "insn_has_hvx_helper);\n"
+            )
         else:
             hex_common.bad_register(regtype, regid)
     elif hex_common.is_single(regid):
@@ -62,9 +65,15 @@ def analyze_read(f, tag, regtype, regid, regno):
             elif regtype == "P":
                 f.write(f"    ctx_log_pred_read(ctx, {regN});\n")
             elif regtype in {"V", "O"}:
-                f.write(f"    ctx_log_vreg_read(ctx, {regN});\n")
+                f.write(
+                    f"    ctx_log_vreg_read(ctx, {regN}, "
+                    "insn_has_hvx_helper);\n"
+                )
             elif regtype == "Q":
-                f.write(f"    ctx_log_qreg_read(ctx, {regN});\n")
+                f.write(
+                    f"    ctx_log_qreg_read(ctx, {regN}, "
+                    "insn_has_hvx_helper);\n"
+                )
             else:
                 hex_common.bad_register(regtype, regid)
         elif hex_common.is_new_val(regtype, regid, tag):
@@ -73,7 +82,10 @@ def analyze_read(f, tag, regtype, regid, regno):
             elif regtype == "P":
                 f.write(f"    ctx_log_pred_read_new(ctx, {regN});\n")
             elif regtype == "O":
-                f.write(f"    ctx_log_vreg_read_new(ctx, {regN});\n")
+                f.write(
+                    f"    ctx_log_vreg_read_new(ctx, {regN}, "
+                    "insn_has_hvx_helper);\n"
+                )
             else:
                 hex_common.bad_register(regtype, regid)
         else:
@@ -90,7 +102,8 @@ def analyze_write(f, tag, regtype, regid, regno):
         elif regtype == "V":
             f.write(
                 f"    ctx_log_vreg_write_pair(ctx, {regN}, "
-                f"{vreg_write_type(tag)}, {predicated});\n"
+                f"{vreg_write_type(tag)}, {predicated}, "
+                "insn_has_hvx_helper);\n"
             )
         else:
             hex_common.bad_register(regtype, regid)
@@ -102,10 +115,14 @@ def analyze_write(f, tag, regtype, regid, regno):
         elif regtype == "V":
             f.write(
                 f"    ctx_log_vreg_write(ctx, {regN}, "
-                f"{vreg_write_type(tag)}, {predicated});\n"
+                f"{vreg_write_type(tag)}, {predicated}, "
+                "insn_has_hvx_helper);\n"
             )
         elif regtype == "Q":
-            f.write(f"    ctx_log_qreg_write(ctx, {regN});\n")
+            f.write(
+                f"    ctx_log_qreg_write(ctx, {regN}, "
+                "insn_has_hvx_helper);\n"
+            )
         else:
             hex_common.bad_register(regtype, regid)
     else:
@@ -132,6 +149,17 @@ def gen_analyze_func(f, tag, regs, imms):
     f.write("{\n")
 
     f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
+    if (hex_common.is_hvx_insn(tag)):
+        if hex_common.has_hvx_helper(tag):
+            f.write(
+                "    const bool G_GNUC_UNUSED insn_has_hvx_helper = true;\n"
+            )
+            f.write("    ctx_start_hvx_insn(ctx);\n")
+        else:
+            f.write(
+                "    const bool G_GNUC_UNUSED insn_has_hvx_helper = false;\n"
+            )
+
 
     ## Declare the operands
     i = 0
@@ -153,15 +181,6 @@ def gen_analyze_func(f, tag, regs, imms):
             analyze_write(f, tag, regtype, regid, i)
         i += 1
 
-    has_generated_helper = not hex_common.skip_qemu_helper(
-        tag
-    ) and not hex_common.is_idef_parser_enabled(tag)
-
-    ## Mark HVX instructions with generated helpers
-    if (has_generated_helper and
-        "A_CVI" in hex_common.attribdict[tag]):
-        f.write("    ctx->has_hvx_helper = true;\n")
-
     f.write("}\n\n")
 
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 0da65d6dd6..befe3590c2 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -307,6 +307,16 @@ def is_idef_parser_enabled(tag):
     return tag in idef_parser_enabled
 
 
+def is_hvx_insn(tag):
+    return "A_CVI" in attribdict[tag]
+
+
+def has_hvx_helper(tag):
+    return (is_hvx_insn(tag) and
+            not skip_qemu_helper(tag) and
+            not is_idef_parser_enabled(tag))
+
+
 def imm_name(immlett):
     return f"{immlett}iV"
 
-- 
2.34.1


