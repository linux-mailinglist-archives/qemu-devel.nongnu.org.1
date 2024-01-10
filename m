Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA18D8295BE
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUQy-0004GZ-25; Wed, 10 Jan 2024 03:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQe-0004CG-HG
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:16 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQc-000416-BK
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:16 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6dac8955af0so2105250b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877153; x=1705481953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w86nYECoDMS6Sq6IwosfgDMSNY82wviRMUl/OBcsm7s=;
 b=K0kb0dxAVz4RZfScSahQCTLrnq1CEQri+DMlHzACc3Bp1QWj32vGAoHFA3V2yfomZJ
 mDR5Qxjx+W2U8j0wNAyBeQIG0R0Bzj53XBaJyg+3gQLtAt7z5MbIPCGkmPUGLY+MT0cO
 JkpDSPvUlQ4OLNCNtKzMz/OFM5iLHVAwII4zSRFpTSjtte6GmnitAtRpUwmfgSB9eQja
 Z8QGyLbG4LClL0AiglhxkNPpIfDZ4LW0wANONHFT6nv2RT7Rzrrq02PjZvPn5xIExwDn
 znrYqiWFpp3GVvwQxhdLcRvCie3mNqsg+H0G79P90PR4uJHxzRXRckRX90RM07iN8+Yv
 2kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877153; x=1705481953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w86nYECoDMS6Sq6IwosfgDMSNY82wviRMUl/OBcsm7s=;
 b=nQccYomA7yVi1z38/WgcuSZdkQJL55rQ3cwpzTfOFzsHkOuPP6VTRoR8Buae+/dS8O
 wRA7BXl7o/9WPBKH3ZosPwr5wRubKyldGK26ut0ujpqYZok+ly/A4Keve7+JkZzYKbaD
 o/UIxqBAIbDzLsY5rWc+QrFqVmHmiV29+glAUqs48/ODIdhrlu63OyVgjGxMigVIsIyc
 1HlVaGoTCeUsP1iDEx3HbNqX9unNWAI5mpuadY0oIeYGtLnYKtlUKlO4n7znfkZieJeQ
 OZ+XSwZQJ1RxlML0DbodtnG8X6CmjWu82Lr00gFkbjIftGejEW7cwWlbywB+1oUKDRsB
 FHFw==
X-Gm-Message-State: AOJu0YzJQsS+jGnw7VzEtaqS5ZFO/Q63q/kdH7iJOvI/3Dl+ajT6lfCX
 c4Vbuz/mgEzUvH5ztZ6EKfcyy8zinfe20xFt
X-Google-Smtp-Source: AGHT+IE99Qbd5y2vLzP6l+Fu1SkjiRbLU6zvb8sp8/BXeVyNkvoax8ToOyJtbLu1xbHSgvlOTkCmUQ==
X-Received: by 2002:a05:6a00:2e20:b0:6d9:a658:16a9 with SMTP id
 fc32-20020a056a002e2000b006d9a65816a9mr628998pfb.69.1704877152699; 
 Wed, 10 Jan 2024 00:59:12 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:12 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 23/65] hw/riscv/virt-acpi-build.c: Add IO controllers and
 devices
Date: Wed, 10 Jan 2024 18:56:51 +1000
Message-ID: <20240110085733.1607526-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: Sunil V L <sunilvl@ventanamicro.com>

Add basic IO controllers and devices like PCI, VirtIO and UART in the
ACPI namespace.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231218150247.466427-13-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 79 ++++++++++++++++++++++++++++++++++++--
 hw/riscv/Kconfig           |  1 +
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index b7db57b28a..536e6b0243 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -27,15 +27,18 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/pci.h"
 #include "hw/acpi/utils.h"
+#include "hw/intc/riscv_aclint.h"
 #include "hw/nvram/fw_cfg_acpi.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/riscv/virt.h"
+#include "hw/riscv/numa.h"
+#include "hw/virtio/virtio-acpi.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
-#include "migration/vmstate.h"
-#include "hw/riscv/virt.h"
-#include "hw/riscv/numa.h"
-#include "hw/intc/riscv_aclint.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
@@ -132,6 +135,39 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
     }
 }
 
+static void
+acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
+                    uint32_t uart_irq)
+{
+    Aml *dev = aml_device("COM0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(uart_memmap->base,
+                                         uart_memmap->size, AML_READ_WRITE));
+    aml_append(crs,
+                aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                               AML_EXCLUSIVE, &uart_irq, 1));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    Aml *pkg = aml_package(2);
+    aml_append(pkg, aml_string("clock-frequency"));
+    aml_append(pkg, aml_int(3686400));
+
+    Aml *UUID = aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301");
+
+    Aml *pkg1 = aml_package(1);
+    aml_append(pkg1, pkg);
+
+    Aml *package = aml_package(2);
+    aml_append(package, UUID);
+    aml_append(package, pkg1);
+
+    aml_append(dev, aml_name_decl("_DSD", package));
+    aml_append(scope, dev);
+}
+
 /* RHCT Node[N] starts at offset 56 */
 #define RHCT_NODE_ARRAY_OFFSET 56
 
@@ -310,6 +346,8 @@ static void build_dsdt(GArray *table_data,
                        RISCVVirtState *s)
 {
     Aml *scope, *dsdt;
+    MachineState *ms = MACHINE(s);
+    uint8_t socket_count;
     const MemMapEntry *memmap = s->memmap;
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = s->oem_id,
                         .oem_table_id = s->oem_table_id };
@@ -329,6 +367,29 @@ static void build_dsdt(GArray *table_data,
 
     fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
 
+    socket_count = riscv_socket_count(ms);
+
+    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
+
+    if (socket_count == 1) {
+        virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
+                             memmap[VIRT_VIRTIO].size,
+                             VIRTIO_IRQ, 0, VIRTIO_COUNT);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ);
+    } else if (socket_count == 2) {
+        virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
+                             memmap[VIRT_VIRTIO].size,
+                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
+                             VIRTIO_COUNT);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES);
+    } else {
+        virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
+                             memmap[VIRT_VIRTIO].size,
+                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
+                             VIRTIO_COUNT);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
+    }
+
     aml_append(dsdt, scope);
 
     /* copy AML table into ACPI tables blob and patch header there */
@@ -465,6 +526,16 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_rhct(tables_blob, tables->linker, s);
 
+    acpi_add_table(table_offsets, tables_blob);
+    {
+        AcpiMcfgInfo mcfg = {
+           .base = s->memmap[VIRT_PCIE_MMIO].base,
+           .size = s->memmap[VIRT_PCIE_MMIO].size,
+        };
+        build_mcfg(tables_blob, tables->linker, &mcfg, s->oem_id,
+                   s->oem_table_id);
+    }
+
     /* XSDT is pointed to by RSDP */
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index b6a5eb4452..a50717be87 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -45,6 +45,7 @@ config RISCV_VIRT
     select FW_CFG_DMA
     select PLATFORM_BUS
     select ACPI
+    select ACPI_PCI
 
 config SHAKTI_C
     bool
-- 
2.43.0


