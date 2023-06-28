Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209174190B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDQ-0004m0-3s; Wed, 28 Jun 2023 15:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDO-0004lY-3G
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:34 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDM-0005ki-B7
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:33 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-991c786369cso23591066b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981951; x=1690573951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuZVGOxAdERUIbSNFIHqfH0CMoojuSo58L7TfE1HkoU=;
 b=H38jqLkdOVLCAUiqIUZOfzr7ditKus67r8uMLTb3RNT1oYdu7zm1AUYtDChBZmSSRa
 3SVuGbCO5fnBlybbNVTkfbSas7y6/RAy2ZFymtKsiTV9504UD4jIl/0fqnTf1duCEDSO
 fWCdb3HCVXHxU8qu8y29LnGC/kKIuEbhTHXAEO8qETMMXUtmZ3KH7OqBHIk1XV/MsTON
 0T/kDTxkCpsJNHs+f/y5vQX6UoKIo3uKcZ+eBct088+BVmSXbCARqSTdkQgx7UpcBCPO
 3+UQQ1Jd0Sq6/uJ1JPj9kWAL0H/oAQOYVrhNfIVI0TRlg8O4hVpwCUvjnIbaKdHA2en3
 F3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981951; x=1690573951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuZVGOxAdERUIbSNFIHqfH0CMoojuSo58L7TfE1HkoU=;
 b=dqnhWiqHhB1s7ohBuc3q32n3xwxhRrYRq82sskCjMlapVIeUkwFV5J+edE3KOTnqpX
 sk36jf1HgN5lyf0sBydO5dezYKGsHEG9z50l00AArafLLF+ophRiv2tH1607ivEElJ+2
 Hp9vT54bvuVTVghv7yT+MpEz8s4NXGDZ2IJh+hoVpsKXY3dNEatPro0jjL1c2pzsMm86
 nGJLfvu/f2pR+5icqtXsmkXSwoKQOD88sBIY2e6qp3uL8p7r9Ksb1OBbYwy3jiBii3Bq
 JNLOawc3J8MAiz8E0XTa0ou63ETK4XFN/ip5884TbyZeeMODL7i/MiXT31AmGvJcS2n4
 1owA==
X-Gm-Message-State: AC+VfDwIDldbJbWcI6ag0aIdzi4jhH7+jC5d/NoOzfrq9lYqTzy0zIwc
 sZZKHeYRmHLd7wXzHoqk0v5cj+NARp0=
X-Google-Smtp-Source: ACHHUZ5/7G/5+vha9GIQqJbK8Qx4sUtUiP910aKgaiWhIv9EEVMmh2FS86wL6GRvWsBCLT9SC7+6Ag==
X-Received: by 2002:a17:907:72c7:b0:98c:e72c:6b83 with SMTP id
 du7-20020a17090772c700b0098ce72c6b83mr18037098ejc.45.1687981950760; 
 Wed, 28 Jun 2023 12:52:30 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:30 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/16] hw/i386/pc_piix: Move i440fx' realize near its
 qdev_new()
Date: Wed, 28 Jun 2023 21:52:04 +0200
Message-ID: <20230628195204.1241-17-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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
 hw/i386/pc_piix.c | 57 ++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d07218a8c9..b18443d3df 100644
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
-    Object *i440fx_host = NULL;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -198,11 +197,37 @@ static void pc_init1(MachineState *machine,
     }
 
     if (pcmc->pci_enabled) {
+        Object *phb;
+
         pci_memory = g_new(MemoryRegion, 1);
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
-        i440fx_host = OBJECT(qdev_new(host_type));
-        hole64_size = object_property_get_uint(i440fx_host,
+
+        phb = OBJECT(qdev_new(host_type));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
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
+        hole64_size = object_property_get_uint(phb,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                &error_abort);
     }
@@ -238,29 +263,6 @@ static void pc_init1(MachineState *machine,
         PIIX3State *piix3;
         PCIDevice *pci_dev;
 
-        object_property_add_child(OBJECT(machine), "i440fx", i440fx_host);
-        object_property_set_link(i440fx_host, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(i440fx_host, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(i440fx_host, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(i440fx_host, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(i440fx_host, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(i440fx_host, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(i440fx_host, I440FX_HOST_PROP_PCI_TYPE,
-                                pci_type, &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(i440fx_host), &error_fatal);
-
-        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(i440fx_host), "pci.0"));
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


