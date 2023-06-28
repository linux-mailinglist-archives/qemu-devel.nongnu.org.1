Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E18774190D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDL-0004kW-Gs; Wed, 28 Jun 2023 15:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDJ-0004je-0C
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:29 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDH-0005jX-8Y
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:28 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-991e69499d1so20684266b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981945; x=1690573945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mL6z6NKnRj7uKbeJl/5GmAu1q3jetiBvcyAOgocsCSQ=;
 b=RsTnsSRG2QbMdkxGxMftOLIQ1si5yrkMKk9BxDT79cJH3ljn/KSig4m/CxaFPnEks2
 h1oJ6faSs6JScXo0D4eQ9BhcqJYKy60NfTCJN/FPgS6X7h60UCkI/6325fYXXnl4xt5p
 N98fckPt1/ny0L5DJIKi5qZ4Fqv1bpvRgm8es5uhPUyrpolVNetnnrD0tVCRMe/WI2PR
 pkPSGkxrM0TfkyWLtX2M18126hr9yQ48Bek8E8Y87QA6To+sPF7DGX5u1IMOHvH5AXyH
 6ii5N9/XBJdZMq/V6gc4XxkC4aj51AnAj3kNRd9WivDwqa6oZwpIRm7sviWyqn+RnBs5
 jzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981945; x=1690573945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mL6z6NKnRj7uKbeJl/5GmAu1q3jetiBvcyAOgocsCSQ=;
 b=b+B1la5ZCbSz/krM2EgZzm37lr5ySsL+FGeQE2uRRGvh2EDkUPQeMuHkZn+LQ33rji
 T91AYUfwXLnq0hzhnaaGeF80kGTCh74UnEBgFWLr5fwJCkbrLz+Xyx/9BVRwRWl18Swa
 ETUS9kSU95beQ/QvTIehUSaDtjLINaQeL5KWTtmFxIcffvCZo+kOz3tKyYSH0MC4gdqO
 AXQE+J69PLBKuMewWCSH7bfJOi9hVCJ/9IZzVADhjfsaa6MxyyWJf9dGZGkyjp8dGBar
 8UYASoa/PID/rnE1AnmPVQGRt5dzI5dovKBaxOUEOWOKw9oDfKheEXPq+kkJ9/R6tL4z
 oP/A==
X-Gm-Message-State: AC+VfDyD5jftgHw8//A7CR8FS4t7vsjnhLPdOigo1DuD4B6g4FYyr1zy
 ORB1UV1v/LGPcrT2c/bTP7R0AS+7J9U=
X-Google-Smtp-Source: ACHHUZ7db4UIJbdDZPV3xjqaAvFZDGUf9PugH/TDo3HcHI0Ey5q1VjYwWtrrhPM4ItF/7qJMxYbTUw==
X-Received: by 2002:a17:906:4793:b0:978:8937:19ba with SMTP id
 cw19-20020a170906479300b00978893719bamr32857892ejc.44.1687981945556; 
 Wed, 28 Jun 2023 12:52:25 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:25 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 12/16] hw/pci-host/i440fx: Add PCI_HOST_{ABOVE,
 BELOW}_4G_MEM_SIZE properties
Date: Wed, 28 Jun 2023 21:52:00 +0200
Message-ID: <20230628195204.1241-13-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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

Introduce the properties in anticipation of QOM'ification; Q35 has the same
properties.

Note that we want to avoid a "ram size" property in the QOM interface since it
seems redundant to both properties introduced in this change. Thus the removal
of the ram_size parameter. We assume the invariant of both properties to sum up
to "ram size" which is already asserted in pc_memory_init(). Under Xen the
invariant seems to hold as well, so we now also check it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/i440fx.h |  1 -
 hw/i386/pc_piix.c            |  5 ++++-
 hw/pci-host/i440fx.c         | 12 ++++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index e3a550021e..7e38456ebb 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -36,7 +36,6 @@ PCIBus *i440fx_init(const char *pci_type,
                     DeviceState *dev,
                     MemoryRegion *address_space_mem,
                     MemoryRegion *address_space_io,
-                    ram_addr_t ram_size,
                     ram_addr_t below_4g_mem_size,
                     ram_addr_t above_4g_mem_size,
                     MemoryRegion *pci_memory,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f9947fbc10..87bee368fc 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -227,6 +227,9 @@ static void pc_init1(MachineState *machine,
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
     } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
         pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
@@ -242,7 +245,7 @@ static void pc_init1(MachineState *machine,
 
         pci_bus = i440fx_init(pci_type,
                               i440fx_host,
-                              system_memory, system_io, machine->ram_size,
+                              system_memory, system_io,
                               x86ms->below_4g_mem_size,
                               x86ms->above_4g_mem_size,
                               pci_memory, ram_memory);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index a740d1762b..4dd70e68fa 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -52,6 +52,8 @@ struct I440FXState {
     MemoryRegion *pci_address_space;
     MemoryRegion *ram_memory;
     Range pci_hole;
+    uint64_t below_4g_mem_size;
+    uint64_t above_4g_mem_size;
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
     uint32_t short_root_bus;
@@ -264,7 +266,6 @@ PCIBus *i440fx_init(const char *pci_type,
                     DeviceState *dev,
                     MemoryRegion *address_space_mem,
                     MemoryRegion *address_space_io,
-                    ram_addr_t ram_size,
                     ram_addr_t below_4g_mem_size,
                     ram_addr_t above_4g_mem_size,
                     MemoryRegion *pci_address_space,
@@ -281,6 +282,8 @@ PCIBus *i440fx_init(const char *pci_type,
     s->io_memory = address_space_io;
     s->pci_address_space = pci_address_space;
     s->ram_memory = ram_memory;
+    s->below_4g_mem_size = below_4g_mem_size;
+    s->above_4g_mem_size = above_4g_mem_size;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          s->io_memory, 0, TYPE_PCI_BUS);
@@ -291,7 +294,7 @@ PCIBus *i440fx_init(const char *pci_type,
     d = pci_create_simple(b, 0, pci_type);
     f = I440FX_PCI_DEVICE(d);
 
-    range_set_bounds(&s->pci_hole, below_4g_mem_size,
+    range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
                      IO_APIC_DEFAULT_ADDRESS - 1);
 
     /* setup pci memory mapping */
@@ -322,6 +325,7 @@ PCIBus *i440fx_init(const char *pci_type,
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
+    ram_addr_t ram_size = s->below_4g_mem_size + s->above_4g_mem_size;
     ram_size = ram_size / 8 / 1024 / 1024;
     if (ram_size > 255) {
         ram_size = 255;
@@ -381,6 +385,10 @@ static Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
                      pci_hole64_size, I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT),
     DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
+    DEFINE_PROP_SIZE(PCI_HOST_BELOW_4G_MEM_SIZE, I440FXState,
+                     below_4g_mem_size, 0),
+    DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, I440FXState,
+                     above_4g_mem_size, 0),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.41.0


