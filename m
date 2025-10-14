Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F68BDB438
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 22:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8liB-0000zH-BW; Tue, 14 Oct 2025 16:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8li7-0000xn-RL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:31 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8li1-0000Rq-KF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=jwM9tbmdPiTIULteWRet09FLlU5nMdmhCz9b8ImjSHI=; b=qEqoO2M6jQ9ODoY
 lL8bZ0ihrLSmGRmWIeea6i+SgXYhJmKP9SpVeLnOut2wQY+dx2ljDBikA3SNncqfLVL/Xz1jKKqtU
 aezwla9zZO8BNXg3e7iY+DwS5r6XeqYeaJiMEqPU2s+jTzyn1HjOdDGr9+J4DeEgYhu3LW/HgjVVV
 Kc=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [PATCH v3 14/34] target/riscv: Fix size of badaddr and bins
Date: Tue, 14 Oct 2025 22:34:51 +0200
Message-ID: <20251014203512.26282-15-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
References: <20251014203512.26282-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fix these fields to 64 bits as they cannot be made smaller. Also make
sure stores to these fields from TCG are 64 bits in size to avoid
incorrect values on big endian hosts.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/cpu.h                             | 4 ++--
 target/riscv/machine.c                         | 2 +-
 target/riscv/translate.c                       | 6 ++++--
 target/riscv/insn_trans/trans_privileged.c.inc | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f2378d0b67..8c93030b1c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -233,8 +233,8 @@ struct CPUArchState {
     uint8_t frm;
     float_status fp_status;
 
-    target_ulong badaddr;
-    target_ulong bins;
+    uint64_t badaddr;
+    uint64_t bins;
 
     target_ulong guest_phys_fault_addr;
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 07995fb303..b047321073 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -437,7 +437,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.load_res, RISCVCPU),
         VMSTATE_UINT64(env.load_val, RISCVCPU),
         VMSTATE_UINT8(env.frm, RISCVCPU),
-        VMSTATE_UINTTL(env.badaddr, RISCVCPU),
+        VMSTATE_UINT64(env.badaddr, RISCVCPU),
         VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
         VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
         VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 6b84d0c384..2770c06413 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -253,7 +253,7 @@ static void generate_exception(DisasContext *ctx, RISCVException excp)
 
 static void gen_exception_illegal(DisasContext *ctx)
 {
-    tcg_gen_st_i32(tcg_constant_i32(ctx->opcode), tcg_env,
+    tcg_gen_st_i64(tcg_constant_i64(ctx->opcode), tcg_env,
                    offsetof(CPURISCVState, bins));
     if (ctx->virt_inst_excp) {
         generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
@@ -264,7 +264,9 @@ static void gen_exception_illegal(DisasContext *ctx)
 
 static void gen_exception_inst_addr_mis(DisasContext *ctx, TCGv target)
 {
-    tcg_gen_st_tl(target, tcg_env, offsetof(CPURISCVState, badaddr));
+    TCGv_i64 ext = tcg_temp_new_i64();
+    tcg_gen_extu_tl_i64(ext, target);
+    tcg_gen_st_i64(ext, tcg_env, offsetof(CPURISCVState, badaddr));
     generate_exception(ctx, RISCV_EXCP_INST_ADDR_MIS);
 }
 
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..a8eaccef67 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -68,7 +68,7 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
-        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
+        tcg_gen_st_i64(tcg_constant_i64(ebreak_addr), tcg_env,
                       offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
     }
-- 
2.51.0


