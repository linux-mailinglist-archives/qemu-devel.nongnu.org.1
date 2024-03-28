Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9F87E4A3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Mar 2024 09:02:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7w9-0003gV-QK; Mon, 18 Mar 2024 04:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rm7w8-0003fF-3u
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:01:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rm7w3-0001SM-1t
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:01:34 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXevT9PdlVUAaAA--.63095S3;
 Mon, 18 Mar 2024 16:01:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx8OTR9PdliWtcAA--.46553S3; 
 Mon, 18 Mar 2024 16:01:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/loongarch: Refine acpi srat table for numa memory
Date: Mon, 18 Mar 2024 16:01:17 +0800
Message-Id: <20240318080121.2836548-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240318080121.2836548-1-maobibo@loongson.cn>
References: <20240318080121.2836548-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx8OTR9PdliWtcAA--.46553S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

One LoongArch virt machine platform, there is limitation for memory
map information. The minimum memory size is 256M and minimum memory
size for numa node0 is 256M also. With qemu numa qtest, it is possible
that memory size of numa node0 is 128M.

Limitations for minimum memory size for both total memory and numa
node0 is removed for acpi srat table creation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/acpi-build.c | 58 +++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index e5ab1080af..d0247d93ee 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -165,8 +165,9 @@ static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
     int i, arch_id, node_id;
-    uint64_t mem_len, mem_base;
-    int nb_numa_nodes = machine->numa_state->num_nodes;
+    hwaddr len, base, gap;
+    NodeInfo *numa_info;
+    int nodes, nb_numa_nodes = machine->numa_state->num_nodes;
     LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(lams);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
@@ -195,35 +196,44 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
     }
 
-    /* Node0 */
-    build_srat_memory(table_data, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE,
-                      0, MEM_AFFINITY_ENABLED);
-    mem_base = VIRT_HIGHMEM_BASE;
-    if (!nb_numa_nodes) {
-        mem_len = machine->ram_size - VIRT_LOWMEM_SIZE;
-    } else {
-        mem_len = machine->numa_state->nodes[0].node_mem - VIRT_LOWMEM_SIZE;
+    base = VIRT_LOWMEM_BASE;
+    gap = VIRT_LOWMEM_SIZE;
+    numa_info = machine->numa_state->nodes;
+    nodes = nb_numa_nodes;
+    if (!nodes) {
+        nodes = 1;
     }
-    if (mem_len)
-        build_srat_memory(table_data, mem_base, mem_len, 0, MEM_AFFINITY_ENABLED);
-
-    /* Node1 - Nodemax */
-    if (nb_numa_nodes) {
-        mem_base += mem_len;
-        for (i = 1; i < nb_numa_nodes; ++i) {
-            if (machine->numa_state->nodes[i].node_mem > 0) {
-                build_srat_memory(table_data, mem_base,
-                                  machine->numa_state->nodes[i].node_mem, i,
-                                  MEM_AFFINITY_ENABLED);
-                mem_base += machine->numa_state->nodes[i].node_mem;
-            }
+
+    for (i = 0; i < nodes; i++) {
+        if (nb_numa_nodes) {
+            len = numa_info[i].node_mem;
+        } else {
+            len = machine->ram_size;
+        }
+
+        /*
+         * memory for the node splited into two part
+         *   lowram:  [base, +gap)
+         *   highram: [VIRT_HIGHMEM_BASE, +(len - gap))
+         */
+        if (len >= gap) {
+            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
+            len -= gap;
+            base = VIRT_HIGHMEM_BASE;
+            gap = machine->ram_size - VIRT_LOWMEM_SIZE;
+        }
+
+        if (len) {
+            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
+            base += len;
+            gap  -= len;
         }
     }
 
     if (machine->device_memory) {
         build_srat_memory(table_data, machine->device_memory->base,
                           memory_region_size(&machine->device_memory->mr),
-                          nb_numa_nodes - 1,
+                          nodes - 1,
                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
     }
 
-- 
2.39.3


