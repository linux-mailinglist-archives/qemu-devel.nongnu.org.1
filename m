Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2111718B4F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:38:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SZd-00019i-2s; Wed, 31 May 2023 16:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SZK-0000u2-Rr
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:37:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SZJ-0003Qp-DN
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:37:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6dbe3c230so836425e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565436; x=1688157436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MtX4o0Ye6nhZ4tPfz5ErTCUaJJiVijCKFgjVroPJbY=;
 b=WHWopqF3gbrH3Y7TxEodIal/tG9Zffcq4zvwmQyh6Nyg7ozxfG8hs6Eo9u64wCRJUV
 bZXjnQFbbPbMAA9EHStCXlWksjNP7OSo4+jMfCv7VG443S5As9ri3JretN2bhD6vTeGB
 JyZQ49S7L8spp7VsgRXQdz0Qw6qZDKQTI1Pu0C7RLqUPivpvnMIae0tnkMMZ9kklj5B1
 fINrWBd7htY80RpSMkLdxFmW+uauouGypaqdEa2y8+v0iqts8pbtRNqjYB1506nj1kLh
 TpOKq3UYkZ9oLGv3TuBIhWetg1e/Evi5RjUgyzuWu7uZKWDE4upZJmzo5xpgPuJ/Guyh
 nEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565436; x=1688157436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MtX4o0Ye6nhZ4tPfz5ErTCUaJJiVijCKFgjVroPJbY=;
 b=Q9mIji7yq5tP+YdBQkia2I8D7kLj7UX//LL4KmI4d28tEBjWyx4lT5p4ANjWBjgsMC
 nuOZXWmk7vYaQBn/EIQ9Cd8Myevy4/SkJA06zJo3vtNanlaXDNWi2bfE1TgZmIKizyJ4
 cAOEHFBzpcNlPhDhrF8NHgwn1Wf80wl02P88juCs/yzqOGqxJ3Dl5EATs9qxTqo24wHY
 XYdSxXdmlq5sd6Mg+xOihg2vaOZQ1oJf88MDiNeTaeljNgWa8xvOxPLeFj7MORmPg0zc
 ejmg+dfhW0ya9DGX+2Y/etQ+AYw2iQfGp5LC9iFv0U7ualqINfdHko6oR58e0hEnb0fb
 pkIg==
X-Gm-Message-State: AC+VfDyXVanNjsTSdAImjtdA9TaQ4qbeuzcqOPxdH3yDyZnnzXz8Pb/Y
 7ZU1j0eORLzRmOMhyu6C37IYNYI6IQo08VRbGQI=
X-Google-Smtp-Source: ACHHUZ5IVVKky3zTO6Z2UkxysdptCBWY2FLw3nuDKbM0j/OlTEe+W+WVVrEFarrEBUR48V4t5SgdgQ==
X-Received: by 2002:a5d:62cd:0:b0:304:b967:956f with SMTP id
 o13-20020a5d62cd000000b00304b967956fmr247819wrv.8.1685565435846; 
 Wed, 31 May 2023 13:37:15 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a5d4bcc000000b003062b2c5255sm8009613wrt.40.2023.05.31.13.37.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:37:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/15] hw/timer/arm_timer: Fix misuse of SysBus IRQ in
 IcpPitState
Date: Wed, 31 May 2023 22:35:57 +0200
Message-Id: <20230531203559.29140-14-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
to avoid to forward it, IcpPitState misuses it as ARM timer
input IRQ. Fix that by using a simple IRQ forwarder handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 6f444e1789..874f9b63bc 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -352,6 +352,7 @@ struct IntegratorPitState {
     MemoryRegion iomem;
     ArmTimerState *timer[3];
     qemu_irq irq_in[3];
+    qemu_irq irq[3];
 };
 
 static uint64_t icp_pit_read(void *opaque, hwaddr offset,
@@ -391,6 +392,13 @@ static const MemoryRegionOps icp_pit_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void icp_pit_fwd_irq(void *opaque, int n, int level)
+{
+    IntegratorPitState *s = opaque;
+
+    qemu_set_irq(s->irq[n], level);
+}
+
 static void icp_pit_init(Object *obj)
 {
     static const uint32_t tmr_freq[] = {
@@ -402,9 +410,14 @@ static void icp_pit_init(Object *obj)
     IntegratorPitState *s = INTEGRATOR_PIT(obj);
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


