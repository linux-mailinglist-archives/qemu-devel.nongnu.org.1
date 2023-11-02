Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E616D7DF84A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:05:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyb5g-0002dw-JQ; Thu, 02 Nov 2023 13:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qyb5e-0002dA-Mx
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:02:42 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qyb5c-0003Zy-R3
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:02:42 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2806cbd43b8so1077828a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698944559; x=1699549359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5R+ST1Gs2FCSwHeJBLallj2l86x2vSPEB38tW8j6/yA=;
 b=acicIm7am2U11WEdWF9mxspw68S5wz1jV4zHcSX0KRsZczfTLzR7PC8zOiqCX9rEs+
 E5IY6VBUcGA605Rq+cEEiueL40o1dvo/jYOc7zqnrbuJZDyDYp5Nx4Yz5toJNMPEW5A6
 PvXfr7Mfakf71dyVZZZBy8ui8sKIvHzewpFVaFEt7Sx0Dn7sMT8p/uNMhTfsWfhi8H2+
 fRCb9p35ERKUCgmBpqK/yaBS+3KPbujoWI0QvQXRvWQd6ZtVIJu1GITTYa4iuJVtYjWA
 R3KQwkkovu1hcDMACspTFXu5+FXxEhx1N9SX4/Au57wNBHwfz2DFB3p/OegWJ2/EmfZD
 Qwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698944559; x=1699549359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5R+ST1Gs2FCSwHeJBLallj2l86x2vSPEB38tW8j6/yA=;
 b=vZHsWo9jN1HMp4VPwaFys7htTspc/VUbf1WvbH9nxLgZF/X+u8I87T37R+oDfz3j8/
 Ue4lv7p31lAGGs6xmNPQUC9pJFcLGLWbaO2CmJu0Dz1IBgdvm80NMwNER9pRcomyDmHK
 3wI32fEOu5gJ7kFQDIdxNaYBD64w8m4An0OMDCMHv2/IoJgvgCTrv1sXws+kfA6/E4Ud
 obVhVIEZTyx3zYzGUuzwL+cGZV5YkV9kJrjg9ZVd/CuyXnBtGlivVUzq7PMCT31Jk0ey
 zzankpWKbF/Ao+OA5sVE7mi9wQIs5yAei5FRa6gNw57BHt/oho9bQTWq9wxM1fZyAM3q
 ZvtA==
X-Gm-Message-State: AOJu0YzAbOBHbFzAx5HgYjloOYXreJJrBX1CRORB4Qq1qhtx/1hUzBL3
 YZ3v7tII0TLL1Bw/ySJRR7KNuQ==
X-Google-Smtp-Source: AGHT+IH1b7z0yoMOAKybAvRMAe922dfdbdxLWUj4jf8Ka1iqtSFnLXsoU27jyX7SLqfi+rkNzqThnw==
X-Received: by 2002:a17:90b:304:b0:280:2856:5ef8 with SMTP id
 ay4-20020a17090b030400b0028028565ef8mr13760000pjb.30.1698944559593; 
 Thu, 02 Nov 2023 10:02:39 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
 by smtp.gmail.com with ESMTPSA id
 18-20020a17090a031200b0026b70d2a8a2sm25098pje.29.2023.11.02.10.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:02:39 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 01/13] hw/arm/virt-acpi-build.c: Migrate fw_cfg creation to
 common location
Date: Thu,  2 Nov 2023 22:32:11 +0530
Message-Id: <20231102170223.2619260-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102170223.2619260-1-sunilvl@ventanamicro.com>
References: <20231102170223.2619260-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

RISC-V also needs to use the same code to create fw_cfg in DSDT. So,
avoid code duplication by moving the code in arm and riscv to a device
specific file.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c       | 19 ++-----------------
 hw/nvram/fw_cfg-acpi.c         | 23 +++++++++++++++++++++++
 hw/nvram/meson.build           |  1 +
 hw/riscv/virt-acpi-build.c     | 19 ++-----------------
 include/hw/nvram/fw_cfg_acpi.h | 15 +++++++++++++++
 5 files changed, 43 insertions(+), 34 deletions(-)
 create mode 100644 hw/nvram/fw_cfg-acpi.c
 create mode 100644 include/hw/nvram/fw_cfg_acpi.h

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9ce136cd88..dd2e95f0ea 100644
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
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 75e415b1a0..4996c72456 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -17,3 +17,4 @@ system_ss.add(when: 'CONFIG_XLNX_EFUSE_ZYNQMP', if_true: files(
 system_ss.add(when: 'CONFIG_XLNX_BBRAM', if_true: files('xlnx-bbram.c'))
 
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
+specific_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 7331248f59..d8772c2821 100644
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
-- 
2.39.2


