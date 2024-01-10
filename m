Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4748295EC
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:10:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUQg-00047G-Op; Wed, 10 Jan 2024 03:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQb-0003u0-FJ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:13 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQZ-0003y5-8W
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:13 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-598890b5b9dso600414eaf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877149; x=1705481949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGfE+oA78sYRSh5wTesPaqq/xlxKJjQeYnd1wSJYBLA=;
 b=mz1APHU9YLxXtmw7yP+fr51pt/mhymGejdnIFuOBNG0zTQ2AoqRT3VLwswm/DArIhu
 OWTKEjP6tHqxIKRc4FOjCtlsNOUzJKtujCfE3QnXo2LUX16Iq1xA4bkrVgaCC2G4r6KJ
 yqAPaR0hdHBTkfJAQPgj4G1bBg+bfD25Kpm8m+JFJg+XrGF9cQ7Bn63EmFDCu1nORZeU
 uYZpTxxEYBHNMf5JKojjXGkeg7SgaUIMT+JJr1TgRg4IaH8Iv+txOH0kEUjWJPyuxJQa
 NrOqknm6vkvOxoYKJ/Nt+5jxEqTylz3Ity7KXVsOasLHpMsLh3Z6e0+KMMPMRNbD4V36
 8q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877149; x=1705481949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGfE+oA78sYRSh5wTesPaqq/xlxKJjQeYnd1wSJYBLA=;
 b=tC7cTHoimijjtsrzo/r7Qjb3uQ0qFYYkc8AKFqLdSv8ASMXF5arYHKhnO6eWcTu1Sq
 o0U4/ym6yghxpKev3e4IFhU8E3zn6oGD5UIn3gQL5v5JJnT6AAx8x3A4zXYlrj1nyYn2
 xxIyB7Byfq8sdJ4bkAjJtuppqE1ILTCQO98jHPzVgHNkRYsf/Gd5PgczSGFKpqgkNaeX
 v27DtFj07ziwgHPY3h7iZ/YVcHuM7lpnx7zETbCILoHTMdsW7HWatkJ3pMEnm6slZrgg
 qes5JMImLQSND99ykDHJojmZvi2/Us9VIxZHfaqV03cdLnqtVpCXoe5MsC95JzSVP9N6
 27CA==
X-Gm-Message-State: AOJu0Yyz3fGJ+axcqQ5Lay/spKqYzwPyLfZeaX4Zh753BXIEMRrU4MXb
 daTH9trobj76JYLX2EtV1ag9FeVArGyqdUWz
X-Google-Smtp-Source: AGHT+IHg/oyG2GAWYXX7hhZh1JhLPzvkNvVUld1KPcgd2YyN45BjbEj9xGI8BijD3jDYIMB2tUUXew==
X-Received: by 2002:a05:6358:99aa:b0:172:e5d2:c312 with SMTP id
 j42-20020a05635899aa00b00172e5d2c312mr752836rwb.39.1704877148717; 
 Wed, 10 Jan 2024 00:59:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:08 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 22/65] hw/riscv/virt: Update GPEX MMIO related properties
Date: Wed, 10 Jan 2024 18:56:50 +1000
Message-ID: <20240110085733.1607526-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2a.google.com
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

Update the GPEX host bridge properties related to MMIO ranges with
values set for the virt machine.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231218150247.466427-12-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/virt.h |  1 +
 hw/riscv/virt.c         | 47 ++++++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 5b03575ed3..f89790fd58 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -61,6 +61,7 @@ struct RISCVVirtState {
     char *oem_table_id;
     OnOffAuto acpi;
     const MemMapEntry *memmap;
+    struct GPEXHost *gpex_host;
 };
 
 enum {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9e7629c51c..a7c4c3508e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1054,21 +1054,45 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
 }
 
 static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
-                                          hwaddr ecam_base, hwaddr ecam_size,
-                                          hwaddr mmio_base, hwaddr mmio_size,
-                                          hwaddr high_mmio_base,
-                                          hwaddr high_mmio_size,
-                                          hwaddr pio_base,
-                                          DeviceState *irqchip)
+                                          DeviceState *irqchip,
+                                          RISCVVirtState *s)
 {
     DeviceState *dev;
     MemoryRegion *ecam_alias, *ecam_reg;
     MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
+    hwaddr ecam_base = s->memmap[VIRT_PCIE_ECAM].base;
+    hwaddr ecam_size = s->memmap[VIRT_PCIE_ECAM].size;
+    hwaddr mmio_base = s->memmap[VIRT_PCIE_MMIO].base;
+    hwaddr mmio_size = s->memmap[VIRT_PCIE_MMIO].size;
+    hwaddr high_mmio_base = virt_high_pcie_memmap.base;
+    hwaddr high_mmio_size = virt_high_pcie_memmap.size;
+    hwaddr pio_base = s->memmap[VIRT_PCIE_PIO].base;
+    hwaddr pio_size = s->memmap[VIRT_PCIE_PIO].size;
     qemu_irq irq;
     int i;
 
     dev = qdev_new(TYPE_GPEX_HOST);
 
+    /* Set GPEX object properties for the virt machine */
+    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BASE,
+                            ecam_base, NULL);
+    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZE,
+                            ecam_size, NULL);
+    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
+                             PCI_HOST_BELOW_4G_MMIO_BASE,
+                             mmio_base, NULL);
+    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_BELOW_4G_MMIO_SIZE,
+                            mmio_size, NULL);
+    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
+                             PCI_HOST_ABOVE_4G_MMIO_BASE,
+                             high_mmio_base, NULL);
+    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ABOVE_4G_MMIO_SIZE,
+                            high_mmio_size, NULL);
+    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BASE,
+                            pio_base, NULL);
+    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
+                            pio_size, NULL);
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     ecam_alias = g_new0(MemoryRegion, 1);
@@ -1099,6 +1123,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
         gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ + i);
     }
 
+    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(GPEX_HOST(dev))->bus;
     return dev;
 }
 
@@ -1494,15 +1519,7 @@ static void virt_machine_init(MachineState *machine)
             qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
     }
 
-    gpex_pcie_init(system_memory,
-                   memmap[VIRT_PCIE_ECAM].base,
-                   memmap[VIRT_PCIE_ECAM].size,
-                   memmap[VIRT_PCIE_MMIO].base,
-                   memmap[VIRT_PCIE_MMIO].size,
-                   virt_high_pcie_memmap.base,
-                   virt_high_pcie_memmap.size,
-                   memmap[VIRT_PCIE_PIO].base,
-                   pcie_irqchip);
+    gpex_pcie_init(system_memory, pcie_irqchip, s);
 
     create_platform_bus(s, mmio_irqchip);
 
-- 
2.43.0


