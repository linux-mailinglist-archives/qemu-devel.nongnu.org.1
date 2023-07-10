Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8E74E1C7
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvb-0007wM-Qa; Mon, 10 Jul 2023 19:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvM-0007bb-Be
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvK-0004S5-JR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDsngXzPd9VZYax82YGMdxQV4ZtCon0fLLMZ+kNSXk4=;
 b=L84CLY1uHm9G7yLNJ0YcFUJPWUHjyOpD9V5oTsaSGSg4Uo1sdx923aNbY7lwdYdJ6AGeJ3
 GI7NpL9aT+K5RBUKjyoEtshM5JuJ6TS8bRXZrkD+2/8XQy/Z4YKlaykcWDVRuhqugHalDp
 946djv1Mr+toMQblIO+8BbMjScGvag4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-K6Ud5p4IO2ODyLtPZlJ8OA-1; Mon, 10 Jul 2023 19:04:04 -0400
X-MC-Unique: K6Ud5p4IO2ODyLtPZlJ8OA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31400956ce8so2831826f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030243; x=1691622243;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDsngXzPd9VZYax82YGMdxQV4ZtCon0fLLMZ+kNSXk4=;
 b=FaPgS7e2JkmDr+29XWY/bjxHTZuSsBox8JwLa7iqTvf+hayq0eLzRDOWLx6lnHy6pP
 kGKs11zAocaRZgvtValM6duu2PGWxtsTWKR4IFYATX5hiHEW/5v05DR1m2YK0sZ9ywrn
 fa1DW4b4sqZahCn1HuhqFTLL/uy1yIAeisrX3GSMMtqbNY2atnSRBd70zL7D17BWpqNn
 WGYli8WHBvq+cqgZDTIUtUZ8pjgu3HA67HC3rL1kZCxiWwMPwihpNAah0uwp4rQ/ZKD/
 p9zW9/kejShv/SqoWUuBY1BQNvU58Xz8nlA4wuvxcP5WPCGn5YXug/amFAzkoB7cL3ag
 kWVg==
X-Gm-Message-State: ABy/qLYflx6bLDjWcYVad6p7Vl5YDbLIAAz886Okr2XAWPqpJpGX5ek5
 litj+kcqjOltusAoS1mWGq+C9hS7vArs2zAyYJ3eg1o5ECSNfQhQ46i0GcjIrqDUHDbVm1nfOEI
 47BfeKCXFfG4P3QSbmoojdmhY298jIr/LQvE7g0a0+FpdPNUXE2c/ZQECeERkSqVPrFBn
X-Received: by 2002:a05:6000:90c:b0:313:f7f1:e34c with SMTP id
 cw12-20020a056000090c00b00313f7f1e34cmr12258393wrb.60.1689030242803; 
 Mon, 10 Jul 2023 16:04:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE81g+A0MkRNx36mzwke2+8jPDXlL+at2ea1JqO+zxMQ3KuwXAutVNZ+NolOGgxV+BJ+qUiZw==
X-Received: by 2002:a05:6000:90c:b0:313:f7f1:e34c with SMTP id
 cw12-20020a056000090c00b00313f7f1e34cmr12258371wrb.60.1689030242536; 
 Mon, 10 Jul 2023 16:04:02 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 z13-20020adfe54d000000b003143ac73fd0sm617119wrm.1.2023.07.10.16.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:02 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 33/66] hw/i386/pc_piix: Move i440fx' realize near its qdev_new()
Message-ID: <c589f7cf0860534dfd21023dec2ec322688a5a03.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Bernhard Beschow <shentey@gmail.com>

I440FX realization is currently mixed with PIIX3 creation. Furthermore, it is
common practice to only set properties between a device's qdev_new() and
qdev_realize(). Clean up to resolve both issues.

Since I440FX spawns a PCI bus let's also move the pci_bus initialization there.

Note that when running `qemu-system-x86_64 -M pc -S` before and after this
patch, `info mtree` in the QEMU console doesn't show any differences except that
the ordering is different.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-18-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


