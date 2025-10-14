Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95596BDB4A1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 22:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8liI-00012V-C3; Tue, 14 Oct 2025 16:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liG-000120-DL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:40 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liA-0000TJ-Kh
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=6S65Lhu8jERU6fAWNnNEwXsZmOdy0t/V2fdRUm8mvpg=; b=hYzfHkgdmGiAGEC
 jBqIvm4qKn9KB5T65K0pcRHHde8nt9AAQW/Asdb8Un5/0d82YhKgR4btYxIbrrT3uVG/XRHtIXuKf
 Zwfxtp12mCCUehYxAta7FJoomIQbMBtUy/OzIZlvF2hEjnReCk7X+IEmRHxZaTG6w90bgY4DkEq9A
 H0=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [PATCH v3 18/34] target/riscv: Fix size of ssp
Date: Tue, 14 Oct 2025 22:34:55 +0200
Message-ID: <20251014203512.26282-19-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
References: <20251014203512.26282-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

As ssp holds a pointer, fix to 64 bits in size and make sure stores from
TCG use the correct size to avoid problems on big endian hosts.

Note, the cpu/ssp VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/cpu.h                            |  2 +-
 target/riscv/machine.c                        |  6 +++---
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 18 +++++++++++++-----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d7a41e6db5..2a71393118 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -255,7 +255,7 @@ struct CPUArchState {
     /* elp state for zicfilp extension */
     bool      elp;
     /* shadow stack register for zicfiss extension */
-    target_ulong ssp;
+    uint64_t ssp;
     /* env place holder for extra word 2 during unwind */
     target_ulong excp_uw2;
     /* sw check code for sw check exception */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 1cf744c5f0..c55794c554 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -390,11 +390,11 @@ static bool ssp_needed(void *opaque)
 
 static const VMStateDescription vmstate_ssp = {
     .name = "cpu/ssp",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = ssp_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.ssp, RISCVCPU),
+        VMSTATE_UINT64(env.ssp, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index f4a1c12ca0..fa1489037d 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -32,7 +32,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGLabel *skip = gen_new_label();
     uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
     TCGv data = tcg_temp_new();
-    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(addr, wide_addr);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
                        mxl_memop(ctx) | MO_ALIGN);
@@ -45,7 +47,8 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
     tcg_gen_addi_tl(addr, addr, tmp);
-    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ext_tl_i64(wide_addr, addr);
+    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
 
     return true;
 }
@@ -59,12 +62,15 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
     TCGv addr = tcg_temp_new();
     int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(addr, wide_addr);
     tcg_gen_addi_tl(addr, addr, tmp);
     tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
                        mxl_memop(ctx) | MO_ALIGN);
-    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ext_tl_i64(wide_addr, addr);
+    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
 
     return true;
 }
@@ -76,7 +82,9 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
-    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(dest, wide_addr);
     gen_set_gpr(ctx, a->rd, dest);
 
     return true;
-- 
2.51.0


