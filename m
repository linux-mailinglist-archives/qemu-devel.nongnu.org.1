Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B1A719798
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4etn-0005DF-J7; Thu, 01 Jun 2023 05:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4eth-00055p-Nt
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:47:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etf-0004Ox-QX
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:47:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so6552915e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685612826; x=1688204826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmhQNJHFAcag6yz9sQ/XjOqESAjbgaIMCNWmwxbtuwY=;
 b=oUMo5NqB7r7wpUyHbTnnyba9E+v4zPJn/YthIR6MoVYSi63MUEqLISYD/BQWvOPMRi
 pR6MWoL+UXLpRAzyNnE0n75OoEK7+YlRiilyjaTsQgo47iho3lMWfaStvse80HY/e9HM
 jHjYspQh++nXBboB4vd3Q0tKRhekV2cfv+JbwDECbWwavWR5djK/TjaFjzFVMqcRcLMX
 pY5itrfeoEbDSiw2+8L4oDapN8UXuURbjjbOpgnbniwAw5sQlAm4hI3L6c+EG14/H1mR
 2TrNEzH7NaWhFqnufdZ7aS1sx3zztEOgnUt5Y5/oIV129q7eBtMFCG7yZFbmZj2GnhaG
 IQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612826; x=1688204826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmhQNJHFAcag6yz9sQ/XjOqESAjbgaIMCNWmwxbtuwY=;
 b=cmXwkKyEOgN6WS7fZKyv9fxCoHxHEQLQdvJVmLGJnOTTUcpmXSKAIe/jktX/TwGxky
 jLjlI8+Nr6h7hOR2rYXBSrlQKakXy2eaGrKmoQcf32QibLVxJZc+HQR0KbsVcJdc/5E/
 tpfVjNYqnjxT/Khv2wQfuQ2Qi+IuXtkJMM0GQnWwm5b5Wuy6hk+695BI3Q8aEkvSkisS
 O2xTAt7S7pPruovSnZgF4ExWglNnbNmLMIfYRpORlgzV0m01Vq18NBocn5MkTO5zBSjH
 NPt5Hr9WgndP3NIOTyvbOUdmFHIlOw9meIFte5LEFYCsAKx3jzm9BqUFXBAdgk8YGYh2
 yJEQ==
X-Gm-Message-State: AC+VfDy8mV4acbDTJZuiK7PRzDtH3H4pTNZf7xH3E0E+tcs7G0cSe5um
 cnt+pvvQjqgSnxn3QthXQQs4iNaz0wCas8OngVo=
X-Google-Smtp-Source: ACHHUZ6BKM/l5R+/8IKjmBiZCZ1b9lbdOOHZfhN9qIM0RC2g7tnOTUC7FVNYUQ4eRoI8QeYq4gslEQ==
X-Received: by 2002:a7b:cd0f:0:b0:3f6:4f1:cfbf with SMTP id
 f15-20020a7bcd0f000000b003f604f1cfbfmr1134766wmj.20.1685612826405; 
 Thu, 01 Jun 2023 02:47:06 -0700 (PDT)
Received: from localhost.localdomain ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 bg22-20020a05600c3c9600b003f4283f5c1bsm8570794wmb.2.2023.06.01.02.47.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 02:47:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 7/7] hw: Simplify using sysbus_init_irqs() [manual]
Date: Thu,  1 Jun 2023 11:46:25 +0200
Message-Id: <20230601094625.39569-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601094625.39569-1-philmd@linaro.org>
References: <20230601094625.39569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In omap2_intc_init(), the parent_intr[] array contains
2 elements: use ARRAY_SIZE() to iterate over.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/omap_intc.c    | 3 +--
 hw/pci-host/gpex.c     | 2 +-
 hw/timer/renesas_tmr.c | 9 +++------
 3 files changed, 5 insertions(+), 9 deletions(-)

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


