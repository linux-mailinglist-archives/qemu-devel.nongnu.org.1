Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0B72B162
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IPF-0006X4-J9; Sun, 11 Jun 2023 06:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP3-0006TB-SH
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:34 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP2-0008Kp-1p
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:33 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-516a008e495so6920125a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479670; x=1689071670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVkoidxP0HHQEryTQwrMVjugXe9vuiGaOhyjtPj/j/o=;
 b=r6wUXl4HHkTgRRaJqGkZm2uXjz8BsGo0z1kfLIy9H2oVhLtNkXjhCiwuuIk0vhAMHv
 vRrDgnn8uJc3xTuXoEs7ZgZGHXHBZa32jeFgVQtgCjEIYKrbWQL9y2cgyLKfriOUJUSc
 uCAM17REtKqB2m7joosf6RfSodAD0RSy5RRzKDui1hpc9Rggl0hLDemewAJ8uF2oGokJ
 Paq47kOlaCJi65v0aYLXEIcEt/47m2iXThF3iCF2UNlFIaWRYoaiTQpOatTjbctgEogF
 aALWyPdKJ4nfA7yWaqnAShmLmUrjO3EX5aU5M1y/MOc2fTcKNN0EhBhDPy34IpwRGHBJ
 cHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479670; x=1689071670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OVkoidxP0HHQEryTQwrMVjugXe9vuiGaOhyjtPj/j/o=;
 b=BbuYJZNBQ/ke5NlS+tJVMwbuLCHhkpkydt4SyIGsFG0CRDjgFufeCAVD22kSOUxZR4
 qSCR7VNWuZe8e61iIWwQdbW4/JvemRoeAHc3uHOMs9dEUxT9FkybgEAwixkYp7lcgZJo
 yiOfLbXyBJ4ayBHqTFZjkmFbKrX/9wcMP/6InZW6L+sNXMF9QA2ExmYKxwZaSZfJxw+G
 04HUUO3tcTjZrd3C7fTTVJP9JFat5GT8G4Njaj0rRotaFKMuGnIxBdrZ4JW5PGLrl1Ur
 BTN0FHBMS5/UeoGLXgy0AShhYOlxj/L6KZIZftRfxa5Zg6Gn+1DT74WxMx+1ZRR4w4gH
 4FIQ==
X-Gm-Message-State: AC+VfDxOr7853MbRyCJwznwJu6aD316oWu1iBKGKkmmCywWA3T1NJQ4M
 F7ca4Gap8frJ2iuyF/M5bPnR0Fqia2I=
X-Google-Smtp-Source: ACHHUZ5rfeQ30WgEWsvihW+AQWlCShTDRMKE33KIcXVUD2BrSfEimu8y8IKHZRWydfXJkRj6itRYVA==
X-Received: by 2002:a05:6402:27c9:b0:506:bbf8:5152 with SMTP id
 c9-20020a05640227c900b00506bbf85152mr3232070ede.9.1686479670090; 
 Sun, 11 Jun 2023 03:34:30 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:29 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 10/15] hw/pci-host/i440fx: Make MemoryRegion pointers
 accessible as properties
Date: Sun, 11 Jun 2023 12:34:07 +0200
Message-ID: <20230611103412.12109-11-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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

The goal is to eliminate i440fx_init() which is a legacy init function. This
neccessitates the memory regions to be properties, like in Q35, which will be
assigned in board code.

Since i440fx needs different PCI devices in Xen mode, and since i440fx shall
be self-contained, the PCI device will be created during realization of the
host. Thus the pointers need to be moved to the host structure to be usable as
properties.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/i440fx.h |  3 ---
 hw/pci-host/i440fx.c         | 44 ++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 15 deletions(-)

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
index 9df4688b2e..050200cc46 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -46,7 +46,13 @@
 OBJECT_DECLARE_SIMPLE_TYPE(I440FXState, I440FX_PCI_HOST_BRIDGE)
 
 struct I440FXState {
+    /*< private >*/
     PCIHostState parent_obj;
+    /*< public >*/
+
+    MemoryRegion *system_memory;
+    MemoryRegion *pci_address_space;
+    MemoryRegion *ram_memory;
     Range pci_hole;
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
@@ -214,12 +220,25 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
 
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
@@ -255,7 +274,11 @@ PCIBus *i440fx_init(const char *pci_type,
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
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
@@ -263,20 +286,17 @@ PCIBus *i440fx_init(const char *pci_type,
 
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
 
@@ -284,17 +304,17 @@ PCIBus *i440fx_init(const char *pci_type,
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
2.41.0


