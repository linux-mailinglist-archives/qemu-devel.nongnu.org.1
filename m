Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A485574E1BC
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzv9-0006hX-Bb; Mon, 10 Jul 2023 19:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzv7-0006b0-81
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzv5-0004Ps-KG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FNn+sY/o3drXdYQoMsrAHjkktUYUW6+/Foc/eC1Pfo=;
 b=BC5x5/k1lSb//z/MqWeYD2mt1LGc44GHWextXilnolc4B+PUnlKbm7nGyG/YoAQS6WlIpZ
 97aP2eUD6irKWYPQH5qS/rKXs8u5cDxVQu+/W6TTkNsqylrb3oCi0RYdoYo0bSI6n7Eypv
 FRI0r8jtjOWPxn2ZpfcE70usDnoz8wE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-pzLI1etPOaGOOozZeCOHdQ-1; Mon, 10 Jul 2023 19:03:49 -0400
X-MC-Unique: pzLI1etPOaGOOozZeCOHdQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbdd5d09b8so34278645e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030228; x=1691622228;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4FNn+sY/o3drXdYQoMsrAHjkktUYUW6+/Foc/eC1Pfo=;
 b=HBQVvOq8DvNuAysDK6qgVK1YRdad92ceBJ82yY/8BQinVo09xtNTFcRso86sdKik+v
 psyWPCPhZ02e4NBvlpEJvcj5isyWoGXyl5Ac7VrdBdGt5hlA4tXB7TWnXpYKyP6o2Nku
 KYm51N8DrbwZ6+p06cVl8SRYH9mj03UJbkayYHK7BwxhCFpw/a8DMyeO/sbMXEDMb3gD
 +WNdjulNg09NQ6MS4dr9f8/hwq/D0hsWxGzzqowCaOFsW4A2F2r8B0sg0LgOo33UgE0b
 QpL4IJmeRylAtqmVv23wdfxUzkd9XStD5OE7j6b3A4X0zVywRFSn5QDAhiC6yw1ku21T
 Xlig==
X-Gm-Message-State: ABy/qLaP9EikTau91K1Kj6P+/wIQvsIsCj2/155qAYP0GLJW85lhD/wI
 gqldyTWIDqXlG2TaU1qCZytKO5hFNaKynibrj7PXHXBBdBZ0mxXcmGmxmPNsqlOiQ+Bw/nrzkI4
 SwYNtX3oLgdW7x79/asC4T1yQZKBz64aIYEZ6/9MDRajLK+WMKLqMKzZCr3CIV+TCP9hY
X-Received: by 2002:a1c:7417:0:b0:3fb:e573:4172 with SMTP id
 p23-20020a1c7417000000b003fbe5734172mr13818774wmc.31.1689030228178; 
 Mon, 10 Jul 2023 16:03:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEVI0Ov4/Ie3hKz6ek9CmRuNwBuGqGt3iR73qpSRRaxjuseycC28nFjJJ9g6sQjE9wPI48AyA==
X-Received: by 2002:a1c:7417:0:b0:3fb:e573:4172 with SMTP id
 p23-20020a1c7417000000b003fbe5734172mr13818756wmc.31.1689030227789; 
 Mon, 10 Jul 2023 16:03:47 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f19-20020a7bcc13000000b003fa973e6612sm11484343wmh.44.2023.07.10.16.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:47 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 28/66] hw/pci-host/i440fx: Make MemoryRegion pointers
 accessible as properties
Message-ID: <09f85b7b93a05f1551509b245be99529a9e278f9.1689030052.git.mst@redhat.com>
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

The goal is to eliminate i440fx_init() which is a legacy init function. This
neccessitates the memory regions to be properties, like in Q35, which will be
assigned in board code.

Since i440fx needs different PCI devices in Xen mode, and since i440fx shall
be self-contained, the PCI device will be created during realization of the
host. Thus the pointers need to be moved to the host structure to be usable as
properties.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-13-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci-host/i440fx.h |  3 ---
 hw/pci-host/i440fx.c         | 42 +++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index bf57216c78..e3a550021e 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -25,9 +25,6 @@ struct PCII440FXState {
     PCIDevice parent_obj;
     /*< public >*/
 
-    MemoryRegion *system_memory;
-    MemoryRegion *pci_address_space;
-    MemoryRegion *ram_memory;
     PAMMemoryRegion pam_regions[PAM_REGIONS_COUNT];
     MemoryRegion smram_region;
     MemoryRegion smram, low_smram;
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e84fcd50b6..b9530fc3a0 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -47,6 +47,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(I440FXState, I440FX_PCI_HOST_BRIDGE)
 
 struct I440FXState {
     PCIHostState parent_obj;
+
+    MemoryRegion *system_memory;
+    MemoryRegion *pci_address_space;
+    MemoryRegion *ram_memory;
     Range pci_hole;
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
@@ -214,12 +218,25 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
 
 static void i440fx_pcihost_initfn(Object *obj)
 {
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
     PCIHostState *phb = PCI_HOST_BRIDGE(obj);
 
     memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
                           "pci-conf-idx", 4);
     memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
                           "pci-conf-data", 4);
+
+    object_property_add_link(obj, PCI_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
+                             (Object **) &s->ram_memory,
+                             qdev_prop_allow_set_link_before_realize, 0);
+
+    object_property_add_link(obj, PCI_HOST_PROP_PCI_MEM, TYPE_MEMORY_REGION,
+                             (Object **) &s->pci_address_space,
+                             qdev_prop_allow_set_link_before_realize, 0);
+
+    object_property_add_link(obj, PCI_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
+                             (Object **) &s->system_memory,
+                             qdev_prop_allow_set_link_before_realize, 0);
 }
 
 static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
@@ -255,27 +272,28 @@ PCIBus *i440fx_init(const char *pci_type,
     PCII440FXState *f;
     unsigned i;
 
-    b = pci_root_bus_new(dev, NULL, pci_address_space,
+    s->system_memory = address_space_mem;
+    s->pci_address_space = pci_address_space;
+    s->ram_memory = ram_memory;
+
+    b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          address_space_io, 0, TYPE_PCI_BUS);
     phb->bus = b;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_create_simple(b, 0, pci_type);
     f = I440FX_PCI_DEVICE(d);
-    f->system_memory = address_space_mem;
-    f->pci_address_space = pci_address_space;
-    f->ram_memory = ram_memory;
 
     range_set_bounds(&s->pci_hole, below_4g_mem_size,
                      IO_APIC_DEFAULT_ADDRESS - 1);
 
     /* setup pci memory mapping */
-    pc_pci_as_mapping_init(f->system_memory, f->pci_address_space);
+    pc_pci_as_mapping_init(s->system_memory, s->pci_address_space);
 
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
-                             f->pci_address_space, SMRAM_C_BASE, SMRAM_C_SIZE);
-    memory_region_add_subregion_overlap(f->system_memory, SMRAM_C_BASE,
+                             s->pci_address_space, SMRAM_C_BASE, SMRAM_C_SIZE);
+    memory_region_add_subregion_overlap(s->system_memory, SMRAM_C_BASE,
                                         &f->smram_region, 1);
     memory_region_set_enabled(&f->smram_region, true);
 
@@ -283,17 +301,17 @@ PCIBus *i440fx_init(const char *pci_type,
     memory_region_init(&f->smram, OBJECT(d), "smram", 4 * GiB);
     memory_region_set_enabled(&f->smram, true);
     memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
-                             f->ram_memory, SMRAM_C_BASE, SMRAM_C_SIZE);
+                             s->ram_memory, SMRAM_C_BASE, SMRAM_C_SIZE);
     memory_region_set_enabled(&f->low_smram, true);
     memory_region_add_subregion(&f->smram, SMRAM_C_BASE, &f->low_smram);
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&f->smram));
 
-    init_pam(&f->pam_regions[0], OBJECT(d), f->ram_memory, f->system_memory,
-             f->pci_address_space, PAM_BIOS_BASE, PAM_BIOS_SIZE);
+    init_pam(&f->pam_regions[0], OBJECT(d), s->ram_memory, s->system_memory,
+             s->pci_address_space, PAM_BIOS_BASE, PAM_BIOS_SIZE);
     for (i = 0; i < ARRAY_SIZE(f->pam_regions) - 1; ++i) {
-        init_pam(&f->pam_regions[i + 1], OBJECT(d), f->ram_memory,
-                 f->system_memory, f->pci_address_space,
+        init_pam(&f->pam_regions[i + 1], OBJECT(d), s->ram_memory,
+                 s->system_memory, s->pci_address_space,
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
-- 
MST


