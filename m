Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021673B75F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:33:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxN-0002ic-9P; Fri, 23 Jun 2023 08:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfxB-0001ve-4H
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:56 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx8-0000j4-48
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:52 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f8775126d3so676554e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523508; x=1690115508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MvTxuDYy5jDd/7WUodSfO58AYaXBKUtUQhiPOjxc1mY=;
 b=CjrC2gp4OzXZXf+LdANLm6oIuU1gqb9Nzqe46Du8G7qKruJUwst7ukiNXh9cicgHTx
 kOb3a6MHBFY+i5ooaXiHa1bv2CDHalwYmrdPADEI3p7b7YDY5pXKCsSBV0JXwRYkRlLu
 VU6RnJOIZ4R+un6BPQAXTaumbF+UOsWjVC5zkKcXB+GtfK/9sVqpPEZjAX1PVDlg+0oa
 BQp5ZsX0fGbBSc4Z6N+r49OF1zCaa/k9H0uYDDDzkbKXHvomR9sVKVLYr4G8GbOHpZW5
 MJnbr7i3cp0PJ+StcD4g/5IRpUQ36qvjjByOYwF4CtUwE1iv7lDaz5oOqbdiKCB42AO9
 V1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523508; x=1690115508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvTxuDYy5jDd/7WUodSfO58AYaXBKUtUQhiPOjxc1mY=;
 b=J4gjZTNl7g+VwMIS4+24CmLHVHIoes1HChuYFy32XcdM5xCz7W/qAkmYFKUHdjWE5R
 qrrCuh69rFko4sp76gu8FivIHWLTuiMzFQ4fppKmVFEQ9CnLiXtBmpxph2XULnwhW1Aj
 6a+bLAYbblVyWgyu8t+4AnNoVrfC25C+YBJmukucFB73QZfEmtHUMLqL1t9qR7UVwQsn
 Jx/mg8OsoYnEEn6PVMzvVmv99vLOvsvPXuYrThePBM6vVLivusUcBORJsB1Ug52wBSgV
 cx/Z4+T4vJpRZ/jvyFvLqxZfgYhF9YRQF7YYmS9NjH/gjfWsFM52kdkK2LF1CNRjwLJS
 vmXg==
X-Gm-Message-State: AC+VfDwD7MzEb0oY3w+6RLreMSua3nmkaS6vMkz+dYo+dMXcxWsye8tb
 DcOpFeiHeUPYKVOz81BHvrzPlTIlUjW13ht7zFA=
X-Google-Smtp-Source: ACHHUZ7pgC6i7dwjhfR7HS5GDk2hj9BhNuedT8KGHxcdjLFWnChYjZoFICQ9kVvu/a/lhCYO5fjUxw==
X-Received: by 2002:a19:6748:0:b0:4f8:6600:4074 with SMTP id
 e8-20020a196748000000b004f866004074mr11332171lfj.17.1687523508381; 
 Fri, 23 Jun 2023 05:31:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] hw/arm/sbsa-ref: add ITS support in SBSA GIC
Date: Fri, 23 Jun 2023 13:31:33 +0100
Message-Id: <20230623123135.1788191-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

From: Shashi Mallela <shashi.mallela@linaro.org>

Create ITS as part of SBSA platform GIC initialization.

GIC ITS information is in DeviceTree so TF-A can pass it to EDK2.

Bumping platform version to 0.2 as this is important hardware change.

Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20230619170913.517373-2-marcin.juszkiewicz@linaro.org
Co-authored-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/sbsa.rst | 14 ++++++++++++++
 hw/arm/sbsa-ref.c        | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index f571fe645e7..a8e0b530a24 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -46,6 +46,9 @@ to be a complete compliant DT. It currently reports:
    - platform version
    - GIC addresses
 
+Platform version
+''''''''''''''''
+
 The platform version is only for informing platform firmware about
 what kind of ``sbsa-ref`` board it is running on. It is neither
 a QEMU versioned machine type nor a reflection of the level of the
@@ -54,3 +57,14 @@ SBSA/SystemReady SR support provided.
 The ``machine-version-major`` value is updated when changes breaking
 fw compatibility are introduced. The ``machine-version-minor`` value
 is updated when features are added that don't break fw compatibility.
+
+Platform version changes:
+
+0.0
+  Devicetree holds information about CPUs, memory and platform version.
+
+0.1
+  GIC information is present in devicetree.
+
+0.2
+  GIC ITS information is present in devicetree.
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index de21200ff93..0639f97dd5f 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -65,6 +65,7 @@ enum {
     SBSA_CPUPERIPHS,
     SBSA_GIC_DIST,
     SBSA_GIC_REDIST,
+    SBSA_GIC_ITS,
     SBSA_SECURE_EC,
     SBSA_GWDT_WS0,
     SBSA_GWDT_REFRESH,
@@ -108,6 +109,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
     [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
     [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
+    [SBSA_GIC_ITS] =            { 0x44081000, 0x00020000 },
     [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
     [SBSA_GWDT_REFRESH] =       { 0x50010000, 0x00001000 },
     [SBSA_GWDT_CONTROL] =       { 0x50011000, 0x00001000 },
@@ -181,8 +183,15 @@ static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
                                  2, sbsa_ref_memmap[SBSA_GIC_REDIST].base,
                                  2, sbsa_ref_memmap[SBSA_GIC_REDIST].size);
 
+    nodename = g_strdup_printf("/intc/its");
+    qemu_fdt_add_subnode(sms->fdt, nodename);
+    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
+                                 2, sbsa_ref_memmap[SBSA_GIC_ITS].base,
+                                 2, sbsa_ref_memmap[SBSA_GIC_ITS].size);
+
     g_free(nodename);
 }
+
 /*
  * Firmware on this machine only uses ACPI table to load OS, these limited
  * device tree nodes are just to let firmware know the info which varies from
@@ -219,7 +228,7 @@ static void create_fdt(SBSAMachineState *sms)
      *                        fw compatibility.
      */
     qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
-    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 1);
+    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 2);
 
     if (ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
@@ -409,7 +418,20 @@ static void create_secure_ram(SBSAMachineState *sms,
     memory_region_add_subregion(secure_sysmem, base, secram);
 }
 
-static void create_gic(SBSAMachineState *sms)
+static void create_its(SBSAMachineState *sms)
+{
+    const char *itsclass = its_class_name();
+    DeviceState *dev;
+
+    dev = qdev_new(itsclass);
+
+    object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(sms->gic),
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, sbsa_ref_memmap[SBSA_GIC_ITS].base);
+}
+
+static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
 {
     unsigned int smp_cpus = MACHINE(sms)->smp.cpus;
     SysBusDevice *gicbusdev;
@@ -436,6 +458,10 @@ static void create_gic(SBSAMachineState *sms)
     qdev_prop_set_uint32(sms->gic, "len-redist-region-count", 1);
     qdev_prop_set_uint32(sms->gic, "redist-region-count[0]", redist0_count);
 
+    object_property_set_link(OBJECT(sms->gic), "sysmem",
+                             OBJECT(mem), &error_fatal);
+    qdev_prop_set_bit(sms->gic, "has-lpi", true);
+
     gicbusdev = SYS_BUS_DEVICE(sms->gic);
     sysbus_realize_and_unref(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, sbsa_ref_memmap[SBSA_GIC_DIST].base);
@@ -482,6 +508,7 @@ static void create_gic(SBSAMachineState *sms)
         sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
+    create_its(sms);
 }
 
 static void create_uart(const SBSAMachineState *sms, int uart,
@@ -788,7 +815,7 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_secure_ram(sms, secure_sysmem);
 
-    create_gic(sms);
+    create_gic(sms, sysmem);
 
     create_uart(sms, SBSA_UART, sysmem, serial_hd(0));
     create_uart(sms, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
-- 
2.34.1


