Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDF17435F2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hd-0002GZ-G9; Fri, 30 Jun 2023 03:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hR-00027N-Sv
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:51 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hQ-0005Rz-1K
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:49 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b69e6cce7dso23719851fa.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110665; x=1690702665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zD7WAfiiRPEcVDryUR/zQvvkHlVUEwejF/uIZK/1fXo=;
 b=GTgbgU4wuMSLSCf01HhlN4x42O7wpg/+QFB+UucutI8d8eGk3XhpnxPFaS9rto4Nl2
 MCkwJkV+RzqEGrw8qHVZpntxR7V0Up15bPecEQydIJslIyRuKqr0Yuh767xyJpUPHBz1
 v9KTMRDK4gKibSZhXBtk1g1E5fj4nONubjJPOgM4v6zKqt+JYZC4PIW6DE8Al2bDSB3/
 fHf+1o0BAYr9X6MvdUMBkzLLqW/ArMaa1lMQFQ96wOaQsBWVA1KiIQ5+4XZjrHd9+zvT
 73CzJsY2GxKK7doq097Nlo47QU1cQT0f4ggjBwIZMSk0esnfFg2BshQjPgjpYX6lEETG
 LseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110665; x=1690702665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zD7WAfiiRPEcVDryUR/zQvvkHlVUEwejF/uIZK/1fXo=;
 b=MKFcVrlGnfdt5hUxOStrZJvP8LJ/V7hQzNxv+Fcr/DEhf0hlClunLgxuFn2TiZ/YZo
 keeZubd3Zr3DRxhQTTiM2Fiq+zMqSzBi0jNI1/iw/CxfhNaHhZigC7q3RcDWbRKZsUdB
 HexeFPvm7iKCvUo0dU5HaflreCF8yBxIlcS6KafmKwMkUR0/UPS6B72/5qjGnBhJALm6
 r+1nDRcgTz3QJskQOgRODnu+1e/uV7Cdlz9aOdd0SfeeMlWBJkIdieh6TnVAYdMnpd5T
 U6aXhK89iL4RgQvM92HXI9hyNcutiMPXNadMoAy1x41TX7AMeLLEniz0h6/QeZ+RccLE
 fN2Q==
X-Gm-Message-State: ABy/qLY4G6rhyt9Ea+M7sj/ybxSWtPUGr1Ron5vPHuRj/65gFICNOa9F
 vhqX88GOCIA0nCQmQVIa6FlYhQfN7lM=
X-Google-Smtp-Source: APBJJlGeJJql8TUkBGfNFmZUNb/l611P5R0BLd9ync1+GJimCNNMu0nB4bjjyVUs355+J6/tqrUL3A==
X-Received: by 2002:a2e:9b85:0:b0:2b6:c864:5d28 with SMTP id
 z5-20020a2e9b85000000b002b6c8645d28mr1518552lji.38.1688110665105; 
 Fri, 30 Jun 2023 00:37:45 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 16/17] hw/pci-host/i440fx: Resolve i440fx_init()
Date: Fri, 30 Jun 2023 09:37:19 +0200
Message-ID: <20230630073720.21297-17-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x235.google.com
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
 hw/i386/pc_piix.c            | 32 +++++++++++++++++++++-----------
 hw/pci-host/i440fx.c         | 33 +++++----------------------------
 3 files changed, 26 insertions(+), 49 deletions(-)

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
index c36783809f..62148d7636 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -126,7 +126,7 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
-    DeviceState *i440fx_host = NULL;
+    Object *phb = NULL;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -201,10 +201,9 @@ static void pc_init1(MachineState *machine,
         pci_memory = g_new(MemoryRegion, 1);
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
-        i440fx_host = qdev_new(host_type);
-        object_property_add_child(OBJECT(machine), "i440fx",
-                                  OBJECT(i440fx_host));
-        hole64_size = object_property_get_uint(OBJECT(i440fx_host),
+        phb = OBJECT(qdev_new(host_type));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
+        hole64_size = object_property_get_uint(phb,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                &error_abort);
     }
@@ -240,12 +239,23 @@ static void pc_init1(MachineState *machine,
         PIIX3State *piix3;
         PCIDevice *pci_dev;
 
-        pci_bus = i440fx_init(pci_type,
-                              i440fx_host,
-                              system_memory, system_io,
-                              x86ms->below_4g_mem_size,
-                              x86ms->above_4g_mem_size,
-                              pci_memory, ram_memory);
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
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE,
+                                pci_type, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
         pci_bus_map_irqs(pci_bus,
                          xen_enabled() ? xen_pci_slot_get_pirq
                                        : pc_pci_slot_get_pirq);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index c458987405..62d6287681 100644
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
@@ -262,36 +267,10 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
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
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_create_simple(b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
@@ -335,8 +314,6 @@ PCIBus *i440fx_init(const char *pci_type,
     d->config[I440FX_COREBOOT_RAM_SIZE] = ram_size;
 
     i440fx_update_memory_mappings(f);
-
-    return b;
 }
 
 static void i440fx_class_init(ObjectClass *klass, void *data)
-- 
2.41.0


