Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC27778B6
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4yn-0001Bz-PZ; Thu, 10 Aug 2023 08:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qU4yh-00018i-EN
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:41:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qU4yd-00044F-AZ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:41:22 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxfevr2tRkcqsUAA--.42246S3;
 Thu, 10 Aug 2023 20:41:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c7o2tRkoiNTAA--.11480S6; 
 Thu, 10 Aug 2023 20:41:14 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 4/6] target/loongarch: Add REQUIRE_LAM macro to check
 atomic instructions
Date: Thu, 10 Aug 2023 20:41:10 +0800
Message-Id: <20230810124112.236640-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230810124112.236640-1-gaosong@loongson.cn>
References: <20230810124112.236640-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c7o2tRkoiNTAA--.11480S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h                         |  2 ++
 target/loongarch/insn_trans/trans_atomic.c.inc | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 13a4ab316a..0166ec3d7b 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -463,6 +463,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_FP_SP      0x80
 #define HW_FLAGS_FP_DP      0x100
 #define HW_FLAGS_LSPW       0x200
+#define HW_FLAGS_LAM        0x400
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
@@ -477,6 +478,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_SP) * HW_FLAGS_FP_SP;
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_DP) * HW_FLAGS_FP_DP;
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, LSPW) * HW_FLAGS_LSPW;
+    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, LAM) * HW_FLAGS_LAM;
 }
 
 void loongarch_cpu_list(void);
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index d90312729b..c65d0da758 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -3,12 +3,20 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
+#define REQUIRE_LAM do { \
+    if ((ctx->base.tb->flags & HW_FLAGS_LAM) == 0) { \
+        return false; \
+    } \
+} while (0)
+
 static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv t0 = make_address_i(ctx, src1, a->imm);
 
+    REQUIRE_LAM;
+
     tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
     tcg_gen_st_tl(t0, cpu_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(dest, cpu_env, offsetof(CPULoongArchState, llval));
@@ -25,6 +33,8 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv t0 = tcg_temp_new();
     TCGv val = tcg_temp_new();
 
+    REQUIRE_LAM;
+
     TCGLabel *l1 = gen_new_label();
     TCGLabel *done = gen_new_label();
 
@@ -53,6 +63,8 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv val = gpr_src(ctx, a->rk, EXT_NONE);
 
+    REQUIRE_LAM;
+
     if (a->rd != 0 && (a->rj == a->rd || a->rk == a->rd)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Warning: source register overlaps destination register"
-- 
2.39.1


