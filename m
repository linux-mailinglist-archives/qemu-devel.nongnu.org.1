Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05277DEF82
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:08:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaL-0001nN-Gg; Thu, 02 Nov 2023 06:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaJ-0001mR-3N
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:55 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaH-0003Fv-HE
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:54 -0400
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso115437366b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919552; x=1699524352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1g5l7WLPwmx/2FQG+3S+vPUT3Z4s0SPpwegU2qPgNuw=;
 b=DmGo06lZAmdxB/qR6iawjZ6Ua5wd8G843uW44q9V/FUIOdORZJ+mCj0aKkN2NI8BmT
 2Tf93/HgtAW9y0uApXeHuSDh4INskXBuVtVYZsL53ZjYrYwuOAz5S6jkThWt4rMO0h5K
 K7cjFwWrwi+Co6LujG2U19o8wsMCf3jJhDuy9I1jxg6M3eHGa8PYB/VvrLXgZVFjnE01
 5wdm3kZb7lP/obRnj77cQ/93cC1VI1u8rrpA8LMC6YTqOxNj98ajnuT+NIHly9uSylYe
 Ay3WC9PbiKkFFLok4TKxeeZYGxFLkMgSs5yFnkiP6kABTYRpL7DWRoVFghXg87g6YbX5
 inNQ==
X-Gm-Message-State: AOJu0YwYi2u5cut49FUtfNDyNl9ezLH6+ahTUz0wejsS5jYfoTshfrny
 2bDEOnPHsgWW41KbAvK4wLS8LR+WtDQ=
X-Google-Smtp-Source: AGHT+IF7TK1VDE/qV+giwDl1EcN/uXj6dlexmc51K3Ym1La852HYawzs7tI4SPPBuCrEGigJpkaRyA==
X-Received: by 2002:a17:907:9289:b0:9bf:388e:8e93 with SMTP id
 bw9-20020a170907928900b009bf388e8e93mr3972942ejc.0.1698919551849; 
 Thu, 02 Nov 2023 03:05:51 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:51 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/10] hw/m68k/irqc: Pass CPU using QOM link property
Date: Thu,  2 Nov 2023 11:05:34 +0100
Message-ID: <20231102100543.4875-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Avoid the interrupt controller directly access the 'first_cpu'
global. Pass 'cpu' from the board code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231024083010.12453-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/intc/m68k_irqc.c         | 10 +++++++++-
 hw/m68k/virt.c              |  2 ++
 include/hw/intc/m68k_irqc.h |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 0c515e4ecb..e09705eeaf 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -11,6 +11,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
+#include "hw/qdev-properties.h"
 #include "hw/nmi.h"
 #include "hw/intc/intc.h"
 #include "hw/intc/m68k_irqc.h"
@@ -35,7 +36,7 @@ static void m68k_irqc_print_info(InterruptStatsProvider *obj, Monitor *mon)
 static void m68k_set_irq(void *opaque, int irq, int level)
 {
     M68KIRQCState *s = opaque;
-    M68kCPU *cpu = M68K_CPU(first_cpu);
+    M68kCPU *cpu = M68K_CPU(s->cpu);
     int i;
 
     if (level) {
@@ -85,12 +86,19 @@ static const VMStateDescription vmstate_m68k_irqc = {
     }
 };
 
+static Property m68k_irqc_properties[] = {
+    DEFINE_PROP_LINK("m68k-cpu", M68KIRQCState, cpu,
+                     TYPE_M68K_CPU, ArchCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void m68k_irqc_class_init(ObjectClass *oc, void *data)
  {
     DeviceClass *dc = DEVICE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(oc);
 
+    device_class_set_props(dc, m68k_irqc_properties);
     nc->nmi_monitor_handler = m68k_nmi;
     dc->reset = m68k_irqc_reset;
     dc->vmsd = &vmstate_m68k_irqc;
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 2dd3c99894..e7dc188855 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -155,6 +155,8 @@ static void virt_init(MachineState *machine)
     /* IRQ Controller */
 
     irqc_dev = qdev_new(TYPE_M68K_IRQC);
+    object_property_set_link(OBJECT(irqc_dev), "m68k-cpu",
+                             OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqc_dev), &error_fatal);
 
     /*
diff --git a/include/hw/intc/m68k_irqc.h b/include/hw/intc/m68k_irqc.h
index ef91f21812..693e33b0aa 100644
--- a/include/hw/intc/m68k_irqc.h
+++ b/include/hw/intc/m68k_irqc.h
@@ -33,6 +33,7 @@ typedef struct M68KIRQCState {
     SysBusDevice parent_obj;
 
     uint8_t ipr;
+    ArchCPU *cpu;
 
     /* statistics */
     uint64_t stats_irq_count[M68K_IRQC_LEVEL_NUM];
-- 
2.41.0


