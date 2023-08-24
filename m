Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407F7786451
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 02:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYyYS-0003Mf-Qa; Wed, 23 Aug 2023 20:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qYyYN-0003MM-My
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 20:50:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qYyYI-00069E-MU
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 20:50:26 -0400
Received: from loongson.cn (unknown [10.2.9.158])
 by gateway (Coremail) with SMTP id _____8AxV_FDqeZkpFsbAA--.56352S3;
 Thu, 24 Aug 2023 08:50:13 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx5sxCqeZkUtRhAA--.20702S2; 
 Thu, 24 Aug 2023 08:50:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2] target/loongarch: cpu: Implement get_arch_id callback
Date: Thu, 24 Aug 2023 08:50:07 +0800
Message-Id: <20230824005007.2000525-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx5sxCqeZkUtRhAA--.20702S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFyxur1UZF1xWFyftF4xGrX_yoW8tFy8pr
 W7ZF1DKa18JrZxJ3ykJa45Xrn8Wr17Wr42qa12krWSkFsrXry8XF1vy34qvF98Za4rGFy2
 vF1rAa45XF48XabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Implement the callback for getting the architecture-dependent CPU
ID, the cpu ID is physical id described in ACPI MADT table, this
will be used for cpu hotplug.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---

v1->v2:
 remove unuseful changeid.

---
 hw/loongarch/virt.c    | 2 ++
 target/loongarch/cpu.c | 8 ++++++++
 target/loongarch/cpu.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e19b042ce8..6f6b577749 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -815,6 +815,8 @@ static void loongarch_init(MachineState *machine)
         cpu = cpu_create(machine->cpu_type);
         cpu->cpu_index = i;
         machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
+        lacpu = LOONGARCH_CPU(cpu);
+        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
     }
     fdt_add_cpu_nodes(lams);
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..7be3769672 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -690,6 +690,13 @@ static struct TCGCPUOps loongarch_tcg_ops = {
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
 
 static gchar *loongarch_gdb_arch_name(CPUState *cs)
@@ -715,6 +722,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
 #ifndef CONFIG_USER_ONLY
+    cc->get_arch_id = loongarch_cpu_get_arch_id;
     dc->vmsd = &vmstate_loongarch_cpu;
     cc->sysemu_ops = &loongarch_sysemu_ops;
 #endif
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fa371ca8ba..033081593c 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -371,6 +371,7 @@ struct ArchCPU {
     CPUNegativeOffsetState neg;
     CPULoongArchState env;
     QEMUTimer timer;
+    uint32_t  phy_id;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
-- 
2.27.0


