Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70904786BBF
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6bo-0003c5-GH; Thu, 24 Aug 2023 05:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6bT-0003Ex-Ak
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6bO-0004D8-HB
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxqOjIIedknHkbAA--.20140S3;
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S30; 
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 28/31] target/loongarch: cpu: Implement get_arch_id callback
Date: Thu, 24 Aug 2023 17:24:06 +0800
Message-Id: <20230824092409.1492470-29-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S30
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

From: Bibo Mao <maobibo@loongson.cn>

Implement the callback for getting the architecture-dependent CPU
ID, the cpu ID is physical id described in ACPI MADT table, this
will be used for cpu hotplug.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230824005007.2000525-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c    | 2 ++
 target/loongarch/cpu.c | 8 ++++++++
 target/loongarch/cpu.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index af15bf5aaa..2629128aed 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -810,6 +810,8 @@ static void loongarch_init(MachineState *machine)
         cpu = cpu_create(machine->cpu_type);
         cpu->cpu_index = i;
         machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
+        lacpu = LOONGARCH_CPU(cpu);
+        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
     }
     fdt_add_cpu_nodes(lams);
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d3c3e0d8a1..27fc6e1f33 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -722,6 +722,13 @@ static struct TCGCPUOps loongarch_tcg_ops = {
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
 };
+
+static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+
+    return cpu->phy_id;
+}
 #endif
 
 static void loongarch_cpu_class_init(ObjectClass *c, void *data)
@@ -742,6 +749,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
 #ifndef CONFIG_USER_ONLY
+    cc->get_arch_id = loongarch_cpu_get_arch_id;
     dc->vmsd = &vmstate_loongarch_cpu;
     cc->sysemu_ops = &loongarch_sysemu_ops;
 #endif
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 25a0ef7e41..4d7201995a 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -376,6 +376,7 @@ struct ArchCPU {
     CPUNegativeOffsetState neg;
     CPULoongArchState env;
     QEMUTimer timer;
+    uint32_t  phy_id;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
-- 
2.39.1


