Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 915547F3D73
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 06:39:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5fwO-0002dX-QB; Wed, 22 Nov 2023 00:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwM-0002dB-Vq
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:23 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwL-00079c-00
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:22 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cf678043fdso19789655ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 21:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700631499; x=1701236299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8CW4PWbEPru8lgh4qRFI+Ky/lG8EKD33qb1ErlTZ+Q=;
 b=LWNQ4WoMXgYivC05yepwbGEfMYRtxnJ4wYWVgFdZgiA8+BX7zFyzAr+FcoG3qXhva/
 CwJQdCgRPxRN3d8cWcKT3mkcXrV5cOxchtoiX+m8dmXbGs68T34dy2jiq/dEkjr/zjD6
 M9usNVXoNRYBqdazPc60cdqvVq0PQZt8J82/gVmYVfzmba3OnilDDOlCyYxEd4CMyirn
 ZpcdTXHChkd9qfmI3E1SfpGdUsnrZBmfVmvJ2pmwi/YWPk4KHx+/Hx83smfrJz0vT75q
 whPYQvbvZWU1knc5GiFr7zMzDr/yUGdVsrVMwAQf+TyxThJ/lVYWiIL6QJtr7dgh01lY
 PZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700631499; x=1701236299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8CW4PWbEPru8lgh4qRFI+Ky/lG8EKD33qb1ErlTZ+Q=;
 b=lkL4FC+8Yy94S2CjRePLhMvOUIiFaXBOj5ExVVoa3fG1A3wSSAmJYA2Sb4ggG35YFg
 L1vYFx1QVnDnnDHCUNRc8ViAr4duiY/TzdQgzHLloozhiTCgXClMEC86j5YpEgJ3Jwgs
 T2zH8cTWmV55teDXqk8DnfTaHFv9Spn1Tm67w/DORgnboC0mTEsWhVbukRZcECsCzYNi
 YuHuVLFM4RvqKfFePUlpnfXxcYu9m7uFyIQTafrQXRfoGcZ4j9a83cQU6/HLASG9F5EJ
 H1Ui50cVWNtr+5O8LcO9a3mH1e5+mz6DsBvkiRBEsL09U9VyeTTD7KYY+ByJpGrzt587
 FWow==
X-Gm-Message-State: AOJu0YxcIZibB7RvKzH7zn+HjW1Xzm2Hc5qDvILs6gAMY5YY7+EJQYYT
 9ryQE5Sx1wBcxQDB9LnmF7gv17vy9tYKMQ==
X-Google-Smtp-Source: AGHT+IFlCYdeKffbUpunpVWkHtv2++yS91HOTian/g2Gv6g7Qfq7WIHGAFYT3lNIGvla/LDmhgCoXw==
X-Received: by 2002:a17:903:18f:b0:1cc:6e8f:c14e with SMTP id
 z15-20020a170903018f00b001cc6e8fc14emr1859363plg.15.1700631499251; 
 Tue, 21 Nov 2023 21:38:19 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001c0a4146961sm8923952plh.19.2023.11.21.21.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 21:38:18 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 2/6] hw/riscv/virt.c: do create_fdt() earlier,
 add finalize_fdt()
Date: Wed, 22 Nov 2023 15:37:56 +1000
Message-ID: <20231122053800.1531799-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122053800.1531799-1-alistair.francis@wdc.com>
References: <20231122053800.1531799-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 49554856f0 fixed a problem, where TPM devices were not appearing
in the FDT, by delaying the FDT creation up until virt_machine_done().
This create a side effect (see gitlab #1925) - devices that need access
to the '/chosen' FDT node during realize() stopped working because, at
that point, we don't have a FDT.

This happens because our FDT creation is monolithic, but it doesn't need
to be. We can add the needed FDT components for realize() time and, at
the same time, do another FDT round where we account for dynamic sysbus
devices.  In other words, the problem fixed by 49554856f0 could also be
fixed by postponing only create_fdt_sockets() and its dependencies,
leaving everything else from create_fdt() to be done during init().

Split the FDT creation in two parts:

- create_fdt(), now moved back to virt_machine_init(), will create FDT
  nodes that doesn't depend on additional (dynamic) devices from the
  sysbus;

- a new finalize_fdt() step is added, where create_fdt_sockets() and
  friends is executed, accounting for the dynamic sysbus devices that
  were added during realize().

This will make both use cases happy: TPM devices are still working as
intended, and devices such as 'guest-loader' have a FDT to work on
during realize().

Fixes: 49554856f0 ("riscv: Generate devicetree only after machine initialization is complete")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1925
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231110172559.73209-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 71 +++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c7fc97e273..d2eac24156 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -962,7 +962,6 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", UART0_IRQ, 0x4);
     }
 
-    qemu_fdt_add_subnode(ms->fdt, "/chosen");
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
     g_free(name);
 }
@@ -1023,11 +1022,29 @@ static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
     g_free(nodename);
 }
 
-static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
+static void finalize_fdt(RISCVVirtState *s)
 {
-    MachineState *ms = MACHINE(s);
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
     uint32_t irq_pcie_phandle = 1, irq_virtio_phandle = 1;
+
+    create_fdt_sockets(s, virt_memmap, &phandle, &irq_mmio_phandle,
+                       &irq_pcie_phandle, &irq_virtio_phandle,
+                       &msi_pcie_phandle);
+
+    create_fdt_virtio(s, virt_memmap, irq_virtio_phandle);
+
+    create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle);
+
+    create_fdt_reset(s, virt_memmap, &phandle);
+
+    create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
+
+    create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
+}
+
+static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
+{
+    MachineState *ms = MACHINE(s);
     uint8_t rng_seed[32];
 
     ms->fdt = create_device_tree(&s->fdt_size);
@@ -1047,28 +1064,16 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
 
-    create_fdt_sockets(s, memmap, &phandle, &irq_mmio_phandle,
-                       &irq_pcie_phandle, &irq_virtio_phandle,
-                       &msi_pcie_phandle);
-
-    create_fdt_virtio(s, memmap, irq_virtio_phandle);
-
-    create_fdt_pcie(s, memmap, irq_pcie_phandle, msi_pcie_phandle);
-
-    create_fdt_reset(s, memmap, &phandle);
-
-    create_fdt_uart(s, memmap, irq_mmio_phandle);
-
-    create_fdt_rtc(s, memmap, irq_mmio_phandle);
-
-    create_fdt_flash(s, memmap);
-    create_fdt_fw_cfg(s, memmap);
-    create_fdt_pmu(s);
+    qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
     /* Pass seed to RNG */
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
     qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
                      rng_seed, sizeof(rng_seed));
+
+    create_fdt_flash(s, memmap);
+    create_fdt_fw_cfg(s, memmap);
+    create_fdt_pmu(s);
 }
 
 static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
@@ -1257,15 +1262,12 @@ static void virt_machine_done(Notifier *notifier, void *data)
     uint64_t kernel_entry = 0;
     BlockBackend *pflash_blk0;
 
-    /* load/create device tree */
-    if (machine->dtb) {
-        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
-        if (!machine->fdt) {
-            error_report("load_device_tree() failed");
-            exit(1);
-        }
-    } else {
-        create_fdt(s, memmap);
+    /*
+     * An user provided dtb must include everything, including
+     * dynamic sysbus devices. Our FDT needs to be finalized.
+     */
+    if (machine->dtb == NULL) {
+        finalize_fdt(s);
     }
 
     /*
@@ -1541,6 +1543,17 @@ static void virt_machine_init(MachineState *machine)
     }
     virt_flash_map(s, system_memory);
 
+    /* load/create device tree */
+    if (machine->dtb) {
+        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
+        if (!machine->fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+    } else {
+        create_fdt(s, memmap);
+    }
+
     s->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
-- 
2.42.0


