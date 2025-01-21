Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5EFA17D99
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Jan 2025 13:11:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taD5i-0002IY-Gy; Tue, 21 Jan 2025 07:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1taD5f-0002AG-83
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:10:43 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1taD5c-0007Pg-Pe
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:10:42 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxYa+6jo9nMMNmAA--.5599S3;
 Tue, 21 Jan 2025 20:10:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxrcW4jo9nQ9ApAA--.26988S4;
 Tue, 21 Jan 2025 20:10:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/loongarch/virt: Remove unused ipistate
Date: Tue, 21 Jan 2025 20:10:31 +0800
Message-Id: <20250121121032.475235-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250121121032.475235-1-maobibo@loongson.cn>
References: <20250121121032.475235-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxrcW4jo9nQ9ApAA--.26988S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Field ipistate in LoongArch CPU object is not used any more,
remove it here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c    | 5 -----
 target/loongarch/cpu.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 15022505c7..97c7da4815 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -848,8 +848,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     DeviceState *pch_pic, *pch_msi, *cpudev;
     DeviceState *ipi, *extioi;
     SysBusDevice *d;
-    LoongArchCPU *lacpu;
-    CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
 
@@ -910,12 +908,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpu_state = qemu_get_cpu(cpu);
         cpudev = DEVICE(cpu_state);
-        lacpu = LOONGARCH_CPU(cpu_state);
-        env = &(lacpu->env);
 
         /* connect ipi irq to cpu irq */
         qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
-        env->ipistate = ipi;
     }
 
     /* Create EXTIOI device */
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8eee49a984..f2a23b7a43 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -385,8 +385,6 @@ typedef struct CPUArchState {
     bool load_elf;
     uint64_t elf_address;
     uint32_t mp_state;
-    /* Store ipistate to access from this struct */
-    DeviceState *ipistate;
 
     struct loongarch_boot_info *boot_info;
 #endif
-- 
2.39.3


