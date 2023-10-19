Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EDE7CFA59
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScC-0005da-Od; Thu, 19 Oct 2023 08:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qtScA-0005dB-Mu
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:59:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qtSc6-0002Yp-VO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:59:02 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxpPAMKDFlwzIzAA--.33960S3;
 Thu, 19 Oct 2023 20:58:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axji8LKDFl8dsqAA--.25009S4; 
 Thu, 19 Oct 2023 20:58:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, peter.maydell@linaro.org,
 eblake@redhat.com, armbru@redhat.com, maobibo@loongson.cn
Subject: [PATCH v2 2/4] target/loongarch: Add cpu feature flags
Date: Thu, 19 Oct 2023 20:58:51 +0800
Message-Id: <20231019125853.3436531-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231019125853.3436531-1-gaosong@loongson.cn>
References: <20231019125853.3436531-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axji8LKDFl8dsqAA--.25009S4
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

CPULoongArchState adds cpu feature flags features.
Intrduce loongarch_feature() to check feature and
set_feature() to set feature.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c |  4 ++++
 target/loongarch/cpu.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ef6922e812..87fcd08110 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -366,6 +366,10 @@ static void loongarch_la464_initfn(Object *obj)
     CPULoongArchState *env = &cpu->env;
     int i;
 
+    env->features = 0;
+    set_feature(env, CPU_FEATURE_LSX);
+    set_feature(env, CPU_FEATURE_LASX);
+
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8b54cf109c..b98064945a 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -295,6 +295,8 @@ typedef struct CPUArchState {
     uint64_t lladdr; /* LL virtual address compared against SC */
     uint64_t llval;
 
+    uint64_t features;
+
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
     uint64_t CSR_PRMD;
@@ -364,6 +366,36 @@ typedef struct CPUArchState {
 #endif
 } CPULoongArchState;
 
+/*
+ * See arch/loongarch/include/asm/cpu.h
+ * and arch/loongarch/include/uapi/asm/hwcap.h
+ */
+enum loongarch_features {
+    CPU_FEATURE_CPUCFG,
+    CPU_FEATURE_LAM,
+    CPU_FEATURE_UAL,
+    CPU_FEATURE_FPU,
+    CPU_FEATURE_LSX,
+    CPU_FEATURE_LASX,
+    CPU_FEATURE_CRC32,
+    CPU_FEATURE_COMPLEX,
+    CPU_FEATURE_CRYPTO,
+    CPU_FEATURE_LVZ,
+    CPU_FEATURE_LBT_X86,
+    CPU_FEATURE_LBT_ARM,
+    CPU_FEATURE_LBT_MIPS,
+};
+
+static inline int loongarch_feature(CPULoongArchState *env, int feature)
+{
+    return (env->features & (1ULL << feature)) != 0;
+}
+
+static inline void set_feature(CPULoongArchState *env, int feature)
+{
+    env->features |= 1ULL << feature;
+}
+
 /**
  * LoongArchCPU:
  * @env: #CPULoongArchState
-- 
2.25.1


