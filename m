Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C07D4A15
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCoF-0001e6-QL; Tue, 24 Oct 2023 04:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCoB-0001d9-BY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:39 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCo9-0001BL-KV
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:39 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c594196344so6282201fa.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698136236; x=1698741036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQzYUltxj5g7ekyBL7Wz4ZsV8ZVW3gL9B5H+7rR+rus=;
 b=PNljHyadIkI+PytbXF51RcoRqajHJxpDbXRQwfUYVjX7SovpapPNEYO72GbeUaqkM3
 dgDsuWHzEru0tYO2mVKXS4xLkTPUdb2GndK3N9INlaG4TdHeu5rU8qIBtnZ4Aeij1cS/
 6xTb9V80gSLbE/QSxTJDY1ivHC5qeuSbZtBWx6r4a1FRzADxeRQovypomrkq35ieRgNo
 XFH8jsm7f7twYCnkkaIeQwqsQ9B4LwsqfGsSqWrTblacFj4SOUwcs9LptHcP2H0fCh0v
 hH77GJ804x+7Bb5Cc5/Vxn9FJlHKV3VuiJ0XZGH8NhuPdkr/5wt1cQ4UAAM9TFmApV4M
 4/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136236; x=1698741036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQzYUltxj5g7ekyBL7Wz4ZsV8ZVW3gL9B5H+7rR+rus=;
 b=ezJLDTVIa1AdI3dNIdeR14opxQ79hEzmMgk5aIa0A3Upr1GnFHsajtjSktI8iGx2yK
 PBaHaqQJVETK7p8PTvxlgcXGiVq+tfUFSlY4k0q754zwoLFM9da0WRoZ02MmW5AbSR1L
 5M16yC20fQp16GELtJWYoEWo1oH+khg3oiIdHIK40KccY64lTQFauhh97pF6TDdsi/kY
 rrV53dFKaE1AwaOLT1obUqSjAXLmTl0Zk0akEoGKb/ep1HhzwK7oZ3vwTg7wEO0eFXXN
 KW6hb5hwfcfnse7e+3IaCcvKIL/Ojp7LsBqIPbnKeTwFggD7aa1a6xOoI2oAQXPgrvGr
 GzOg==
X-Gm-Message-State: AOJu0YzAIKFhde1WkLRx0LvyO+vPIJs2jm5Gi7NUduaiAVcjzCFg0wfv
 HyfQz0RN4XFcCRR9xSXv+MZEQedoEgWNfnYj5fo=
X-Google-Smtp-Source: AGHT+IGl+lGDQGsNcTKSN/DCzqsDII1Z3Rgp0NwT9Z98PTSmVm1EWx/o9taFm0AAq0GSh1r09jrZFg==
X-Received: by 2002:a2e:91d9:0:b0:2c5:2126:127a with SMTP id
 u25-20020a2e91d9000000b002c52126127amr7535501ljg.17.1698136235662; 
 Tue, 24 Oct 2023 01:30:35 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 p6-20020a5d6386000000b00327b5ca093dsm9409641wru.117.2023.10.24.01.30.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 01:30:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/6] hw/m68k/mcf_intc: Pass CPU using QOM link property
Date: Tue, 24 Oct 2023 10:30:07 +0200
Message-ID: <20231024083010.12453-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024083010.12453-1-philmd@linaro.org>
References: <20231024083010.12453-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
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


