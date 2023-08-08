Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD065773619
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBx0-0002dO-UO; Mon, 07 Aug 2023 21:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwy-0002dC-G7
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:56 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBww-0003im-Ru
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:56 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id CB67C43F3A;
 Tue,  8 Aug 2023 01:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691459753; bh=ecXGuJl54UoHpFAvQkdUsmdJF2pb9cfMDSyUK6YXxPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eEMvqMAjO42t8NQxSIKNfXkKOj7tDBo9vUdZmnYpslnhWb9QFR0mrMpYG8xCoZXJ5
 Zp08RI82YpHNTIm1JZKwTuUOROGBHKy0/bcLPuKP7ZBZIX5vfIK8F9hUhP5VjS9tgK
 O+OFvfWZpdNBXrJObvLHJfG6PcxtXWqp44rZXKnI=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>
Subject: [PATCH v4 07/11] target/loongarch: Add LA32 & VA32 to DisasContext
Date: Tue,  8 Aug 2023 09:54:33 +0800
Message-ID: <20230808015506.1705140-8-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808015506.1705140-1-c@jia.je>
References: <20230808015506.1705140-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add LA32 and VA32(32-bit Virtual Address) to DisasContext to allow the
translator to reject doubleword instructions in LA32 mode for example.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h       | 9 +++++++++
 target/loongarch/translate.c | 3 +++
 target/loongarch/translate.h | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 396869c3b6..69589f0aef 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -445,15 +445,24 @@ static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_EUEN_FPE   0x04
 #define HW_FLAGS_EUEN_SXE   0x08
+#define HW_FLAGS_VA32       0x20
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
+    /* VA32 if LA32 or VA32L[1-3] */
+    uint32_t va32 = LOONGARCH_CPUCFG_ARCH(env, LA32);
+    uint64_t plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+    if (plv >= 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
+        va32 = 1;
+    }
+
     *pc = env->pc;
     *cs_base = 0;
     *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    *flags |= va32 * HW_FLAGS_VA32;
 }
 
 void loongarch_cpu_list(void);
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 3146a2d4ac..f1e5fe4cf8 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -119,6 +119,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
         ctx->vl = LSX_LEN;
     }
 
+    ctx->la32 = LOONGARCH_CPUCFG_ARCH(env, LA32);
+    ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
+
     ctx->zero = tcg_constant_tl(0);
 }
 
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 7f60090580..828f1185d2 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -33,6 +33,8 @@ typedef struct DisasContext {
     uint16_t plv;
     int vl;   /* Vector length */
     TCGv zero;
+    bool la32; /* LoongArch32 mode */
+    bool va32; /* 32-bit virtual address */
 } DisasContext;
 
 void generate_exception(DisasContext *ctx, int excp);
-- 
2.41.0


