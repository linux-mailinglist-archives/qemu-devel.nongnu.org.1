Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 562387DEF83
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:08:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaL-0001ni-UY; Thu, 02 Nov 2023 06:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaK-0001mh-4v
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:56 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaI-0003Fy-Ki
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:55 -0400
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-99357737980so108573666b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919553; x=1699524353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nL0Y9TbMWZl0LQx6cxYpTPkWBi5TFH+TySFwvCTQt/Q=;
 b=I3+rRo9D1Ch11P+aZcxmJZWYxQP7QNlDyfBlRqMqCa0LGTp8x3/i1xbffm3NASyFVE
 6/zL89/4zmamHgMZpFcIYQBfJyaVEnGXdFia+HHTFsEtcOLH51b/wLF/z9JzNl10E6+F
 NJ2mWXW4aC+h/NUePlWLZDk0Ps0fa6z8dhsRK4uti4ieQ86frR/OsjiUvMl0W7PcqwiH
 7BWO9ugoF/6ypBD3yMLwkyDo1lo5+4yk28ZENNqcUBKQihHdeYiotMjaAYVOT3KeSZH5
 z/hZUT1W/j7ssPc6U7iI6MuTMNo+uhdMd+ZDmoyi2bTN9bMEdq8VP39OZEOJhCeseRNh
 tWvQ==
X-Gm-Message-State: AOJu0YyIOBg0ym0L1GBVmvsTJJVRAKIuafO8YlvfVk4FYb46P5XKF82O
 lLqrhn+G3ABIG0zlu5F+aU8akJgcprE=
X-Google-Smtp-Source: AGHT+IFfCmlouxEbqz43b+SCL2FixelTS49K8Q2MBO+8To5uo9gCFaNIWIgGGhIYgAXX0gx2Lw8skA==
X-Received: by 2002:a17:907:7255:b0:9bf:10f3:e435 with SMTP id
 ds21-20020a170907725500b009bf10f3e435mr4210725ejc.1.1698919552892; 
 Thu, 02 Nov 2023 03:05:52 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:52 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/10] hw/m68k/mcf5206: Pass CPU using QOM link property
Date: Thu,  2 Nov 2023 11:05:35 +0100
Message-ID: <20231102100543.4875-3-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.54; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f54.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Avoid the interrupt controller directly access the first cpu via
the qemu_get_cpu() call. Pass it as argument to mcf5206_init()
from the board code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231024083010.12453-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/an5206.c  | 6 ++++--
 hw/m68k/mcf5206.c | 9 ++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 11ae4c9795..1e8e64f8bd 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -20,12 +20,14 @@
 #define AN5206_MBAR_ADDR 0x10000000
 #define AN5206_RAMBAR_ADDR 0x20000000
 
-static void mcf5206_init(MemoryRegion *sysmem, uint32_t base)
+static void mcf5206_init(M68kCPU *cpu, MemoryRegion *sysmem, uint32_t base)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
     dev = qdev_new(TYPE_MCF5206_MBAR);
+    object_property_set_link(OBJECT(dev), "m68k-cpu",
+                             OBJECT(cpu), &error_abort);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
 
@@ -60,7 +62,7 @@ static void an5206_init(MachineState *machine)
     memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
     memory_region_add_subregion(address_space_mem, AN5206_RAMBAR_ADDR, sram);
 
-    mcf5206_init(address_space_mem, AN5206_MBAR_ADDR);
+    mcf5206_init(cpu, address_space_mem, AN5206_MBAR_ADDR);
 
     /* Load kernel.  */
     if (!kernel_filename) {
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 2ab1b4f059..f920ca2ceb 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -10,6 +10,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "hw/m68k/mcf.h"
@@ -601,13 +602,19 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
     s->timer[1] = m5206_timer_init(s->pic[10]);
     s->uart[0] = mcf_uart_init(s->pic[12], serial_hd(0));
     s->uart[1] = mcf_uart_init(s->pic[13], serial_hd(1));
-    s->cpu = M68K_CPU(qemu_get_cpu(0));
 }
 
+static Property mcf5206_mbar_properties[] = {
+    DEFINE_PROP_LINK("m68k-cpu", m5206_mbar_state, cpu,
+                     TYPE_M68K_CPU, M68kCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void mcf5206_mbar_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, mcf5206_mbar_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "MCF5206 system integration module";
     dc->realize = mcf5206_mbar_realize;
-- 
2.41.0


