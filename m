Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD694750ED7
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJcsq-0003ho-IC; Wed, 12 Jul 2023 12:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qJcsn-0003gm-0Q
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:40:05 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qJcsk-0004cB-GH
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:40:04 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b89cfb4571so53799505ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689180001; x=1691772001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=my6WC56v1NHoMbkaX3PQi+I7N7GynsA+Ik6uIihef78=;
 b=BI7LIKlv/hre/FD7W1RLXqzzMMJlEa5d1oNvWH9OiHAsEGIoL0zWWKZ+OCePMkSfBG
 J8frAkEJtaMTJFja1w/hyPYGlKeP6QUWVLHDRcXVom2bTYzDSc3xfpRKiX+JPN5YdkMH
 pgOLDlwAtfj09mIwZrhJQtCZQ4KN3N40a82duYDcv5DIs6NKx9GoUS29vgawaMUG1yYz
 dARyE7y9MvMvWHnzl24xiuFoHSmewP0JmKdCOFEDTOZkd+w0WuswE2ewxd5deDsKB/t8
 rNHXOrcTebScCH7ioS4KitHHPKlnHwnjP8tOQ343FwHg0Sxm9WfM+ivUJunK4A07PS0Q
 46Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689180001; x=1691772001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=my6WC56v1NHoMbkaX3PQi+I7N7GynsA+Ik6uIihef78=;
 b=arWTsCHtzwl3gszB457anCq2yosnapSzcUhkexU2QOY/eAdqcv6pYL6y/EJILjk1ml
 CXKqGUdfmSL1XdNIipGeXzKJ+Ovv3TJF5L8K2AcDBkGuxaqCoWv6c5hPBQJlDX/v65ZZ
 1V+y/RhS9K/Sf4+zjd8MCyFcoX6bJYis30NWXRUgI1hh7UhlVe3aWSxKsBOQnM+yUNMY
 6ljoGP5+dzLdxYoL3W7T1C9E319tltRnd+0+0ceZBCLQn+zqnzx0u2roB7P9qwrmi6ep
 qRaYlzJh6zxMLAEPeTiqPncFmre0N3qqEH0dTyqidXPGoldae7THMLHikSucioy3YrU8
 5PMA==
X-Gm-Message-State: ABy/qLZHHGHWZn1fb7S8Y2xNbmzquM0kXSEQVNXPZuXAIflHaxd3gIkO
 vvLK81VpmTnxLp1+mIOzDgjtev+FuY8AVRoPLzk=
X-Google-Smtp-Source: APBJJlH1bZVw1Yd3yPQHPGl8QtjMxDrioDa8QrrC6KVYinDmUTKywH+eI973l9Xx5Aq+SqZ+kWhebw==
X-Received: by 2002:a17:902:788c:b0:1ae:8892:7d27 with SMTP id
 q12-20020a170902788c00b001ae88927d27mr10527926pll.42.1689180000942; 
 Wed, 12 Jul 2023 09:40:00 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.25])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a1709027d9200b001ac7f583f72sm4172824plm.209.2023.07.12.09.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 09:40:00 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 02/10] hw/riscv: virt: Add PCI bus reference in RISCVVirtState
Date: Wed, 12 Jul 2023 22:09:35 +0530
Message-Id: <20230712163943.98994-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712163943.98994-1-sunilvl@ventanamicro.com>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x632.google.com
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

The PCI bus information is needed in RISCVVirtState so that other
files like virt-acpi-build.c can make use of it. Add new field in
RISCVVirtState so that ACPI code can use it.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt.c         | 6 ++++--
 include/hw/riscv/virt.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d90286dc46..46d3341113 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1073,7 +1073,8 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
                                           hwaddr high_mmio_base,
                                           hwaddr high_mmio_size,
                                           hwaddr pio_base,
-                                          DeviceState *irqchip)
+                                          DeviceState *irqchip,
+                                          RISCVVirtState *s)
 {
     DeviceState *dev;
     MemoryRegion *ecam_alias, *ecam_reg;
@@ -1113,6 +1114,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
         gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ + i);
     }
 
+    s->bus = PCI_HOST_BRIDGE(dev)->bus;
     return dev;
 }
 
@@ -1502,7 +1504,7 @@ static void virt_machine_init(MachineState *machine)
                    virt_high_pcie_memmap.base,
                    virt_high_pcie_memmap.size,
                    memmap[VIRT_PCIE_PIO].base,
-                   pcie_irqchip);
+                   pcie_irqchip, s);
 
     create_platform_bus(s, mmio_irqchip);
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e5c474b26e..4ef1f660ab 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -60,6 +60,7 @@ struct RISCVVirtState {
     char *oem_table_id;
     OnOffAuto acpi;
     const MemMapEntry *memmap;
+    PCIBus *bus;
 };
 
 enum {
-- 
2.39.2


