Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3960A7D1238
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr5I-0005cB-LX; Fri, 20 Oct 2023 11:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5G-0005bk-DQ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:42 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5E-0001Ld-Ly
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:42 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so143366966b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697814398; x=1698419198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfVWFHCjBq/tqfdnBzt5xPqvbfwJpX/7kEv+608Z6sg=;
 b=ypt5z6ocfHBqyCc0dp68ZNG392QWtMEhfs5qReu/yi25XtdsHRMuhMQYywJ5tL/DAs
 YkvtKqGTeaej1BfOLjO6xqxkp8XNvLwmEzEe9hqNeLRIgMJ0ydfQJEnhxeCoqGyyTcKB
 Ng+48sz7KqyG7h9Il+gWPp0JyMZpVFpRHcCdEa32jbpN8pLTky2d1JTMfSC9gWPG7d0B
 mApjlc/ijuV/zcEuSDP4EWlanaOGuMdyUI20uAO9aqJxr/rN3BiMX7Y1pJkeb0J0j5RG
 m5gfBPoPsRMrVhkhEGSo4gUWkoqhMucq79YDSYYym97DkzfVHmVXZdG2nLEHYRhCiUFE
 1yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814398; x=1698419198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfVWFHCjBq/tqfdnBzt5xPqvbfwJpX/7kEv+608Z6sg=;
 b=RGxQbD65oDpCuy+1pIggrNFOETP5P+VFhg5g2Dl5MmwmYDWzAJsmQ9tiwGEhe6hFN/
 7dilNLBIAwDLS0bpyx06Pqw+oMqgqgeVkr+PuMqXvb6DjfPia+NJvipgtwMpKpc0dhRy
 uefNeQnuAS+EUBpAJRLkOsRO+PVhFWzFNq12QaQgm4wO9zPNcJdYAXfVq7Ahar8G8eFV
 u++sfdetrxJCs0DfeDtvTzFgaecZo8PZH8geibmtXiwQd/DCQJQQ8RzrOE2QwpmmVyu0
 UzQbxt4zHa++BANl+7wD6m+EOuBduJZg66+HGP6ZrLLuc6CkysNI7jfCUYs8R6s3ZxYP
 Wdlw==
X-Gm-Message-State: AOJu0YyqhSPIEWtxU9Ok9BWzzIHcLkM45PjJLndT0h+LhFxIYZ+N3dpj
 jt86R3CD3wLNFURcSANkJsSwO6jzwnlFW5xz4Fk=
X-Google-Smtp-Source: AGHT+IGr3083arpP587iLw/EQFuJZL+OBVggqZxv2z3Y77UCbPj8JX1yKLi+IORS+eKuxomJKKUmuw==
X-Received: by 2002:a17:907:948e:b0:9bf:9c58:e91e with SMTP id
 dm14-20020a170907948e00b009bf9c58e91emr1397181ejc.56.1697814396835; 
 Fri, 20 Oct 2023 08:06:36 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 m19-20020a1709066d1300b0099bd453357esm1645245ejr.41.2023.10.20.08.06.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 08:06:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] hw/m68k/irqc: Pass CPU using QOM link property
Date: Fri, 20 Oct 2023 17:06:21 +0200
Message-ID: <20231020150627.56893-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020150627.56893-1-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Avoid the interrupt controller directly access the 'first_cpu'
global. Pass it from the board code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/m68k_irqc.h |  1 +
 hw/intc/m68k_irqc.c         | 10 +++++++++-
 hw/m68k/virt.c              |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

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
index 2dd3c99894..da35e74bd9 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -155,6 +155,8 @@ static void virt_init(MachineState *machine)
     /* IRQ Controller */
 
     irqc_dev = qdev_new(TYPE_M68K_IRQC);
+    object_property_set_link(OBJECT(irqc_dev), "m68k-cpu",
+                             OBJECT(first_cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqc_dev), &error_fatal);
 
     /*
-- 
2.41.0


