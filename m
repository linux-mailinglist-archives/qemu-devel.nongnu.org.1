Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E8750141
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:21:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJV37-000471-Ej; Wed, 12 Jul 2023 04:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV35-00045r-ET
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV33-0000Vb-Ri
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeZIiFiGg00bqejhACjdDAvGLL+LbrK7eHFvnGw23Sw=;
 b=P0WFzN+1pUdJg4rI9GG2ypUHze+rQoWxJswE8lnT4LH15J772na220SxwsR6I8kCgSBRXK
 PWh5QdcfVs9iLqY8XgemTO8FyoS/B9qvbG95/esQQINKFI/1YxQRkPFZgCvM49YlPHl4w1
 6ko6GXdpaD5tqLgrTPuYEw8xmNNFEZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-N_e1iAtaPHuKBf4UsUbaOg-1; Wed, 12 Jul 2023 04:18:03 -0400
X-MC-Unique: N_e1iAtaPHuKBf4UsUbaOg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1130D8EBBAA;
 Wed, 12 Jul 2023 08:18:03 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA767492C13;
 Wed, 12 Jul 2023 08:17:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [GIT PULL 04/21] hw/ppc/spapr: Use machine_memory_devices_init()
Date: Wed, 12 Jul 2023 10:17:33 +0200
Message-ID: <20230712081750.80852-5-david@redhat.com>
In-Reply-To: <20230712081750.80852-1-david@redhat.com>
References: <20230712081750.80852-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's use our new helper and stop always allocating ms->device_memory.
There is no difference in common memory-device code anymore between
ms->device_memory being NULL or the size being 0. So we only have to
teach spapr code that ms->device_memory isn't always around.

We can now modify two maxram_size checks to rely on ms->device_memory
for detecting whether we have memory devices.

Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230623124553.400585-5-david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c       | 37 +++++++++++++++++++------------------
 hw/ppc/spapr_hcall.c |  2 +-
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 54dbfd7fe9..1c8b8d57a7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -547,10 +547,8 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
                                 cpu_to_be32(lmb_size & 0xffffffff)};
     MemoryDeviceInfoList *dimms = NULL;
 
-    /*
-     * Don't create the node if there is no device memory
-     */
-    if (machine->ram_size == machine->maxram_size) {
+    /* Don't create the node if there is no device memory. */
+    if (!machine->device_memory) {
         return 0;
     }
 
@@ -860,16 +858,23 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
-    uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
-        memory_region_size(&MACHINE(spapr)->device_memory->mr);
     uint32_t lrdr_capacity[] = {
-        cpu_to_be32(max_device_addr >> 32),
-        cpu_to_be32(max_device_addr & 0xffffffff),
+        0,
+        0,
         cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE >> 32),
         cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
         cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
     };
 
+    /* Do we have device memory? */
+    if (MACHINE(spapr)->device_memory) {
+        uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
+            memory_region_size(&MACHINE(spapr)->device_memory->mr);
+
+        lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
+        lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
+    }
+
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
     /* hypertas */
@@ -2455,6 +2460,7 @@ static void spapr_create_lmb_dr_connectors(SpaprMachineState *spapr)
     uint32_t nr_lmbs = (machine->maxram_size - machine->ram_size)/lmb_size;
     int i;
 
+    g_assert(!nr_lmbs || machine->device_memory);
     for (i = 0; i < nr_lmbs; i++) {
         uint64_t addr;
 
@@ -2876,12 +2882,11 @@ static void spapr_machine_init(MachineState *machine)
     /* map RAM */
     memory_region_add_subregion(sysmem, 0, machine->ram);
 
-    /* always allocate the device memory information */
-    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
-
     /* initialize hotplug memory address space */
     if (machine->ram_size < machine->maxram_size) {
         ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
+        hwaddr device_mem_base;
+
         /*
          * Limit the number of hotpluggable memory slots to half the number
          * slots that KVM supports, leaving the other half for PCI and other
@@ -2900,12 +2905,8 @@ static void spapr_machine_init(MachineState *machine)
             exit(1);
         }
 
-        machine->device_memory->base = ROUND_UP(machine->ram_size,
-                                                SPAPR_DEVICE_MEM_ALIGN);
-        memory_region_init(&machine->device_memory->mr, OBJECT(spapr),
-                           "device-memory", device_mem_size);
-        memory_region_add_subregion(sysmem, machine->device_memory->base,
-                                    &machine->device_memory->mr);
+        device_mem_base = ROUND_UP(machine->ram_size, SPAPR_DEVICE_MEM_ALIGN);
+        machine_memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
     if (smc->dr_lmb_enabled) {
@@ -5119,7 +5120,7 @@ static bool phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
     int i;
 
     /* Do we have device memory? */
-    if (MACHINE(spapr)->maxram_size > ram_top) {
+    if (MACHINE(spapr)->device_memory) {
         /* Can't just use maxram_size, because there may be an
          * alignment gap between normal and device memory regions
          */
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 002ea0b7c1..9b1f225d4a 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -32,7 +32,7 @@ bool is_ram_address(SpaprMachineState *spapr, hwaddr addr)
     if (addr < machine->ram_size) {
         return true;
     }
-    if ((addr >= dms->base)
+    if (dms && (addr >= dms->base)
         && ((addr - dms->base) < memory_region_size(&dms->mr))) {
         return true;
     }
-- 
2.41.0


