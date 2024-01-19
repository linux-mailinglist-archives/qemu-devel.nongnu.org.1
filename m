Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A983289F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmpi-0007Zs-E3; Fri, 19 Jan 2024 06:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpa-0007Wu-UN
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:40 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpW-0007KC-F6
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:37 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55817a12ad8so776988a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705662871; x=1706267671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRdxU4Ux/WYb9oau9qsh6pPUNLeWhKGZpVjne6FmQCA=;
 b=OWqPsV4J+vXld/gHwUir8zxMW+2QsCxk2FP0bsQngAO1bnQUZORT8Yp2yWYl8J1TYk
 f952ZOnAMC2Bsl4ruki5ADtoD5UhpCkMgMo/UATgmH+iu8gX3TNFO1BXJ3xIpUHToteS
 ciFWhjfuyt8tg2iRc5EMl7QAElEkoN6LEloDAhdulqVU+Ba7XzVEvLTZS3fcR8eiQIUG
 JBUgRZQ0LQl+ZikkPy96ETlPy/D45LUob3WyoW6BuVHuk4GYdTHMQj20oizmTIRvpq2G
 HTpIk1ux0dwVlQ+ePLPbQ5OkxWegSuFlh82XfgtjIFgI4hwu1s+sZf9phRqKw0sjwTLL
 joCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705662871; x=1706267671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRdxU4Ux/WYb9oau9qsh6pPUNLeWhKGZpVjne6FmQCA=;
 b=S2bwR7VTK7l22KEOlOY4tM55dq0MIpRA3BBLLS3YD1fP1g43cibBqWIvcKMwXMxbDl
 jeNPLu9ZNREu920pB6h0otVl17ISJSdgG3pcFvBfkBmJtT5HjIaRGh/OBWjyWqgXSH+f
 s2+f7sPmFQQPt9nM97IIlZNcLE0FQUaBJT8zbeC/WtvvsM9QA7Sb/iZnccm/7BvawdMM
 IxGr+67gC7m4rrzYynfsFKq/1t0LOARswmMedbEpztu6s4/SihLZ6YW9CMD0r+WwxE6h
 pZ/sWsJayoZAOnpV92FdMjPpqXJYAcW77JMfDVxbkTw5VKkUWXecencThiIG1+5Zrxbg
 N0CQ==
X-Gm-Message-State: AOJu0YyQZtRnAeNYYfDIInVCCzTTVEdKZJp+0ndPCdrGHVouXDwAAOhL
 eqcHm0KLz4cOkLBqj0UhrC36UxAmJCXwDBn48h4FSuzOhyR3Qlic5USsLJzSATg2z5VxQ3mbnOL
 yEBY=
X-Google-Smtp-Source: AGHT+IF+7XPCWKeLDrzf6iHr4qRyOyhOD+FEWclxYKDEEIwHcmnG5F2DBjnw5UTyO1yybUu3tkl6kw==
X-Received: by 2002:a17:906:f190:b0:a26:ea22:e62b with SMTP id
 gs16-20020a170906f19000b00a26ea22e62bmr1295323ejb.43.1705662871389; 
 Fri, 19 Jan 2024 03:14:31 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.227.tellas.gr.
 [109.242.227.114]) by smtp.gmail.com with ESMTPSA id
 vq9-20020a170907a4c900b00a2ca97242d5sm9283321ejc.120.2024.01.19.03.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:14:31 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/6] hw/arm/xen_arm.c: convert DPRINTF to tracepoints
Date: Fri, 19 Jan 2024 13:14:21 +0200
Message-Id: <49905a0d22aa80956645d6dd74e9bc098c56555b.1705662313.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
References: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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
on tracepoints should be able to opt-in to each tracepoint and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into tracepoints.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/trace-events |  7 +++++++
 hw/arm/xen_arm.c    | 26 +++++++++++++++-----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index a6a67d5f16..e3f5d677d7 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -81,3 +81,10 @@ strongarm_ssp_read(uint64_t addr) "Bad register 0x%zu"
 strongarm_ssp_write_wrong_data_size(int v) "Wrong data size: %i bits"
 strongarm_ssp_write_wrong_data_size_invalid(void) "Attempt to use SSP LBM mode"
 strongarm_ssp_write_bad_register(uint64_t addr) "Bad register 0x%zu"
+
+# xen_arm.c
+xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%lx"
+xen_init_ram(const char *hi_xor_low, uint64_t base, uint64_t size) "Initialized region xen.ram.%s: base 0x%lx size 0x%lx"
+xen_enable_tpm_not_found(void) "Couldn't find tmp0 backend"
+xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%lx"
+xen_arm_init(const char *msg) "%s"
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index a5631529d0..a024117d22 100644
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
 
@@ -117,15 +119,13 @@ static void xen_init_ram(MachineState *machine)
     memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
                              GUEST_RAM0_BASE, ram_size[0]);
     memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
-    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
-            GUEST_RAM0_BASE, ram_size[0]);
+    trace_xen_init_ram("lo", GUEST_RAM0_BASE, ram_size[0]);
 
     if (ram_size[1] > 0) {
         memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
-        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
-                GUEST_RAM1_BASE, ram_size[1]);
+        trace_xen_init_ram("hi", GUEST_RAM1_BASE, ram_size[1]);
     }
 }
 
@@ -158,7 +158,7 @@ static void xen_enable_tpm(XenArmState *xam)
 
     TPMBackend *be = qemu_find_tpm_be("tpm0");
     if (be == NULL) {
-        DPRINTF("Couldn't fine the backend for tpm0\n");
+        trace_xen_enable_tpm_not_found();
         return;
     }
     dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
@@ -168,7 +168,7 @@ static void xen_enable_tpm(XenArmState *xam)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, xam->cfg.tpm_base_addr);
 
-    DPRINTF("Connected tpmdev at address 0x%lx\n", xam->cfg.tpm_base_addr);
+    trace_xen_enable_tpm(xam->cfg.tpm_base_addr);
 }
 #endif
 
@@ -179,8 +179,11 @@ static void xen_arm_init(MachineState *machine)
     xam->state =  g_new0(XenIOState, 1);
 
     if (machine->ram_size == 0) {
-        DPRINTF("ram_size not specified. QEMU machine started without IOREQ"
-                "(no emulated devices including Virtio)\n");
+        trace_xen_arm_init("ram_size not specified. "
+                           "QEMU machine started "
+                           "without IOREQ "
+                           "(no emulated devices"
+                           "including Virtio)");
         return;
     }
 
@@ -194,7 +197,8 @@ static void xen_arm_init(MachineState *machine)
     if (xam->cfg.tpm_base_addr) {
         xen_enable_tpm(xam);
     } else {
-        DPRINTF("tpm-base-addr is not provided. TPM will not be enabled\n");
+        trace_xen_arm_init("tpm-base-addr is not provided."
+                           "TPM will not be enabled");
     }
 #endif
 }
-- 
γαῖα πυρί μιχθήτω


