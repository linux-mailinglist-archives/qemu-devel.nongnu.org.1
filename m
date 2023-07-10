Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D974E1EB
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvE-0007Oy-TQ; Mon, 10 Jul 2023 19:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvC-0007Ds-T9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvB-0004QI-0L
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hddxwq1XHSF6riRXSBNidFCr4o8X89eTT2U5op/sFq0=;
 b=IDQzMDFfY9ewiHvbHoqKnC5dpnmRFs7uM/Zs5HGxVJKJb9jpG7RRMEHNTxXoRHWJx5z9pq
 JwsT0cUAha7oFqsN81WHsNLfszgrCTPW0tMVCQBBFFvoF/8Ep1CFoP1cKir8PSL/KV+TA/
 1dVy0kb8l0/9JD+kiTbQtlgjdeyJr/Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-d6JW5XcxNuuv8qvvjAfdQg-1; Mon, 10 Jul 2023 19:03:55 -0400
X-MC-Unique: d6JW5XcxNuuv8qvvjAfdQg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-315a03cae87so488609f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030233; x=1691622233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hddxwq1XHSF6riRXSBNidFCr4o8X89eTT2U5op/sFq0=;
 b=f8OfCzER5slYwFAQjc/fswmY+KCgf46+yyW5RNG0dGnNxXYXoy7ipI5n7kvpJwG2us
 RVgrIhxNtVrzo706RV2wpSSV7+9u276rgmLxRMyjmrQmZW1VOKeu/wtfNHF16oK78Kni
 rDlfduHWyP5pHSMsQb62M9g33I9CHnlFQoHLnQjNwnaBAYZtgF5zfN+30Z2XUzqdQiFC
 b77tGo0iFZjQk1Svvr459PYuhC1bhHm+ez/jvUZvz1REd162+n5uWulL+gLhI+OHANwq
 HOFoJokOAuaHezJaGwhx8nfolWc2t4RJZXq2CU3oXFvRD9tEei8NphGKOAp/dE9NxMBV
 7MYQ==
X-Gm-Message-State: ABy/qLZYLmBsDMXpwcLwORPG8ZBKWFhfoW+GpvZo41dosl5k6yFKLLeh
 U2U9IJkJLtZ1hbiZPizwtjQlNES90A2FGk1Cr2KP6nm5qLiOYXQ6lw8m4YC5ziMIybKlFCRNihQ
 /pxQ6b7ErAGm505aJ5/HbnFQwXrVcOA825GCABIEk8QAIFAVm31bFiAtPMtR8LQ9RUAPy
X-Received: by 2002:a5d:65c8:0:b0:313:f0a7:133a with SMTP id
 e8-20020a5d65c8000000b00313f0a7133amr15801249wrw.13.1689030233693; 
 Mon, 10 Jul 2023 16:03:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGcY0b6/kVCw3nDJVbJ7Jpo5eENdwDD2x6sdH11NSpj2DQ1Myps0V6u8gzB8wKIbtKqkInmAQ==
X-Received: by 2002:a5d:65c8:0:b0:313:f0a7:133a with SMTP id
 e8-20020a5d65c8000000b00313f0a7133amr15801234wrw.13.1689030233473; 
 Mon, 10 Jul 2023 16:03:53 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 m15-20020adfdc4f000000b003142ea7a661sm597465wrj.21.2023.07.10.16.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:53 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 30/66] hw/pci-host/i440fx: Add PCI_HOST_{ABOVE,
 BELOW}_4G_MEM_SIZE properties
Message-ID: <82feef45f42db607b9439411d4aad7c21bdf3047.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Introduce the properties in anticipation of QOM'ification; Q35 has the same
properties.

Note that we want to avoid a "ram size" property in the QOM interface since it
seems redundant to both properties introduced in this change. Thus the removal
of the ram_size parameter. We assume the invariant of both properties to sum up
to "ram size" which is already asserted in pc_memory_init(). Under Xen the
invariant seems to hold as well, so we now also check it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230630073720.21297-15-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index 26e8473a4d..c36783809f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -224,6 +224,9 @@ static void pc_init1(MachineState *machine,
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
     } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
         pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
@@ -239,7 +242,7 @@ static void pc_init1(MachineState *machine,
 
         pci_bus = i440fx_init(pci_type,
                               i440fx_host,
-                              system_memory, system_io, machine->ram_size,
+                              system_memory, system_io,
                               x86ms->below_4g_mem_size,
                               x86ms->above_4g_mem_size,
                               pci_memory, ram_memory);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index de14c75e95..8731740a1b 100644
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
@@ -290,7 +293,7 @@ PCIBus *i440fx_init(const char *pci_type,
     d = pci_create_simple(b, 0, pci_type);
     f = I440FX_PCI_DEVICE(d);
 
-    range_set_bounds(&s->pci_hole, below_4g_mem_size,
+    range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
                      IO_APIC_DEFAULT_ADDRESS - 1);
 
     /* setup pci memory mapping */
@@ -321,6 +324,7 @@ PCIBus *i440fx_init(const char *pci_type,
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
+    ram_addr_t ram_size = s->below_4g_mem_size + s->above_4g_mem_size;
     ram_size = ram_size / 8 / 1024 / 1024;
     if (ram_size > 255) {
         ram_size = 255;
@@ -380,6 +384,10 @@ static Property i440fx_props[] = {
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
MST


