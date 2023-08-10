Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 309137778BE
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4yq-0001Ce-Sj; Thu, 10 Aug 2023 08:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qU4yi-00019H-AZ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:41:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qU4yf-00044Y-Us
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:41:24 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxg_Ds2tRkd6sUAA--.44860S3;
 Thu, 10 Aug 2023 20:41:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c7o2tRkoiNTAA--.11480S8; 
 Thu, 10 Aug 2023 20:41:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 6/6] target/loongarch: Add REQUIRE_IOCSR macro to check
 IOCSR instructions
Date: Thu, 10 Aug 2023 20:41:12 +0800
Message-Id: <20230810124112.236640-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230810124112.236640-1-gaosong@loongson.cn>
References: <20230810124112.236640-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c7o2tRkoiNTAA--.11480S8
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
 target/loongarch/cpu.h                             | 2 ++
 target/loongarch/insn_trans/trans_privileged.c.inc | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 19d2a28a47..69a3ab16ee 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -465,6 +465,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_LSPW       0x200
 #define HW_FLAGS_LAM        0x400
 #define HW_FLAGS_LSX        0x800
+#define HW_FLAGS_IOCSR      0x2000
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
@@ -481,6 +482,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, LSPW) * HW_FLAGS_LSPW;
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, LAM) * HW_FLAGS_LAM;
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, LSX) * HW_FLAGS_LSX;
+    *flags |= FIELD_EX32(env->cpucfg[1], CPUCFG1, IOCSR) * HW_FLAGS_IOCSR;
 }
 
 void loongarch_cpu_list(void);
diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 210678dbb8..78badf4bbb 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -286,12 +286,19 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     return true;
 }
 
+#define REQUIRE_IOCSR do { \
+    if ((ctx->base.tb->flags & HW_FLAGS_IOCSR) == 0) { \
+        return false; \
+    } \
+} while (0)
+
 static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
                         void (*func)(TCGv, TCGv_ptr, TCGv))
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
+    REQUIRE_IOCSR;
     if (check_plv(ctx)) {
         return false;
     }
@@ -305,6 +312,7 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     TCGv val = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
+    REQUIRE_IOCSR;
     if (check_plv(ctx)) {
         return false;
     }
-- 
2.39.1


