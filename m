Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D5747489
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:53:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNX-000675-Cc; Tue, 04 Jul 2023 10:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNQ-0005SN-Mj
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNO-0003Fk-3v
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:36 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31297125334so4911112f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482292; x=1691074292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCPWCNW3sULrKOxLX0GNQbm2gqBGrznr8P5ALvlpdo0=;
 b=gx+eoLAzdCaf2mFU71JLWi4Vszd+vOyUX62jA1rtmJsj1QOhsMhmegoflCkqq+ARel
 049ZkE412nzx5Erpi3pt+A7nnS7ILZxJnrHQ2qJcSVQy1LU9Ex7qWhJM29oDM4FiOiWy
 1+HVMbV9rptsCAm/oZ217opeW5Owt431wVOEy0NhLNvOoKt66Njg3LX9Ig2Dd4mEagr3
 01BBpbzyLFSfnJj5Ohn79QcuMdZXGCHfHMrwNtNwRgsANR/GVpD7wzgyr1KuIXp2bYkE
 4YDANPQxjPCEat75RUdNf8ZDxBzN0Ud8ZK4zeOezTYtU+lGVcuGT7lnnvBqNnGoNq6T4
 UQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482292; x=1691074292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCPWCNW3sULrKOxLX0GNQbm2gqBGrznr8P5ALvlpdo0=;
 b=d1Y51ubCrekB6MkirVTHjks0Wpk5mD+CCshdFU95ULbbQfkIwlTofY2jf64+la4S7P
 9bgaciDAVL8Mrqu8RYXVR6+4bP8lEpUm902mP3wxTynunu4V9w9OrPsctosbPLdtWhDC
 aj38q4eUd57y6M8Lra54jx1CKaEA5K85L6EQUstQqhVtVVTvlxjT+UkP2rsNt71FlhVD
 nRmiO8LdX17wsjDkwzH2EHWDOlVBVZy9Fj0U4mblvKz1L/9ZWpo9JLRIopnOvg6wooV7
 93O8gr/4sQIYdcnONrRVow41VWUPanlEsA3u5K88vvg0lMSG3a2+GIKDEoCDXxg+nzOP
 dXLA==
X-Gm-Message-State: AC+VfDxPChhmvj4S1CzFSuoQoxnfZpMgVgeYldiQevOC7yPRjTumozfv
 eVVNw5e1neBXBcMFgqH2JIxH/bc+KWTovtRToWg=
X-Google-Smtp-Source: ACHHUZ63BVm5gzWPmTSZ/kb8vAlksDFf9Ga9iBNTLfKOgdeNFOs+cMV+VPM/0ctcMULQAQe7JicVvw==
X-Received: by 2002:adf:e3c9:0:b0:313:ef28:d3d6 with SMTP id
 k9-20020adfe3c9000000b00313ef28d3d6mr16845550wrm.6.1688482292605; 
 Tue, 04 Jul 2023 07:51:32 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 g5-20020adff405000000b003143cb109d5sm2883604wro.14.2023.07.04.07.51.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/19] hw/timer/arm_timer: Fix misuse of SysBus IRQ in
 IntegratorPIT
Date: Tue,  4 Jul 2023 16:50:08 +0200
Message-Id: <20230704145012.49870-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

SysBus IRQ are *output* IRQs. As some sort of simplification
to avoid to forward it, IntegratorPIT misuses it as ARM timer
input IRQ. Fix that by using a simple IRQ forwarder handler.

Note: sysbus_pass_irq() forwards GPIOs and IRQs from a container
to an inner device but only work with an entire set of IRQs, so
we can not use it here where we forward a single IRQ from each
timer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index f6bec28884..aae7f3cf9d 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -344,6 +344,7 @@ struct IntegratorPIT {
     MemoryRegion iomem;
     ArmTimer *timer[3];
     qemu_irq irq_in[3];
+    qemu_irq irq[3];
 };
 
 static uint64_t icp_pit_read(void *opaque, hwaddr offset,
@@ -383,6 +384,13 @@ static const MemoryRegionOps icp_pit_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void icp_pit_fwd_irq(void *opaque, int n, int level)
+{
+    IntegratorPIT *s = opaque;
+
+    qemu_set_irq(s->irq[n], level);
+}
+
 static void icp_pit_init(Object *obj)
 {
     static const uint32_t tmr_freq[] = {
@@ -394,9 +402,14 @@ static void icp_pit_init(Object *obj)
     IntegratorPIT *s = INTEGRATOR_PIT(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
+    qdev_init_gpio_in_named(DEVICE(obj), icp_pit_fwd_irq,
+                            "timer-in", ARRAY_SIZE(s->timer));
+
     for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
         s->timer[i] = arm_timer_new(tmr_freq[i], s->irq_in[i]);
-        sysbus_init_irq(dev, &s->irq_in[i]);
+        sysbus_init_irq(dev, &s->irq[i]);
+        sysbus_connect_irq(dev, i,
+                           qdev_get_gpio_in_named(DEVICE(obj), "timer-in", i));
     }
 
     memory_region_init_io(&s->iomem, obj, &icp_pit_ops, s,
-- 
2.38.1


