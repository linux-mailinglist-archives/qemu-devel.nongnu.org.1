Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F06708295A1
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:04:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUQ2-0001bu-Ap; Wed, 10 Jan 2024 03:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPu-0001YH-VH
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:31 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPr-0003bR-V4
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:30 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bbd6e37af4so3358953b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877107; x=1705481907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kQeFrDgirXLRD3F4Gx8RwXStxG8V2Ahl3eb2io1Op8=;
 b=hs2hP0jhP2byh4R/fqNvQr9how2iWqqex5xsDvkXeIN5Rp2JsKoPnRZ734RLwZK0nn
 VFwvDPennkDzR2bu2SmtObpd/z4zRjKSwhtfgnyNzp6SbI+lMnQ2VV34uZq1wUajuIei
 rXOIsd+2nhcBC+fxc0rpc2ySCmTgI9JJhDFNeXWS81o+NW4EtMZpIoAAwh00xlukXdmZ
 ToJFU+nqPKbM4Ebhuuk5n+B40x7aZSsnIgmxPalnzbfsbfdKgoa2xMyu23ZkU1tNjiGt
 x3h9xVV+QW0VjKuTgvUJ5LPv0gZQelYajSKRlTTq/5s0a5cdTL5D2n1LD//tLzou9Jfr
 jtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877107; x=1705481907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kQeFrDgirXLRD3F4Gx8RwXStxG8V2Ahl3eb2io1Op8=;
 b=Ac5+sYdkLm4nHQsmahEda18B0HkFZpTzWTEFJDQtY4OKi1DPqL0QHY/AGvfz9ndXZ6
 Ig6gykSdXIuTFUxbB+qY/VYXmrYAFwHqJVM1I6vybSykUF2gUtyc+OV5a1XMNGpzXQV9
 uX85XlZVn6nWG4mGEIgRNa3Dhy+r+bDFUDjlGJyMUIy/NRSGRopfwiKDKJ/pTX/qw64s
 Bf7Ut28b8sQm74idc4D0sVLQNM1sa2nc4H2NuG3+UsbAkrHc+tiUTrvmSgOpOXLkTGlj
 qRFjJLE/BrOP+8fI6y/XZoIXn6paAGZ72wNWaKHy8jk0o6Eo0EP282RPKOqR9B0ORd+x
 Kr4Q==
X-Gm-Message-State: AOJu0YzBRJ2HBm/y6Nr2KfphhSWEXLThkBMLpSAZNUr2dFuQzlZFt8eh
 1tIikA9TjJ+ct8C8HpiETYMOcNWyQEMSIXbQ
X-Google-Smtp-Source: AGHT+IEw5hR/A3GVLEQ6XbKA5ZT6prTfg9WDRu13nuelo+E0tRcDECDYg8Z18qlQ5Cj0Gxx3G/1htg==
X-Received: by 2002:a05:6808:2393:b0:3bd:3932:20db with SMTP id
 bp19-20020a056808239300b003bd393220dbmr867871oib.14.1704877106742; 
 Wed, 10 Jan 2024 00:58:26 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:26 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 12/65] hw/arm/virt-acpi-build.c: Migrate fw_cfg creation to
 common location
Date: Wed, 10 Jan 2024 18:56:40 +1000
Message-ID: <20240110085733.1607526-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
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

RISC-V also needs to use the same code to create fw_cfg in DSDT. So,
avoid code duplication by moving the code in arm and riscv to a device
specific file.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231218150247.466427-2-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/nvram/fw_cfg_acpi.h | 15 +++++++++++++++
 hw/arm/virt-acpi-build.c       | 19 ++-----------------
 hw/nvram/fw_cfg-acpi.c         | 23 +++++++++++++++++++++++
 hw/riscv/virt-acpi-build.c     | 19 ++-----------------
 hw/nvram/meson.build           |  1 +
 5 files changed, 43 insertions(+), 34 deletions(-)
 create mode 100644 include/hw/nvram/fw_cfg_acpi.h
 create mode 100644 hw/nvram/fw_cfg-acpi.c

diff --git a/include/hw/nvram/fw_cfg_acpi.h b/include/hw/nvram/fw_cfg_acpi.h
new file mode 100644
index 0000000000..b6553d86fc
--- /dev/null
+++ b/include/hw/nvram/fw_cfg_acpi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * ACPI support for fw_cfg
+ *
+ */
+
+#ifndef FW_CFG_ACPI_H
+#define FW_CFG_ACPI_H
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+
+void fw_cfg_acpi_dsdt_add(Aml *scope, const MemMapEntry *fw_cfg_memmap);
+
+#endif
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5e7cf6c6b3..b6edf9db00 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -35,7 +35,7 @@
 #include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
-#include "hw/nvram/fw_cfg.h"
+#include "hw/nvram/fw_cfg_acpi.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
@@ -94,21 +94,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
     aml_append(scope, dev);
 }
 
-static void acpi_dsdt_add_fw_cfg(Aml *scope, const MemMapEntry *fw_cfg_memmap)
-{
-    Aml *dev = aml_device("FWCF");
-    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
-    /* device present, functioning, decoding, not shown in UI */
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
-
-    Aml *crs = aml_resource_template();
-    aml_append(crs, aml_memory32_fixed(fw_cfg_memmap->base,
-                                       fw_cfg_memmap->size, AML_READ_WRITE));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-    aml_append(scope, dev);
-}
-
 static void acpi_dsdt_add_flash(Aml *scope, const MemMapEntry *flash_memmap)
 {
     Aml *dev, *crs;
@@ -864,7 +849,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     if (vmc->acpi_expose_flash) {
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
-    acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
+    fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
     acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, vms);
diff --git a/hw/nvram/fw_cfg-acpi.c b/hw/nvram/fw_cfg-acpi.c
new file mode 100644
index 0000000000..4e48baeaa0
--- /dev/null
+++ b/hw/nvram/fw_cfg-acpi.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Add fw_cfg device in DSDT
+ *
+ */
+
+#include "hw/nvram/fw_cfg_acpi.h"
+#include "hw/acpi/aml-build.h"
+
+void fw_cfg_acpi_dsdt_add(Aml *scope, const MemMapEntry *fw_cfg_memmap)
+{
+    Aml *dev = aml_device("FWCF");
+    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
+    /* device present, functioning, decoding, not shown in UI */
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
+    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(fw_cfg_memmap->base,
+                                       fw_cfg_memmap->size, AML_READ_WRITE));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index d3bfaf502e..fc04d1defa 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -28,6 +28,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
+#include "hw/nvram/fw_cfg_acpi.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
@@ -97,22 +98,6 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
     }
 }
 
-static void acpi_dsdt_add_fw_cfg(Aml *scope, const MemMapEntry *fw_cfg_memmap)
-{
-    Aml *dev = aml_device("FWCF");
-    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
-
-    /* device present, functioning, decoding, not shown in UI */
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
-
-    Aml *crs = aml_resource_template();
-    aml_append(crs, aml_memory32_fixed(fw_cfg_memmap->base,
-                                       fw_cfg_memmap->size, AML_READ_WRITE));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-    aml_append(scope, dev);
-}
-
 /* RHCT Node[N] starts at offset 56 */
 #define RHCT_NODE_ARRAY_OFFSET 56
 
@@ -226,7 +211,7 @@ static void build_dsdt(GArray *table_data,
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, s);
 
-    acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
+    fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
 
     aml_append(dsdt, scope);
 
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 75e415b1a0..4996c72456 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -17,3 +17,4 @@ system_ss.add(when: 'CONFIG_XLNX_EFUSE_ZYNQMP', if_true: files(
 system_ss.add(when: 'CONFIG_XLNX_BBRAM', if_true: files('xlnx-bbram.c'))
 
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
+specific_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
-- 
2.43.0


