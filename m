Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C32741913
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDJ-0004jC-8K; Wed, 28 Jun 2023 15:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDH-0004ip-6V
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:27 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDF-0005jJ-E5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:26 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b69f1570b2so3698311fa.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981943; x=1690573943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiFO595PbyvHK55Z+oXifs8Sd0sd0acHPDSBWvnuw9s=;
 b=L1UlLDKPd7NqZty+eYZZ3GDaWRfUwW6WSS97zQpxhcz2u2PKpQ3jQRSGNL+eOtp/aP
 cka0+vzIpOxfA0qyum3UUbmff5Jl4BhNici0VvL1RE9mOmSn2HUicdsKKZCM1KbzLc+j
 +fRnEXxmCUp8Z2Ju+b4w+Sde/esliihDkIAGubUylC6LGxRfrBwrSqa1qdlpwuN98fPX
 L//WmXLUveYNfMR0uH95Rh+MHJvBUVlS2x9izbQ0PM4rqZRWzMJqm3KXLSiw3lh4Zpv4
 /HNKlTy0OQgVkKjNvKRGanmkpMcEM0rFGszbhocFBKxaS74vOc7zLRFFdW28RLO6+RSc
 HosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981943; x=1690573943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiFO595PbyvHK55Z+oXifs8Sd0sd0acHPDSBWvnuw9s=;
 b=RHX11evkpNPr9eBZqwGhW4UufI89SuThGknLxeHYohsEA8t4jg4PLfzPIhQyftGnsL
 5ryIMcQRTpsy9IcFnkVv+r2wWZAcYmEivGAarMnhRgXQb98Dv5IMIyhJMK8kp68lFCM2
 dXeCOdNns+cQksjFsAZ+Yrt+EfLm1sJMlF+WprJCxEUETlTE2XEwi40YRfXgl+xWz7Xu
 8oUcGXKPsqvEc4qghpqTwcWEwAWd/AhC4WJPNJK/uyLZTL4dqkOhfmub6qDIa3WQ+uEC
 G22eSdz3Gim+/cgxPSbx2JTF7vZQvkaw5SGlPC1+c6bn027vgXZQCGA7UxAktdfeNn9I
 9NXg==
X-Gm-Message-State: AC+VfDxvML1qF8IMjz79qCEC664MWR5s/PYXfHD2ZK4HcMay4iQKoD4T
 6YiPhd2tDkb7XPWL05+G29vIKs2DgAA=
X-Google-Smtp-Source: ACHHUZ4kj94VZRo41x56imYiVk7FGchoA3dnFGcld5SdcNxbKZcp/xJKcJsi5Md+OjmW+GN4D9vl7Q==
X-Received: by 2002:a2e:8089:0:b0:2b6:b88b:6689 with SMTP id
 i9-20020a2e8089000000b002b6b88b6689mr3429637ljg.22.1687981943301; 
 Wed, 28 Jun 2023 12:52:23 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:22 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/16] hw/pci-host/i440fx: Make MemoryRegion pointers
 accessible as properties
Date: Wed, 28 Jun 2023 21:51:58 +0200
Message-ID: <20230628195204.1241-11-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22c.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 9df4688b2e..efc940ba12 100644
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
@@ -255,7 +272,11 @@ PCIBus *i440fx_init(const char *pci_type,
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
@@ -263,20 +284,17 @@ PCIBus *i440fx_init(const char *pci_type,
 
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
 
@@ -284,17 +302,17 @@ PCIBus *i440fx_init(const char *pci_type,
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


