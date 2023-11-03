Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 118EA7E0658
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 17:24:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywwd-00034r-1b; Fri, 03 Nov 2023 12:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qywwb-00034Y-K8
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:22:49 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qywwZ-0001iP-JO
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:22:49 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ce2cc39d12so1252891a34.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699028565; x=1699633365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7NDoqZemMXsjA53+STr4Q/JGMDoeNsO3GVH3o1yeV4=;
 b=F3YH2sUjsYeue80qEErZDPPTf9m7baRpuhrdz7rfXnFX9zSYBypAi+h1lupqsXq/SP
 zXZFJ3TJ9s2uBtagfyww5x5BqnjU7LOhSmO8z1fZ5CW273yiGv8ArYk4ln2WFKteoJvA
 EyFn5jHwom3dcPJnv6xwmyupXcrm6+ohY9dpX7nhWtrgBd0LdBIkC+sJado3ouWXQ+Lc
 zxYJc3K7gXXLD2KLxkph/FNFPt3WO1TrhinxGByxaSKuNY8wrzieqh+oBe10T38EKp3r
 2XgIsFtPrpyR0OwWgGFdaegUveh25eTH1FxVHsxwEDt6gCwbXmhr8VGRi67zMq/+x2Nv
 YBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699028565; x=1699633365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7NDoqZemMXsjA53+STr4Q/JGMDoeNsO3GVH3o1yeV4=;
 b=G+drMDNUBXN0M7LffjQ7VzSouzXDsl0Md4SLnbds6J1r3r6BkhFnGuKf6LW3gSqCN1
 nxzeK0M+zAVnqB+ZSlZ3i5XIjcwrsqGI6mIikaIkcyZXp0yFNfAdVhsPMUhhfbJCUBYU
 S1i8eYuAQgeX2/te92EQ33p3tP2AKTg8MC5iLqeSkk3CuvnTZhLkVWfNhJBOjyKpbZUX
 0433Cd/IFOgArhHpNDgKyLejG40xPCegkVko2mf8e7UqhjuoRlUzPdeoi/OksSAIvTMo
 oQ8QRcsDpYRbfhrSBGNYM1+FNT/Me7S+LDtzHMc02tTnQALhtrid5Oc9tnKJoC4KE/Vb
 nffw==
X-Gm-Message-State: AOJu0Yyqy8x5iCw5BS/DQPai+vHtCQ7UOdpCzykG0oPGxDfbBIGctIDd
 KiMVHAQ8sYpZnJhCDCi39zFcjEnK27zCOw==
X-Google-Smtp-Source: AGHT+IGEReq3r3zKgkADJ9cPsjRzhBKtdSgiDnNVxeH4cEftI70/FRfGLBtfZxdhZt/nn/dDVpWRhQ==
X-Received: by 2002:a9d:768f:0:b0:6c2:2bca:7a14 with SMTP id
 j15-20020a9d768f000000b006c22bca7a14mr21696282otl.23.1699028565532; 
 Fri, 03 Nov 2023 09:22:45 -0700 (PDT)
Received: from taylor-ubuntu.austin.rr.com (cpe-68-203-8-61.austin.res.rr.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 t7-20020a9d7747000000b006ce2c31dd9bsm316039otl.20.2023.11.03.09.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 09:22:44 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, richard.henderson@linaro.org,
 philmd@linaro.org, ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 2/3] Hexagon (target/hexagon) Enable more short-circuit
 packets (scalar core)
Date: Fri,  3 Nov 2023 10:22:40 -0600
Message-Id: <20231103162241.92926-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103162241.92926-1-ltaylorsimpson@gmail.com>
References: <20231103162241.92926-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x330.google.com
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

Look for read-after-write instead of overlap of reads and writes

Here is an example with overalp but no read-after-write:
0x000200fc:  0x38103876	{	R0 = add(R0,R1); R6 = add(R6,R7) }

BEFORE:
 ---- 00000000000200fc
 mov_i32 loc2,$0x0
 mov_i32 loc2,r0
 add_i32 loc3,loc2,r1
 mov_i32 loc2,loc3
 mov_i32 loc4,$0x0
 mov_i32 loc4,r6
 add_i32 loc5,loc4,r7
 mov_i32 loc4,loc5
 mov_i32 r0,loc2
 mov_i32 r6,loc4

AFTER:
 ---- 00000000000200fc
 add_i32 loc2,r0,r1
 mov_i32 r0,loc2
 add_i32 loc3,r6,r7
 mov_i32 r6,loc3

We can also short-circuit packets with .new values by reading from the
real destination instead of the temporary.
0x00020100:  0x78005ff3	{	R19 = #0xff
0x00020104:  0x2002e204		if (cmp.eq(N19.new,R2)) jump:t PC+8 }

BEFORE:
 ---- 0000000000020100
 mov_i32 pc,$0x20108
 mov_i32 loc8,$0x0
 mov_i32 loc8,$0xff
 setcond_i32 loc10,loc8,r2,eq
 mov_i32 loc6,loc10
 mov_i32 r19,loc8
 add_i32 pkt_cnt,pkt_cnt,$0x2
 add_i32 insn_cnt,insn_cnt,$0x4
 brcond_i32 loc6,$0x0,eq,$L1
 goto_tb $0x0
 mov_i32 pc,$0x20108
 exit_tb $0x7fbb54000040
 set_label $L1
 goto_tb $0x1
 exit_tb $0x7fbb54000041
 set_label $L0
 exit_tb $0x7fbb54000043

AFTER:
 ---- 0000000000020100
 mov_i32 pc,$0x20108
 mov_i32 r19,$0xff
 setcond_i32 loc7,r19,r2,eq
 mov_i32 loc4,loc7
 add_i32 pkt_cnt,pkt_cnt,$0x2
 add_i32 insn_cnt,insn_cnt,$0x4
 brcond_i32 loc4,$0x0,eq,$L1
 goto_tb $0x0
 mov_i32 pc,$0x20108
 exit_tb $0x7f9764000040
 set_label $L1
 goto_tb $0x1
 exit_tb $0x7f9764000041
 set_label $L0
 exit_tb $0x7f9764000043

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h      | 13 +++++++------
 target/hexagon/translate.c      | 19 +++----------------
 target/hexagon/gen_tcg_funcs.py |  2 +-
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index b2fe3a048d..7bb19ee672 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -38,12 +38,10 @@ typedef struct DisasContext {
     int reg_log[REG_WRITES_MAX];
     int reg_log_idx;
     DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
-    DECLARE_BITMAP(regs_read, TOTAL_PER_THREAD_REGS);
     DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
     int preg_log[PRED_WRITES_MAX];
     int preg_log_idx;
     DECLARE_BITMAP(pregs_written, NUM_PREGS);
-    DECLARE_BITMAP(pregs_read, NUM_PREGS);
     uint8_t store_width[STORES_MAX];
     bool s1_store_processed;
     int future_vregs_idx;
@@ -68,6 +66,7 @@ typedef struct DisasContext {
     bool is_tight_loop;
     bool short_circuit;
     bool has_hvx_helper;
+    bool read_after_write;
     TCGv new_value[TOTAL_PER_THREAD_REGS];
     TCGv new_pred_value[NUM_PREGS];
     TCGv pred_written;
@@ -88,13 +87,14 @@ static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
 
 static inline void ctx_log_pred_read(DisasContext *ctx, int pnum)
 {
-    set_bit(pnum, ctx->pregs_read);
+    if (test_bit(pnum, ctx->pregs_written)) {
+        ctx->read_after_write = true;
+    }
 }
 
 static inline void ctx_log_pred_read_new(DisasContext *ctx, int pnum)
 {
     g_assert(test_bit(pnum, ctx->pregs_written));
-    set_bit(pnum, ctx->pregs_read);
 }
 
 static inline void ctx_log_reg_write(DisasContext *ctx, int rnum,
@@ -125,13 +125,14 @@ static inline void ctx_log_reg_write_pair(DisasContext *ctx, int rnum,
 
 static inline void ctx_log_reg_read(DisasContext *ctx, int rnum)
 {
-    set_bit(rnum, ctx->regs_read);
+    if (test_bit(rnum, ctx->regs_written)) {
+        ctx->read_after_write = true;
+    }
 }
 
 static inline void ctx_log_reg_read_new(DisasContext *ctx, int rnum)
 {
     g_assert(test_bit(rnum, ctx->regs_written));
-    set_bit(rnum, ctx->regs_read);
 }
 
 static inline void ctx_log_reg_read_pair(DisasContext *ctx, int rnum)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 666c061180..9dab26ee17 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -394,20 +394,8 @@ static bool need_commit(DisasContext *ctx)
         }
     }
 
-    /* Check for overlap between register reads and writes */
-    for (int i = 0; i < ctx->reg_log_idx; i++) {
-        int rnum = ctx->reg_log[i];
-        if (test_bit(rnum, ctx->regs_read)) {
-            return true;
-        }
-    }
-
-    /* Check for overlap between predicate reads and writes */
-    for (int i = 0; i < ctx->preg_log_idx; i++) {
-        int pnum = ctx->preg_log[i];
-        if (test_bit(pnum, ctx->pregs_read)) {
-            return true;
-        }
+    if (ctx->read_after_write) {
+        return true;
     }
 
     /* Check for overlap between HVX reads and writes */
@@ -466,6 +454,7 @@ static void analyze_packet(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
     ctx->has_hvx_helper = false;
+    ctx->read_after_write = false;
     for (int i = 0; i < pkt->num_insns; i++) {
         Insn *insn = &pkt->insn[i];
         ctx->insn = insn;
@@ -490,11 +479,9 @@ static void gen_start_packet(DisasContext *ctx)
     ctx->next_PC = next_PC;
     ctx->reg_log_idx = 0;
     bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
-    bitmap_zero(ctx->regs_read, TOTAL_PER_THREAD_REGS);
     bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
     ctx->preg_log_idx = 0;
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
-    bitmap_zero(ctx->pregs_read, NUM_PREGS);
     ctx->future_vregs_idx = 0;
     ctx->tmp_vregs_idx = 0;
     ctx->vreg_log_idx = 0;
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index f5246cee6d..3d24ae7960 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -198,7 +198,7 @@ def genptr_decl_new(f, tag, regtype, regid, regno):
         if regid in {"t", "u", "v"}:
             f.write(
                 f"    TCGv {regtype}{regid}N = "
-                f"ctx->new_pred_value[insn->regno[{regno}]];\n"
+                f"get_result_pred(ctx, insn->regno[{regno}]);\n"
             )
         else:
             hex_common.bad_register(regtype, regid)
-- 
2.34.1


