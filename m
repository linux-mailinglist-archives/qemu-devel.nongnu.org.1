Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA77D3C0A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxao-0005We-OJ; Mon, 23 Oct 2023 12:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1quxad-0005Ix-V2
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:15:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1quxac-0002ev-3Q
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:15:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4083740f92dso29031005e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077737; x=1698682537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m34DNNtpMvzZtPYxZvH42oGWZoTO6oa4Hph6YDxvg6A=;
 b=MUt1n+Fzx6DYkIDm/jkkYQ01mBRkce4JXlXBWWRSExz+NSkEtimwhAvLDvhPTVAkNU
 eYg5IsMJTJaLqdzmGhc25qPMtWDe/a54NyTA5WY/eXyrkB68mVhBaFscc/JIC1lo1XfU
 SKImP1ywpyMQpEwcxtB1d0HMvQFY8SjbeO7h+Mxy3FMe94w0aQDqx9mV6fHgNbu0RmIR
 EMlI71u0b05mqnJwVsjpJkQcJMw5TgeTSGpQ4GLY9j8HvlIMN0yv/gxAXeSG3Ur47YAv
 9tvGn5JgHA27coN5c++K3JoOBLO9lKNxff9tj7W8abiPCZUzV1UTBtxXJv1KSnwBW6G3
 KwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077737; x=1698682537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m34DNNtpMvzZtPYxZvH42oGWZoTO6oa4Hph6YDxvg6A=;
 b=ZsHsLcKjz6+LFZMmNzRtZBWeuP5XdiYcSnM0RG5c8RN5TDjvNWaUAhc0+lYqruRVGF
 uikL699OfvzzadbyVP0+qLKmcAzXS25pCZWo9A4lSwwYDyGpLB6Nux25tvEPfCr0EeI4
 o2CfMK3a0w9invHlcSl3d+PMZoZSqjetvpp172T5X6blGxCeNfjaQ8vNRg3cEOhV2tOD
 2mWCRvuy+ay3Rk+UpwQXPq0eq+XHqGokEL0lubo1WUnrvlikSv00UFCSUzb7AlK0Gsum
 Un7x54wFGdwnVMSfWGgE40W7M9EL7+mfGIcju2hhkncJiQn9SSHerY0YcIYEyRTk4yYy
 EohA==
X-Gm-Message-State: AOJu0YzN34rbLDWIdwZX8S2K4pYQuS+V5wdnXvtDnEWpO/a49JlXkDLi
 3h5bgHtH7bPiDBJyijd5avhkjA==
X-Google-Smtp-Source: AGHT+IEixgRNjsDHrfGy6vcKBxt0UDLkQzUfvnsn1Z+GqD7iFTxzZyqdwT9Tn//TcCNR00JXcsh64Q==
X-Received: by 2002:a05:600c:a07:b0:405:3251:47a1 with SMTP id
 z7-20020a05600c0a0700b00405325147a1mr7033052wmp.40.1698077736662; 
 Mon, 23 Oct 2023 09:15:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c2e4c00b0040648217f4fsm14460597wmf.39.2023.10.23.09.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:15:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Axel Heider <axel.heider@hensoldt.net>, Laszlo Ersek <lersek@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/3] hw/arm/virt: Rename VIRT_UART and VIRT_SECURE_UART to
 VIRT_UART[01]
Date: Mon, 23 Oct 2023 17:15:31 +0100
Message-Id: <20231023161532.2729084-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023161532.2729084-1-peter.maydell@linaro.org>
References: <20231023161532.2729084-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

We're going to make the second UART not always a secure-only device.
Rename the constants VIRT_UART and VIRT_SECURE_UART to VIRT_UART0
and VIRT_UART1 accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    |  4 ++--
 hw/arm/virt-acpi-build.c | 12 ++++++------
 hw/arm/virt.c            | 14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index f69239850e6..0de58328b2f 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -59,7 +59,7 @@ enum {
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
     VIRT_SMMU,
-    VIRT_UART,
+    VIRT_UART0,
     VIRT_MMIO,
     VIRT_RTC,
     VIRT_FW_CFG,
@@ -69,7 +69,7 @@ enum {
     VIRT_PCIE_ECAM,
     VIRT_PLATFORM_BUS,
     VIRT_GPIO,
-    VIRT_SECURE_UART,
+    VIRT_UART1,
     VIRT_SECURE_MEM,
     VIRT_SECURE_GPIO,
     VIRT_PCDIMM_ACPI,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9ce136cd88c..54f26640982 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -483,14 +483,14 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
     /* Base Address */
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
-                     vms->memmap[VIRT_UART].base);
+                     vms->memmap[VIRT_UART0].base);
     /* Interrupt Type */
     build_append_int_noprefix(table_data,
         (1 << 3) /* Bit[3] ARMH GIC interrupt */, 1);
     build_append_int_noprefix(table_data, 0, 1); /* IRQ */
     /* Global System Interrupt */
     build_append_int_noprefix(table_data,
-                              vms->irqmap[VIRT_UART] + ARM_SPI_BASE, 4);
+                              vms->irqmap[VIRT_UART0] + ARM_SPI_BASE, 4);
     build_append_int_noprefix(table_data, 3 /* 9600 */, 1); /* Baud Rate */
     build_append_int_noprefix(table_data, 0 /* No Parity */, 1); /* Parity */
     /* Stop Bits */
@@ -674,11 +674,11 @@ build_dbg2(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     /* BaseAddressRegister[] */
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
-                     vms->memmap[VIRT_UART].base);
+                     vms->memmap[VIRT_UART0].base);
 
     /* AddressSize[] */
     build_append_int_noprefix(table_data,
-                              vms->memmap[VIRT_UART].size, 4);
+                              vms->memmap[VIRT_UART0].size, 4);
 
     /* NamespaceString[] */
     g_array_append_vals(table_data, name, namespace_length);
@@ -859,8 +859,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      */
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, vms);
-    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
-                       (irqmap[VIRT_UART] + ARM_SPI_BASE));
+    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
+                       (irqmap[VIRT_UART0] + ARM_SPI_BASE));
     if (vmc->acpi_expose_flash) {
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b714ff1c03d..fd524aed6b6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -144,11 +144,11 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
     /* This redistributor space allows up to 2*64kB*123 CPUs */
     [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
-    [VIRT_UART] =               { 0x09000000, 0x00001000 },
+    [VIRT_UART0] =              { 0x09000000, 0x00001000 },
     [VIRT_RTC] =                { 0x09010000, 0x00001000 },
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
-    [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
+    [VIRT_UART1] =              { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
     [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
@@ -191,11 +191,11 @@ static MemMapEntry extended_memmap[] = {
 };
 
 static const int a15irqmap[] = {
-    [VIRT_UART] = 1,
+    [VIRT_UART0] = 1,
     [VIRT_RTC] = 2,
     [VIRT_PCIE] = 3, /* ... to 6 */
     [VIRT_GPIO] = 7,
-    [VIRT_SECURE_UART] = 8,
+    [VIRT_UART1] = 8,
     [VIRT_ACPI_GED] = 9,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
@@ -889,7 +889,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     qemu_fdt_setprop(ms->fdt, nodename, "clock-names",
                          clocknames, sizeof(clocknames));
 
-    if (uart == VIRT_UART) {
+    if (uart == VIRT_UART0) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
         qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
     } else {
@@ -2269,11 +2269,11 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
+    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0));
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem, secure_tag_sysmem);
-        create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1));
     }
 
     if (tag_sysmem) {
-- 
2.34.1


