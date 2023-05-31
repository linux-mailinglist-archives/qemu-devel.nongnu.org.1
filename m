Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E337D718E95
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:35:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UOk-0004gM-4Z; Wed, 31 May 2023 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOf-0004d7-Uo
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:28 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOd-00058m-5J
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:25 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3094910b150so169172f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572461; x=1688164461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTOXUlsQg1I2uqXYz0kosQk6IYoXK5LW0X8kOF6ZClA=;
 b=iywQId/zgdVpx4dU8E0e4lromH4P+JTUbk0BQ59h6naJGrfSNCnL2bOf43uZQv5KUb
 sfiLpBWYhKvuhsbUiiwklvGZN1Y7MoAmDbzOKLN61mco/lzCQElfRrcgnHQerjVuUQI8
 UEbpWYu1F4jgzR+IPwLIpnB5M6uVSEMQpoPe76Zw7K6Msm7ktZ2LIErGo9ryptq00px5
 njvc8d0J7tkUneUZYKnDeT7l2UVxAbPxag3O32+KElUAR/9Ijm6fkiSaaLqW2Hk9rck5
 aHK/TCjYIfzw6C/L7PI3rwe+Pvm6qYsFVE6e291JK5dsIJ2QFCRAvoULTlzD3mHDuytq
 xFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572461; x=1688164461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTOXUlsQg1I2uqXYz0kosQk6IYoXK5LW0X8kOF6ZClA=;
 b=BYQxKWlXV/d50100kazUS5jbYVmTTAM/iwSypxHQP9yWeLr1fVuKaJgRNbAFU8mJ5C
 VdR2HSNko3uLK1K9xxG5ypGLaWx6lQbTHMP6bIk3xwzcQDY3wBySf04HntoYWq/AfV1l
 j0nUuwIbXYPfXfNH4L5fG2LJ+EKJSLweUpjIXNhstaLAQmadMVrZNmOdd/IXhPOK6QKu
 HH+1upEVxxpQshCMHxDaxLP4uCyD0zPY8ouMQ2zLK4ynGt0qprMK4tuqWK5pMz1V3v0M
 VixwtXTIvgUXm9TQ3Qzswl2I7EmTh+ixjvk8IJOLdRGFAd9hWAanRnEwwd1e2TJs9EX+
 1I2g==
X-Gm-Message-State: AC+VfDyce4jPboAeAqDutwuOxT0CdGOFIiNUVvWxs1NZqEB/G+NtRAeX
 ELxIyHCOGjJMcGKMXZR7mRObZomAlJTc5gdZUjA=
X-Google-Smtp-Source: ACHHUZ5eQ3W7yred1WPvX0cNUdzknkIHusS46+bVX6rPzfoF+8Ayt3q+IBAGmsogy2fi+eRkq1oRbw==
X-Received: by 2002:adf:fd8a:0:b0:306:492c:cdd8 with SMTP id
 d10-20020adffd8a000000b00306492ccdd8mr382231wrr.15.1685572461397; 
 Wed, 31 May 2023 15:34:21 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a5d4c42000000b0030af15d7e41sm8110254wrt.4.2023.05.31.15.34.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 15:34:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] hw: Simplify using sysbus_init_irqs() [manual]
Date: Thu,  1 Jun 2023 00:33:41 +0200
Message-Id: <20230531223341.34827-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531223341.34827-1-philmd@linaro.org>
References: <20230531223341.34827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Audit the sysbus_init_irq() calls and manually convert
to sysbus_init_irqs() when a loop is involved.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongarch_extioi.c | 3 +--
 hw/intc/omap_intc.c        | 3 +--
 hw/pci-host/gpex.c         | 2 +-
 hw/timer/renesas_tmr.c     | 9 +++------
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index db941de20e..c579636215 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -275,8 +275,7 @@ static void loongarch_extioi_instance_init(Object *obj)
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(obj);
     int cpu, pin;
 
-    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, EXTIOI_IRQS);
-
+    sysbus_init_irqs(dev, s->irq, EXTIOI_IRQS);
     qdev_init_gpio_in(DEVICE(obj), extioi_setirq, EXTIOI_IRQS);
 
     for (cpu = 0; cpu < EXTIOI_CPUS; cpu++) {
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 647bf324a8..f324b640e3 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -627,8 +627,7 @@ static void omap2_intc_init(Object *obj)
 
     s->level_only = 1;
     s->nbanks = 3;
-    sysbus_init_irq(sbd, &s->parent_intr[0]);
-    sysbus_init_irq(sbd, &s->parent_intr[1]);
+    sysbus_init_irqs(sbd, s->parent_intr, ARRAY_SIZE(s->parent_intr));
     qdev_init_gpio_in(dev, omap_set_intr_noedge, s->nbanks * 32);
     memory_region_init_io(&s->mmio, obj, &omap2_inth_mem_ops, s,
                           "omap2-intc", 0x1000);
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index a6752fac5e..7b46e3e36e 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -128,8 +128,8 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
         sysbus_init_mmio(sbd, &s->io_ioport);
     }
 
+    sysbus_init_irqs(sbd, s->irq, GPEX_NUM_IRQS);
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
         s->irq_num[i] = -1;
     }
 
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index c15f654738..dd2929d6e7 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -428,17 +428,14 @@ static void rtmr_init(Object *obj)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(obj);
     RTMRState *tmr = RTMR(obj);
-    int i;
 
     memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
                           tmr, "renesas-tmr", 0x10);
     sysbus_init_mmio(d, &tmr->memory);
 
-    for (i = 0; i < ARRAY_SIZE(tmr->ovi); i++) {
-        sysbus_init_irq(d, &tmr->cmia[i]);
-        sysbus_init_irq(d, &tmr->cmib[i]);
-        sysbus_init_irq(d, &tmr->ovi[i]);
-    }
+    sysbus_init_irqs(d, tmr->cmia, ARRAY_SIZE(tmr->cmia));
+    sysbus_init_irqs(d, tmr->cmib, ARRAY_SIZE(tmr->cmib));
+    sysbus_init_irqs(d, tmr->ovi, ARRAY_SIZE(tmr->ovi));
     timer_init_ns(&tmr->timer[0], QEMU_CLOCK_VIRTUAL, timer_event0, tmr);
     timer_init_ns(&tmr->timer[1], QEMU_CLOCK_VIRTUAL, timer_event1, tmr);
 }
-- 
2.38.1


