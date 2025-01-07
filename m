Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4ECA035B0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Jan 2025 04:09:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUzxJ-00058R-4E; Mon, 06 Jan 2025 22:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tUzxG-00056R-1P
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 22:08:30 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tUzxC-0004c2-Ur
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 22:08:29 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxmeGmmnxnX_heAA--.59297S3;
 Tue, 07 Jan 2025 11:08:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxfcejmnxnn2gXAA--.35275S8;
 Tue, 07 Jan 2025 11:08:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 6/7] hw/intc/loongson_ipi: Add more output parameter for
 cpu_by_arch_id
Date: Tue,  7 Jan 2025 11:08:18 +0800
Message-Id: <20250107030819.90442-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250107030819.90442-1-maobibo@loongson.cn>
References: <20250107030819.90442-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxfcejmnxnn2gXAA--.35275S8
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

Add logic cpu index output parameter for function cpu_by_arch_id,
CPUState::cpu_index is logic cpu slot index for possible_cpus.
However it is logic cpu index with LoongsonIPICommonState::IPICore,
here hide access for CPUState::cpu_index directly, it comes from
function cpu_by_arch_id().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c               | 19 +++++++++++++++----
 hw/intc/loongson_ipi.c                | 23 ++++++++++++++++++++++-
 hw/intc/loongson_ipi_common.c         | 21 ++++++++++++---------
 include/hw/intc/loongson_ipi_common.h |  3 ++-
 4 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 41d9625dcb..515549e8a5 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -38,17 +38,28 @@ static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
     return found_cpu;
 }
 
-static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
+static int loongarch_cpu_by_arch_id(LoongsonIPICommonState *lics,
+                                    int64_t arch_id, int *index, CPUState **pcs)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     CPUArchId *archid;
+    CPUState *cs;
 
     archid = find_cpu_by_archid(machine, arch_id);
-    if (archid) {
-        return CPU(archid->cpu);
+    if (archid && archid->cpu) {
+        cs = archid->cpu;
+        if (index) {
+            *index = cs->cpu_index;
+        }
+
+        if (pcs) {
+            *pcs = cs;
+        }
+
+        return MEMTX_OK;
     }
 
-    return NULL;
+    return MEMTX_ERROR;
 }
 
 static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 29e92d48fd..d2268a27f8 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -20,6 +20,27 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
     return NULL;
 }
 
+static int loongson_cpu_by_arch_id(LoongsonIPICommonState *lics,
+                                   int64_t arch_id, int *index, CPUState **pcs)
+{
+    CPUState *cs;
+
+    cs = cpu_by_arch_id(arch_id);
+    if (cs == NULL) {
+        return MEMTX_ERROR;
+    }
+
+    if (index) {
+        *index = cs->cpu_index;
+    }
+
+    if (pcs) {
+        *pcs = cs;
+    }
+
+    return MEMTX_OK;
+}
+
 static const MemoryRegionOps loongson_ipi_core_ops = {
     .read_with_attrs = loongson_ipi_core_readl,
     .write_with_attrs = loongson_ipi_core_writel,
@@ -92,7 +113,7 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
                                       &lic->parent_unrealize);
     device_class_set_props(dc, loongson_ipi_properties);
     licc->get_iocsr_as = get_iocsr_as;
-    licc->cpu_by_arch_id = cpu_by_arch_id;
+    licc->cpu_by_arch_id = loongson_cpu_by_arch_id;
 }
 
 static const TypeInfo loongson_ipi_types[] = {
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index 363cddc54c..f5ab5024c0 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -103,16 +103,17 @@ static MemTxResult mail_send(LoongsonIPICommonState *ipi,
     uint32_t cpuid;
     hwaddr addr;
     CPUState *cs;
+    int cpu, ret;
 
     cpuid = extract32(val, 16, 10);
-    cs = licc->cpu_by_arch_id(cpuid);
-    if (cs == NULL) {
+    ret = licc->cpu_by_arch_id(ipi, cpuid, &cpu, &cs);
+    if (ret != MEMTX_OK) {
         return MEMTX_DECODE_ERROR;
     }
 
     /* override requester_id */
     addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
-    attrs.requester_id = cs->cpu_index;
+    attrs.requester_id = cpu;
     return send_ipi_data(ipi, cs, val, addr, attrs);
 }
 
@@ -123,16 +124,17 @@ static MemTxResult any_send(LoongsonIPICommonState *ipi,
     uint32_t cpuid;
     hwaddr addr;
     CPUState *cs;
+    int cpu, ret;
 
     cpuid = extract32(val, 16, 10);
-    cs = licc->cpu_by_arch_id(cpuid);
-    if (cs == NULL) {
+    ret = licc->cpu_by_arch_id(ipi, cpuid, &cpu, &cs);
+    if (ret != MEMTX_OK) {
         return MEMTX_DECODE_ERROR;
     }
 
     /* override requester_id */
     addr = val & 0xffff;
-    attrs.requester_id = cs->cpu_index;
+    attrs.requester_id = cpu;
     return send_ipi_data(ipi, cs, val, addr, attrs);
 }
 
@@ -146,6 +148,7 @@ MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr, uint64_t val,
     uint32_t cpuid;
     uint8_t vector;
     CPUState *cs;
+    int cpu, ret;
 
     addr &= 0xff;
     trace_loongson_ipi_write(size, (uint64_t)addr, val);
@@ -176,11 +179,11 @@ MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr, uint64_t val,
         cpuid = extract32(val, 16, 10);
         /* IPI status vector */
         vector = extract8(val, 0, 5);
-        cs = licc->cpu_by_arch_id(cpuid);
-        if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
+        ret = licc->cpu_by_arch_id(ipi, cpuid, &cpu, &cs);
+        if (ret != MEMTX_OK || cpu >= ipi->num_cpu) {
             return MEMTX_DECODE_ERROR;
         }
-        loongson_ipi_core_writel(&ipi->cpu[cs->cpu_index], CORE_SET_OFF,
+        loongson_ipi_core_writel(&ipi->cpu[cpu], CORE_SET_OFF,
                                  BIT(vector), 4, attrs);
         break;
     default:
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 4192f3d548..b587f9c571 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -46,7 +46,8 @@ struct LoongsonIPICommonClass {
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
     AddressSpace *(*get_iocsr_as)(CPUState *cpu);
-    CPUState *(*cpu_by_arch_id)(int64_t id);
+    int (*cpu_by_arch_id)(LoongsonIPICommonState *lics, int64_t id,
+                          int *index, CPUState **pcs);
 };
 
 MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
-- 
2.39.3


