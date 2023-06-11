Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FCB72B169
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:36:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IPG-0006Xb-8Y; Sun, 11 Jun 2023 06:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP8-0006WH-96
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:39 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP6-0008Lu-Kd
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so5827004a12.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479675; x=1689071675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7k4Fqj00ZToMlyG8RUBaexkoYZTRKI80CsrA6U0Gl1I=;
 b=LU7rEZocYF+17wGGsu8fbIF0Ph3RlIRYJHk6DIzteOu5+PEyObLPdAFQDVZkl1qFqq
 SIlvE5r/6Nh2jPbwCZToLbHH9he0D0PxkUg5f4k+1oHTbmcURornqdk9s8qTvH93jkdH
 QTM9x6bOSD1uD03ssMtTM/CGb7EldjJlO3EkVTGhVvkxA5AH6PJ1SHcPYH7YDGdOIFnZ
 bCpwLsFwSJAVPTz05NpmHReSMZLveJsqM9G9WkkSDjncsloJleEUNdIs4c5Ne+W7Ky5Q
 GV3L1mir6Ie3HKd6JjURZ7a9AZ3/g2alE8U0u4GlWjYKXv8cWDDV2mtiotxhzkr+V8zR
 oUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479675; x=1689071675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7k4Fqj00ZToMlyG8RUBaexkoYZTRKI80CsrA6U0Gl1I=;
 b=Zk1hSTNRGgAUkMdAh1/8MtEUy5zME3Dcj9STNNHBFnRm9Ii+L7b2w3K0hRyBetpL5I
 KdvhKeqbOwsWkUxcxSG+lgLnsxOFHpgPuQfEtUoknuPHD32irX+NA0qgsj+43RpkmOWo
 8snCKAhQv/gMv7DkFyuGwHnBkbA8qXo3QfFCZaTMk3VdMXhJCsGn5oCUrO/pYK5rLvmP
 Fei3BmqXkGXuQc3t3Abo5GhNJhfqj+OAVMDvq3f7cz+uLhiPyx7+CiJ6auP8rITfd8SD
 k9515a5+cjpRveOOnFvviz2pfuL+ls+fOHXFfTBE9ez+Z7NIKITk5hhKUdieVJ2lPqPS
 3tuA==
X-Gm-Message-State: AC+VfDwJiC0hpSBs0Yv020VpEOpYLlsOOvZf85DLaYM+1S7MEWYAlj2e
 mPAAScG69+ghvoM8ZNgXANtF9dC8HAk=
X-Google-Smtp-Source: ACHHUZ7PWys3a1kjBg2hSZ/VoCZ/NJ7RL6oz4/Ad6mXkFO4g8G/IZdPwoRQaMT5wR/z//9X2hyySNA==
X-Received: by 2002:aa7:ccce:0:b0:514:a4da:408e with SMTP id
 y14-20020aa7ccce000000b00514a4da408emr3176770edt.2.1686479675007; 
 Sun, 11 Jun 2023 03:34:35 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 15/15] hw/i386/pc_piix: Move i440fx' realize near its
 qdev_new()
Date: Sun, 11 Jun 2023 12:34:12 +0200
Message-ID: <20230611103412.12109-16-shentey@gmail.com>
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

I440FX realization is currently mixed with PIIX3 creation. Furthermore, it is
common practice to only set properties between a device's qdev_new() and
qdev_realize(). Clean up to resolve both issues.

Since I440FX spawns a PCI bus let's also move the pci_bus initialization there.

Note that when running `qemu-system-x86_64 -M pc -S` before and after this
patch, `info mtree` in the QEMU console doesn't show any differences except that
the ordering is different.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_piix.c | 57 ++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 22173b122b..23b9725c94 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -126,7 +126,6 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *rom_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size;
-    Object *i440fx_host;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -198,17 +197,43 @@ static void pc_init1(MachineState *machine,
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
     } else {
         pci_memory = NULL;
         rom_memory = system_memory;
-        i440fx_host = NULL;
+        pci_bus = NULL;
         hole64_size = 0;
     }
 
@@ -243,29 +268,6 @@ static void pc_init1(MachineState *machine,
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
 
@@ -290,7 +292,6 @@ static void pc_init1(MachineState *machine,
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
                                                              "rtc"));
     } else {
-        pci_bus = NULL;
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
 
-- 
2.41.0


