Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE734832A57
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:26:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQork-0004xe-5W; Fri, 19 Jan 2024 08:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQori-0004wu-0U
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:24:58 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQorg-0006dM-7y
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:24:57 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cd0f4f306fso8382711fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705670694; x=1706275494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAngX4m6Z7n5rBnwPaU8JIuuuFcTQSGFa/hGBLJQ25E=;
 b=aQIu/T5Zlz4CTM5+UgQHPp9KAScEh4hxllmc6+aejGByCrptxiG8Sj6pqZNjCe7Tgk
 iPy+lGkyzjq3+FhVk39O+iGJs6O20u/JJcLBoh5tsNzNFKKCIWFKg+iWebhgSYBfnXkG
 yGA6JGbozTnjzJc/vFSsw9lVvqZabDpD4jXSaGSDG3nxMa4UaDEV4DF3zAd+tEH6s7l2
 ollupBnQNn9Ph0gUdNbAB3kCerOskK0kzAwvWnbI7dhQ4fU0Ry4cda0lvVXiniJe1dib
 KpDPqAGH79kdT6LL7pyWAswXz40M+0ZjUfGTE9a5qSjwleucTZWKwhLX7mu++AzNzDD9
 43xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705670694; x=1706275494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAngX4m6Z7n5rBnwPaU8JIuuuFcTQSGFa/hGBLJQ25E=;
 b=kB0pxPREgNdBH4PDj90w06G5g++vCNwT3mkmCYEQn647zbYy+5JJPkkLOYTnSB3xy4
 RAt/75CvjDqD0U0jP/6/ibRf/+0rmY4xA7Yrgk0DGloKZdz/ilu7QHvanm4ryNmE7/L4
 8dyHZtJ6PZ/NoGu7scWMwb+ZDTZDJQAvfIbg087lKZChs8Tk5nEJkn3xDWQdeRwSGWHK
 BS9Y7PCr5KrKbZxzJgoX9DFGQvj1nAg2Yy5QYRV6zBVds+NRqPdOmx0+uYxSv4roPgl4
 y0P2hT8fl96I64NVdMskpriUS8XnVolcQTW/Fn5TuY4RplPQaUOu4iX1ho/zCDpeeI6y
 tdyg==
X-Gm-Message-State: AOJu0Yyc3H/IsXXaZUi3ejNXQRddd5DiS7t2cIoARG2ZChGNE40f1KsF
 pDCIoCUoIw55Qo/JMRu1TDhLLyGytZ2L0XUPW1/YoCKx/DG0X3z0DD/0c2W1xhWv2EgUzl+Vhsj
 BzUM=
X-Google-Smtp-Source: AGHT+IFY85TUfdmGhOXUuurdf83wXKDDr4KyWdYQqIWsb6PeMKNpY7955RyDKWckr/AX+oUl6YMs8w==
X-Received: by 2002:a05:651c:1991:b0:2cd:494b:b4aa with SMTP id
 bx17-20020a05651c199100b002cd494bb4aamr1997659ljb.30.1705670693620; 
 Fri, 19 Jan 2024 05:24:53 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 b11-20020aa7dc0b000000b00558fc426affsm8568310edu.88.2024.01.19.05.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 05:24:53 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/5] hw/arm/xen_arm.c: convert DPRINTF to trace events and
 error/warn reports
Date: Fri, 19 Jan 2024 15:24:44 +0200
Message-Id: <c7eb8943f085e0f68e3471fecf49cc96571c8852.1705670342.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
References: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22e.google.com
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

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on trace events should be able to opt-in to each trace event and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into trace events. Errors or warnings are converted to error_report and
warn_report calls.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/trace-events |  5 +++++
 hw/arm/xen_arm.c    | 23 +++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index b0a56fcdc6..623eb003bb 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -65,3 +65,8 @@ z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
+
+# xen_arm.c
+xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%lx"
+xen_init_ram(uint64_t machine_ram_size) "Initialized xen ram with size 0x%lx"
+xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%lx"
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index a5631529d0..32776d94df 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -34,6 +34,7 @@
 #include "hw/xen/xen-hvm-common.h"
 #include "sysemu/tpm.h"
 #include "hw/xen/arch_hvm.h"
+#include "trace.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
@@ -91,8 +92,9 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
 
         sysbus_create_simple("virtio-mmio", base, irq);
 
-        DPRINTF("Created virtio-mmio device %d: irq %d base 0x%lx\n",
-                i, GUEST_VIRTIO_MMIO_SPI_FIRST + i, base);
+        trace_xen_create_virtio_mmio_devices(i,
+                                             GUEST_VIRTIO_MMIO_SPI_FIRST + i,
+                                             base);
     }
 }
 
@@ -101,6 +103,7 @@ static void xen_init_ram(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     ram_addr_t block_len, ram_size[GUEST_RAM_BANKS];
 
+    trace_xen_init_ram(machine->ram_size);
     if (machine->ram_size <= GUEST_RAM0_SIZE) {
         ram_size[0] = machine->ram_size;
         ram_size[1] = 0;
@@ -117,15 +120,10 @@ static void xen_init_ram(MachineState *machine)
     memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
                              GUEST_RAM0_BASE, ram_size[0]);
     memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
-    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
-            GUEST_RAM0_BASE, ram_size[0]);
-
     if (ram_size[1] > 0) {
         memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
-        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
-                GUEST_RAM1_BASE, ram_size[1]);
     }
 }
 
@@ -158,7 +156,7 @@ static void xen_enable_tpm(XenArmState *xam)
 
     TPMBackend *be = qemu_find_tpm_be("tpm0");
     if (be == NULL) {
-        DPRINTF("Couldn't fine the backend for tpm0\n");
+        error_report("Couldn't find tmp0 backend");
         return;
     }
     dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
@@ -168,7 +166,7 @@ static void xen_enable_tpm(XenArmState *xam)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, xam->cfg.tpm_base_addr);
 
-    DPRINTF("Connected tpmdev at address 0x%lx\n", xam->cfg.tpm_base_addr);
+    trace_xen_enable_tpm(xam->cfg.tpm_base_addr);
 }
 #endif
 
@@ -179,8 +177,9 @@ static void xen_arm_init(MachineState *machine)
     xam->state =  g_new0(XenIOState, 1);
 
     if (machine->ram_size == 0) {
-        DPRINTF("ram_size not specified. QEMU machine started without IOREQ"
-                "(no emulated devices including Virtio)\n");
+        warn_report("%s non-zero ram size not specified. QEMU machine started"
+                    " without IOREQ (no emulated devices including virtio)",
+                    MACHINE_CLASS(object_get_class(OBJECT(machine)))->desc);
         return;
     }
 
@@ -194,7 +193,7 @@ static void xen_arm_init(MachineState *machine)
     if (xam->cfg.tpm_base_addr) {
         xen_enable_tpm(xam);
     } else {
-        DPRINTF("tpm-base-addr is not provided. TPM will not be enabled\n");
+        warn_report("tpm-base-addr is not provided. TPM will not be enabled");
     }
 #endif
 }
-- 
γαῖα πυρί μιχθήτω


