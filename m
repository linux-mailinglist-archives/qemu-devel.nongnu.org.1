Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAF172F19D
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FCE-0004gy-11; Tue, 13 Jun 2023 21:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCC-0004gN-77
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:12 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCA-0004VH-9P
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-543c6a2aa07so3387810a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705668; x=1689297668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TPEsts0bLmi2C1xS0E0BsNiJynzg8MYIvX516FXYv8=;
 b=oZ9miai+bBK2bDwGWvly7tlEtHoAtm4f+iJtuiCYTq07/pTkAKNoYpNuntjtse1Epa
 A/Iah9ft3vbth48hLZNLJ5iFHl0LqUfC9ZOU16rlkyYoEtN/NudnanNUXGMQR/A8h0gP
 VbaKEHP1oCrG+ANkG2Ine0ynhT9nUDcmdPjbgy1rMYCPGAK7Y8Opx1OvPlffiytCBT7y
 cWb1nog5nhU53oSOdF9f+KCC92NwOZshzdS19gp9Ny8O5QHI3mno2nKXE0hDBtV011gS
 oyAGe16Y92i6SRf4xcPAswnlhyKTM0iwhThJCFTutrZOcPjCynuhOIDEFy3HUbm+USaX
 VI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705668; x=1689297668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/TPEsts0bLmi2C1xS0E0BsNiJynzg8MYIvX516FXYv8=;
 b=cwrzt1Q18qaFqD3/M9svqQDbLv32b0BSx+yTAeI2e/ECiuBMU1LGQAGVNSrtP5zkfh
 yuyoS11Y7MERbiIekO5ejZvSi+Y2MlpgbHW1DFvEHyQPKga1C/JsZFLXok/CVt4ZkPNU
 jJC33IxCqD21S5Xs99DrWP4JBDUL/DZDQq11lpHdrBLl9tufN3ZeyT26SkHwxMSSc8Tg
 YdVM3hH/ktatinVBjR7aI8iMa82yKT3WXFU8RvToOOPVO/riFUUJJp6ppmH+ycJm1PC4
 F07PfWpMBX0ckgisoXb33W2xC6CILiA3F8wrg7CWKXQ28ME2HQ1Hz7yG/lh3KVRPERSP
 Tx1w==
X-Gm-Message-State: AC+VfDxZUpoKzN0lIMP9tZnbTGDNsHGEZnnox5lmuyNJjMG9SHGX4KBD
 kF6T/x4p5+xLx1UTrYivZcI15W2O1sHsLw==
X-Google-Smtp-Source: ACHHUZ4HQbzPF2XgIP+zYGCoGgzEI+0FmH1tBKXognQFRnScjXx3pwkJ7BvR57rcrBYrCbOG11TxUQ==
X-Received: by 2002:a05:6a21:3603:b0:101:282c:2b with SMTP id
 yg3-20020a056a21360300b00101282c002bmr251806pzb.32.1686705668127; 
 Tue, 13 Jun 2023 18:21:08 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/60] target/riscv: Update check for Zca/Zcf/Zcd
Date: Wed, 14 Jun 2023 11:19:25 +1000
Message-Id: <20230614012017.3100663-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Even though Zca/Zcf/Zcd can be included by C/F/D, however, their priv
version is higher than the priv version of C/F/D. So if we use check
for them instead of check for C/F/D totally, it will trigger new
problem when we try to disable the extensions based on the configured
priv version.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517135714.211809-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                |  5 +++--
 target/riscv/insn_trans/trans_rvd.c.inc | 12 +++++++-----
 target/riscv/insn_trans/trans_rvf.c.inc | 14 ++++++++------
 target/riscv/insn_trans/trans_rvi.c.inc |  5 +++--
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 933b11c50d..29f1fb3995 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -551,7 +551,7 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 
     /* check misaligned: */
     next_pc = ctx->base.pc_next + imm;
-    if (!ctx->cfg_ptr->ext_zca) {
+    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
         if ((next_pc & 0x3) != 0) {
             gen_exception_inst_addr_mis(ctx);
             return;
@@ -1125,7 +1125,8 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
          * The Zca extension is added as way to refer to instructions in the C
          * extension that do not include the floating-point loads and stores
          */
-        if (ctx->cfg_ptr->ext_zca && decode_insn16(ctx, opcode)) {
+        if ((has_ext(ctx, RVC) || ctx->cfg_ptr->ext_zca) &&
+            decode_insn16(ctx, opcode)) {
             return;
         }
     } else {
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 2c51e01c40..6bdb55ef43 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -31,9 +31,11 @@
     } \
 } while (0)
 
-#define REQUIRE_ZCD(ctx) do { \
-    if (!ctx->cfg_ptr->ext_zcd) {  \
-        return false;     \
+#define REQUIRE_ZCD_OR_DC(ctx) do { \
+    if (!ctx->cfg_ptr->ext_zcd) { \
+        if (!has_ext(ctx, RVD) || !has_ext(ctx, RVC)) { \
+            return false; \
+        } \
     } \
 } while (0)
 
@@ -67,13 +69,13 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 
 static bool trans_c_fld(DisasContext *ctx, arg_fld *a)
 {
-    REQUIRE_ZCD(ctx);
+    REQUIRE_ZCD_OR_DC(ctx);
     return trans_fld(ctx, a);
 }
 
 static bool trans_c_fsd(DisasContext *ctx, arg_fsd *a)
 {
-    REQUIRE_ZCD(ctx);
+    REQUIRE_ZCD_OR_DC(ctx);
     return trans_fsd(ctx, a);
 }
 
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index b2de4fcf3f..c47138575a 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -30,10 +30,12 @@
     } \
 } while (0)
 
-#define REQUIRE_ZCF(ctx) do {                  \
-    if (!ctx->cfg_ptr->ext_zcf) {              \
-        return false;                          \
-    }                                          \
+#define REQUIRE_ZCF_OR_FC(ctx) do {                     \
+    if (!ctx->cfg_ptr->ext_zcf) {                       \
+        if (!has_ext(ctx, RVF) || !has_ext(ctx, RVC)) { \
+            return false;                               \
+        }                                               \
+    }                                                   \
 } while (0)
 
 static bool trans_flw(DisasContext *ctx, arg_flw *a)
@@ -69,13 +71,13 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
 
 static bool trans_c_flw(DisasContext *ctx, arg_flw *a)
 {
-    REQUIRE_ZCF(ctx);
+    REQUIRE_ZCF_OR_FC(ctx);
     return trans_flw(ctx, a);
 }
 
 static bool trans_c_fsw(DisasContext *ctx, arg_fsw *a)
 {
-    REQUIRE_ZCF(ctx);
+    REQUIRE_ZCF_OR_FC(ctx);
     return trans_fsw(ctx, a);
 }
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 2031e9931e..d794247f40 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -56,7 +56,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     tcg_gen_andi_tl(cpu_pc, cpu_pc, (target_ulong)-2);
 
     gen_set_pc(ctx, cpu_pc);
-    if (!ctx->cfg_ptr->ext_zca) {
+    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
         TCGv t0 = tcg_temp_new();
 
         misaligned = gen_new_label();
@@ -169,7 +169,8 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 
     gen_set_label(l); /* branch taken */
 
-    if (!ctx->cfg_ptr->ext_zca && ((ctx->base.pc_next + a->imm) & 0x3)) {
+    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
+        ((ctx->base.pc_next + a->imm) & 0x3)) {
         /* misaligned */
         gen_exception_inst_addr_mis(ctx);
     } else {
-- 
2.40.1


