Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D877F362
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWZMI-0001Hn-9A; Thu, 17 Aug 2023 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qWZM8-0008M1-MR
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qWZM5-0002a6-Qf
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxY_D26N1keXUZAA--.52341S3;
 Thu, 17 Aug 2023 17:31:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSPs6N1kjKdcAA--.12060S15; 
 Thu, 17 Aug 2023 17:31:34 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, yijun@loongson.cn,
 shenjinyang@loongson.cn
Subject: [PATCH v3 13/18] target/loongarch: Add loongarch32 cpu la132
Date: Thu, 17 Aug 2023 17:31:16 +0800
Message-Id: <20230817093121.1053890-14-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230817093121.1053890-1-gaosong@loongson.cn>
References: <20230817093121.1053890-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSPs6N1kjKdcAA--.12060S15
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

Add la132 as a loongarch32 cpu type and allow virt machine to be used
with la132 instead of la464.

Due to lack of public documentation of la132, it is currently a
synthetic loongarch32 cpu model. Details need to be added in the future.

Signed-off-by: Jiajie Chen <c@jia.je>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c    |  5 -----
 target/loongarch/cpu.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e19b042ce8..af15bf5aaa 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -798,11 +798,6 @@ static void loongarch_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
-    if (!strstr(cpu_model, "la464")) {
-        error_report("LoongArch/TCG needs cpu type la464");
-        exit(1);
-    }
-
     if (ram_size < 1 * GiB) {
         error_report("ram_size must be greater than 1G.");
         exit(1);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8d95c997dc..95e00a044c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -440,6 +440,34 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 }
 
+static void loongarch_la132_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+
+    int i;
+
+    for (i = 0; i < 21; i++) {
+        env->cpucfg[i] = 0x0;
+    }
+
+    cpu->dtb_compatible = "loongarch,Loongson-1C103";
+
+    uint32_t data = 0;
+    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
+    data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
+    data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
+    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, UAL, 1);
+    data = FIELD_DP32(data, CPUCFG1, RI, 0);
+    data = FIELD_DP32(data, CPUCFG1, EP, 0);
+    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
+    data = FIELD_DP32(data, CPUCFG1, HP, 1);
+    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
+    env->cpucfg[1] = data;
+}
+
 static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
 {
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
@@ -779,6 +807,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .class_init = loongarch32_cpu_class_init,
     },
     DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
+    DEFINE_LOONGARCH32_CPU_TYPE("la132", loongarch_la132_initfn),
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
-- 
2.39.1


