Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8645BA13127
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 03:19:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYFS4-0004cn-38; Wed, 15 Jan 2025 21:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYFS1-0004br-33
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:42 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYFRy-0006DF-IA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:40 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxG6xAbIhngzJkAA--.10997S3;
 Thu, 16 Jan 2025 10:17:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx+8QnbIhnhWokAA--.14648S10;
 Thu, 16 Jan 2025 10:17:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PULL 8/8] hw/intc/loongarch_ipi: Use alternative implemation for
 cpu_by_arch_id
Date: Thu, 16 Jan 2025 10:17:10 +0800
Message-Id: <20250116021710.251648-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250116021710.251648-1-maobibo@loongson.cn>
References: <20250116021710.251648-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx+8QnbIhnhWokAA--.14648S10
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

There is arch_id and CPUState pointer in IPICore object. With function
cpu_by_arch_id() it can be implemented by parsing IPICore array inside,
rather than possible_cpus array.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 515549e8a5..5376f1e084 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -17,43 +17,29 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
     return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
 }
 
-static int archid_cmp(const void *a, const void *b)
+static int loongarch_ipi_cmp(const void *a, const void *b)
 {
-   CPUArchId *archid_a = (CPUArchId *)a;
-   CPUArchId *archid_b = (CPUArchId *)b;
+   IPICore *ipi_a = (IPICore *)a;
+   IPICore *ipi_b = (IPICore *)b;
 
-   return archid_a->arch_id - archid_b->arch_id;
-}
-
-static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
-{
-    CPUArchId apic_id, *found_cpu;
-
-    apic_id.arch_id = id;
-    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
-                        ms->possible_cpus->len,
-                        sizeof(*ms->possible_cpus->cpus),
-                        archid_cmp);
-
-    return found_cpu;
+   return ipi_a->arch_id - ipi_b->arch_id;
 }
 
 static int loongarch_cpu_by_arch_id(LoongsonIPICommonState *lics,
                                     int64_t arch_id, int *index, CPUState **pcs)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
-    CPUArchId *archid;
-    CPUState *cs;
+    IPICore ipi, *found;
 
-    archid = find_cpu_by_archid(machine, arch_id);
-    if (archid && archid->cpu) {
-        cs = archid->cpu;
+    ipi.arch_id = arch_id;
+    found = bsearch(&ipi, lics->cpu, lics->num_cpu, sizeof(IPICore),
+                    loongarch_ipi_cmp);
+    if (found && found->cpu) {
         if (index) {
-            *index = cs->cpu_index;
+            *index = found - lics->cpu;
         }
 
         if (pcs) {
-            *pcs = cs;
+            *pcs = found->cpu;
         }
 
         return MEMTX_OK;
-- 
2.43.5


