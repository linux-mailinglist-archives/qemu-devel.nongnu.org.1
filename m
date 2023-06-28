Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6674191B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDN-0004lI-Oo; Wed, 28 Jun 2023 15:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDL-0004km-Mp
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDJ-0005kP-V5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:31 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-98d34f1e54fso20555266b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981948; x=1690573948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAuySTnUlRMKcQIw8Nf4jgD5dpIo9GmxLU1PU0Ah2h8=;
 b=kv9Z6o2Pa/eQMUJKSX9/22f3Pwdwbwinvvjp07jkKUFHNCF8OrgAds34bPYBjKFSIs
 x84a6OOBYa0Ru04vHAoQfv6rDqf2rj8IrzJQQ9GoURTXAB9AWrVhbCrZK1DVBstfz7Ih
 gE4dspizdO94G/2Ti81lfgESF55IK+o9uY7ZALw3WNMFxpmC8Xal+6mn3CqmLsciZgnO
 KRYd2emvqfZ7W1aAGSKWyyGns+bupngFKthY4El0V7rwr6VFkQd3sdy5+6PUS9TYTNxJ
 UWsi5pSWlz/B3cLAHokhDCkSS++Jetbx1Pl/X1AuqzfnJXl1rDDRYQjc/+2WDaM4M7Sl
 rV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981948; x=1690573948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PAuySTnUlRMKcQIw8Nf4jgD5dpIo9GmxLU1PU0Ah2h8=;
 b=WADtLR2GSOIxs5qCc/okwX/d0ufYVCgmMGqMKroAA1iHHyk+md7a5GrVk6cGIVPOiw
 dyVYaJOCKbSBSh0GUrLqnv+cxcgPXYp0Y1yg+1pFSjIVEQAunEj+CIOGqmu6YDnKE7gk
 5ZUAE3pE996L01msoacu8fgWOsx6ERYZeS63RzoxjVMQ0A2VJpiP2lYLR/I44u4PiXBg
 GrbBd+3q4qRE/Zr+XRWQ8pom8rHxM/eX3aP8rg/Yedfs2TzCxaP7OhDPyrFmS01mqubR
 t22Xejc1u6Qb3/WIWS5cNsq2jO58IMWfwWK57qgZLUIAb+jJzrvn4FiMZ5/FRApiHIfM
 2ckw==
X-Gm-Message-State: AC+VfDyJ+mXcC5X6O7GuLIGfN704fRoWVgJ2ZNVmn/YzSMzFZQPz33Ar
 cnIsIF0WDZxm1C/l1drlN8i9Ev95wB4=
X-Google-Smtp-Source: ACHHUZ4qTrKQapL480apX6W3KEZ9QUyhUZajTvGneQrEezpY8PVhNdiC+8TnNXAEj3x59ToL9p+CGQ==
X-Received: by 2002:a17:907:7f16:b0:992:1233:9c45 with SMTP id
 qf22-20020a1709077f1600b0099212339c45mr5084249ejc.69.1687981948303; 
 Wed, 28 Jun 2023 12:52:28 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:27 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 14/16] hw/pci-host/i440fx: Resolve i440fx_init()
Date: Wed, 28 Jun 2023 21:52:02 +0200
Message-ID: <20230628195204.1241-15-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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

i440fx_init() is a legacy init function. The previous patches worked towards
TYPE_I440FX_PCI_HOST_BRIDGE to be instantiated the QOM way. Do this now by
transforming the parameters passed to i440fx_init() into property assignments.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/i440fx.h | 10 ----------
 hw/i386/pc_piix.c            | 30 +++++++++++++++++++++---------
 hw/pci-host/i440fx.c         | 34 +++++-----------------------------
 3 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index 2d7bae5a45..c988f70890 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -34,14 +34,4 @@ struct PCII440FXState {
 
 #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
 
-PCIBus *i440fx_init(const char *pci_type,
-                    DeviceState *dev,
-                    MemoryRegion *address_space_mem,
-                    MemoryRegion *address_space_io,
-                    ram_addr_t below_4g_mem_size,
-                    ram_addr_t above_4g_mem_size,
-                    MemoryRegion *pci_memory,
-                    MemoryRegion *ram_memory);
-
-
 #endif
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 87bee368fc..1df309b8e2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -126,7 +126,7 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *rom_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size;
-    DeviceState *i440fx_host;
+    Object *i440fx_host;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -201,8 +201,8 @@ static void pc_init1(MachineState *machine,
         pci_memory = g_new(MemoryRegion, 1);
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
-        i440fx_host = qdev_new(host_type);
-        hole64_size = object_property_get_uint(OBJECT(i440fx_host),
+        i440fx_host = OBJECT(qdev_new(host_type));
+        hole64_size = object_property_get_uint(i440fx_host,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                &error_abort);
     } else {
@@ -243,12 +243,24 @@ static void pc_init1(MachineState *machine,
         PIIX3State *piix3;
         PCIDevice *pci_dev;
 
-        pci_bus = i440fx_init(pci_type,
-                              i440fx_host,
-                              system_memory, system_io,
-                              x86ms->below_4g_mem_size,
-                              x86ms->above_4g_mem_size,
-                              pci_memory, ram_memory);
+        object_property_add_child(OBJECT(machine), "i440fx", i440fx_host);
+        object_property_set_link(i440fx_host, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(i440fx_host, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(i440fx_host, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(i440fx_host, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(i440fx_host, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(i440fx_host, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(i440fx_host, I440FX_HOST_PROP_PCI_TYPE,
+                                pci_type, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(i440fx_host), &error_fatal);
+
+        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(i440fx_host), "pci.0"));
         pci_bus_map_irqs(pci_bus,
                          xen_enabled() ? xen_pci_slot_get_pirq
                                        : pc_pci_slot_get_pirq);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e8e66afc11..62d6287681 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -249,9 +249,14 @@ static void i440fx_pcihost_initfn(Object *obj)
 
 static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     I440FXState *s = I440FX_PCI_HOST_BRIDGE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    PCIBus *b;
+    PCIDevice *d;
+    PCII440FXState *f;
+    unsigned i;
 
     memory_region_add_subregion(s->io_memory, 0xcf8, &phb->conf_mem);
     sysbus_init_ioports(sbd, 0xcf8, 4);
@@ -262,37 +267,10 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
     /* register i440fx 0xcf8 port as coalesced pio */
     memory_region_set_flush_coalesced(&phb->data_mem);
     memory_region_add_coalescing(&phb->conf_mem, 0, 4);
-}
-
-PCIBus *i440fx_init(const char *pci_type,
-                    DeviceState *dev,
-                    MemoryRegion *address_space_mem,
-                    MemoryRegion *address_space_io,
-                    ram_addr_t below_4g_mem_size,
-                    ram_addr_t above_4g_mem_size,
-                    MemoryRegion *pci_address_space,
-                    MemoryRegion *ram_memory)
-{
-    I440FXState *s = I440FX_PCI_HOST_BRIDGE(dev);
-    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
-    PCIBus *b;
-    PCIDevice *d;
-    PCII440FXState *f;
-    unsigned i;
-
-    s->system_memory = address_space_mem;
-    s->io_memory = address_space_io;
-    s->pci_address_space = pci_address_space;
-    s->ram_memory = ram_memory;
-    s->below_4g_mem_size = below_4g_mem_size;
-    s->above_4g_mem_size = above_4g_mem_size;
-    s->pci_type = (char *)pci_type;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          s->io_memory, 0, TYPE_PCI_BUS);
     phb->bus = b;
-    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_create_simple(b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
@@ -336,8 +314,6 @@ PCIBus *i440fx_init(const char *pci_type,
     d->config[I440FX_COREBOOT_RAM_SIZE] = ram_size;
 
     i440fx_update_memory_mappings(f);
-
-    return b;
 }
 
 static void i440fx_class_init(ObjectClass *klass, void *data)
-- 
2.41.0


