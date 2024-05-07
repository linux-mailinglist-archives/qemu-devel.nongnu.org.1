Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7568BD9DD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 May 2024 05:50:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Bpp-0004mH-1M; Mon, 06 May 2024 23:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s4Bpj-0004kh-31
 for qemu-devel@nongnu.org; Mon, 06 May 2024 23:49:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s4BpQ-0003PA-RB
 for qemu-devel@nongnu.org; Mon, 06 May 2024 23:49:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxtOqzpDlmn6kIAA--.11384S3;
 Tue, 07 May 2024 11:49:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxrlexpDlmi4sTAA--.33863S6; 
 Tue, 07 May 2024 11:49:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] hw/loongarch: Refine system dram memory region
Date: Tue,  7 May 2024 11:49:02 +0800
Message-Id: <20240507034904.2391129-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240507034904.2391129-1-maobibo@loongson.cn>
References: <20240507034904.2391129-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrlexpDlmi4sTAA--.33863S6
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

For system dram memory region, it is not necessary to use numa node
information. There is only low memory region and high memory region.

Remove numa node information for ddr memory region here, it can reduce
memory region number about LoongArch virt machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 55 ++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index aca8290795..5abfe0a9d7 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -974,18 +974,13 @@ static void loongarch_init(MachineState *machine)
 {
     LoongArchCPU *lacpu;
     const char *cpu_model = machine->cpu_type;
-    ram_addr_t offset = 0;
-    ram_addr_t ram_size = machine->ram_size;
-    uint64_t highram_size = 0, phyAddr = 0;
     MemoryRegion *address_space_mem = get_system_memory();
     LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
-    int nb_numa_nodes = machine->numa_state->num_nodes;
-    NodeInfo *numa_info = machine->numa_state->nodes;
     int i;
+    hwaddr base, size, ram_size = machine->ram_size;
     const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUState *cpu;
-    char *ramName = NULL;
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -1020,41 +1015,27 @@ static void loongarch_init(MachineState *machine)
     fdt_add_memory_nodes(machine);
     fw_cfg_add_memory(machine);
 
-    /* Node0 memory */
-    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.node0.lowram",
-                             machine->ram, offset, VIRT_LOWMEM_SIZE);
-    memory_region_add_subregion(address_space_mem, phyAddr, &lams->lowmem);
-
-    offset += VIRT_LOWMEM_SIZE;
-    if (nb_numa_nodes > 0) {
-        assert(numa_info[0].node_mem > VIRT_LOWMEM_SIZE);
-        highram_size = numa_info[0].node_mem - VIRT_LOWMEM_SIZE;
-    } else {
-        highram_size = ram_size - VIRT_LOWMEM_SIZE;
+    size = ram_size;
+    base = VIRT_LOWMEM_BASE;
+    if (size > VIRT_LOWMEM_SIZE) {
+        size = VIRT_LOWMEM_SIZE;
     }
-    phyAddr = VIRT_HIGHMEM_BASE;
-    memory_region_init_alias(&lams->highmem, NULL, "loongarch.node0.highram",
-                              machine->ram, offset, highram_size);
-    memory_region_add_subregion(address_space_mem, phyAddr, &lams->highmem);
-
-    /* Node1 - Nodemax memory */
-    offset += highram_size;
-    phyAddr += highram_size;
-
-    for (i = 1; i < nb_numa_nodes; i++) {
-        MemoryRegion *nodemem = g_new(MemoryRegion, 1);
-        ramName = g_strdup_printf("loongarch.node%d.ram", i);
-        memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
-                                 offset,  numa_info[i].node_mem);
-        memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
-        offset += numa_info[i].node_mem;
-        phyAddr += numa_info[i].node_mem;
+
+    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.lowram",
+                              machine->ram, base, size);
+    memory_region_add_subregion(address_space_mem, base, &lams->lowmem);
+    base += size;
+    if (ram_size - size) {
+        base = VIRT_HIGHMEM_BASE;
+        memory_region_init_alias(&lams->highmem, NULL, "loongarch.highram",
+                machine->ram, VIRT_LOWMEM_BASE + size, ram_size - size);
+        memory_region_add_subregion(address_space_mem, base, &lams->highmem);
+        base += ram_size - size;
     }
 
     /* initialize device memory address space */
     if (machine->ram_size < machine->maxram_size) {
         ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
-        hwaddr device_mem_base;
 
         if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
             error_report("unsupported amount of memory slots: %"PRIu64,
@@ -1068,9 +1049,7 @@ static void loongarch_init(MachineState *machine)
                          "%d bytes", TARGET_PAGE_SIZE);
             exit(EXIT_FAILURE);
         }
-        /* device memory base is the top of high memory address. */
-        device_mem_base = ROUND_UP(VIRT_HIGHMEM_BASE + highram_size, 1 * GiB);
-        machine_memory_devices_init(machine, device_mem_base, device_mem_size);
+        machine_memory_devices_init(machine, base, device_mem_size);
     }
 
     /* load the BIOS image. */
-- 
2.39.3


