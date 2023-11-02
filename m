Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC907DFB46
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 21:11:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qye1H-0004NL-IK; Thu, 02 Nov 2023 16:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qye1F-0004Mq-UU
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 16:10:21 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qye1E-0006t6-IM
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 16:10:21 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1dd71c0a41fso772503fac.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698955819; x=1699560619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7NDoqZemMXsjA53+STr4Q/JGMDoeNsO3GVH3o1yeV4=;
 b=Z0jzkIeiR73kkfdNxMy6IcpqO5SPd1U2CfvkqzWedBO93/kHfegjvuk8Ro80pKWjyh
 FqXh7TGR5WYYqyu/Bq9Tx4dhkxBHk0Ys5izmIfb+rd01Ur0sw6ym4eLoVelDZ8+y6BLE
 vX8r2xr8fDMZSeA4RNSaKMI8VrJsamoOoshNryaeRrqS5d33lJvyqqBtDYxh2D8P0leh
 G9pUxrXZOAZiV8GkgmwMfNEUAYXryONR8nu9LLuoyf/8exWHWoMw5Kvb/VlcHPsR8CDO
 eDQWnMSX4s2qaECQMSaw66iXwelwWZz/V5f4CLDN18iytLP1eWOfwfbd6BdjY2VH6tgT
 G/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698955819; x=1699560619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7NDoqZemMXsjA53+STr4Q/JGMDoeNsO3GVH3o1yeV4=;
 b=VEkcrp0kUwgFYyj0y0ve6qL8Dbm7L0CHYfTCDEuuDANZYsSIbNJu/qkfNt5N0qNmmx
 eO4dznaZRlGTZzwpmv6KhPBEssEXo4Mbe1KA7CagU+qE2AEfvk0d0oUfBR+jIxWX3zE4
 rsHA45v7kUtHLqL6oWZ0kPK6jcc7JIot9EixuCBNAySviNe2pasHPowpvpBH+YElnQrD
 WZ0v/0Fk/gslmduMHCN3umRcSS1AD2XI9ozeq7hp55ldjTsBQE+749RlS97WahuHYFtv
 N5/Vql6n2VYRhx5Dl/Miz/9s73QqMsD3gc5iVCCNLdnmlBgVSFJSB8OpI1LDqG34bSwR
 LcUA==
X-Gm-Message-State: AOJu0YyELNTGDu1tdt6BHfJQhh45XgMeb74F5w3R+8fORmRnIycl9mgi
 2hQSNMcSMrEo+1071D8SkLf/00I+Hlo=
X-Google-Smtp-Source: AGHT+IGE5spTkSp2xMzqIATfIUqr0JAe7/eo8b69ZzzHGRegjU1kQLKTBHc+7EvmtNesUbaVCM+ivA==
X-Received: by 2002:a05:6870:860c:b0:1ea:a11:71f4 with SMTP id
 h12-20020a056870860c00b001ea0a1171f4mr23238447oal.59.1698955818854; 
 Thu, 02 Nov 2023 13:10:18 -0700 (PDT)
Received: from taylor-ubuntu.austin.rr.com (cpe-68-203-8-61.austin.res.rr.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 z9-20020a056870e14900b001e98b1544fesm63543oaa.9.2023.11.02.13.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 13:10:18 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PATCH 2/3] Hexagon (target/hexagon) Enable more short-circuit
 packets (scalar core)
Date: Thu,  2 Nov 2023 14:10:05 -0600
Message-Id: <20231102201006.33143-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102201006.33143-1-ltaylorsimpson@gmail.com>
References: <20231102201006.33143-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: test/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x2c.google.com
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


