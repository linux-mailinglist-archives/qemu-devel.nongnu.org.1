Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB3718B49
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SZL-0000ZB-Nw; Wed, 31 May 2023 16:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SZA-0000Oq-35
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:37:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SZ8-0003O4-3V
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:37:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30ae69ef78aso1147041f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565424; x=1688157424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEve7XoaYuxNRaMbirKWz6mHRspgIpo3ijJ/vB0fM1Q=;
 b=hh1ypo1VmsZGgNNC3I8aOgRxi94Eoo3p7PxerOIVHtDb+V1M6Kgn48OpidwXj+cGgH
 DJI1zBF6RKPUwyVRkR6cckupRnYTgEElFKDZCceO90eZgKorgesT5xTw3vWrN9yRyZOV
 TU2YCZuQ4f4Y0xrwXhRTKAacXI7UdWLlEP/ggdcbG3Qawoytfyh4Vxm8THaRxzCMgr5x
 d8FiWUQIwW1uEYVOqKNksbaOga7+Z8zGJYAcHpIqh2EbO6ULGvK7+81sIAr1gILzVXll
 jCa0CHrpP4XKD19Ns4xRSY1KP7KFonK6UadqOuL51qv03LHn0HcLvhNetfpTdenDE6l6
 WQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565424; x=1688157424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEve7XoaYuxNRaMbirKWz6mHRspgIpo3ijJ/vB0fM1Q=;
 b=FcujveGUOJKYJ7eEKgpidRcyEPcMuCWctJ8+LW+smBfB2P9HLO3iMpnt8ANbqzRP7u
 eFpMuCQVYLlwEQgWHBIUvNk4QqdipnrrVau0v8UMHwu5fWEy/fwe1LVTHSIwvrO3IKHf
 gRWE68Qbu9eqenIjCcd/IKtkxAkV7E66+rrFdBUYHK8bzCOtmCYskQmFg8eA5BuZNMWW
 tB04x8Zd8CXIDn9aLVagk9h0fGemAdSLATZzDTNVrKFrdyX/WQUjRo7bw0e2WVnJ3Gxy
 +yRjY9l5Eae+q65JVAbRK61F6mxyNMe8jVBAlnORmz//hqtB6VtxRR2EUkVRrFwafH1B
 IHkA==
X-Gm-Message-State: AC+VfDyBAzt7eiueo9uZoJ4lI9jUpjcmDUxpS70mYfhpvQhmZML0BzX7
 zzn3xdNuvjn/YSiizbKzlt2h2gpS+L48EP1lE3g=
X-Google-Smtp-Source: ACHHUZ4KcL8BEwMeZme+jPquBE8cN9ObS7+m0z3Pt4QexRKfuLdx8u9yeAV2l21S7lc4kJYFbI63rg==
X-Received: by 2002:a5d:4530:0:b0:307:869c:99ce with SMTP id
 j16-20020a5d4530000000b00307869c99cemr161898wra.21.1685565424407; 
 Wed, 31 May 2023 13:37:04 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 k5-20020adff5c5000000b0030af1d87342sm8014447wrp.6.2023.05.31.13.37.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:37:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/15] hw/timer/arm_timer: Iterate on timers using for() loop
 statement
Date: Wed, 31 May 2023 22:35:55 +0200
Message-Id: <20230531203559.29140-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
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

The same pattern is used for each timer, 2 or 3 times. To avoid
too much code churn in the next commits, iterate on the number
of timers using a for() loop statement.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 4d31f917f6..19789ad2c4 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -308,10 +308,10 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 {
     SP804State *s = SP804(dev);
 
-    s->timer[0] = arm_timer_new(s->freq[0]);
-    s->timer[1] = arm_timer_new(s->freq[1]);
-    s->timer[0]->irq = qemu_allocate_irq(sp804_set_irq, s, 0);
-    s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
+    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
+        s->timer[i] = arm_timer_new(s->freq[i]);
+        s->timer[i]->irq = qemu_allocate_irq(sp804_set_irq, s, i);
+    }
 }
 
 static void sp804_unrealize(DeviceState *dev)
@@ -390,18 +390,19 @@ static const MemoryRegionOps icp_pit_ops = {
 
 static void icp_pit_init(Object *obj)
 {
+    static const uint32_t tmr_freq[] = {
+        /* Timer 0 runs at the system clock speed (40MHz).  */
+        40000000,
+        /* The other two timers run at 1MHz.  */
+        1000000, 1000000
+    };
     IntegratorPitState *s = INTEGRATOR_PIT(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    /* Timer 0 runs at the system clock speed (40MHz).  */
-    s->timer[0] = arm_timer_new(40000000);
-    /* The other two timers run at 1MHz.  */
-    s->timer[1] = arm_timer_new(1000000);
-    s->timer[2] = arm_timer_new(1000000);
-
-    sysbus_init_irq(dev, &s->timer[0]->irq);
-    sysbus_init_irq(dev, &s->timer[1]->irq);
-    sysbus_init_irq(dev, &s->timer[2]->irq);
+    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
+        s->timer[i] = arm_timer_new(tmr_freq[i]);
+        sysbus_init_irq(dev, &s->timer[i]->irq);
+    }
 
     memory_region_init_io(&s->iomem, obj, &icp_pit_ops, s,
                           "icp_pit", 0x1000);
-- 
2.38.1


