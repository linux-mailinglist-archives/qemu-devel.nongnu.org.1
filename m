Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A324472B16A
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:36:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IPE-0006WI-VS; Sun, 11 Jun 2023 06:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP5-0006Tm-D6
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:35 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP3-0008LD-O2
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:35 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5147f5efeb5so5962025a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479672; x=1689071672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w00lQ/oA1fgsvaWNQuZeFk0WhcCtDmg0NfYoWLzahb8=;
 b=hCYzsirEHaIIeuvNusspmgPd5N8bh1RDVnnZ0jEnQvICyBiXx9fXi6BZ+DuSa3uQBu
 2SNF5SWwO11T+I/mAiZqQAXzyfYfxxbozaTXjqBgOUaoUO9XvOmVDFUN6JxU2STl9Rep
 cWarvCS6fwuznviYIHN5MN69yrK2oAw+VQ7nvgfI9YTq+cWZsXKWP9aJpa+cdekRIxeh
 pwwjnRptsT5EPf+sRO537bQcFZzqqbYWV8i4PMdixv+bA8ei5POIGtInh2uTPD8sGvE+
 tqHBIsUmCNiV9ogTWLSri8MsN3w4gUqKpcYzQHSJ71Clk6ixBJcmMbplZ3mp8kFadPlL
 svzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479672; x=1689071672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w00lQ/oA1fgsvaWNQuZeFk0WhcCtDmg0NfYoWLzahb8=;
 b=GIScQKdu4bt/HL6FJ+JTxzqAW9hTg5PGBHQMnmXsYXLdXoJ9D46HFJBBYcO36JxnKt
 r0HuJc9p01FhFq+DX5IjZvG3PLVFAprJGPQk3x/bP8++9yEFqcGOH/f2bd3r6HIBGGOF
 xJuTh/R2hbDwuI/MuVlggyHhkRzLciA6bcPWLR5b2f+Ho5nRbmvtuvDcTtBT7vu0uaRL
 6FAOSAdM98ifN4ySW2+pV+7/yH1RJ1X8jR45q4UhHWncpWglMiXnNlujK6DwIiKBNkhc
 j9oDCL0p3G9wgFWkcmj9RMM7AeS35Rrv9bGQVr1c12cU6xyXaUzeafDJMjPHbrJMLzye
 N9tg==
X-Gm-Message-State: AC+VfDzdlR1PZdmf8VHjkKLNskMvQGBEZjIZF5ep4YCC0ruGhKF0HvVL
 PPNI7WRkjNcNOaW1rz949wQ/4eWvDRw=
X-Google-Smtp-Source: ACHHUZ7KEG+Vx9ZsC3EDFOLFlVTilopjrugZ3a2oIXn9R2Yu3FIxXmhV2U5ICjJrr/AC1+l05fzz9w==
X-Received: by 2002:aa7:dad7:0:b0:510:d889:88c8 with SMTP id
 x23-20020aa7dad7000000b00510d88988c8mr2686143eds.38.1686479672108; 
 Sun, 11 Jun 2023 03:34:32 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:31 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 12/15] hw/pci-host/i440fx: Add PCI_HOST_{ABOVE,
 BELOW}_4G_MEM_SIZE properties
Date: Sun, 11 Jun 2023 12:34:09 +0200
Message-ID: <20230611103412.12109-13-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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
index 42af03dbb4..f9141536cf 100644
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
index 67eeffb421..3c44f24d2a 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -54,6 +54,8 @@ struct I440FXState {
     MemoryRegion *pci_address_space;
     MemoryRegion *ram_memory;
     Range pci_hole;
+    uint64_t below_4g_mem_size;
+    uint64_t above_4g_mem_size;
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
     uint32_t short_root_bus;
@@ -266,7 +268,6 @@ PCIBus *i440fx_init(const char *pci_type,
                     DeviceState *dev,
                     MemoryRegion *address_space_mem,
                     MemoryRegion *address_space_io,
-                    ram_addr_t ram_size,
                     ram_addr_t below_4g_mem_size,
                     ram_addr_t above_4g_mem_size,
                     MemoryRegion *pci_address_space,
@@ -283,6 +284,8 @@ PCIBus *i440fx_init(const char *pci_type,
     s->address_space_io = address_space_io;
     s->pci_address_space = pci_address_space;
     s->ram_memory = ram_memory;
+    s->below_4g_mem_size = below_4g_mem_size;
+    s->above_4g_mem_size = above_4g_mem_size;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          s->address_space_io, 0, TYPE_PCI_BUS);
@@ -293,7 +296,7 @@ PCIBus *i440fx_init(const char *pci_type,
     d = pci_create_simple(b, 0, pci_type);
     f = I440FX_PCI_DEVICE(d);
 
-    range_set_bounds(&s->pci_hole, below_4g_mem_size,
+    range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
                      IO_APIC_DEFAULT_ADDRESS - 1);
 
     /* setup pci memory mapping */
@@ -324,6 +327,7 @@ PCIBus *i440fx_init(const char *pci_type,
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
+    ram_addr_t ram_size = s->below_4g_mem_size + s->above_4g_mem_size;
     ram_size = ram_size / 8 / 1024 / 1024;
     if (ram_size > 255) {
         ram_size = 255;
@@ -383,6 +387,10 @@ static Property i440fx_props[] = {
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


