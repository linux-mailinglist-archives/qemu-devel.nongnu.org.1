Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80327F4F9B
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:33:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s1C-0004WT-E6; Wed, 22 Nov 2023 13:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0m-0004Hc-Fw
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0i-0004es-Cy
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:43 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso286335e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677898; x=1701282698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juSImIqOFX4cBg5Zc+Do2T+lJUxoOW0iOapk4mN+Z7o=;
 b=HYm4Qm6T8RPZspq0QC/9ILxuDUOlrpei8Dlmyju6RtFlBex4tXpdag8vXyGKMNihvu
 4TX5YpXceDlDSOBQ4babeDEKGr1zLWzfSdi69Ggdsl1RPvr3+iCSqRjVY8Ignh06HqiC
 miI1k+K5QljjCGSBuPgtjKH+VMAAHNDD9F42wOcuUYpLC+fxlkgV+koQd8DcFhs5wVhx
 xSmlYR0UFnMrUu0OeT3J76LFareVEbZgPW1/UT23Tq4sxrsvVsp7xUwDGnNt2x8FuoPM
 uwkLFl54juhBvsILdYmr/BfKcODTPd4/zR+VdKgMpuCidhZwrLch/pClxACCBk5f/58O
 WLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677898; x=1701282698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juSImIqOFX4cBg5Zc+Do2T+lJUxoOW0iOapk4mN+Z7o=;
 b=KLWw8n+tGDxXRn/u4M/NlFrE7qLCVTKhRpBiULkSwCmiEInDH287WE+KrTHcjkEeRA
 xXiO+vPwnlno8afTGF+Kab3Fk79ML7KhszDbwY2DprCuHQD+DZOJdqGtZ9tmHsDtBEeG
 DBmfFDD/s4I6wnBsJpgl4vpf915TL6aJk2tUR18ZCRQsJmOz7a0ewgpOuOXhRHc85UxT
 thUpfcvGGaXaAmGFbJ3iawObTRFd7Tojft9+JAD7dFf92LpNMr5vaIpKEZhZc9YbMb+9
 g4lLylQAbbFVMLFym3JPWLu3ciFJx7L4IJfgIapSj4P51Jms2BfyX2mURIpQeKhVeQh3
 mPcg==
X-Gm-Message-State: AOJu0YyLpM8OpcN/JPLaLjfvnBri7QrukWK/F787fwejkblLsD+HavsS
 FO5agWG9tw8NC6J46PLj2FGVgK2bTLzbSz62C6s=
X-Google-Smtp-Source: AGHT+IEDhZssPByOJSwxEJVD+BQeS0gJKpv55Tt6F3/9rP1iAZJ3KJSnJODJSNYMYHo+HTAjjtT9mw==
X-Received: by 2002:a05:600c:4f01:b0:409:773:cf62 with SMTP id
 l1-20020a05600c4f0100b004090773cf62mr2223036wmq.39.1700677898695; 
 Wed, 22 Nov 2023 10:31:38 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 b5-20020a05600c4e0500b003feae747ff2sm261799wmq.35.2023.11.22.10.31.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH-for-9.0 09/11] hw/arm/bcm2836: Allocate ARM CPU state with
 object_new()
Date: Wed, 22 Nov 2023 19:30:45 +0100
Message-ID: <20231122183048.17150-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The ARMCPU type is forward declared as a pointer to all hw/ files.
Its declaration is restricted to target/arm/ files. By using a
pointer in BCM283XState instead of embedding the whole CPU state,
we don't need to include "cpu.h" which is target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/bcm2836.h |  4 ++--
 hw/arm/bcm2836.c         | 19 ++++++++++---------
 hw/arm/raspi.c           |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 6f90cabfa3..784bab0aad 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -14,7 +14,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/intc/bcm2836_control.h"
-#include "target/arm/cpu.h"
+#include "target/arm/cpu-qom.h"
 #include "qom/object.h"
 
 #define TYPE_BCM283X "bcm283x"
@@ -38,7 +38,7 @@ struct BCM283XState {
     uint32_t enabled_cpus;
 
     struct {
-        ARMCPU core;
+        ARMCPU *core;
     } cpu[BCM283X_NCPUS];
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8031a74600..4f5acee77e 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -39,8 +39,9 @@ static void bcm2836_init(Object *obj)
     int n;
 
     for (n = 0; n < bc->core_count; n++) {
-        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
-                                bc->cpu_type);
+        s->cpu[n].core = ARM_CPU(object_new(bc->cpu_type));
+        object_property_add_child(obj, "cpu[*]", OBJECT(s->cpu[n].core));
+        qdev_realize_and_unref(DEVICE(s->cpu[n].core), NULL, &error_abort);
     }
     if (bc->core_count > 1) {
         qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_property);
@@ -139,24 +140,24 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         object_property_set_bool(OBJECT(&s->cpu[n].core), "start-powered-off",
                                  n >= s->enabled_cpus, &error_abort);
 
-        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
+        if (!qdev_realize(DEVICE(s->cpu[n].core), NULL, errp)) {
             return;
         }
 
         /* Connect irq/fiq outputs from the interrupt controller. */
         qdev_connect_gpio_out_named(DEVICE(&s->control), "irq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_IRQ));
+                qdev_get_gpio_in(DEVICE(s->cpu[n].core), ARM_CPU_IRQ));
         qdev_connect_gpio_out_named(DEVICE(&s->control), "fiq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_FIQ));
+                qdev_get_gpio_in(DEVICE(s->cpu[n].core), ARM_CPU_FIQ));
 
         /* Connect timers from the CPU to the interrupt controller */
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_PHYS,
+        qdev_connect_gpio_out(DEVICE(s->cpu[n].core), GTIMER_PHYS,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpnsirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_VIRT,
+        qdev_connect_gpio_out(DEVICE(s->cpu[n].core), GTIMER_VIRT,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntvirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_HYP,
+        qdev_connect_gpio_out(DEVICE(s->cpu[n].core), GTIMER_HYP,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cnthpirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
+        qdev_connect_gpio_out(DEVICE(s->cpu[n].core), GTIMER_SEC,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
     }
 }
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index cc4c4ec9bf..01c391b90a 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -252,7 +252,7 @@ static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
         s->binfo.firmware_loaded = true;
     }
 
-    arm_load_kernel(&s->soc.cpu[0].core, machine, &s->binfo);
+    arm_load_kernel(s->soc.cpu[0].core, machine, &s->binfo);
 }
 
 static void raspi_machine_init(MachineState *machine)
-- 
2.41.0


