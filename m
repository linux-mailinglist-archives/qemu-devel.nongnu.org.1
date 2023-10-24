Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 543257D4A1A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCo9-0001bq-4l; Tue, 24 Oct 2023 04:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCnz-0001W4-Bo
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCnx-00017V-KR
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so2814161f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698136224; x=1698741024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgMoLhn/PijE82EW0MI6DqC9oqnirXW6IOpPCP9Xfok=;
 b=i/4aO4pGu6LOO/+hjJ5ptcsVu4rDxG33uOTIrf0u8alw0QMt2cjNk6NZT4nBfpy6lC
 mAeX8+n3SgJVkE5XwL3roKs9aQMMaDUy5nqAbB/14svK12sNt+JaLUiqoMq+6pX5L2U9
 7gNCHZohnKmbVKS4sZxno11UrR++pwcPwy5sbiI1BMa5JxZpFwUo65f/L9sCMRw3GzaJ
 v0mGDDe8YsuW4e0+krsErn3v13t0ggyC7b/0Wt9x5sPtSiOrXQZI7aZ8GgMe94c2IoFp
 djzBkeXhHZMpw9jhyloMejwsULU9bMyD5dWlGWT5+x6RnhmHgh5cWjm2tKzmzv92X9X4
 cHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136224; x=1698741024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgMoLhn/PijE82EW0MI6DqC9oqnirXW6IOpPCP9Xfok=;
 b=KP33yzcfex+RXLXFSaMcl+1y0H/J1TwZoPCHoih4ILsyfmepzQ5QBD8Vo1ta18WeK8
 wM1dxTz1fL5FZ0bYSJOH4HibI+FNCczDQ95vZ8M7+WSgrBdscnHoPGePJgmKCqoBYbLu
 sNEX5cSNiiSdy97rdItm8kBXsAenxIRFHHOs1jEJyg1e4oeAHkYSy49gixnpTBebVnsm
 nYIhp2/tqT/djcDrXNUbWHzfh1DgpMbZAHYW3LMRN5Ul8pY25JzcCx/JeYhVY3B2/5fd
 2MBCS+Ir2s4ZwD3v5PrdP86InPoRJn3CYaJYvwbPnlaw1ZxNHCaE/U2ZgGZPw6jjH70d
 vNaA==
X-Gm-Message-State: AOJu0YzFirTdvc+cmMf5fA6SK2Ec1ly3VbcYpHUtOM/276Q13wLcIoD3
 OhS00mjzVILOwlD+3P5+yeE5crCaAc92Ghxt+wk=
X-Google-Smtp-Source: AGHT+IGOaZV3SgR3l8K/dUyiMtjGgy76TrU1qE+u/aqyfDNfEOhtcDcuiE4ZUgY1UKM9nsb7Kb3JkQ==
X-Received: by 2002:a5d:4a4c:0:b0:32d:8907:2b18 with SMTP id
 v12-20020a5d4a4c000000b0032d89072b18mr9276531wrs.66.1698136223971; 
 Tue, 24 Oct 2023 01:30:23 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 b14-20020a5d550e000000b0032d9caeab0fsm9394218wrv.77.2023.10.24.01.30.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 01:30:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/6] hw/m68k/mcf5206: Pass CPU using QOM link property
Date: Tue, 24 Oct 2023 10:30:05 +0200
Message-ID: <20231024083010.12453-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024083010.12453-1-philmd@linaro.org>
References: <20231024083010.12453-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Avoid the interrupt controller directly access the first cpu via
the qemu_get_cpu() call. Pass it as argument to mcf5206_init()
from the board code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


