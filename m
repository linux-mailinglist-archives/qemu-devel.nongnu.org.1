Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9177D123C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr5b-000681-K1; Fri, 20 Oct 2023 11:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5Y-00062A-3Y
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:07:00 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5W-0001OF-95
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:59 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so4283141a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697814416; x=1698419216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGRPHT/WBPalUJTx91B3yYyqtqOtvzDargUZTDcy7QI=;
 b=SHEfxekyZ7yfjC+tw7SoR2u9yjSim0obd62kJbpEeNNT0qqdH+mPa/13s6Y2M83YIy
 FqBmKxCllByLJ1VDTpkeH6koOL7GWdl4ZrGEEDFNnMHWh+sixCNRTZLpBgBsSEuvfjK5
 3x243RYSkdglYsvqaYpN1PUwV2ObyNWFrvvhKrP+J3gWpan1avKOab6u0bY0TBhOqU8Q
 JlHHccj7cNJzMjZeSr+5Y0b+Zu6DYft9M+AJwP0EvJtM8gdMAAiCNLRy2wFMtXYDOn6u
 IkyJfOu+1EsEZS6HtninDZlmVM8zgfT0OKgiplxoSrhRTSK3Hj3M7m2m2LpMYB3apVIZ
 bBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814416; x=1698419216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DGRPHT/WBPalUJTx91B3yYyqtqOtvzDargUZTDcy7QI=;
 b=fOS1KMNdLZHxZ1Yqo9R9jweIkP4XQmrQZwFLddNL0XnmcE9BW1TBJ4/1mBvNJNlRwJ
 z+/vQ4OgRMgQiNAWs00xgj0rb/CD4qdDGhAinUwMY4k1cP5V2Zir/4IWg8tgke7s43+l
 IGeKDplU2b16FCUyTVhTIsr6kJMlnG1s0vaBbim3EG5ruY+qV+tgrzFiggBbaRiRv+zU
 xJ3wGksTfLvtOhVqXKBcIKYHVmSXK9lXOEt6QBpGS5VDz4W9Q8I8SwW7jTvr+ZMYoN0L
 EfmEfW1nHOQ8Vehyj2uKawH4Tn7920NnoEL6f343T85gDixelQnv0zvju1Yf2Os8AOOA
 yqHg==
X-Gm-Message-State: AOJu0Ywick0BvxHsZAzGJRBqt+aV6z+THTXlzSuvPLmiyg49vF3QaNF+
 1ZKK+NL7X/uCR74d9/UatU8vgnNDCybkYwYcdLA=
X-Google-Smtp-Source: AGHT+IHNeoWbm/asXaUWROPfr09CIgVyIRWg2xMPIU8t+pRpJrQZfssiGPUEIwnYr+WgBbcOXgd0fg==
X-Received: by 2002:a17:906:4fc7:b0:9bf:c00f:654a with SMTP id
 i7-20020a1709064fc700b009bfc00f654amr1755999ejw.24.1697814416331; 
 Fri, 20 Oct 2023 08:06:56 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 xa17-20020a170907b9d100b009b913aa7cdasm1665815ejc.92.2023.10.20.08.06.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 08:06:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] hw/m68k/mcf_intc: Pass CPU using QOM link property
Date: Fri, 20 Oct 2023 17:06:24 +0200
Message-ID: <20231020150627.56893-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020150627.56893-1-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

QOM objects shouldn't access each other internals fields
except using the QOM API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/mcf_intc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 1f74ea0e14..1d3b34e18c 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -14,6 +14,7 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
+#include "hw/qdev-properties.h"
 #include "qom/object.h"
 
 #define TYPE_MCF_INTC "mcf-intc"
@@ -176,10 +177,17 @@ static void mcf_intc_instance_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
+static Property mcf_intc_properties[] = {
+    DEFINE_PROP_LINK("m68k-cpu", mcf_intc_state, cpu,
+                     TYPE_M68K_CPU, M68kCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void mcf_intc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, mcf_intc_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->reset = mcf_intc_reset;
 }
@@ -204,16 +212,13 @@ qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
                         M68kCPU *cpu)
 {
     DeviceState  *dev;
-    mcf_intc_state *s;
 
     dev = qdev_new(TYPE_MCF_INTC);
+    object_property_set_link(OBJECT(dev), "m68k-cpu",
+                             OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    s = MCF_INTC(dev);
-    s->cpu = cpu;
-
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
-    return qemu_allocate_irqs(mcf_intc_set_irq, s, 64);
+    return qemu_allocate_irqs(mcf_intc_set_irq, dev, 64);
 }
-- 
2.41.0


