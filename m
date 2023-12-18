Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 219F68174B0
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 16:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFFAG-00045Y-MR; Mon, 18 Dec 2023 10:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rFFAB-0003xE-77
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:04:11 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rFFA9-0007JL-0h
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:04:10 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d66a0d10dcso640537b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 07:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702911847; x=1703516647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRENz1LilMrUU5ZeLcJi7qH/m2ui+beNNPkaJ/M7Zbo=;
 b=KLYMcsQZocuhaFOhD1Gkqxw2PKdm/4xIvyGlnKB6ZgLpSAEQ4rD/etExDa5XPqfeJw
 L+EHHElVy9RGYsJqEllqA65+C9oEiozKm5TfK9lanlvKzWvs6CNdvXul+URDcuHa5HpB
 xdZECJGwCgjiuKKPk0D+qyiIqYVCQzU7t/qoeBbdaryZ4C2lKCj4pBXc9AY0DAmatv5q
 rnz3LM7ulNylObxuzsocNIjR+be2q3FHrqxgjQDzTxqHCem/9LkLrlSCbHJTHg557A1r
 qdKVISpA4gxeXay47q/yYXyP+QYx8Mx6gNdALaU+8ysCDtBOyc5TrVzTq+qVzk217UC/
 z74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911847; x=1703516647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRENz1LilMrUU5ZeLcJi7qH/m2ui+beNNPkaJ/M7Zbo=;
 b=DtGIb+tp11nq9IpbSowj2tQfy2XTlMX7Wu0UgCPFhx+zPFpT04ESkgZ/pAEH2l+acx
 kYMXPAUZjaj7Iku71AT21aNnrUh7hfDsEwQZL59+MbacabVqDN/N6r3q9FO1iiblhd2F
 uJmAxzZSvzBWmmX1ZRLDD15D9wy6rPEvpug69utVieEfLQNVLErnCuot9vR4h2/Y20So
 XgUXziyU2BUlFPjgNMnRNpJzMTvnK2TleBuRp7RJi/koJk64GChtL/A4lUpxnAu5brjB
 ZRslmoTO/9xplom2Z93FcudSSLWQO/eZh8+cZWE9gwOr7fCbnDSKHeT2Qo/oss+V0p/m
 drZQ==
X-Gm-Message-State: AOJu0YwiER1xN9W3x4aFSRbaZpw/CekYIT9YliyogZYeR3VFNI1WZZAc
 2EtndzFDL/yUHNYgRzJh55WAww==
X-Google-Smtp-Source: AGHT+IEft5xudJYymoUWNyzoqqx3c7K60B2V0PlmBbOqSzLuExLMYA7dzMVnVn01dSqoXJauJpZAdg==
X-Received: by 2002:aa7:8684:0:b0:6d4:1666:62bb with SMTP id
 d4-20020aa78684000000b006d4166662bbmr962683pfo.68.1702911847623; 
 Mon, 18 Dec 2023 07:04:07 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a056a000a0100b006c06779e593sm18975505pfh.16.2023.12.18.07.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 07:04:07 -0800 (PST)
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
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v8 11/13] hw/riscv/virt: Update GPEX MMIO related properties
Date: Mon, 18 Dec 2023 20:32:45 +0530
Message-Id: <20231218150247.466427-12-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218150247.466427-1-sunilvl@ventanamicro.com>
References: <20231218150247.466427-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x432.google.com
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

Update the GPEX host bridge properties related to MMIO ranges with
values set for the virt machine.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/riscv/virt.c         | 47 ++++++++++++++++++++++++++++-------------
 include/hw/riscv/virt.h |  1 +
 2 files changed, 33 insertions(+), 15 deletions(-)

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
-- 
2.39.2


