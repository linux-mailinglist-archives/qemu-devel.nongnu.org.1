Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A932C859212
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Feb 2024 20:27:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQKf-0001rO-H8; Sat, 17 Feb 2024 14:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKd-0001qY-MK
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:39 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKb-0004UJ-Kx
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:39 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d944e8f367so29217145ad.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708197995; x=1708802795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUNIfOBkHjYLuvOH/rpRmRcQF/okub2SyllhTNRVXOo=;
 b=DK8Q50L1fVjV0EihpgZ7L8RAhXKVWrBQREyYd1/+DA+Ihfj6zJCf5JvN2bHivb6whF
 RdZByP6OwNpHDCrwBV5GT2WgvMc+KTBl2kq/wPJXUFeuqmbj6vqHxGKmp96SK6bWgXfB
 dACTqxDBzCcka4IbBYEOeTrFrUJoEtYLslRM08XofW3Kg/sYyXf9e1SBYhCxcMioJl6v
 DHNHc6QzC+2qmCDMEaHdgY8c/N8FBVCVoja5TAjCMtV7xhVSvyXt8vsCCTPSA2/stefY
 udfc/NQK7CD1VnUvwbburr2KIoA8AMoKJ5giplsYvnlSv2rIt8uokSyIJl+g06LtoGkk
 Kc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708197995; x=1708802795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUNIfOBkHjYLuvOH/rpRmRcQF/okub2SyllhTNRVXOo=;
 b=SyGCGPJ+9LXy8F32toZzRWgQO6YIsq3qm5l2GTzhtWdcL0K3jN4uyIapfdYlub8lHe
 kRgWRinCGvyEMBDb6hVmYvlQQlkxOT6ZEfmAa46Rx+o0Qlnc9n1Sen/+tUUQwIJnT9RN
 vRk5QOZZMLY8M5u1QI5MiIg/TPeUW4K6K6z1RGdIlHDRkRQUDAMV/Unrf+x9qtjFqmxh
 QdGY0O/xeGc7o7w0nlsCaBH54/AFsu082nSUA98g0B0shrGxmBvfHyiMDUXAOyCxoix+
 sbkUTqK3UlitTHm9XkgmXjoov1VylxsHrRL/Y13Xr9x7LAmByDxPa1rHlh7r1dD8LicE
 2ysA==
X-Gm-Message-State: AOJu0YzfGyncUCH/IYCn93tUFbB+RmzQZnZeiy2Llhqho19ulYJH2Npa
 /Z+pzZCGKxrGRn2uMY7eV1cSnX7fKjX5R6IBJ3pv89/oYQWH5gBkWfd8HNiLZuy8SXnzuwesQ5H
 S
X-Google-Smtp-Source: AGHT+IEaBmVD3Mc5pIFt4cmzTnKlv3giDxE/iZEdbB3jshNXbNpyUoi/FNe4KVjpn0lHRJwnSubRUQ==
X-Received: by 2002:a17:902:c40e:b0:1db:5b41:c5ac with SMTP id
 k14-20020a170902c40e00b001db5b41c5acmr10309421plk.68.1708197995018; 
 Sat, 17 Feb 2024 11:26:35 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 p3-20020a170902c70300b001db86c48221sm1770927plp.22.2024.02.17.11.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 11:26:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 6/6] tests/libqos: add riscv/virt machine nodes
Date: Sat, 17 Feb 2024 16:26:07 -0300
Message-ID: <20240217192607.32565-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217192607.32565-1-dbarboza@ventanamicro.com>
References: <20240217192607.32565-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a RISC-V 'virt' machine to the graph. This implementation is a
modified copy of the existing arm machine in arm-virt-machine.c

It contains a virtio-mmio and a generic-pcihost controller. The
generic-pcihost controller hardcodes assumptions from the ARM 'virt'
machine, like ecam and pio_base addresses, so we'll add an extra step to
set its parameters after creating it.

Our command line is incremented with 'aclint' parameters to allow the
machine to run MSI tests.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqos/meson.build          |   1 +
 tests/qtest/libqos/riscv-virt-machine.c | 137 ++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tests/qtest/libqos/riscv-virt-machine.c

diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 90aae42a22..3aed6efcb8 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -60,6 +60,7 @@ libqos_srcs = files(
         'arm-xilinx-zynq-a9-machine.c',
         'ppc64_pseries-machine.c',
         'x86_64_pc-machine.c',
+        'riscv-virt-machine.c',
 )
 
 if have_virtfs
diff --git a/tests/qtest/libqos/riscv-virt-machine.c b/tests/qtest/libqos/riscv-virt-machine.c
new file mode 100644
index 0000000000..c4364c9c5d
--- /dev/null
+++ b/tests/qtest/libqos/riscv-virt-machine.c
@@ -0,0 +1,137 @@
+/*
+ * libqos driver framework for risc-v
+ *
+ * Initial version based on arm-virt-machine.c
+ *
+ * Copyright (c) 2024 Ventana Micro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2.1 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "../libqtest.h"
+#include "qemu/module.h"
+#include "libqos-malloc.h"
+#include "qgraph.h"
+#include "virtio-mmio.h"
+#include "generic-pcihost.h"
+#include "hw/pci/pci_regs.h"
+
+#define RISCV_PAGE_SIZE            4096
+
+/* VIRT_DRAM */
+#define RISCV_VIRT_RAM_ADDR        0x80000000
+#define RISCV_VIRT_RAM_SIZE        0x20000000
+
+/*
+ * VIRT_VIRTIO. BASE_ADDR  points to the last
+ * virtio_mmio device.
+ */
+#define VIRTIO_MMIO_BASE_ADDR      0x10008000
+#define VIRTIO_MMIO_SIZE           0x00001000
+
+/* VIRT_PCIE_PIO  */
+#define RISCV_GPEX_PIO_BASE        0x3000000
+#define RISCV_BUS_PIO_LIMIT        0x10000
+
+/* VIRT_PCIE_MMIO */
+#define RISCV_BUS_MMIO_ALLOC_PTR   0x40000000
+#define RISCV_BUS_MMIO_LIMIT       0x80000000
+
+/* VIRT_PCIE_ECAM */
+#define RISCV_ECAM_ALLOC_PTR   0x30000000
+
+typedef struct QVirtMachine QVirtMachine;
+
+struct QVirtMachine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QVirtioMMIODevice virtio_mmio;
+    QGenericPCIHost bridge;
+};
+
+static void virt_destructor(QOSGraphObject *obj)
+{
+    QVirtMachine *machine = (QVirtMachine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *virt_get_driver(void *object, const char *interface)
+{
+    QVirtMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in riscv/virtio\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *virt_get_device(void *obj, const char *device)
+{
+    QVirtMachine *machine = obj;
+    if (!g_strcmp0(device, "generic-pcihost")) {
+        return &machine->bridge.obj;
+    } else if (!g_strcmp0(device, "virtio-mmio")) {
+        return &machine->virtio_mmio.obj;
+    }
+
+    fprintf(stderr, "%s not present in riscv/virt\n", device);
+    g_assert_not_reached();
+}
+
+static void riscv_config_qpci_bus(QGenericPCIBus *qpci)
+{
+    qpci->gpex_pio_base = RISCV_GPEX_PIO_BASE;
+    qpci->bus.pio_limit = RISCV_BUS_PIO_LIMIT;
+
+    qpci->bus.mmio_alloc_ptr = RISCV_BUS_MMIO_ALLOC_PTR;
+    qpci->bus.mmio_limit = RISCV_BUS_MMIO_LIMIT;
+
+    qpci->ecam_alloc_ptr = RISCV_ECAM_ALLOC_PTR;
+}
+
+static void *qos_create_machine_riscv_virt(QTestState *qts)
+{
+    QVirtMachine *machine = g_new0(QVirtMachine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               RISCV_VIRT_RAM_ADDR,
+               RISCV_VIRT_RAM_ADDR + RISCV_VIRT_RAM_SIZE,
+               RISCV_PAGE_SIZE);
+    qvirtio_mmio_init_device(&machine->virtio_mmio, qts, VIRTIO_MMIO_BASE_ADDR,
+                              VIRTIO_MMIO_SIZE);
+
+    qos_create_generic_pcihost(&machine->bridge, qts, &machine->alloc);
+    riscv_config_qpci_bus(&machine->bridge.pci);
+
+    machine->obj.get_device = virt_get_device;
+    machine->obj.get_driver = virt_get_driver;
+    machine->obj.destructor = virt_destructor;
+    return machine;
+}
+
+static void virt_machine_register_nodes(void)
+{
+    qos_node_create_machine_args("riscv32/virt", qos_create_machine_riscv_virt,
+                                 "aclint=on,aia=aplic-imsic");
+    qos_node_contains("riscv32/virt", "virtio-mmio", NULL);
+    qos_node_contains("riscv32/virt", "generic-pcihost", NULL);
+
+    qos_node_create_machine_args("riscv64/virt", qos_create_machine_riscv_virt,
+                                 "aclint=on,aia=aplic-imsic");
+    qos_node_contains("riscv64/virt", "virtio-mmio", NULL);
+    qos_node_contains("riscv64/virt", "generic-pcihost", NULL);
+}
+
+libqos_init(virt_machine_register_nodes);
-- 
2.43.2


