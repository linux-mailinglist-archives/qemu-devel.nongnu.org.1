Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71542829579
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:59:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUQ3-0001m1-31; Wed, 10 Jan 2024 03:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPy-0001cS-98
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:34 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPw-0003d1-Cz
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:34 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9ac5bd128so2416173b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877111; x=1705481911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lh94sJg/ngvqYPRH8ZJRctVdTHj1K6DW15CXMA3QDyg=;
 b=IXm6BsT/NycZn9282VDrwWAhpSP1Ef3D5/UMpSw60dBJIRfzvHp2tE4UPo3ohppPZV
 RNmIlbOx0mFjkzBdzQY4vOkUIgNG8a5thRQ8QBuT2ylmkN5F1qpWGreRNDAEKGZW0W79
 3/Vj1rg0HuVUDhiN0hVCJEPjI3MmhDfwn/RezlhQpcXHpCscFdsr36vzcZhNbrE7OKMW
 ZqGuWhsKj5+cqVRHB0lvo1GNq09syA0Rltdv/C3tH5/vaMncyC7VNhwhTlBCPKlTdEj8
 uSjkLoZo4pszmjX9SWTOiBLSVCyJcL56Ldwo+WLMbOUC11ll9dY70fQdUYJx7HvB/YAf
 IOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877111; x=1705481911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lh94sJg/ngvqYPRH8ZJRctVdTHj1K6DW15CXMA3QDyg=;
 b=g1FhewZARwPWm5uJALhlnnNvjoXvWPbrSW3mom2EEu42MiOyup3tkOkLs85Bz1MIdi
 6ZKXt5M3cn2OsIlOViGX2/1c1lcQ1qr/iNw+tKYhhmp0UmxxPxIPR0SK67clno9FU+tU
 9aHMD8QUEp3NQV8oMA+TfuzC7sAjTa65aBKU3Opr61/0fIGOwRwkV3/2yHG1kGDRTaZv
 Ka/e9efElWrsjWIIdI+FdPaSOptK7lxJA1xK23MAeTi7aPqkKgUksmgQ/dgmHOl3IXfg
 DCtEx5j4dHQu+vUo8S2PRcJLGdTXdSPXzWTWcsBkTWrWkzzZfBl9G1MVMtYt+CyqcRW9
 gpBw==
X-Gm-Message-State: AOJu0YzVKgzWLzS167GJrnifO2YPRvw8+GupKpvF35bGN2pEH3E8+Veg
 oXPrwh4KlFFYoL/LoZidBW+AeWqzGKp2UC7d
X-Google-Smtp-Source: AGHT+IELhsn9Qkmi8OwlDOBKsBW2W1dspewEbOdeXoxKHZIu4ICHjgVUG3xwmkm02bNDBvvOZ2veRg==
X-Received: by 2002:a05:6a00:17a9:b0:6db:35e7:1636 with SMTP id
 s41-20020a056a0017a900b006db35e71636mr72809pfg.49.1704877110731; 
 Wed, 10 Jan 2024 00:58:30 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:30 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 13/65] hw/arm/virt-acpi-build.c: Migrate virtio creation to
 common location
Date: Wed, 10 Jan 2024 18:56:41 +1000
Message-ID: <20240110085733.1607526-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

RISC-V also needs to create the virtio in DSDT in the same way as ARM.
So, instead of duplicating the code, move this function to the device
specific file which is common across architectures.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231218150247.466427-3-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/virtio/virtio-acpi.h | 16 ++++++++++++++++
 hw/arm/virt-acpi-build.c        | 32 ++++----------------------------
 hw/virtio/virtio-acpi.c         | 33 +++++++++++++++++++++++++++++++++
 hw/virtio/meson.build           |  1 +
 4 files changed, 54 insertions(+), 28 deletions(-)
 create mode 100644 include/hw/virtio/virtio-acpi.h
 create mode 100644 hw/virtio/virtio-acpi.c

diff --git a/include/hw/virtio/virtio-acpi.h b/include/hw/virtio/virtio-acpi.h
new file mode 100644
index 0000000000..844e102569
--- /dev/null
+++ b/include/hw/virtio/virtio-acpi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * ACPI support for virtio
+ */
+
+#ifndef VIRTIO_ACPI_H
+#define VIRTIO_ACPI_H
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+
+void virtio_acpi_dsdt_add(Aml *scope, const hwaddr virtio_mmio_base,
+                          const hwaddr virtio_mmio_size, uint32_t mmio_irq,
+                          long int start_index, int num);
+
+#endif
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b6edf9db00..a22a2f43a5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -58,6 +58,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
+#include "hw/virtio/virtio-acpi.h"
 
 #define ARM_SPI_BASE 32
 
@@ -118,32 +119,6 @@ static void acpi_dsdt_add_flash(Aml *scope, const MemMapEntry *flash_memmap)
     aml_append(scope, dev);
 }
 
-static void acpi_dsdt_add_virtio(Aml *scope,
-                                 const MemMapEntry *virtio_mmio_memmap,
-                                 uint32_t mmio_irq, int num)
-{
-    hwaddr base = virtio_mmio_memmap->base;
-    hwaddr size = virtio_mmio_memmap->size;
-    int i;
-
-    for (i = 0; i < num; i++) {
-        uint32_t irq = mmio_irq + i;
-        Aml *dev = aml_device("VR%02u", i);
-        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
-        aml_append(dev, aml_name_decl("_UID", aml_int(i)));
-        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
-
-        Aml *crs = aml_resource_template();
-        aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
-        aml_append(crs,
-                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
-                                 AML_EXCLUSIVE, &irq, 1));
-        aml_append(dev, aml_name_decl("_CRS", crs));
-        aml_append(scope, dev);
-        base += size;
-    }
-}
-
 static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
                               uint32_t irq, VirtMachineState *vms)
 {
@@ -850,8 +825,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
     fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
-    acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
-                    (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
+    virtio_acpi_dsdt_add(scope, memmap[VIRT_MMIO].base, memmap[VIRT_MMIO].size,
+                         (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
+                         0, NUM_VIRTIO_TRANSPORTS);
     acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, vms);
     if (vms->acpi_dev) {
         build_ged_aml(scope, "\\_SB."GED_DEVICE,
diff --git a/hw/virtio/virtio-acpi.c b/hw/virtio/virtio-acpi.c
new file mode 100644
index 0000000000..e18cb38bdb
--- /dev/null
+++ b/hw/virtio/virtio-acpi.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio ACPI Support
+ *
+ */
+
+#include "hw/virtio/virtio-acpi.h"
+#include "hw/acpi/aml-build.h"
+
+void virtio_acpi_dsdt_add(Aml *scope, const hwaddr base, const hwaddr size,
+                          uint32_t mmio_irq, long int start_index, int num)
+{
+    hwaddr virtio_base = base;
+    uint32_t irq = mmio_irq;
+    long int i;
+
+    for (i = start_index; i < start_index + num; i++) {
+        Aml *dev = aml_device("VR%02u", (unsigned)i);
+        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
+        aml_append(dev, aml_name_decl("_UID", aml_int(i)));
+        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+        Aml *crs = aml_resource_template();
+        aml_append(crs, aml_memory32_fixed(virtio_base, size, AML_READ_WRITE));
+        aml_append(crs,
+                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                                 AML_EXCLUSIVE, &irq, 1));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+        aml_append(scope, dev);
+        virtio_base += size;
+        irq++;
+    }
+}
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index c8c1001451..47baf00366 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -77,3 +77,4 @@ system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
 system_ss.add(files('virtio-hmp-cmds.c'))
 
 specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
+system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
-- 
2.43.0


