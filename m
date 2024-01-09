Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2314D828C20
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:11:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGYn-0002bi-AH; Tue, 09 Jan 2024 13:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGXu-0002QG-Rl
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:09:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGXs-0003xn-J3
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:09:50 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5aefcc2fso36709905e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823786; x=1705428586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5YYwF8QpDX8Jtsvrc0+qop9CxJbiTqbmmnqrqDqyeI=;
 b=zc3HwQdSshDJHEOsY3yp17CdZ7Zy1l4Lp0tYILKRYz+8r8P2U6IKXnJ0dd5Nilyu0P
 mWRUBBzKBYqIW/eI2qHY0Gp1aGPTG9JkjhDUNWqGnNW923b6p060/FiyQ1BqEbsmMC7K
 Tf3+PNir5FfC0htdflhhIQEbyPFAdvYOO3S4N1mscCeS6t30u/7MV/vlNbaj0Iz2P75J
 aCsUSixULzSQNF9U++hApbnr5kJCelTS88baSW4ctuS4RSHeMWpk9NfRBUYo20gbYsFf
 xjfxJr4peYrscDeztycZWveDm5j5AzEvqnuHA6hd1mbzDHXaEPpQSZVksAAvfhqhcGuh
 Ba5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823786; x=1705428586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5YYwF8QpDX8Jtsvrc0+qop9CxJbiTqbmmnqrqDqyeI=;
 b=tRqIITAItzrw4Or+S1xP+jFXvg/4N5q8VqeTGCArwi2NFCUTIJTc+9kDEohtsfdFXw
 eRC9nCkDtodHziutU+BrzitR99yXTXfC1Lm6eM231lQJ+XoDAg69U2zv8wyWgEQj3gm7
 2G8a6DjzOIdGbbtB4LglEf7qV3wzsaMqVLFdwsouNPs++n7UDXZmn4RY/LykcSWCLseI
 38GFWCRKgPHDWYeVG1u7eHF67APQ7d204R1UrgbUSSCq3KXFTXZN0ImKFQOeJFtv5EDW
 +VRERsk+MCeiPzya0eJ6x53JNEoXCrWelZm2E1vbzEj4qyTW5TsRbYWtwgpI0adPvUqJ
 Zouw==
X-Gm-Message-State: AOJu0YwDkzQf3W9k93rjwwOW3cGR7MzZarn6uh7O+DdadmunmM/MTBK2
 Vw3BgbLXmHozgDvDYsiTh+fFATsGFWGI4TwN6no7PMBVEN6zwQ==
X-Google-Smtp-Source: AGHT+IFcMy2+PSIqkJXkJOk7zBkIxvTDngWDXIqHtM26yr/0CW5VAufouu0pTj6L7lD/cN8qwlpJHQ==
X-Received: by 2002:a05:600c:5405:b0:40d:87b7:24c7 with SMTP id
 he5-20020a05600c540500b0040d87b724c7mr2804585wmb.125.1704823786329; 
 Tue, 09 Jan 2024 10:09:46 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 x6-20020a5d54c6000000b0033674734a58sm3001364wrv.79.2024.01.09.10.09.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:09:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/14] hw/arm/armv7m: Introduce cpudev variable in
 armv7m_realize()
Date: Tue,  9 Jan 2024 19:09:17 +0100
Message-ID: <20240109180930.90793-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
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

We are going to cast s->cpu as DeviceState multiple times.
Add a local 'cpudev' variable to simplify code review, having
a single DEVICE(s->cpu) conversion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 50c6c6b1f5..d239468558 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -277,6 +277,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 {
     ARMv7MState *s = ARMV7M(dev);
     SysBusDevice *sbd;
+    DeviceState *cpudev;
     Error *err = NULL;
     int i;
 
@@ -299,6 +300,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+    cpudev = DEVICE(s->cpu);
 
     object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
@@ -356,7 +358,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     s->cpu->env.nvic = &s->nvic;
     s->nvic.cpu = s->cpu;
 
-    if (!qdev_realize(DEVICE(s->cpu), NULL, errp)) {
+    if (!qdev_realize(cpudev, NULL, errp)) {
         return;
     }
 
@@ -426,8 +428,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     /* Wire the NVIC up to the CPU */
     sbd = SYS_BUS_DEVICE(&s->nvic);
-    sysbus_connect_irq(sbd, 0,
-                       qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
+    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
 
     memory_region_add_subregion(&s->container, 0xe000e000,
                                 sysbus_mmio_get_region(sbd, 0));
-- 
2.41.0


