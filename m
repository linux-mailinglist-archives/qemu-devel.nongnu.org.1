Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5407435F7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hj-0002WO-BP; Fri, 30 Jun 2023 03:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hQ-000274-Al
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:48 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hO-0005RI-3n
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-992dcae74e0so57811666b.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110663; x=1690702663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9f6N/xpJQAivSQxg1bCJgMWryqgA6B1D7qlruT/MdZI=;
 b=aEvmfv7nHI4s7XeHSMl+hpTrFOD76JZMoh8tYRalKtyLp3WZ3E5Au6BHdwGphsjz6v
 WCPO1Cn3Bq1N53Bfn3AWBxrmXIPiR/ccw9PT2jRh+2x4rCwotB9DjncLtxANThSWfBQ+
 +/rReqOjoBbDT/oJeeoROmjXNydaBEMOyZRLdgt5hYoDCLtyLpNrvr2z5IVy5g28XLVM
 Pk7R+WeK2od+AnUbiATGO1xZZEj7mqE9bfXFxDyRymxXuMftdJaemHgQ6VA8dlF+EaO3
 kkhjA9KYT1Aj0wTdaI6AL82x9DK5H6VY3rFH/MeRs9WXQa4GlXZUcN2CmGTkB0jTZXMp
 9YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110663; x=1690702663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9f6N/xpJQAivSQxg1bCJgMWryqgA6B1D7qlruT/MdZI=;
 b=kmqyUBVPY7AnS2YyfhM6CIKR2VwpbcYJARNY9uoLyDShIrxus5ecc4xGlLqCLns4JW
 t9de9mrOSRmiwcSB9bQUgpE1ANQYxtXXrFauQDUUAABAbGE3zYUhB7nU/rrgvbmskA5N
 7GZ2FEsGmWeU93x+PzpAv0K/aey8w3bgmXypJEBxk1GkHTm5ENYm1cUi0Q2iuQxBrib9
 nJsItZ2y4PTHc2KJbO1M/M2PtIdSztIHVNFjkIgmK2M8dKwiG2LWWbg/VTcRzFhG9NjB
 FEEpjJyHmiX99kTH0kBpMd21J5zYfSf3nFH2hLyQ+VJmvFPRJQ851ax1UKzNYqDxX7c9
 s7MQ==
X-Gm-Message-State: ABy/qLaMvYm769Z23YJa+LjOwtyqhVTZ/eTjFa7QojLhXUSO4Tle18P5
 zpfVdfn5NlgOCxGvrOKD2n0iDE0CagU=
X-Google-Smtp-Source: APBJJlERhgV0Pa1BT6mw8V791PmhuqS69lHR+0istg6bs3yJ43MWYymG6RFPhpjlLPoqBs2p3VAfzA==
X-Received: by 2002:a17:906:fa1a:b0:992:6939:2998 with SMTP id
 lo26-20020a170906fa1a00b0099269392998mr1330479ejb.27.1688110663330; 
 Fri, 30 Jun 2023 00:37:43 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 14/17] hw/pci-host/i440fx: Add PCI_HOST_{ABOVE,
 BELOW}_4G_MEM_SIZE properties
Date: Fri, 30 Jun 2023 09:37:17 +0200
Message-ID: <20230630073720.21297-15-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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
2.41.0


