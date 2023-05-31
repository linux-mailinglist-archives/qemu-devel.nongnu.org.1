Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020C6718B53
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SZX-0000zW-Rx; Wed, 31 May 2023 16:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SZH-0000ny-E6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:37:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SZF-0003Oj-OQ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:37:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6dfc4dffaso1105895e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565430; x=1688157430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiC6CuBtjw1sGes9CKcEGdJAP6aAhbbs6USQHp8o0zw=;
 b=sX2nLNh8/HMNxHC21LnZnEMCZ/Rmlhd8lW0RsR29ykrQBgiCyzgBdUPtrVvhJs732B
 tVlNUl4W4V2Smc0BqEhh5fJiRFci57Q/FFJeYzh0b3FduzqKNT+Ep/lj5NkFW2EUMO3z
 Hqe8126wP2Of99cBHYTB+Qaa6QNoku9VsdZceuPGe0otpBHRSukx9kP7asog4M5GK1m+
 sede8DgssRwf6O+/suYKTBP2KEeg926wl7n/so8aqNWbJZwDcks6t2WG4/yFeyvCrX+k
 jCPykDpXiSoM6LkYIosTccMu2Vv1QjNXYFNAN6UhngoPwgYjHQwsx1Fv/gpY2/ssa+Ru
 RmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565430; x=1688157430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiC6CuBtjw1sGes9CKcEGdJAP6aAhbbs6USQHp8o0zw=;
 b=Nt1lJ4bLvkGB9H7fCFaQDPbzO43+9veKuiZHg+ozSR5RyZimvZKw7/vE78wPxn+Bqx
 0l12O6cZ6uYTZv2xRagfb/8YUOt3YOanSynyvgNjGA1BBA/tQknLv4qE4ghoRUSupF5L
 bLHy7FDoSOLe+S4VD7CbAvRbA3b/y9c0/vIYJUW26MQ1weYZuA+bIAfsuEjV4XPCy7Xa
 YFmZ0mieVpMle0omR4Qgi/5ICwMKy7snybtxg5wSjIfmzna+dPJmB3PPXdN3uQRkv2Kr
 f4WRr6q2uJ7qdfEVf6sUUxeMhJYtg7c0liETalncson68Qnajns2ZmeBO3rhFd3qj+eL
 YayQ==
X-Gm-Message-State: AC+VfDxEs1Tji/JMKUN5oLlq32zQv1xP6PgKOVEdulnfESGcK++G/7Nj
 mPE7/YbET3MGX49U9G7Zk1f/M+XAt7koRWnCO6Q=
X-Google-Smtp-Source: ACHHUZ5r5Ggb6AMqF2TJ3xs3yRxUtShUj8fYRGPEqsgnSGTqZl963vElDyasgnJQWCDEzH1T+nVq3A==
X-Received: by 2002:a05:600c:2210:b0:3f7:5e3:c1f2 with SMTP id
 z16-20020a05600c221000b003f705e3c1f2mr321295wml.8.1685565430398; 
 Wed, 31 May 2023 13:37:10 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1c4c12000000b003f423f5b659sm21831888wmf.10.2023.05.31.13.37.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:37:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/15] hw/timer/arm_timer: Pass timer output IRQ as parameter
 to arm_timer_new
Date: Wed, 31 May 2023 22:35:56 +0200
Message-Id: <20230531203559.29140-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Both SP804State/IcpPitState peek at ArmTimerState internal state.
This is fine so far but we want to convert ArmTimerState to QOM
where peeking at QOM state internal should be avoided.
ArmTimerState's IRQ is just a pointer, so we can pass/set it via
argument, avoiding accessing ArmTimerState internal state except
from the arm_timer_*() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 19789ad2c4..6f444e1789 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -177,7 +177,7 @@ static void arm_timer_reset(ArmTimerState *s)
     s->control = TIMER_CTRL_IE;
 }
 
-static ArmTimerState *arm_timer_new(uint32_t freq)
+static ArmTimerState *arm_timer_new(uint32_t freq, qemu_irq irq_out)
 {
     ArmTimerState *s;
 
@@ -185,6 +185,7 @@ static ArmTimerState *arm_timer_new(uint32_t freq)
     s->freq = freq;
     arm_timer_reset(s);
 
+    s->irq = irq_out;
     s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_LEGACY);
     vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, s);
     return s;
@@ -207,6 +208,7 @@ struct SP804State {
     uint32_t freq[2];
     int level[2];
     qemu_irq irq;
+    qemu_irq irq_in[2];
 };
 
 static const uint8_t sp804_ids[] = {
@@ -309,8 +311,8 @@ static void sp804_realize(DeviceState *dev, Error **errp)
     SP804State *s = SP804(dev);
 
     for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
-        s->timer[i] = arm_timer_new(s->freq[i]);
-        s->timer[i]->irq = qemu_allocate_irq(sp804_set_irq, s, i);
+        s->irq_in[i] = qemu_allocate_irq(sp804_set_irq, s, i);
+        s->timer[i] = arm_timer_new(s->freq[i], s->irq_in[i]);
     }
 }
 
@@ -319,7 +321,7 @@ static void sp804_unrealize(DeviceState *dev)
     SP804State *s = SP804(dev);
 
     for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
-        qemu_free_irq(s->timer[i]->irq);
+        qemu_free_irq(s->irq_in[i]);
     }
 }
 
@@ -349,6 +351,7 @@ struct IntegratorPitState {
 
     MemoryRegion iomem;
     ArmTimerState *timer[3];
+    qemu_irq irq_in[3];
 };
 
 static uint64_t icp_pit_read(void *opaque, hwaddr offset,
@@ -400,8 +403,8 @@ static void icp_pit_init(Object *obj)
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
     for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
-        s->timer[i] = arm_timer_new(tmr_freq[i]);
-        sysbus_init_irq(dev, &s->timer[i]->irq);
+        s->timer[i] = arm_timer_new(tmr_freq[i], s->irq_in[i]);
+        sysbus_init_irq(dev, &s->irq_in[i]);
     }
 
     memory_region_init_io(&s->iomem, obj, &icp_pit_ops, s,
-- 
2.38.1


