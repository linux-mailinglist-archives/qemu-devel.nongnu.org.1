Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9372B167
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IPG-0006Xc-9u; Sun, 11 Jun 2023 06:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP7-0006W3-CH
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:37 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP5-0008Lg-MH
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:37 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5149429c944so5841740a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479674; x=1689071674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJFPbZLf8D9w89pWTQhfns3YXPPzXmXhSuGo7GoNoZU=;
 b=Gn1WlHEnzxDyU1tyExlg4wlEBYukdZ2uNHXRVsfqXqSB/y0wBI37F2qN3f1VN1O1OQ
 ZsfW22BCq27BcDPCZEvKrLpdlvIw2O3OnEXJi4ASwTpKOk15X5/39lXXCYr7VRBqelBg
 h6NafBwuSRguctUoNZw0qsLkOpJFhWAafRlsatPqa5sxaI4UUzPW3wWNcP4M7OLi2xzn
 2SZM9A4hsHUTEEnxo4HACAQ9di0ret+OuFTv5CaW6tD8rKqo/mrxYoCdJ+aOT+mz62cd
 tE8cX7DWPKkTg8bXOHXA4wQ7trYGvsbFMzjJs8UohBXxp+wfH2L/sq4rlG5niVAk4S6z
 A2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479674; x=1689071674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJFPbZLf8D9w89pWTQhfns3YXPPzXmXhSuGo7GoNoZU=;
 b=MFAD9b/9s33UCAetN7sIYh/g0w5DFc+d20y+5nID6lKfxbp0DOmm/YpUEKTFVokwEW
 NB6mI5FDCSnDkvAQq+uQ5JaKR00meyfAa0p/2cRm2f23i7VWZtobyQFUEUTwazCIAY7q
 LRakCvi1r4KOnq6pu9+AFuyC+nc8g7uU9buTCnxnz/GT0OF/6AUA3U+5ghQ2y2U2SHd1
 0HfYZGZaG3mjhjYTwJ6sTlWZMbtx2Zsex32nydsIGN9YtOnWQpRIlBYeApPLQto+QEs1
 tt1+12zZeMAl1b4ksw/bny2gJ/w+rZy9Jtl/+fSlU4/FO3YFm3rlhrekyw0goGnkd7aH
 4mcw==
X-Gm-Message-State: AC+VfDx49N0IJnP0g3d+cptw5qZOlFvHZpesiBsiIZs6chkOp7ZUFN3R
 2bYZt/x0LPRwqCLYWu8xZk+QChbq9E8=
X-Google-Smtp-Source: ACHHUZ6lA4eGElnxkRDmCyyPpDwdrFsKq9hYUQBaK/0Y2p6sJzG9IzY2gZ1m6f4z1L8CqpvvpRDEbQ==
X-Received: by 2002:aa7:d70a:0:b0:50d:b92e:d1dc with SMTP id
 t10-20020aa7d70a000000b0050db92ed1dcmr2929534edq.14.1686479674084; 
 Sun, 11 Jun 2023 03:34:34 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:33 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 14/15] hw/pci-host/i440fx: Resolve i440fx_init()
Date: Sun, 11 Jun 2023 12:34:11 +0200
Message-ID: <20230611103412.12109-15-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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
index f9141536cf..22173b122b 100644
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
index 44ff3f7ea0..e1708bf2c9 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -251,9 +251,14 @@ static void i440fx_pcihost_initfn(Object *obj)
 
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
 
     memory_region_add_subregion(s->address_space_io, 0xcf8, &phb->conf_mem);
     sysbus_init_ioports(sbd, 0xcf8, 4);
@@ -264,37 +269,10 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
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
-    s->address_space_io = address_space_io;
-    s->pci_address_space = pci_address_space;
-    s->ram_memory = ram_memory;
-    s->below_4g_mem_size = below_4g_mem_size;
-    s->above_4g_mem_size = above_4g_mem_size;
-    s->pci_type = (char *)pci_type;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          s->address_space_io, 0, TYPE_PCI_BUS);
     phb->bus = b;
-    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_create_simple(b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
@@ -338,8 +316,6 @@ PCIBus *i440fx_init(const char *pci_type,
     d->config[I440FX_COREBOOT_RAM_SIZE] = ram_size;
 
     i440fx_update_memory_mappings(f);
-
-    return b;
 }
 
 static void i440fx_class_init(ObjectClass *klass, void *data)
-- 
2.41.0


