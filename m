Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B7F7CFA35
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:02:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScC-0005de-QL; Thu, 19 Oct 2023 08:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qtSc9-0005ci-V1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:59:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qtSc6-0002YV-6l
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:59:01 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxFegMKDFlxjIzAA--.40585S3;
 Thu, 19 Oct 2023 20:58:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axji8LKDFl8dsqAA--.25009S5; 
 Thu, 19 Oct 2023 20:58:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, peter.maydell@linaro.org,
 eblake@redhat.com, armbru@redhat.com, maobibo@loongson.cn
Subject: [PATCH v2 3/4] target/loongarch: Allow user enable/disable LSX/LASX
 features
Date: Thu, 19 Oct 2023 20:58:52 +0800
Message-Id: <20231019125853.3436531-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231019125853.3436531-1-gaosong@loongson.cn>
References: <20231019125853.3436531-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axji8LKDFl8dsqAA--.25009S5
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

Some users may not need LSX/LASX, this patch allows the user
enable/disable LSX/LASX features.

 e.g
 '-cpu max,lsx=on,lasx=on'   (default);
 '-cpu max,lsx=on,lasx=off'  (enabled LSX);
 '-cpu max,lsx=off,lasx=on'  (enabled LASX, LSX);
 '-cpu max,lsx=off'          (disable LSX and LASX).

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 target/loongarch/cpu.h |  8 +++++
 2 files changed, 86 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 87fcd08110..48ad4f9d8b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -447,6 +447,7 @@ static void loongarch_la464_initfn(Object *obj)
     env->cpucfg[20] = data;
 
     env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
+    loongarch_cpu_post_init(obj);
 }
 
 static void loongarch_la132_initfn(Object *obj)
@@ -626,6 +627,83 @@ static const MemoryRegionOps loongarch_qemu_ops = {
 };
 #endif
 
+static bool loongarch_get_lsx(Object *obj, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    bool ret;
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
+        ret = true;
+        cpu->has_lsx = ON_OFF_AUTO_AUTO;
+    } else {
+        ret = false;
+        cpu->has_lsx = ON_OFF_AUTO_OFF;
+    }
+    return ret;
+}
+
+static void loongarch_set_lsx(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    if (value) {
+        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LSX, 1);
+    } else {
+        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LSX, 0);
+        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LASX, 0);
+    }
+
+    cpu->has_lsx = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
+static bool loongarch_get_lasx(Object *obj, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    bool ret;
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
+        ret = true;
+        cpu->has_lasx = true;
+    } else {
+        ret = false;
+        cpu->has_lasx = false;
+    }
+    return ret;
+}
+
+static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    if (value) {
+        if (cpu->has_lsx == ON_OFF_AUTO_AUTO || cpu->has_lsx == ON_OFF_AUTO_OFF) {
+            cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LSX, 1);
+	}
+        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LASX, 1);
+    } else {
+        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LASX, 0);
+    }
+
+    cpu->has_lasx = value;
+}
+
+void loongarch_cpu_post_init(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+
+    if (loongarch_feature(env, CPU_FEATURE_LSX)) {
+        cpu->has_lsx = ON_OFF_AUTO_AUTO;
+        object_property_add_bool(obj, "lsx", loongarch_get_lsx,
+                                 loongarch_set_lsx);
+    }
+    if (loongarch_feature(env, CPU_FEATURE_LASX)) {
+        cpu->has_lasx = ON_OFF_AUTO_AUTO;
+        object_property_add_bool(obj, "lasx", loongarch_get_lasx,
+                                 loongarch_set_lasx);
+    }
+}
+
 static void loongarch_cpu_init(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b98064945a..b63ebe16ac 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -13,6 +13,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/registerfields.h"
 #include "qemu/timer.h"
+#include "qapi/qapi-types-common.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/memory.h"
 #endif
@@ -413,6 +414,11 @@ struct ArchCPU {
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
+
+    /* CPU has LSX */
+    OnOffAuto has_lsx;
+    /* CPU has  LASX */
+    OnOffAuto has_lasx;
 };
 
 #define TYPE_LOONGARCH_CPU "loongarch-cpu"
@@ -518,4 +524,6 @@ void loongarch_cpu_list(void);
 #define LOONGARCH_CPU_TYPE_NAME(model) model LOONGARCH_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
+void loongarch_cpu_post_init(Object *obj);
+
 #endif /* LOONGARCH_CPU_H */
-- 
2.25.1


