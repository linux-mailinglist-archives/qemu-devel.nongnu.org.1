Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A140C7C6DEB
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqufX-0003nB-Cm; Thu, 12 Oct 2023 08:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqufU-0003af-6R
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:57 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqufS-0001uJ-42
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:55 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso1093460a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697113191; x=1697717991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwJ45+LzAe2ikUIZ7U1vT0BShidVUnLgV99Ux1OJYV8=;
 b=T/GtfZCe4cU2YZc80xbTcw1Fy8+WmbCOBpkvBdwjGz9ikp08ThDn8peZCEfY10tJGj
 uSbE11v8fPnIvMbMKBHMNUc9BH1fQscgoGvgMZTadULxKsKMyUBcJjtRTW7v3Pan55S/
 m4whQzEsPMBvkPAeiXrTDiUvezycDvx6ejCIuqgJIgww+SV5IFW5BggjcJTQzpkY6MIm
 FwrpEZhut3paaMsAjHd4b/uZ06VWd9bErUQgsxzI0/3kHB+6VnOj39UDeYOOQIs6lPOV
 MIYdeA90rOz6znLpKLmI3BQYgL376i1WAL8DH2JAat5O/hDSr2H6/ccXs2akhTBG8FLc
 4o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113191; x=1697717991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwJ45+LzAe2ikUIZ7U1vT0BShidVUnLgV99Ux1OJYV8=;
 b=Yh++Tshh3vO35iHbLWLWC00W9Fuhm0NnI9fGP9uLSIO3KE35E2IXr0OlGGqag3XouC
 4mY4LFAdtkh8cumFlsNTZlbuAPP9u6pV3xKd2wH/yF+A99L3TQ01rbcVLBAewujEiqDg
 0VSQJIrG2xZz2InSsqcTlyuPylzqv1dmAmSlBDxtvZFVKr7XYZFwsrQScf8PHf/Vpcdk
 1M/1sV6exfHzhlhiOxNGTySQQOXdpotNsAL0wg982wGFRVd/HBHPW9DqBUm7cUSP1MgX
 2cttmtgI3EfA+5fBPhcnp7BakyeVz17ts0bjzJrYxGK7fVcLvhB6TD9MskN0ZJbcnihG
 tIvQ==
X-Gm-Message-State: AOJu0YwZqOQPBfV2kSL9MJBFk4tJvL1uS2WSE0rSxyNty5LXcPM0BNDR
 lFvgh6hXZSDhKWtM0kj2Ep5k0EUyxm3f7Vn1fhcUhQ==
X-Google-Smtp-Source: AGHT+IEANvvBaoD6eK3pPVNGNQcEhBKEg1y1KbyxPrkunZf/bL69CZUqUhAAgP9AIws3mCvkniUL5A==
X-Received: by 2002:a05:6402:699:b0:522:3a89:a7bc with SMTP id
 f25-20020a056402069900b005223a89a7bcmr17242908edy.42.1697113191434; 
 Thu, 12 Oct 2023 05:19:51 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-232.abo.bbox.fr. [176.131.211.232])
 by smtp.gmail.com with ESMTPSA id
 c25-20020aa7d619000000b0053622a35665sm9929836edr.66.2023.10.12.05.19.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Oct 2023 05:19:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] hw/pci-host/designware: Create ViewPorts during host
 bridge realization
Date: Thu, 12 Oct 2023 14:18:56 +0200
Message-ID: <20231012121857.31873-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012121857.31873-1-philmd@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

ViewPorts are managed by the host bridge part, so create them
when the host bridge is realized. The host bridge become the
owner of the memory regions.

The PCI root function realize() method now only contains PCI
specific code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/designware.c | 207 +++++++++++++++++++--------------------
 1 file changed, 102 insertions(+), 105 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 6cb8655a75..e5dc9b4b8d 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -384,22 +384,10 @@ static char *designware_pcie_viewport_name(const char *direction,
 static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
-    DesignwarePCIEHost *host = DESIGNWARE_PCIE_HOST(
-                                    qdev_get_parent_bus(DEVICE(dev))->parent);
-    MemoryRegion *host_mem = get_system_memory();
-    MemoryRegion *address_space = &host->pci.memory;
     PCIBridge *br = PCI_BRIDGE(dev);
-    DesignwarePCIEViewport *viewport;
-    /*
-     * Dummy values used for initial configuration of MemoryRegions
-     * that belong to a given viewport
-     */
-    const hwaddr dummy_offset = 0;
-    const uint64_t dummy_size = 4;
-    size_t i;
 
     br->bus_name  = "dw-pcie";
-    root->host = host;
+    root->host = DESIGNWARE_PCIE_HOST(qdev_get_parent_bus(DEVICE(dev))->parent);
 
     pci_set_word(dev->config + PCI_COMMAND,
                  PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
@@ -414,97 +402,6 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 
     msi_nonbroken = true;
     msi_init(dev, 0x50, 32, true, true, &error_fatal);
-
-    for (i = 0; i < DESIGNWARE_PCIE_NUM_VIEWPORTS; i++) {
-        MemoryRegion *source, *destination, *mem;
-        const char *direction;
-        char *name;
-
-        viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
-        viewport->inbound = true;
-        viewport->base    = 0x0000000000000000ULL;
-        viewport->target  = 0x0000000000000000ULL;
-        viewport->limit   = UINT32_MAX;
-        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
-
-        source      = &host->pci.address_space_root;
-        destination = host_mem;
-        direction   = "Inbound";
-
-        /*
-         * Configure MemoryRegion implementing PCI -> CPU memory
-         * access
-         */
-        mem  = &viewport->mem;
-        name = designware_pcie_viewport_name(direction, i, "MEM");
-        memory_region_init_alias(mem, OBJECT(root), name, destination,
-                                 dummy_offset, dummy_size);
-        memory_region_add_subregion_overlap(source, dummy_offset, mem, -1);
-        memory_region_set_enabled(mem, false);
-        g_free(name);
-
-        viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
-        viewport->host    = host;
-        viewport->inbound = false;
-        viewport->base    = 0x0000000000000000ULL;
-        viewport->target  = 0x0000000000000000ULL;
-        viewport->limit   = UINT32_MAX;
-        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
-
-        destination = &host->pci.memory;
-        direction   = "Outbound";
-        source      = host_mem;
-
-        /*
-         * Configure MemoryRegion implementing CPU -> PCI memory
-         * access
-         */
-        mem  = &viewport->mem;
-        name = designware_pcie_viewport_name(direction, i, "MEM");
-        memory_region_init_alias(mem, OBJECT(root), name, destination,
-                                 dummy_offset, dummy_size);
-        memory_region_add_subregion(source, dummy_offset, mem);
-        memory_region_set_enabled(mem, false);
-        g_free(name);
-
-        /*
-         * Configure MemoryRegion implementing access to configuration
-         * space
-         */
-        mem  = &viewport->cfg;
-        name = designware_pcie_viewport_name(direction, i, "CFG");
-        memory_region_init_io(&viewport->cfg, OBJECT(root),
-                              &designware_pci_host_conf_ops,
-                              viewport, name, dummy_size);
-        memory_region_add_subregion(source, dummy_offset, mem);
-        memory_region_set_enabled(mem, false);
-        g_free(name);
-    }
-
-    /*
-     * If no inbound iATU windows are configured, HW defaults to
-     * letting inbound TLPs to pass in. We emulate that by explicitly
-     * configuring first inbound window to cover all of target's
-     * address space.
-     *
-     * NOTE: This will not work correctly for the case when first
-     * configured inbound window is window 0
-     */
-    viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
-    viewport->cr[1] = DESIGNWARE_PCIE_ATU_ENABLE;
-    designware_pcie_update_viewport(root, viewport);
-
-    memory_region_init_io(&host->msi.iomem, OBJECT(root),
-                          &designware_pci_host_msi_ops,
-                          root, "pcie-msi", 0x4);
-    /*
-     * We initially place MSI interrupt I/O region at address 0 and
-     * disable it. It'll be later moved to correct offset and enabled
-     * in designware_pcie_root_update_msi_mapping() as a part of
-     * initialization done by guest OS
-     */
-    memory_region_add_subregion(address_space, dummy_offset, &host->msi.iomem);
-    memory_region_set_enabled(&host->msi.iomem, false);
 }
 
 static void designware_pcie_set_irq(void *opaque, int irq_num, int level)
@@ -590,7 +487,7 @@ static void designware_pcie_root_class_init(ObjectClass *klass, void *data)
     dc->reset = pci_bridge_reset;
     /*
      * PCI-facing part of the host bridge, not usable without the
-     * host-facing part, which can't be device_add'ed, yet.
+     * host-facing part.
      */
     dc->user_creatable = false;
     dc->vmsd = &vmstate_designware_pcie_root;
@@ -650,8 +547,17 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
     DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    MemoryRegion *host_mem = get_system_memory();
+    DesignwarePCIEViewport *viewport;
     size_t i;
 
+    /*
+     * Dummy values used for initial configuration of MemoryRegions
+     * that belong to a given viewport
+     */
+    const hwaddr dummy_offset = 0;
+    const uint64_t dummy_size = 4;
+
     for (i = 0; i < ARRAY_SIZE(s->pci.irqs); i++) {
         sysbus_init_irq(sbd, &s->pci.irqs[i]);
     }
@@ -694,6 +600,97 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_int32(DEVICE(&s->root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->root), "multifunction", false);
     qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
+
+    memory_region_init_io(&s->msi.iomem, OBJECT(s),
+                          &designware_pci_host_msi_ops,
+                          s, "pcie-msi", 0x4);
+    /*
+     * We initially place MSI interrupt I/O region at address 0 and
+     * disable it. It'll be later moved to correct offset and enabled
+     * in designware_pcie_host_update_msi_mapping() as a part of
+     * initialization done by guest OS
+     */
+    memory_region_add_subregion(&s->pci.memory, dummy_offset, &s->msi.iomem);
+    memory_region_set_enabled(&s->msi.iomem, false);
+
+    for (i = 0; i < DESIGNWARE_PCIE_NUM_VIEWPORTS; i++) {
+        MemoryRegion *source, *destination, *mem;
+        const char *direction;
+        char *name;
+
+        viewport = &s->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
+        viewport->inbound = true;
+        viewport->base    = 0x0000000000000000ULL;
+        viewport->target  = 0x0000000000000000ULL;
+        viewport->limit   = UINT32_MAX;
+        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
+
+        source      = &s->pci.address_space_root;
+        destination = host_mem;
+        direction   = "Inbound";
+
+        /*
+         * Configure MemoryRegion implementing PCI -> CPU memory
+         * access
+         */
+        mem  = &viewport->mem;
+        name = designware_pcie_viewport_name(direction, i, "MEM");
+        memory_region_init_alias(mem, OBJECT(s), name, destination,
+                                 dummy_offset, dummy_size);
+        memory_region_add_subregion_overlap(source, dummy_offset, mem, -1);
+        memory_region_set_enabled(mem, false);
+        g_free(name);
+
+        viewport = &s->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
+        viewport->host    = s;
+        viewport->inbound = false;
+        viewport->base    = 0x0000000000000000ULL;
+        viewport->target  = 0x0000000000000000ULL;
+        viewport->limit   = UINT32_MAX;
+        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
+
+        destination = &s->pci.memory;
+        direction   = "Outbound";
+        source      = host_mem;
+
+        /*
+         * Configure MemoryRegion implementing CPU -> PCI memory
+         * access
+         */
+        mem  = &viewport->mem;
+        name = designware_pcie_viewport_name(direction, i, "MEM");
+        memory_region_init_alias(mem, OBJECT(s), name, destination,
+                                 dummy_offset, dummy_size);
+        memory_region_add_subregion(source, dummy_offset, mem);
+        memory_region_set_enabled(mem, false);
+        g_free(name);
+
+        /*
+         * Configure MemoryRegion implementing access to configuration
+         * space
+         */
+        mem  = &viewport->cfg;
+        name = designware_pcie_viewport_name(direction, i, "CFG");
+        memory_region_init_io(&viewport->cfg, OBJECT(s),
+                              &designware_pci_host_conf_ops,
+                              viewport, name, dummy_size);
+        memory_region_add_subregion(source, dummy_offset, mem);
+        memory_region_set_enabled(mem, false);
+        g_free(name);
+    }
+
+    /*
+     * If no inbound iATU windows are configured, HW defaults to
+     * letting inbound TLPs to pass in. We emulate that by explicitly
+     * configuring first inbound window to cover all of target's
+     * address space.
+     *
+     * NOTE: This will not work correctly for the case when first
+     * configured inbound window is window 0
+     */
+    viewport = &s->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
+    viewport->cr[1] = DESIGNWARE_PCIE_ATU_ENABLE;
+    designware_pcie_update_viewport(&s->root, viewport);
 }
 
 static const VMStateDescription vmstate_designware_pcie_host = {
-- 
2.41.0


