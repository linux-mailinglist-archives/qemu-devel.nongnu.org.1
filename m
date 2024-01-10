Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D682A191
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNee2-0006uv-Vm; Wed, 10 Jan 2024 14:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNee0-0006q8-4z
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:53:44 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNedy-0001oE-I6
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:53:43 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33761e291c1so2714746f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916421; x=1705521221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5YYwF8QpDX8Jtsvrc0+qop9CxJbiTqbmmnqrqDqyeI=;
 b=xCoOXTYSU3tG6dOoEPKMBQK0p7U5v6jSUytnCJUQFkM/a7cdrJfXkrf1/g/wxiFOjS
 3KcJh6JM/W+uSTbupMu/mK3BG7xP4+/v1ArigX67uEHNPjybHsVqrW648vRGTCmsO8jc
 6gnUgAUdrmBbqorxdov8hyBtEK1WLALQPs2zgUfTcPJlUn9XLnqheow3eg26q3tbiDBt
 qA/1Qt4qRTFJi7Bnq/6OgjWVvXQ2un0nnVpITh7gfGpMUOZLUHlTtGy1+DtMwIFC0lHx
 NmEwaju5ZJf139zZ27o7a4/JNDgOzHCJZFSY7N7UiL/w0UDduGLOY/IHmN9iU3zSnbJc
 5QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916421; x=1705521221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5YYwF8QpDX8Jtsvrc0+qop9CxJbiTqbmmnqrqDqyeI=;
 b=W9L3VgZQZkgztOaoRQQ8WC/fs3JU+rAJu0Fyo7Dd05LsfoN00S/3riaQz6a1K50Arw
 ++GW0xfZysjL1Xsp6WqPOkZ1XmCNWCKOsTDTHjEIXl+st18oBABaUyECV3spyRufwSPD
 OeslzOQSLP4omeytMwiWkOXQpScTnCumMLLgaq+PmKIAma3Wvn30JuDMyKASWYln8zka
 MIbZEN7sEJva2ZMAvvr8L/6a/W3m1iI3T++0he6r7RSw3V16uBuAY7kmMn0VbvXuly5F
 c6bRRxvxICpWGBcYphwiEFxRkc1yth3UtfH4YWJhT9SmP91PzbDqTgv+z/cNzmjxJZd7
 k3sw==
X-Gm-Message-State: AOJu0YxXmCbdTl/qNhwEeCv1n6NhNLjGcNcjy2YWAPbmZ98eF5pzEIiK
 /p01tIcSQQFXKSNcJGYK+t/utWDpsLIhHPTmgTxg/0hrdrU=
X-Google-Smtp-Source: AGHT+IGxC/nnlqKU3ONI5WNDIBxZz59NGE+y4irL+gMYhAm8f5/ZbCysM0p/xD4AuA5tSqpwOHjIUA==
X-Received: by 2002:a05:600c:3c9c:b0:40d:5d0a:cf4a with SMTP id
 bg28-20020a05600c3c9c00b0040d5d0acf4amr370282wmb.34.1704916420849; 
 Wed, 10 Jan 2024 11:53:40 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 jh3-20020a05600ca08300b0040e50d82af5sm3155192wmb.32.2024.01.10.11.53.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:53:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/14] hw/arm/armv7m: Introduce cpudev variable in
 armv7m_realize()
Date: Wed, 10 Jan 2024 20:53:15 +0100
Message-ID: <20240110195329.3995-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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


