Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C636D773618
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBx9-0002er-Az; Mon, 07 Aug 2023 21:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBx8-0002ef-0D
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:56:06 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBx6-0003np-Di
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:56:05 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 7C84D41E9E;
 Tue,  8 Aug 2023 01:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691459763; bh=TSanPZf91U12nquKIo1AxJOtCbjMKT+7VhAQNrFLZk0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kOnA7qm9UgRKVwaHavcM0bpzuGMht/ZEGBOAsbzCBIBrmxHYuWxEMNRcDmMUvdlCy
 8UFTjjoRUmDNH8OGPaRmynAWSEKb3PWgybPHOxqk/mBT6f0qw8G/AqWDx/N5GnERDr
 hF4De4UGOYA6hXfg+1xR9vvm++WxjyrBTAmbv0kA=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>
Subject: [PATCH v4 11/11] target/loongarch: Add loongarch32 cpu la132
Date: Tue,  8 Aug 2023 09:54:37 +0800
Message-ID: <20230808015506.1705140-12-c@jia.je>
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

Add la132 as a loongarch32 cpu type and allow virt machine to be used
with la132 instead of la464.

Refactor common init logic out as loongarch_cpu_initfn_common.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 hw/loongarch/virt.c    |  5 ----
 target/loongarch/cpu.c | 54 ++++++++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 18 deletions(-)

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
index 13d4fccbd3..341176817e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -356,30 +356,18 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 #endif
 }
 
-static void loongarch_la464_initfn(Object *obj)
+static void loongarch_cpu_initfn_common(CPULoongArchState *env)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    CPULoongArchState *env = &cpu->env;
     int i;
 
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
 
-    cpu->dtb_compatible = "loongarch,Loongson-3A5000";
-    env->cpucfg[0] = 0x14c010;  /* PRID */
-
     uint32_t data = 0;
-    data = FIELD_DP32(data, CPUCFG1, ARCH, 2);
     data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
     data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
-    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x2f);
-    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x2f);
     data = FIELD_DP32(data, CPUCFG1, UAL, 1);
-    data = FIELD_DP32(data, CPUCFG1, RI, 1);
-    data = FIELD_DP32(data, CPUCFG1, EP, 1);
-    data = FIELD_DP32(data, CPUCFG1, RPLV, 1);
-    data = FIELD_DP32(data, CPUCFG1, HP, 1);
     data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
     env->cpucfg[1] = data;
 
@@ -439,6 +427,45 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 }
 
+static void loongarch_la464_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+
+    loongarch_cpu_initfn_common(env);
+
+    cpu->dtb_compatible = "loongarch,Loongson-3A5000";
+    env->cpucfg[0] = 0x14c010;  /* PRID */
+
+    uint32_t data = env->cpucfg[1];
+    data = FIELD_DP32(data, CPUCFG1, ARCH, 2); /* LA64 */
+    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x2f); /* 48 bits */
+    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x2f); /* 48 bits */
+    data = FIELD_DP32(data, CPUCFG1, RI, 1);
+    data = FIELD_DP32(data, CPUCFG1, EP, 1);
+    data = FIELD_DP32(data, CPUCFG1, RPLV, 1);
+    env->cpucfg[1] = data;
+}
+
+static void loongarch_la132_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+
+    loongarch_cpu_initfn_common(env);
+
+    cpu->dtb_compatible = "loongarch,Loongson-1C103";
+
+    uint32_t data = env->cpucfg[1];
+    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
+    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, RI, 0);
+    data = FIELD_DP32(data, CPUCFG1, EP, 0);
+    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
+    env->cpucfg[1] = data;
+}
+
 static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
 {
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
@@ -784,5 +811,6 @@ static const TypeInfo loongarch32_cpu_type_infos[] = {
         .class_size = sizeof(LoongArchCPUClass),
         .class_init = loongarch32_cpu_class_init,
     },
+    DEFINE_LOONGARCH32_CPU_TYPE("la132", loongarch_la132_initfn),
 };
 DEFINE_TYPES(loongarch32_cpu_type_infos)
-- 
2.41.0


