Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC0678D43E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGt8-0008TK-6t; Wed, 30 Aug 2023 04:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbGt5-0008Py-3O
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbGt0-0007Sg-ST
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxNuiEAu9kYggdAA--.5920S3;
 Wed, 30 Aug 2023 16:49:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF81+Au9kHhxnAA--.49766S5; 
 Wed, 30 Aug 2023 16:49:08 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v4 03/48] target/loongarch: Add CHECK_ASXE maccro for check
 LASX enable
Date: Wed, 30 Aug 2023 16:48:17 +0800
Message-Id: <20230830084902.2113960-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230830084902.2113960-1-gaosong@loongson.cn>
References: <20230830084902.2113960-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81+Au9kHhxnAA--.49766S5
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h                       |  2 ++
 target/loongarch/cpu.c                       |  2 ++
 target/loongarch/insn_trans/trans_lasx.c.inc | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 347ad1c8a9..f125a8e49b 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -462,6 +462,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_EUEN_FPE   0x04
 #define HW_FLAGS_EUEN_SXE   0x08
+#define HW_FLAGS_EUEN_ASXE  0x10
 #define HW_FLAGS_VA32       0x20
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
@@ -472,6 +473,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
     *flags |= is_va32(env) * HW_FLAGS_VA32;
 }
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 923e4b30cf..4deae22104 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -54,6 +54,7 @@ static const char * const excp_names[] = {
     [EXCCODE_DBP] = "Debug breakpoint",
     [EXCCODE_BCE] = "Bound Check Exception",
     [EXCCODE_SXD] = "128 bit vector instructions Disable exception",
+    [EXCCODE_ASXD] = "256 bit vector instructions Disable exception",
 };
 
 const char *loongarch_exception_name(int32_t exception)
@@ -189,6 +190,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_FPD:
     case EXCCODE_FPE:
     case EXCCODE_SXD:
+    case EXCCODE_ASXD:
         env->CSR_BADV = env->pc;
         QEMU_FALLTHROUGH;
     case EXCCODE_BCE:
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 56a9839255..75a77f5dce 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -4,3 +4,13 @@
  * Copyright (c) 2023 Loongson Technology Corporation Limited
  */
 
+#ifndef CONFIG_USER_ONLY
+#define CHECK_ASXE do { \
+    if ((ctx->base.tb->flags & HW_FLAGS_EUEN_ASXE) == 0) { \
+        generate_exception(ctx, EXCCODE_ASXD); \
+        return true; \
+    } \
+} while (0)
+#else
+#define CHECK_ASXE
+#endif
-- 
2.39.1


