Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9F74E1ED
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvZ-0007gI-Ij; Mon, 10 Jul 2023 19:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvK-0007ZD-Mc
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvI-0004Rr-Hz
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBihUDmGB6uFtH/AkcYIicM5fh04EulaKYLbdQ/QMSU=;
 b=OvKdYC2wsf9M78Ou00YBqkL8fDZkYr2G75lbWqnzsajUBTU+QSRpG/sxVnreTqBhqbkMT1
 ledVWKW1Iywwd55nYvwFon7MGjwK6+2CDABKxw0/YPDCHJcAQoR+PT13JoXbPU8m4vLMWm
 9hiLwq2WQTJNi5fzMHzSLU0XNWQex8c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-d7LU3e7PNs6zqPjbiB52ug-1; Mon, 10 Jul 2023 19:04:01 -0400
X-MC-Unique: d7LU3e7PNs6zqPjbiB52ug-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbb0fdd060so31133165e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030239; x=1691622239;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zBihUDmGB6uFtH/AkcYIicM5fh04EulaKYLbdQ/QMSU=;
 b=kAzoZOlfV0njUTGO0iJCOBG00AgF1i/Iz5l8D/VfWKxMJB0IuYTzn/aVLbshDLjAMB
 vjDx8SWr2fzbsIQi3/hwbuCfDcPdTMjIP4n6C4muV3jtiI98DtMlsB+0//M0fitj/aAO
 fn6z8JmOuSa3zchLC9X8HkMTHK0kDIeOkBf0b1YTwi44nSw2/MwE1rEAcCzelayHhijT
 9UunPqDV92QjAMn2rOIwpky/QBTl5WTmx3wqfpVqPhzGBHxGQT5jAZaI7faEZ8H/SaCg
 PzmX9pQKh9kbw96qY0Z7bDVarqG7RNbKm5XmLbvfRXpglO6U7j3/WjUNpnKbX9cYLICT
 TjTA==
X-Gm-Message-State: ABy/qLa/nZY6k7HOBEDY63pfkZBaUlCwvFNLkyQiz19tHjUCFtbwXN5g
 vpdsNuZ/AfaP8TSSCNHVd97CZLNH35QPF3ZMGW75I/Ou7ITMXEG8o5T77OeI3XgRWOxTJytROs2
 5JCLbZTcey2wNuj5tXSNOxSU0GSIdHjw1Xpan2f8RSsR7e7oUUbBMIYdjKTQHoPn+Y0Z4
X-Received: by 2002:a5d:410e:0:b0:315:902b:7913 with SMTP id
 l14-20020a5d410e000000b00315902b7913mr8570111wrp.31.1689030239489; 
 Mon, 10 Jul 2023 16:03:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlElvc1J+xlRdlRyjYLiJgR2dAGxWK2KEPCb6Q8YoCskjj8F/t0YHQRC7R/MPt10UdfwRJBRew==
X-Received: by 2002:a5d:410e:0:b0:315:902b:7913 with SMTP id
 l14-20020a5d410e000000b00315902b7913mr8570090wrp.31.1689030239206; 
 Mon, 10 Jul 2023 16:03:59 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f4-20020a5d4dc4000000b0031424f4ef1dsm601118wru.19.2023.07.10.16.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:58 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 32/66] hw/pci-host/i440fx: Resolve i440fx_init()
Message-ID: <ce5ac09a7548d90ac414f60bbe87c69a8487de10.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

i440fx_init() is a legacy init function. The previous patches worked towards
TYPE_I440FX_PCI_HOST_BRIDGE to be instantiated the QOM way. Do this now by
transforming the parameters passed to i440fx_init() into property assignments.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230630073720.21297-17-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
MST


