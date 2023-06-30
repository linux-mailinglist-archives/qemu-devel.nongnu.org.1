Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B90957435F1
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hi-0002U9-Ry; Fri, 30 Jun 2023 03:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hS-00027P-9M
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:51 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hQ-0005SC-IA
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:50 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b69f1570b2so25193951fa.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110666; x=1690702666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOf3K5c1LYvFQTKfHh34pmRh6PTnzPVYs2BYazeElIQ=;
 b=p3ze413PffepApOROqKyYZbU9VUS2YrMe0Vku/UIGpCJvfpG73SOqcxEEufrqTG8OF
 3Srvf6A2lsrsq2YkczhiZ+qp0Dsyb9GKxHs76oKmlbi5N7RvoImqRjOMy/sOqNEVZOmr
 OPd2NWlvj2YRU3mPriCCyPB54cRzuUcDMWcJLxSxcTs3ZFSll3zhNn+forCxETIxWRrS
 0udm14CHXIrxskAdI0A0hz0/zzrmtl0UxoWwsriWNVQIkeShbwUNxDkAyCOdv+0N6Ot5
 ysrIiGzhRXx98M8HKuc5bSErf0qVCAq1cZIZXtQoY6175AGgXyI+D/Rkd/IlFhHeYYbr
 ik1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110666; x=1690702666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOf3K5c1LYvFQTKfHh34pmRh6PTnzPVYs2BYazeElIQ=;
 b=eiOziRhEViJMeQI8GTAzPEIYDFRYz6ci/D1RlNXLfy1lVa4tvG8pRN6j7hl8rBhwyn
 MQyi3ZnEwy73o2toSSMdxAdmsMH0HIviVovpBGoJ0YAV662NAqte2vnH1ARCdnev4cbB
 /PYNJSE5eU1gwvnqMy+7Ck8ahrGghP80Iq1t8C/g+jDuLPhzpx/UX7Zv8idwnfXWGrH0
 zu6M8/YY66XKDjElnOZmIlehlkcKg3AXG7hlJvnqpwIRvpqVAIevb90nausvqkLtz4iU
 J+rCrzydRcwFk53VxErEQp4Rsz0b5UF8mZ2I9men52Y12QMrX6k7SSww99ZPuZzUL4yW
 wurw==
X-Gm-Message-State: ABy/qLY0bzxVGFT1XTWGKDLgC1mE5gP+BAHs44Zn8M7aesSXS2HuMHG0
 AtEOVqwk1u8dolCjVv4FNxMy/G1Y4ws=
X-Google-Smtp-Source: APBJJlE8p3ihtVR/oeVHM6IgahlZ4SDrNm2LssCZ9kzuL+QwCNPb9A3s91sqVXNNKZ8yg431SMYPiA==
X-Received: by 2002:a2e:918f:0:b0:2b6:9ed2:f61c with SMTP id
 f15-20020a2e918f000000b002b69ed2f61cmr1335104ljg.7.1688110666297; 
 Fri, 30 Jun 2023 00:37:46 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/17] hw/i386/pc_piix: Move i440fx' realize near its
 qdev_new()
Date: Fri, 30 Jun 2023 09:37:20 +0200
Message-ID: <20230630073720.21297-18-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

I440FX realization is currently mixed with PIIX3 creation. Furthermore, it is
common practice to only set properties between a device's qdev_new() and
qdev_realize(). Clean up to resolve both issues.

Since I440FX spawns a PCI bus let's also move the pci_bus initialization there.

Note that when running `qemu-system-x86_64 -M pc -S` before and after this
patch, `info mtree` in the QEMU console doesn't show any differences except that
the ordering is different.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 51 ++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 62148d7636..b18443d3df 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -114,7 +114,7 @@ static void pc_init1(MachineState *machine,
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    PCIBus *pci_bus;
+    PCIBus *pci_bus = NULL;
     ISABus *isa_bus;
     int piix3_devfn = -1;
     qemu_irq smi_irq;
@@ -126,7 +126,6 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
-    Object *phb = NULL;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -198,11 +197,36 @@ static void pc_init1(MachineState *machine,
     }
 
     if (pcmc->pci_enabled) {
+        Object *phb;
+
         pci_memory = g_new(MemoryRegion, 1);
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
+
         phb = OBJECT(qdev_new(host_type));
         object_property_add_child(OBJECT(machine), "i440fx", phb);
+        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                                &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pci_bus,
+                         xen_enabled() ? xen_pci_slot_get_pirq
+                                       : pc_pci_slot_get_pirq);
+        pcms->bus = pci_bus;
+
         hole64_size = object_property_get_uint(phb,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                &error_abort);
@@ -239,28 +263,6 @@ static void pc_init1(MachineState *machine,
         PIIX3State *piix3;
         PCIDevice *pci_dev;
 
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE,
-                                pci_type, &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pci_bus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-        pcms->bus = pci_bus;
-
         pci_dev = pci_create_simple_multifunction(pci_bus, -1, true,
                                                   TYPE_PIIX3_DEVICE);
 
@@ -285,7 +287,6 @@ static void pc_init1(MachineState *machine,
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
                                                              "rtc"));
     } else {
-        pci_bus = NULL;
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
 
-- 
2.41.0


