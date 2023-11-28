Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E17FBBCA
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:39:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yI0-0001zQ-WA; Tue, 28 Nov 2023 08:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHy-0001yj-Ld
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:10 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHw-00086p-RU
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:10 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c87adce180so67022821fa.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701178687; x=1701783487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leKlI1n6G5PcdrvHQ/d7MuXu3YgwQw5y2/1THyY9+Xg=;
 b=W3PzGoEmR6sbKFXX+T0JkywSJSgZuhQzLRzUNTjpq/Hrycn+yt6U1PVrCo3BAL5IqT
 nMw//cRi2OMzAunrmo0YVM3YbX0oLuWj/KRGdbGpiabkMcfLxFXoOLffTLO0t/Ry3ZzS
 Ydj3r26/nUTH7PpvSyZXvvYugfRyQJB5kvrBHIWlX9JVhebjtXkfnZPt6dl7Hti6M+f3
 sW8PTfW6/poizaaIpOhUCHu3piZVURszJr+Kgy9MwaS01Zve42kbot0FYriH+ip5TaP4
 IDDFTr0GiScr6Kaj8xhdx8s239961f64b6FOlDfHEuKVAVVJiTrwTOYK3qn8otGewqrH
 BEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701178687; x=1701783487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leKlI1n6G5PcdrvHQ/d7MuXu3YgwQw5y2/1THyY9+Xg=;
 b=nD7Es1Dr1NnVIbYyKQVqKAILXwKKptCSNxA3+fxO53G1IbS6OaU9DDiWiOL0lAcfGC
 rfggTYD/nqehVBAcWznXa5T8o20c2vto9cdkinZSLAIbVnU7L1pgRASHHaSaVgp3NVXy
 yrZqUu2kjlbQ8Ib+pNsHpFouj116gmMCW1KjYICMcLrqJbyvjo9V2/yRfw3VPhHlEHyS
 brWOF3DLpafkxk2HPzEYwpSMQeWzyGYIXLz7pejLEcuGTSZFifYQkNlE9PI+n1Jw3eP9
 JCrHMpspwUc0uLq7oKIfs3FJUW2WuP9+ycS68mxQ1qgLTn27Xu797+vMS9XtJ8WBi6ZV
 XjzA==
X-Gm-Message-State: AOJu0Yztd5YC71KVJ4Syfmfww9I+XU+5agGEysgThirkJkH7C3ytzdaX
 OJpEKaeKrq187fJ05t8xNvxwObyEiYGjU903L/Y=
X-Google-Smtp-Source: AGHT+IE8wiBjnwfCL5bMqaeO9Xah0oMqPsbyQocrFtXmrx4tTb020gmqmGxGUJ8rI1dR/DmqzSWJ8A==
X-Received: by 2002:a19:ac47:0:b0:507:a766:ad27 with SMTP id
 r7-20020a19ac47000000b00507a766ad27mr9934289lfc.16.1701178686759; 
 Tue, 28 Nov 2023 05:38:06 -0800 (PST)
Received: from m1x-phil.lan (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 h1-20020a170906590100b00a0c68d3f486sm3861968ejq.94.2023.11.28.05.38.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Nov 2023 05:38:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 4/7] hw/isa/vt82c686: Route PIRQ inputs using via_isa_set_irq()
Date: Tue, 28 Nov 2023 14:37:37 +0100
Message-ID: <20231128133740.64525-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128133740.64525-1-philmd@linaro.org>
References: <20231128133740.64525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The chip has 4 pins (called PIRQA-D in VT82C686B and PINTA-D in
VT8231) that are meant to be connected to PCI IRQ lines and allow
routing PCI interrupts to the ISA PIC. Route these in
via_isa_set_irq() to make it possible to share them with internal
functions that can also be routed to the same ISA IRQs.

Fixes: 2fdadd02e675caca4aba4ae26317701fe2c4c901
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <8c4513d8b78fac40e6d4e65a0a4b3a7f2f278a4b.1701035944.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/vt82c686.c | 67 ++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 6fad8293e6..a3eb6769fc 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -593,6 +593,21 @@ static const TypeInfo via_isa_info = {
     },
 };
 
+static int via_isa_get_pci_irq(const ViaISAState *s, int pin)
+{
+    switch (pin) {
+    case 0:
+        return s->dev.config[0x55] >> 4;
+    case 1:
+        return s->dev.config[0x56] & 0xf;
+    case 2:
+        return s->dev.config[0x56] >> 4;
+    case 3:
+        return s->dev.config[0x57] >> 4;
+    }
+    return 0;
+}
+
 void via_isa_set_irq(PCIDevice *d, int pin, int level)
 {
     ViaISAState *s = VIA_ISA(pci_get_function_0(d));
@@ -601,6 +616,10 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     uint16_t mask = BIT(f);
 
     switch (f) {
+    case 0: /* PIRQ/PINT inputs */
+        irq = via_isa_get_pci_irq(s, pin);
+        f = 8 + pin; /* Use function 8-11 for PCI interrupt inputs */
+        break;
     case 2: /* USB ports 0-1 */
     case 3: /* USB ports 2-3 */
         max_irq = 14;
@@ -633,52 +652,17 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     qemu_set_irq(s->isa_irqs_in[irq], !!s->irq_state[irq]);
 }
 
+static void via_isa_pirq(void *opaque, int pin, int level)
+{
+    via_isa_set_irq(opaque, pin, level);
+}
+
 static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
 {
     ViaISAState *s = opaque;
     qemu_set_irq(s->cpu_intr, level);
 }
 
-static int via_isa_get_pci_irq(const ViaISAState *s, int irq_num)
-{
-    switch (irq_num) {
-    case 0:
-        return s->dev.config[0x55] >> 4;
-    case 1:
-        return s->dev.config[0x56] & 0xf;
-    case 2:
-        return s->dev.config[0x56] >> 4;
-    case 3:
-        return s->dev.config[0x57] >> 4;
-    }
-    return 0;
-}
-
-static void via_isa_set_pci_irq(void *opaque, int irq_num, int level)
-{
-    ViaISAState *s = opaque;
-    PCIBus *bus = pci_get_bus(&s->dev);
-    int i, pic_level, pic_irq = via_isa_get_pci_irq(s, irq_num);
-
-    /* IRQ 0: disabled, IRQ 2,8,13: reserved */
-    if (!pic_irq) {
-        return;
-    }
-    if (unlikely(pic_irq == 2 || pic_irq == 8 || pic_irq == 13)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid ISA IRQ routing");
-    }
-
-    /* The pic level is the logical OR of all the PCI irqs mapped to it. */
-    pic_level = 0;
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        if (pic_irq == via_isa_get_pci_irq(s, i)) {
-            pic_level |= pci_bus_get_irq_level(bus, i);
-        }
-    }
-    /* Now we change the pic irq level according to the via irq mappings. */
-    qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
-}
-
 static void via_isa_realize(PCIDevice *d, Error **errp)
 {
     ViaISAState *s = VIA_ISA(d);
@@ -689,6 +673,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     int i;
 
     qdev_init_gpio_out(dev, &s->cpu_intr, 1);
+    qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
     isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
                           errp);
@@ -702,8 +687,6 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(isa_bus, 0);
 
-    qdev_init_gpio_in_named(dev, via_isa_set_pci_irq, "pirq", PCI_NUM_PINS);
-
     /* RTC */
     qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
     if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), errp)) {
-- 
2.41.0


