Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D22787184
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 16:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBLr-0007yP-2C; Thu, 24 Aug 2023 10:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qZBLp-0007y0-3l
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:30:21 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qZBLm-0000Ew-Ns
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:30:20 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26fb8225268so1024770a91.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692887417; x=1693492217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EEtzW/yDSwNYpHxOq+BMaImRS+4pnaLp19/AKav5UI=;
 b=d2IaI1B1MAwbGk+BH2VRO6gWZEs/fzQQjmCw7hUW3l3QlelOUkGGYxflRbq2+tusFF
 ggJk7F/duGxIOONyn5WdzAAEyH75gHAp3YTk08ZMVnoBz1YjEA4rVlyGqJFUwpBU+oZa
 8s+Hm442eLZoQlmiow4xc/eYRQdr4z+CEfer9vryDJkivwCrszn6Q3qcUgz3BjYq2Nk8
 KZiY75M+V2pGA2dznalWKiqe8Qi+CmzWoYW8/8MTfC3glfFPbtMgD4cMVmGBX978wQJR
 YYzoiD4kWBMJw6LzAefg6txpIylTQLpbQwSgps/OMD0BIjGROkl1u0iaoREAPh4de7sw
 27yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692887417; x=1693492217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EEtzW/yDSwNYpHxOq+BMaImRS+4pnaLp19/AKav5UI=;
 b=ck99Qj11GILE253dfr1oVtKwY/71aKdfPNnGFnOqRxOOEABVE7coj/ZDLLoGGma1U1
 j4lS8aVabddp3i/SsXoP36xpBF2bd9ALVciQ3YoXwDX5y0hHH4+9m1FpqkkgvKnWEXy8
 9mqTQSKYejermfJLRnSZD+KrsL6ouMzzZS8xGFcOKj6fid+I+a/JPZSkkMYN3+Ga2GLF
 bTZHaYqltcH2RG3/8zrAbByQCsQ6GR3aubmHT/nDGV0ildHAgVItoNxknQbHboJOTFvw
 GbXClflc4ISyGMdXFQxWBtpKZodtjhL6GZy203udhbaVTS2M6rTAdl1clkMxYWG5kIkE
 GtMw==
X-Gm-Message-State: AOJu0YyHoUk4N8IJYdVWZggYBHvp4Tdthg2bME8viIqfeETwxGEcqeMU
 oKK52pbx2FZmLGGOg2vSO25vFQ==
X-Google-Smtp-Source: AGHT+IH1o7o7JgLe7774veiOTQ8rBOuKWswv95QjvvktzIax06ElLjFm4nG/14FZP/kgwXnZ788ayA==
X-Received: by 2002:a17:90a:854c:b0:26d:1201:a8c4 with SMTP id
 a12-20020a17090a854c00b0026d1201a8c4mr12961399pjw.13.1692887417408; 
 Thu, 24 Aug 2023 07:30:17 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.191.205])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a17090a2bc600b00262fc3d911esm1666864pje.28.2023.08.24.07.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:30:14 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 02/12] hw/arm/virt-acpi-build.c: Migrate virtio creation to
 common location
Date: Thu, 24 Aug 2023 19:59:32 +0530
Message-Id: <20230824142942.3983650-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824142942.3983650-1-sunilvl@ventanamicro.com>
References: <20230824142942.3983650-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RISC-V also needs to create the virtio in DSDT in the same way as ARM. So,
instead of duplicating the code, move this function to the device specific
file which is common across architectures.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/arm/virt-acpi-build.c        | 29 ++---------------------------
 hw/virtio/meson.build           |  1 +
 hw/virtio/virtio-acpi.c         | 28 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio-acpi.h | 11 +++++++++++
 4 files changed, 42 insertions(+), 27 deletions(-)
 create mode 100644 hw/virtio/virtio-acpi.c
 create mode 100644 include/hw/virtio/virtio-acpi.h

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b8e725d953..69733f6663 100644
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
@@ -850,7 +825,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
     fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
-    acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
+    virtio_acpi_dsdt_add(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
     acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, vms);
     if (vms->acpi_dev) {
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 13e7c6c272..3ae1242bcf 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -75,3 +75,4 @@ system_ss.add(when: 'CONFIG_ALL', if_true: files('virtio-stub.c'))
 system_ss.add(files('virtio-hmp-cmds.c'))
 
 specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
+system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
diff --git a/hw/virtio/virtio-acpi.c b/hw/virtio/virtio-acpi.c
new file mode 100644
index 0000000000..977499defd
--- /dev/null
+++ b/hw/virtio/virtio-acpi.c
@@ -0,0 +1,28 @@
+#include "hw/virtio/virtio-acpi.h"
+#include "hw/acpi/aml-build.h"
+
+void virtio_acpi_dsdt_add(Aml *scope,
+                          const MemMapEntry *virtio_mmio_memmap,
+                          uint32_t mmio_irq, int num)
+{
+    hwaddr base = virtio_mmio_memmap->base;
+    hwaddr size = virtio_mmio_memmap->size;
+    int i;
+
+    for (i = 0; i < num; i++) {
+        uint32_t irq = mmio_irq + i;
+        Aml *dev = aml_device("VR%02u", i);
+        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
+        aml_append(dev, aml_name_decl("_UID", aml_int(i)));
+        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+        Aml *crs = aml_resource_template();
+        aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
+        aml_append(crs,
+                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                                 AML_EXCLUSIVE, &irq, 1));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+        aml_append(scope, dev);
+        base += size;
+    }
+}
diff --git a/include/hw/virtio/virtio-acpi.h b/include/hw/virtio/virtio-acpi.h
new file mode 100644
index 0000000000..b8687b1b42
--- /dev/null
+++ b/include/hw/virtio/virtio-acpi.h
@@ -0,0 +1,11 @@
+#ifndef VIRTIO_ACPI_H
+#define VIRTIO_ACPI_H
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+
+void virtio_acpi_dsdt_add(Aml *scope, const MemMapEntry *virtio_mmio_memmap,
+                          uint32_t mmio_irq, int num);
+
+#endif
+
-- 
2.39.2


