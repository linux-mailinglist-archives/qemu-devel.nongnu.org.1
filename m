Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B577F35C
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWZME-0000qx-Kn; Thu, 17 Aug 2023 05:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qWZLx-0006Si-0O
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qWZLr-0002Z9-W6
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXevy6N1kXnUZAA--.47119S3;
 Thu, 17 Aug 2023 17:31:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSPs6N1kjKdcAA--.12060S9; 
 Thu, 17 Aug 2023 17:31:30 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, yijun@loongson.cn,
 shenjinyang@loongson.cn
Subject: [PATCH v3 07/18] target/loongarch: Add LA64 & VA32 to DisasContext
Date: Thu, 17 Aug 2023 17:31:10 +0800
Message-Id: <20230817093121.1053890-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230817093121.1053890-1-gaosong@loongson.cn>
References: <20230817093121.1053890-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSPs6N1kjKdcAA--.12060S9
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

From: Jiajie Chen <c@jia.je>

Add LA64 and VA32(32-bit Virtual Address) to DisasContext to allow the
translator to reject doubleword instructions in LA32 mode for example.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h       | 13 +++++++++++++
 target/loongarch/translate.c |  3 +++
 target/loongarch/translate.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 2af4c414b0..0e02257f91 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -431,6 +431,17 @@ static inline bool is_la64(CPULoongArchState *env)
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
 }
 
+static inline bool is_va32(CPULoongArchState *env)
+{
+    /* VA32 if !LA64 or VA32L[1-3] */
+    bool va32 = !is_la64(env);
+    uint64_t plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+    if (plv >= 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
+        va32 = true;
+    }
+    return va32;
+}
+
 /*
  * LoongArch CPUs hardware flags.
  */
@@ -438,6 +449,7 @@ static inline bool is_la64(CPULoongArchState *env)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_EUEN_FPE   0x04
 #define HW_FLAGS_EUEN_SXE   0x08
+#define HW_FLAGS_VA32       0x20
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
@@ -447,6 +459,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    *flags |= is_va32(env) * HW_FLAGS_VA32;
 }
 
 void loongarch_cpu_list(void);
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 3146a2d4ac..ac847745df 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -119,6 +119,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
         ctx->vl = LSX_LEN;
     }
 
+    ctx->la64 = is_la64(env);
+    ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
+
     ctx->zero = tcg_constant_tl(0);
 }
 
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 7f60090580..b6fa5df82d 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -33,6 +33,8 @@ typedef struct DisasContext {
     uint16_t plv;
     int vl;   /* Vector length */
     TCGv zero;
+    bool la64; /* LoongArch64 mode */
+    bool va32; /* 32-bit virtual address */
 } DisasContext;
 
 void generate_exception(DisasContext *ctx, int excp);
-- 
2.39.1


