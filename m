Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E24960246
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Aug 2024 08:50:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyP-0004hT-06; Tue, 27 Aug 2024 02:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3IXbNZgUKCoAxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com>)
 id 1sipy7-000412-BF
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:31 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3IXbNZgUKCoAxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com>)
 id 1sipxl-00068R-Hj
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:13 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-202049f7100so43666485ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741154; x=1725345954; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pcznmppE/eHJmuavNLVdGWiRYNpwz+Bx0fZqgaTbTak=;
 b=0wPhtur+o6nxaI4F9IkSK3iKm5kZ9DEu9jRJkVyx5kHbpSeL7Gxa8v9ZUw2mjRugPg
 hWjKT7cmhFSaROc7z/92H7bp6yNpDnDcUX/9vF13y8Upgj7B64ODOemx3xP0Rm2qn79H
 oXig7rPDLCAzAWdrqn8iGVLnEIfr8G73cS2i1Ao3mTse9n8cIyq4LX4SJX1+QVR0wAT2
 srT7tQoylb1DlOiXVFvWHi6dw3WIh75lIoSaqgNxj3a4BYtfVsb672obk0S6u+PiHtvk
 EwyA0BK33TrunMKCUdiloaUrRDfxKjsTFVoWPgalwe8BEfH54QYnqH/ajR+T2EY8IYbo
 lrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741154; x=1725345954;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pcznmppE/eHJmuavNLVdGWiRYNpwz+Bx0fZqgaTbTak=;
 b=xJWJRDHyFGsExWhqdkOsN4i9KVYGof/n1QGRscU3zTZiukICJFGryhO9rv1iDjVaRD
 28ePz17NoDTI6EmOM7AnQadKrRdAuSDuC0nLwfr1KHAWxvimpO7pgFDkeGPyNQTG1bGn
 Dqw9yyAye2fWmu3vUktXoGmFjUI04mslj0Zw6jmTL24xjtf2FUF2ig6OUwVpNPNFYPX8
 Y9WBMtIFbpRC4aUZ9D+kSeDyhMOICWxd0o2qj7FnCo3FkOxaOP1HdKZieUtUodzTufzr
 Ehm/obLBQ4q6Z9sx3tE14vfclzfYWwa9bkiiaDThmeTqKoYBNuDx8LJmn+otkNgD4PCP
 bNJA==
X-Gm-Message-State: AOJu0Yyu2gXZlPP84r9XWfoWUDoz0LmvQgQjg5Zc5xm0E5yaWHAFFU65
 fjtgE/Xaij9FwPuJOAogh9PI0je04i1ZiaFhZrVpkch2008QRpnVH22/BOQLXlNRLg2L8bGMk+Z
 uLIX9/gsmdScM4skEEO6T1zPbj76vR3VCMLP+Zkjlg1OgYcmQzLjCvefFAtINDdS+o9sUTkWwu9
 QPSoZbKN590wXDMzyHvLDp2TAp8g==
X-Google-Smtp-Source: AGHT+IHycQVyVFqO06SwuTRInRa69Fb/SoeMk/V5DUGLehqqHOkRIiu1G5DG40PCJNHx1GSp/Qq78PGLcw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:903:22ca:b0:201:ed2d:4c4d
 with SMTP id
 d9443c01a7336-2039e4c2504mr6152295ad.5.1724741153474; Mon, 26 Aug 2024
 23:45:53 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:16 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-13-tavip@google.com>
Subject: [RFC PATCH v3 12/24] hw/arm: add basic support for the RT500 SoC
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3IXbNZgUKCoAxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add basic support for the RT500 SoC. It supports enough peripherals to
run the NXP's microXpresso SDK hello world example.

The patch includes an automatically generated header which contains
peripheral base addreses and interrupt numbers.

The header can be regenerated with the svd-rt500 target when the
build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/rt500.h     |  44 +++++
 include/hw/arm/svd/rt500.h |  63 +++++++
 hw/arm/rt500.c             | 335 +++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig             |   2 +
 hw/arm/meson.build         |   1 +
 hw/arm/svd/meson.build     |   4 +
 6 files changed, 449 insertions(+)
 create mode 100644 include/hw/arm/rt500.h
 create mode 100644 include/hw/arm/svd/rt500.h
 create mode 100644 hw/arm/rt500.c

diff --git a/include/hw/arm/rt500.h b/include/hw/arm/rt500.h
new file mode 100644
index 0000000000..66ec82436b
--- /dev/null
+++ b/include/hw/arm/rt500.h
@@ -0,0 +1,44 @@
+/*
+ * i.MX RT500 platforms.
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#ifndef HW_ARM_RT500_H
+#define HW_ARM_RT500_H
+
+#include "hw/arm/armv7m.h"
+#include "hw/misc/flexcomm.h"
+#include "hw/misc/rt500_clkctl0.h"
+#include "hw/misc/rt500_clkctl1.h"
+#include "hw/ssi/flexspi.h"
+#include "hw/misc/rt500_rstctl.h"
+
+#define TYPE_RT500 "rt500"
+#define RT500(obj) OBJECT_CHECK(RT500State, (obj), TYPE_RT500)
+
+#define RT500_FLEXCOMM_NUM (17)
+#define RT500_FLEXSPI_NUM (2)
+#define RT500_RSTCTL_NUM (2)
+
+typedef struct RT500State {
+    SysBusDevice parent_obj;
+
+    ARMv7MState armv7m;
+    MemoryRegion *mem;
+    FlexcommState flexcomm[RT500_FLEXCOMM_NUM];
+    RT500ClkCtl0State clkctl0;
+    RT500ClkCtl1State clkctl1;
+    FlexSpiState flexspi[RT500_FLEXSPI_NUM];
+    RT500RstCtlState rstctl[RT500_RSTCTL_NUM];
+
+    Clock *sysclk;
+    Clock *refclk;
+} RT500State;
+
+#endif /* HW_ARM_RT500_H */
diff --git a/include/hw/arm/svd/rt500.h b/include/hw/arm/svd/rt500.h
new file mode 100644
index 0000000000..3594258f2e
--- /dev/null
+++ b/include/hw/arm/svd/rt500.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#define RT500_FLEXCOMM0_BASE 0x40106000UL
+#define RT500_FLEXCOMM1_BASE 0x40107000UL
+#define RT500_FLEXCOMM2_BASE 0x40108000UL
+#define RT500_FLEXCOMM3_BASE 0x40109000UL
+#define RT500_FLEXCOMM4_BASE 0x40122000UL
+#define RT500_FLEXCOMM5_BASE 0x40123000UL
+#define RT500_FLEXCOMM6_BASE 0x40124000UL
+#define RT500_FLEXCOMM7_BASE 0x40125000UL
+#define RT500_FLEXCOMM14_BASE 0x40126000UL
+#define RT500_FLEXCOMM15_BASE 0x40127000UL
+#define RT500_FLEXCOMM16_BASE 0x40128000UL
+#define RT500_FLEXCOMM8_BASE 0x40209000UL
+#define RT500_FLEXCOMM9_BASE 0x4020A000UL
+#define RT500_FLEXCOMM10_BASE 0x4020B000UL
+#define RT500_FLEXCOMM11_BASE 0x4020C000UL
+#define RT500_FLEXCOMM12_BASE 0x4020D000UL
+#define RT500_FLEXCOMM13_BASE 0x4020E000UL
+
+#define RT500_FLEXCOMM0_IRQn 0x14UL
+#define RT500_FLEXCOMM1_IRQn 0x15UL
+#define RT500_FLEXCOMM2_IRQn 0x16UL
+#define RT500_FLEXCOMM3_IRQn 0x17UL
+#define RT500_FLEXCOMM4_IRQn 0x18UL
+#define RT500_FLEXCOMM5_IRQn 0x19UL
+#define RT500_FLEXCOMM6_IRQn 0x43UL
+#define RT500_FLEXCOMM7_IRQn 0x44UL
+#define RT500_FLEXCOMM14_IRQn 0x20UL
+#define RT500_FLEXCOMM15_IRQn 0x21UL
+#define RT500_FLEXCOMM16_IRQn 0x66UL
+#define RT500_FLEXCOMM8_IRQn 0x60UL
+#define RT500_FLEXCOMM9_IRQn 0x61UL
+#define RT500_FLEXCOMM10_IRQn 0x62UL
+#define RT500_FLEXCOMM11_IRQn 0x63UL
+#define RT500_FLEXCOMM12_IRQn 0x64UL
+#define RT500_FLEXCOMM13_IRQn 0x65UL
+
+#define RT500_CLKCTL0_BASE 0x40001000UL
+
+
+#define RT500_CLKCTL1_BASE 0x40021000UL
+
+
+#define RT500_FLEXSPI0_BASE 0x40134000UL
+
+#define RT500_FLEXSPI0_FLEXSPI1_IRQn 0x42UL
+
+#define RT500_FLEXSPI1_BASE 0x4013C000UL
+
+#define RT500_FLEXSPI0_FLEXSPI1_IRQn 0x42UL
+
+#define RT500_RSTCTL0_BASE 0x40000000UL
+
+
+#define RT500_RSTCTL1_BASE 0x40020000UL
+
+
diff --git a/hw/arm/rt500.c b/hw/arm/rt500.c
new file mode 100644
index 0000000000..2c6d238c18
--- /dev/null
+++ b/hw/arm/rt500.c
@@ -0,0 +1,335 @@
+/*
+ * i.MX RT500 platforms.
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/arm/boot.h"
+#include "hw/boards.h"
+#include "hw/irq.h"
+#include "qemu/log.h"
+#include "qemu/datadir.h"
+#include "qemu/units.h"
+#include "exec/address-spaces.h"
+#include "sysemu/reset.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "hw/arm/armv7m.h"
+#include "hw/loader.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/rt500.h"
+#include "hw/arm/svd/rt500.h"
+
+#define MMAP_SRAM_CODE_BASE   (0x0)
+#define MMAP_SRAM_DATA_BASE   (0x20000000)
+#define MMAP_SRAM_SIZE        (5 * MiB)
+#define MMAP_BOOT_ROM_BASE    (0x03000000)
+#define MMAP_BOOT_ROM_SIZE    (192 * KiB)
+#define MMAP_SDMA_RAM_BASE    (0x24100000)
+#define MMAP_SDMA_RAM_SIZE    (32 * KiB)
+#define MMAP_FLEXSPI0_BASE    (0x08000000)
+#define MMAP_FLEXSPI0_SIZE    (128 * MiB)
+#define MMAP_FLEXSPI1_BASE    (0x28000000)
+#define MMAP_FLEXSPI1_SIZE    (128 * MiB)
+
+#define SECURE_OFFSET (0x10000000)
+
+#define RT500_NUM_IRQ (RT500_FLEXCOMM16_IRQn + 1)
+
+typedef enum MemInfoType {
+    MEM_RAM,
+    MEM_ROM,
+    MEM_ALIAS
+} MemInfoType;
+
+static void do_sys_reset(void *opaque, int n, int level)
+{
+    if (level) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+static void rt500_init(Object *obj)
+{
+    RT500State *s = RT500(obj);
+
+    /* Add ARMv7-M device */
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
+
+    for (int i = 0; i < RT500_FLEXCOMM_NUM; i++) {
+        char *id = g_strdup_printf("flexcomm%d", i);
+
+        object_initialize_child(obj, id, &s->flexcomm[i], TYPE_FLEXCOMM);
+        DEVICE(&s->flexcomm[i])->id = id;
+    }
+
+    object_initialize_child(obj, "clkctl0", &s->clkctl0, TYPE_RT500_CLKCTL0);
+    object_initialize_child(obj, "clkctl1", &s->clkctl1, TYPE_RT500_CLKCTL1);
+
+    /* Initialize clocks */
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
+
+    for (int i = 0; i < RT500_FLEXSPI_NUM; i++) {
+        char *id = g_strdup_printf("flexspi%d", i);
+
+        object_initialize_child(obj, id, &s->flexspi[i], TYPE_FLEXSPI);
+        DEVICE(&s->flexspi[i])->id = id;
+    }
+
+    for (int i = 0; i < RT500_RSTCTL_NUM; i++) {
+        static const char *types[] = {
+            TYPE_RT500_RSTCTL0, TYPE_RT500_RSTCTL1
+        };
+        char *id = g_strdup_printf("rstctl%d", i);
+
+        object_initialize_child(obj, id, &s->rstctl[i], types[i]);
+        DEVICE(&s->rstctl[i])->id = id;
+    }
+}
+
+static void rt500_realize_memory(RT500State *s, Error **errp)
+{
+    static const struct {
+        const char *name;
+        hwaddr base;
+        size_t size;
+        MemInfoType type;
+        int alias_for;
+    } mem_info[] = {
+        {
+            .name = "SRAM (code bus)",
+            .base = MMAP_SRAM_CODE_BASE,
+            .size = MMAP_SRAM_SIZE,
+            .type = MEM_RAM,
+        },
+        {
+            .name = "BOOT-ROM",
+            .base = MMAP_BOOT_ROM_BASE,
+            .size = MMAP_BOOT_ROM_SIZE,
+            .type = MEM_ROM,
+        },
+        {
+            .name = "Smart DMA RAM",
+            .base = MMAP_SDMA_RAM_BASE,
+            .size = MMAP_SDMA_RAM_SIZE,
+            .type = MEM_RAM,
+        },
+        {
+            .name = "SRAM (data bus)",
+            .base = MMAP_SRAM_DATA_BASE,
+            .size = MMAP_SRAM_SIZE,
+            .type = MEM_ALIAS,
+            .alias_for = 0
+        },
+    };
+
+    s->mem = g_malloc_n(2 * ARRAY_SIZE(mem_info), sizeof(MemoryRegion));
+    for (int i = 0; i < ARRAY_SIZE(mem_info); i++) {
+        const char *name = mem_info[i].name;
+        int size = mem_info[i].size;
+        int type = mem_info[i].type;
+        int alias_for = mem_info[i].alias_for;
+        MemoryRegion *mem = &s->mem[i];
+        uint32_t base = mem_info[i].base;
+        MemoryRegion *sec_mem;
+        char sec_name[256];
+
+        switch (type) {
+        case MEM_RAM:
+            memory_region_init_ram(mem, OBJECT(s), name, size, errp);
+            break;
+        case MEM_ROM:
+            memory_region_init_rom(mem, OBJECT(s), name, size, errp);
+            break;
+        case MEM_ALIAS:
+        {
+            MemoryRegion *orig = &s->mem[alias_for];
+
+            memory_region_init_alias(mem, OBJECT(s), name, orig, 0, size);
+            break;
+        }
+        default:
+            g_assert_not_reached();
+        }
+
+        memory_region_add_subregion(get_system_memory(), base, mem);
+
+        /* create secure alias */
+        snprintf(sec_name, sizeof(sec_name), "SECURE %s", name);
+        sec_mem = &s->mem[ARRAY_SIZE(mem_info) + i];
+        if (type == MEM_ALIAS) {
+            mem = &s->mem[alias_for];
+        }
+        memory_region_init_alias(sec_mem, OBJECT(s), sec_name, mem, 0, size);
+        memory_region_add_subregion(get_system_memory(), base + SECURE_OFFSET,
+                                    sec_mem);
+
+        if (mem_info[i].type == MEM_ROM) {
+            char *fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, "rt500.rom");
+
+            if (fname) {
+                int fsize = get_image_size(fname);
+                int ret;
+
+                if (fsize > size) {
+                    error_setg(errp, "rom file too big: %d > %d", fsize, size);
+                } else {
+                    ret = load_image_targphys(fname, base, size);
+                    if (ret < 0) {
+                        error_setg(errp, "could not load rom: %s", fname);
+                    }
+                }
+            }
+            g_free(fname);
+        }
+    }
+}
+
+static void rt500_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    RT500State *s = RT500(dev);
+
+    rt500_realize_memory(s, errp);
+
+    /* Setup ARMv7M CPU */
+    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", RT500_NUM_IRQ);
+    qdev_prop_set_uint8(DEVICE(&s->armv7m), "num-prio-bits", 3);
+    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type", "cortex-m33-arm-cpu");
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
+    if (!ms->kernel_filename) {
+        qdev_prop_set_uint32(DEVICE(&s->armv7m), "init-nsvtor",
+                             MMAP_BOOT_ROM_BASE);
+        qdev_prop_set_uint32(DEVICE(&s->armv7m), "init-svtor",
+                             MMAP_BOOT_ROM_BASE + SECURE_OFFSET);
+    }
+
+    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
+    qdev_connect_clock_in(DEVICE(&s->armv7m), "refclk",
+                     qdev_get_clock_out(DEVICE(&s->clkctl0), "systick_clk"));
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->armv7m), errp);
+    qdev_connect_gpio_out_named(DEVICE(&s->armv7m), "SYSRESETREQ", 0,
+                                qemu_allocate_irq(&do_sys_reset, NULL, 0));
+
+    /* Setup FLEXCOMM */
+    for (int i = 0; i < RT500_FLEXCOMM_NUM; i++) {
+        static const uint32_t addr[] = {
+            RT500_FLEXCOMM0_BASE, RT500_FLEXCOMM1_BASE, RT500_FLEXCOMM2_BASE,
+            RT500_FLEXCOMM3_BASE, RT500_FLEXCOMM4_BASE, RT500_FLEXCOMM5_BASE,
+            RT500_FLEXCOMM6_BASE, RT500_FLEXCOMM7_BASE, RT500_FLEXCOMM8_BASE,
+            RT500_FLEXCOMM8_BASE, RT500_FLEXCOMM10_BASE, RT500_FLEXCOMM11_BASE,
+            RT500_FLEXCOMM12_BASE, RT500_FLEXCOMM13_BASE, RT500_FLEXCOMM14_BASE,
+            RT500_FLEXCOMM15_BASE, RT500_FLEXCOMM16_BASE
+        };
+        static const int irq[] = {
+            RT500_FLEXCOMM0_IRQn, RT500_FLEXCOMM1_IRQn, RT500_FLEXCOMM2_IRQn,
+            RT500_FLEXCOMM3_IRQn, RT500_FLEXCOMM4_IRQn, RT500_FLEXCOMM5_IRQn,
+            RT500_FLEXCOMM6_IRQn, RT500_FLEXCOMM7_IRQn, RT500_FLEXCOMM8_IRQn,
+            RT500_FLEXCOMM9_IRQn, RT500_FLEXCOMM10_IRQn, RT500_FLEXCOMM11_IRQn,
+            RT500_FLEXCOMM12_IRQn, RT500_FLEXCOMM13_IRQn, RT500_FLEXCOMM14_IRQn,
+            RT500_FLEXCOMM15_IRQn, RT500_FLEXCOMM16_IRQn
+        };
+        static const int functions[] = {
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_HSSPI,
+            FLEXCOMM_PMICI2C, FLEXCOMM_HSSPI
+        };
+        DeviceState *ds = DEVICE(&s->flexcomm[i]);
+
+        qdev_prop_set_uint32(ds, "functions", functions[i]);
+        qdev_prop_set_chr(ds, "chardev", qemu_chr_find(ds->id));
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(ds), 0,
+                           qdev_get_gpio_in(DEVICE(&s->armv7m), irq[i]));
+    }
+
+    /* Setup CTLCTL0 */
+    qdev_connect_clock_in(DEVICE(&s->clkctl0), "sysclk", s->sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(DEVICE(&s->clkctl0)), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(DEVICE(&s->clkctl0)), 0, RT500_CLKCTL0_BASE);
+
+    /* Setup CTLCTL1 */
+    qdev_connect_clock_in(DEVICE(&s->clkctl1), "sysclk", s->sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(DEVICE(&s->clkctl1)), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(DEVICE(&s->clkctl1)), 0, RT500_CLKCTL1_BASE);
+
+    /* Setup FlexSPI */
+    for (int i = 0; i < RT500_FLEXSPI_NUM; i++) {
+        static const uint32_t addr[] = {
+            RT500_FLEXSPI0_BASE, RT500_FLEXSPI1_BASE
+        };
+        static const uint32_t mmap_base[] = {
+            MMAP_FLEXSPI0_BASE, MMAP_FLEXSPI1_BASE
+        };
+        static const uint32_t mmap_size[] = {
+            MMAP_FLEXSPI0_SIZE, MMAP_FLEXSPI1_SIZE,
+        };
+        DeviceState *ds = DEVICE(&s->flexspi[i]);
+
+        qdev_prop_set_uint32(ds, "mmap_size", mmap_size[i]);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 1, mmap_base[i]);
+    }
+
+    /* Setup reset controllers */
+    for (int i = 0; i < RT500_RSTCTL_NUM; i++) {
+        DeviceState *ds = DEVICE(&s->rstctl[i]);
+        static const uint32_t addr[] = {
+            RT500_RSTCTL0_BASE, RT500_RSTCTL1_BASE
+        };
+
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
+    }
+}
+
+static void rt500_unrealize(DeviceState *ds)
+{
+    RT500State *s = RT500(ds);
+
+    g_free(s->mem);
+}
+
+static void rt500_reset(DeviceState *ds)
+{
+}
+
+static void rt500_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = rt500_realize;
+    dc->unrealize = rt500_unrealize;
+    dc->desc = "RT500 (ARM Cortex-M33)";
+    dc->reset = rt500_reset;
+}
+
+static const TypeInfo rt500_types[] = {
+    {
+        .name = TYPE_RT500,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(RT500State),
+        .instance_init = rt500_init,
+        .class_init = rt500_class_init,
+    },
+};
+
+DEFINE_TYPES(rt500_types);
+
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 668135bc85..d1443e8f89 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -717,3 +717,5 @@ config RT500
     bool
     select FLEXCOMM
     select RT500_CLKCTL
+    select FLEXSPI
+    select RT500_RSTCTL
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index eb604d00cf..7d827d512c 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,6 +59,7 @@ arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
+arm_ss.add(when: 'CONFIG_RT500', if_true: files('rt500.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 25f4917089..b7480e7d48 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -28,4 +28,8 @@ if get_option('mcux-soc-svd')
   run_target('svd-rt500-rstctl1', command: svd_gen_header +
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_rstctl1.h',
       '-p', 'RSTCTL1', '-t', 'RT500_RSTCTL1'])
+  run_target('svd-rt500', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500.h',
+      '-s', 'RT500', '-p', 'FLEXCOMM0', '-p', 'CLKCTL0', '-p', 'CLKCTL1',
+      '-p', 'FLEXSPI0', '-p', 'FLEXSPI1', '-p', 'RSTCTL0', '-p', 'RSTCTL1'])
 endif
-- 
2.46.0.295.g3b9ea8a38a-goog


