Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5397D1234
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr5P-0005cv-0y; Fri, 20 Oct 2023 11:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5M-0005cS-PR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:49 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5L-0001M2-2B
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:48 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9be3b66f254so140839766b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697814405; x=1698419205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68n6n0mII6+P8wsMRhocKE/9XK5lu0Lo0YDMzSDC/I4=;
 b=xIl831Hh8E603sIVCyxP6Gsy6PszG+v9WNJBJQU6s9peNbHvXsN0DW6kbwWEYG3bUL
 fpeAwhavwc+weo3nTBthoCOZudS6sEZbH8MHEjjl0TBhU+oUea2o87g14mtBUNKoWYXh
 7OOBR4oyBWFfw5fowHdioFCEKxcD9Y53B+WYL3xA/ZnEzsXmsDJJDXeqw5QZ2cbUFCRv
 Y7e8CQHUeAb9YlqzduvtKY/ElJ3U8GPR8Dj6YEIJVibQrm3jOjIO90jvKOXyWBafaexh
 1hifWZbG3E4n77sjuC9F47VsuNuzOkVDApruvTAFBWP+C/wwGw9DAF4xqhj1izFz1Bk8
 sGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814405; x=1698419205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68n6n0mII6+P8wsMRhocKE/9XK5lu0Lo0YDMzSDC/I4=;
 b=XrPxvzuqEqqdJ1I/+BQQoEusWd76IhrHE5ZcJJuU8wLlbYMHFm8XZK1XtmruE0zDh5
 M7YXPI4wtb30P4stok+x7j2f3fZJukJfk0hdYnGxfrS0TgNU6am0l0PDj0aOm31es6bY
 haBI4sgqfgNbYggGiPZ6LPITzY7RMqdqoXHniLjD6QT1iJaJlqR7EXM44XxmGiFDyk4u
 Hjo/vtoZhgy4rBEw+D//GiHVOfFt7jgTlAvEhSrOUZv/ix/WqNWTWeqtx3RALluJbmk9
 e+OzONcAMmf+nZXi6JzFosDLEVtH5e2yx0r9TQPc3hEvH+uvOgmp4tSYQsG4kQDOQWM/
 xRvw==
X-Gm-Message-State: AOJu0YySXj1YDSj6c2hrSy4M0boJF+F/rCsQlFrxPwEOZ9/I8NQaZxH2
 gkGRcKrzVPZoG7WVLoFn8eqi8ajQoyV1zPcRQDA=
X-Google-Smtp-Source: AGHT+IHagumdG3cBzEcHgi4cKaEgJkrvbg8lVtmvbKHa82clsV15H0jHS6G2xWqZkwHShh9tTqGozQ==
X-Received: by 2002:a17:906:7315:b0:9be:71ab:fb5e with SMTP id
 di21-20020a170906731500b009be71abfb5emr1908651ejc.22.1697814404882; 
 Fri, 20 Oct 2023 08:06:44 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 u10-20020a17090657ca00b009b8dbdd5203sm1666524ejr.107.2023.10.20.08.06.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 08:06:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] hw/m68k/mcf5206: Pass CPU using QOM link property
Date: Fri, 20 Oct 2023 17:06:22 +0200
Message-ID: <20231020150627.56893-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020150627.56893-1-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Avoid the interrupt controller directly access the first cpu
via the qemu_get_cpu() call. Pass it from the board code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/an5206.c  | 2 ++
 hw/m68k/mcf5206.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 11ae4c9795..f51c93088f 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -26,6 +26,8 @@ static void mcf5206_init(MemoryRegion *sysmem, uint32_t base)
     SysBusDevice *s;
 
     dev = qdev_new(TYPE_MCF5206_MBAR);
+    object_property_set_link(OBJECT(dev), "m68k-cpu",
+                             OBJECT(first_cpu), &error_abort);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
 
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


