Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFDC7DFB48
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 21:11:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qye1H-0004NJ-19; Thu, 02 Nov 2023 16:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qye1F-0004Me-7L
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 16:10:21 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qye1D-0006sm-BJ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 16:10:20 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1ef370c2e1aso748232fac.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698955817; x=1699560617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dj0lmMHru47k51oEUfPxD/8OwW94ztW1wUywnekyGis=;
 b=eMXl1hfMMTHaTjPnsPG0OEAwcZobXtl6P2Cunk50XTI8sim+X/hRtFyqF1yl1jgzSo
 r5NmKB71Mhy+zEEUDvoJHwZ9Ds7WsQWY+ThvyM3eJ1lztyFI9VWv8p0CV8i2bJW0oeiy
 13UL004UogkOdcwSHShsmnj10O3lV+FSUi2gZuVdWi/AArQDhFpsnUAsZMC91twUMHbL
 varNTx3jEyVgFfyuYiUmwCWgSO/w43CJKAa2OZM3+yDIyvhyrF0qmUcD5jpMq0mPtbiZ
 Z6bIHz+T1BaMXip9uHUKv4dM/24iA6iS5PLFJs6Cv74SZeNcFxnpNe9PcHZ3rosOk7qm
 DVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698955817; x=1699560617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dj0lmMHru47k51oEUfPxD/8OwW94ztW1wUywnekyGis=;
 b=Fm5vGa6QIxlqiWBYhIqwAS4yWk+QUSLt8RTXjx7OVaSsGcKp0OkLfy/SLp7LC+5duz
 jW6RBH+oravkTYPmk+NV7HM8PML6mjc9irZrjc4Rc61whP9OwBnI8q2hvQHgeyFJ60wI
 Sh5o2Lq8+LYp/c6mIgPUpflVEW4VDybsylci2ug8zNRMJxGXxKCmY0GGvSNwe5GvMGhO
 cVsxPcvhjbtCLCWbf/7RhWJffagmDkRdxMmLnSkRBRvGiNE1UwQFxGM2Td+Bt/pOVlgh
 +hdn6in0LhBObGTooOwWKEPI/6UJtIz4mhULjRU0PhUZsSIy/HDqX09+uOaGARxBZFFF
 i7aw==
X-Gm-Message-State: AOJu0YyqxNA4OKVpePsyMtyxoVQ02Dgdg/pBIqmDlJkUAMgNBWh5gRud
 fG+NiZx2YjbB7IwhpXnDSj1dW2UUCkA=
X-Google-Smtp-Source: AGHT+IGvn2YAPCTzazw37vH736mwsgPh7zHY8SguZvrpgkOwyA+nhdPW7UO06xs2jX07DcIv9qbFWg==
X-Received: by 2002:a05:6871:a509:b0:1e9:bd5c:ae38 with SMTP id
 wc9-20020a056871a50900b001e9bd5cae38mr20472401oab.2.1698955817590; 
 Thu, 02 Nov 2023 13:10:17 -0700 (PDT)
Received: from taylor-ubuntu.austin.rr.com (cpe-68-203-8-61.austin.res.rr.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 z9-20020a056870e14900b001e98b1544fesm63543oaa.9.2023.11.02.13.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 13:10:16 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PATCH 1/3] Hexagon (target/hexagon) Analyze reads before writes
Date: Thu,  2 Nov 2023 14:10:04 -0600
Message-Id: <20231102201006.33143-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102201006.33143-1-ltaylorsimpson@gmail.com>
References: <20231102201006.33143-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: test/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x2e.google.com
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

We divide gen_analyze_funcs.py into 3 phases
    Declare the operands
    Analyze the register reads
    Analyze the register writes

We also create special versions of ctx_log_*_read for new operands
    Check that the operand is written before the read

This is a precursor to improving the analysis for short-circuiting
the packet semantics in a subsequent commit

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h          |  24 ++-
 target/hexagon/README               |   7 +-
 target/hexagon/gen_analyze_funcs.py | 221 +++++++++++-----------------
 3 files changed, 111 insertions(+), 141 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 4dd59c6726..b2fe3a048d 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -75,6 +75,8 @@ typedef struct DisasContext {
     TCGv dczero_addr;
 } DisasContext;
 
+bool is_gather_store_insn(DisasContext *ctx);
+
 static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
 {
     if (!test_bit(pnum, ctx->pregs_written)) {
@@ -89,6 +91,12 @@ static inline void ctx_log_pred_read(DisasContext *ctx, int pnum)
     set_bit(pnum, ctx->pregs_read);
 }
 
+static inline void ctx_log_pred_read_new(DisasContext *ctx, int pnum)
+{
+    g_assert(test_bit(pnum, ctx->pregs_written));
+    set_bit(pnum, ctx->pregs_read);
+}
+
 static inline void ctx_log_reg_write(DisasContext *ctx, int rnum,
                                      bool is_predicated)
 {
@@ -120,6 +128,12 @@ static inline void ctx_log_reg_read(DisasContext *ctx, int rnum)
     set_bit(rnum, ctx->regs_read);
 }
 
+static inline void ctx_log_reg_read_new(DisasContext *ctx, int rnum)
+{
+    g_assert(test_bit(rnum, ctx->regs_written));
+    set_bit(rnum, ctx->regs_read);
+}
+
 static inline void ctx_log_reg_read_pair(DisasContext *ctx, int rnum)
 {
     ctx_log_reg_read(ctx, rnum);
@@ -171,6 +185,15 @@ static inline void ctx_log_vreg_read(DisasContext *ctx, int rnum)
     set_bit(rnum, ctx->vregs_read);
 }
 
+static inline void ctx_log_vreg_read_new(DisasContext *ctx, int rnum)
+{
+    g_assert(is_gather_store_insn(ctx) ||
+             test_bit(rnum, ctx->vregs_updated) ||
+             test_bit(rnum, ctx->vregs_select) ||
+             test_bit(rnum, ctx->vregs_updated_tmp));
+    set_bit(rnum, ctx->vregs_read);
+}
+
 static inline void ctx_log_vreg_read_pair(DisasContext *ctx, int rnum)
 {
     ctx_log_vreg_read(ctx, rnum ^ 0);
@@ -205,7 +228,6 @@ extern TCGv hex_vstore_addr[VSTORES_MAX];
 extern TCGv hex_vstore_size[VSTORES_MAX];
 extern TCGv hex_vstore_pending[VSTORES_MAX];
 
-bool is_gather_store_insn(DisasContext *ctx);
 void process_store(DisasContext *ctx, int slot_num);
 
 FIELD(PROBE_PKT_SCALAR_STORE_S0, MMU_IDX,       0, 2)
diff --git a/target/hexagon/README b/target/hexagon/README
index 69b2ffe9bb..7dd74629eb 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -183,10 +183,11 @@ when the override is present.
     }
 
 We also generate an analyze_<tag> function for each instruction.  Currently,
-these functions record the writes to registers by calling ctx_log_*.  During
+these functions record the reads and writes to registers by calling ctx_log_*.  During
 gen_start_packet, we invoke the analyze_<tag> function for each instruction in
-the packet, and we mark the implicit writes.  After the analysis is performed,
-we initialize the result register for each of the predicated assignments.
+the packet, and we mark the implicit writes.  The analysis determines if the packet
+semantics can be short-circuited.  If not, we initialize the result register for each
+of the predicated assignments.
 
 In addition to instruction semantics, we use a generator to create the decode
 tree.  This generation is also a two step process.  The first step is to run
diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index c3b521abef..40b9473c44 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -22,157 +22,90 @@
 import string
 import hex_common
 
-
 ##
 ## Helpers for gen_analyze_func
 ##
 def is_predicated(tag):
     return "A_CONDEXEC" in hex_common.attribdict[tag]
 
+def vreg_write_type(tag):
+    newv = "EXT_DFL"
+    if hex_common.is_new_result(tag):
+        newv = "EXT_NEW"
+    elif hex_common.is_tmp_result(tag):
+        newv = "EXT_TMP"
+    return newv
 
-def analyze_opn_old(f, tag, regtype, regid, regno):
+def declare_regn(f, tag, regtype, regid, regno):
     regN = f"{regtype}{regid}N"
-    predicated = "true" if is_predicated(tag) else "false"
-    if regtype == "R":
-        if regid in {"ss", "tt"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_read_pair(ctx, {regN});\n")
-        elif regid in {"dd", "ee", "xx", "yy"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_write_pair(ctx, {regN}, {predicated});\n")
-        elif regid in {"s", "t", "u", "v"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
-        elif regid in {"d", "e", "x", "y"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_write(ctx, {regN}, {predicated});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid in {"s", "t", "u", "v"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_pred_read(ctx, {regN});\n")
-        elif regid in {"d", "e", "x"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_pred_write(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "C":
-        if regid == "ss":
-            f.write(
-                f"    const int {regN} = insn->regno[{regno}] "
-                "+ HEX_REG_SA0;\n"
-            )
+    if regtype == "C":
+        f.write(
+            f"    const int {regN} = insn->regno[{regno}] "
+            "+ HEX_REG_SA0;\n"
+        )
+    else:
+        f.write(f"    const int {regN} = insn->regno[{regno}];\n")
+
+def analyze_read(f, tag, regtype, regid, regno):
+    regN = f"{regtype}{regid}N"
+    if hex_common.is_pair(regid):
+        if regtype in {"R",  "C"}:
             f.write(f"    ctx_log_reg_read_pair(ctx, {regN});\n")
-        elif regid == "dd":
-            f.write(f"    const int {regN} = insn->regno[{regno}] " "+ HEX_REG_SA0;\n")
-            f.write(f"    ctx_log_reg_write_pair(ctx, {regN}, {predicated});\n")
-        elif regid == "s":
-            f.write(
-                f"    const int {regN} = insn->regno[{regno}] "
-                "+ HEX_REG_SA0;\n"
-            )
-            f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
-        elif regid == "d":
-            f.write(f"    const int {regN} = insn->regno[{regno}] " "+ HEX_REG_SA0;\n")
-            f.write(f"    ctx_log_reg_write(ctx, {regN}, {predicated});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "M":
-        if regid == "u":
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "V":
-        newv = "EXT_DFL"
-        if hex_common.is_new_result(tag):
-            newv = "EXT_NEW"
-        elif hex_common.is_tmp_result(tag):
-            newv = "EXT_TMP"
-        if regid in {"dd", "xx"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(
-                f"    ctx_log_vreg_write_pair(ctx, {regN}, {newv}, " f"{predicated});\n"
-            )
-        elif regid in {"uu", "vv"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
+        elif regtype == "V":
             f.write(f"    ctx_log_vreg_read_pair(ctx, {regN});\n")
-        elif regid in {"s", "u", "v", "w"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_vreg_read(ctx, {regN});\n")
-        elif regid in {"d", "x", "y"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_vreg_write(ctx, {regN}, {newv}, " f"{predicated});\n")
         else:
             hex_common.bad_register(regtype, regid)
-    elif regtype == "Q":
-        if regid in {"d", "e", "x"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_qreg_write(ctx, {regN});\n")
-        elif regid in {"s", "t", "u", "v"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_qreg_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "G":
-        if regid in {"dd"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"d"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"ss"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"s"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "S":
-        if regid in {"dd"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"d"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"ss"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"s"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
+    elif hex_common.is_single(regid):
+        if hex_common.is_old_val(regtype, regid, tag):
+            if regtype in {"R", "C", "M"}:
+                f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
+            elif regtype == "P":
+                f.write(f"    ctx_log_pred_read(ctx, {regN});\n")
+            elif regtype in {"V", "O"}:
+                f.write(f"    ctx_log_vreg_read(ctx, {regN});\n")
+            elif regtype == "Q":
+                f.write(f"    ctx_log_qreg_read(ctx, {regN});\n")
+            else:
+                hex_common.bad_register(regtype, regid)
+        elif hex_common.is_new_val(regtype, regid, tag):
+            if regtype == "N":
+                f.write(f"    ctx_log_reg_read_new(ctx, {regN});\n")
+            elif regtype == "P":
+                f.write(f"    ctx_log_pred_read_new(ctx, {regN});\n")
+            elif regtype == "O":
+                f.write(f"    ctx_log_vreg_read_new(ctx, {regN});\n")
+            else:
+                hex_common.bad_register(regtype, regid)
         else:
             hex_common.bad_register(regtype, regid)
     else:
         hex_common.bad_register(regtype, regid)
 
-
-def analyze_opn_new(f, tag, regtype, regid, regno):
+def analyze_write(f, tag, regtype, regid, regno):
     regN = f"{regtype}{regid}N"
-    if regtype == "N":
-        if regid in {"s", "t"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid in {"t", "u", "v"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_pred_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "O":
-        if regid == "s":
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_vreg_read(ctx, {regN});\n")
+    predicated = "true" if is_predicated(tag) else "false"
+    if hex_common.is_pair(regid):
+        if regtype in {"R", "C"}:
+            f.write(f"    ctx_log_reg_write_pair(ctx, {regN}, {predicated});\n")
+        elif regtype == "V":
+            f.write(
+                f"    ctx_log_vreg_write_pair(ctx, {regN}, "
+                f"{vreg_write_type(tag)}, {predicated});\n"
+            )
         else:
             hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def analyze_opn(f, tag, regtype, regid, i):
-    if hex_common.is_pair(regid):
-        analyze_opn_old(f, tag, regtype, regid, i)
     elif hex_common.is_single(regid):
-        if hex_common.is_old_val(regtype, regid, tag):
-            analyze_opn_old(f, tag, regtype, regid, i)
-        elif hex_common.is_new_val(regtype, regid, tag):
-            analyze_opn_new(f, tag, regtype, regid, i)
+        if regtype in {"R", "C"}:
+            f.write(f"    ctx_log_reg_write(ctx, {regN}, {predicated});\n")
+        elif regtype == "P":
+            f.write(f"    ctx_log_pred_write(ctx, {regN});\n")
+        elif regtype == "V":
+            f.write(
+                f"    ctx_log_vreg_write(ctx, {regN}, "
+                f"{vreg_write_type(tag)}, {predicated});\n"
+            )
+        elif regtype == "Q":
+            f.write(f"    ctx_log_qreg_write(ctx, {regN});\n")
         else:
             hex_common.bad_register(regtype, regid)
     else:
@@ -187,11 +120,11 @@ def analyze_opn(f, tag, regtype, regid, i):
 ##     {
 ##         Insn *insn G_GNUC_UNUSED = ctx->insn;
 ##         const int RdN = insn->regno[0];
-##         ctx_log_reg_write(ctx, RdN, false);
 ##         const int RsN = insn->regno[1];
-##         ctx_log_reg_read(ctx, RsN);
 ##         const int RtN = insn->regno[2];
+##         ctx_log_reg_read(ctx, RsN);
 ##         ctx_log_reg_read(ctx, RtN);
+##         ctx_log_reg_write(ctx, RdN, false);
 ##     }
 ##
 def gen_analyze_func(f, tag, regs, imms):
@@ -200,10 +133,24 @@ def gen_analyze_func(f, tag, regs, imms):
 
     f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
 
+    ## Declare the operands
+    i = 0
+    for regtype, regid in regs:
+        declare_regn(f, tag, regtype, regid, i)
+        i += 1
+
+    ## Analyze the register reads
+    i = 0
+    for regtype, regid in regs:
+        if hex_common.is_read(regid):
+            analyze_read(f, tag, regtype, regid, i)
+        i += 1
+
+    ## Analyze the register writes
     i = 0
-    ## Analyze all the registers
     for regtype, regid in regs:
-        analyze_opn(f, tag, regtype, regid, i)
+        if hex_common.is_written(regid):
+            analyze_write(f, tag, regtype, regid, i)
         i += 1
 
     has_generated_helper = not hex_common.skip_qemu_helper(
@@ -240,13 +187,13 @@ def main():
     tagimms = hex_common.get_tagimms()
 
     with open(sys.argv[-1], "w") as f:
-        f.write("#ifndef HEXAGON_TCG_FUNCS_H\n")
-        f.write("#define HEXAGON_TCG_FUNCS_H\n\n")
+        f.write("#ifndef HEXAGON_ANALYZE_FUNCS_H\n")
+        f.write("#define HEXAGON_ANALYZE_FUNCS_H\n\n")
 
         for tag in hex_common.tags:
             gen_analyze_func(f, tag, tagregs[tag], tagimms[tag])
 
-        f.write("#endif    /* HEXAGON_TCG_FUNCS_H */\n")
+        f.write("#endif    /* HEXAGON_ANALYZE_FUNCS_H */\n")
 
 
 if __name__ == "__main__":
-- 
2.34.1


