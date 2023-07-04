Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACD74747A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNS-0005S4-RO; Tue, 04 Jul 2023 10:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhN0-0004Cr-C6
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMy-000384-7l
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3143493728dso2901039f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482267; x=1691074267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqlw3Rk5PWDcCN3qJsPC9utAFftgQ+lEqjZf5us/n9A=;
 b=LcFT8p/ceFvxLncqrnvOjw+1v2k09hT5bIvnzVXwaDm6+LGfHZgYV/iEdpnhVs78MI
 2QGs+nDBF6z4L4BiWFp7o8XVzXHjKq8PRqp9XzXPHMdIi7wdKUMXvl0wEP4RrPECTcHJ
 cnGCQAKdOie+zztHclk1xdCYO6CRZEJ90GR54lqhGfq8rKB+s3QR1mRZmb0flMNMRYEx
 2tCRUrVpAMjzBKyAdhJir/dZChc8V7MMEI4gvcyLTIN524FNq3ZVN2LDoJpKObotHbG1
 0plcVxXD/cAi+yqRujdflsdbdqmXl6uwTsfCYvCj4a57k0c+5YrD1Lzt+BHTGoybyPv+
 Ch7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482267; x=1691074267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqlw3Rk5PWDcCN3qJsPC9utAFftgQ+lEqjZf5us/n9A=;
 b=MhiZE4IZUDtUq6PWmnmNOlXQ4wiP8voqpI0KCbLemEKyOUOwdf60kIT3t0A7s3ZvRS
 0Lz4ISkXxAMMIyMbP+tBi8jcLnSxP1QfW4kFchvtHY/kI32FVxgNOJrtMsiZNv6uz+3c
 Pz+gtLJOByX6s3hnf1DA9hclb/KXNDoZzT//lVU4fpV8XzigddH9sWteDXs2WkOd4PHX
 SWcHtGDOGD1ZL3UDq0NKWw7NpRP1e+4euMo2UwwDv0L9Za6GG1n6A5EvrhJf5u/eLMcz
 GyIZN542Q9G8VYZR0ZNKIdCqsNDNFXkKENybDM8esFk9pz6RLxN/0eH2499hvBth3/TB
 33bg==
X-Gm-Message-State: ABy/qLbGN/J3G2tjL2SluzxfqQWXVLuVT44chocc5uqoHpWDhZrN7dk7
 hb5hZTh59Yry2j1y8w/oRLVlcdveqco+L3yxKBw=
X-Google-Smtp-Source: APBJJlHM4WYV+MrDFVjS3P9mSDp6ioNAVo/Sacx5gwNIpcLj33dXsp8chuhKsX0EzOWNaYC2Zthqbw==
X-Received: by 2002:a5d:66c2:0:b0:313:ef08:c83b with SMTP id
 k2-20020a5d66c2000000b00313ef08c83bmr12273604wrw.56.1688482266821; 
 Tue, 04 Jul 2023 07:51:06 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 j8-20020adfff88000000b0031412b685d2sm14988442wrr.32.2023.07.04.07.51.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/19] hw/timer/arm_timer: Rename arm_timer_init() ->
 arm_timer_new()
Date: Tue,  4 Jul 2023 16:50:03 +0200
Message-Id: <20230704145012.49870-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

QDev models often use foo_new() as the combination of
foo_init() + foo_realize(). Here arm_timer_init() is
a such combination, so rename it as arm_timer_new() to
emphasis the returned device is already realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index cbd82e8365..4ef34b0f60 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -179,7 +179,7 @@ static void arm_timer_reset_hold(ArmTimer *s)
     s->control = TIMER_CTRL_IE;
 }
 
-static ArmTimer *arm_timer_init(uint32_t freq)
+static ArmTimer *arm_timer_new(uint32_t freq)
 {
     ArmTimer *s;
 
@@ -310,8 +310,8 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 {
     SP804Timer *s = SP804_TIMER(dev);
 
-    s->timer[0] = arm_timer_init(s->freq0);
-    s->timer[1] = arm_timer_init(s->freq1);
+    s->timer[0] = arm_timer_new(s->freq0);
+    s->timer[1] = arm_timer_new(s->freq1);
     s->timer[0]->irq = qemu_allocate_irq(sp804_set_irq, s, 0);
     s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
 }
@@ -386,10 +386,10 @@ static void icp_pit_init(Object *obj)
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
     /* Timer 0 runs at the system clock speed (40MHz).  */
-    s->timer[0] = arm_timer_init(40000000);
+    s->timer[0] = arm_timer_new(40000000);
     /* The other two timers run at 1MHz.  */
-    s->timer[1] = arm_timer_init(1000000);
-    s->timer[2] = arm_timer_init(1000000);
+    s->timer[1] = arm_timer_new(1000000);
+    s->timer[2] = arm_timer_new(1000000);
 
     sysbus_init_irq(dev, &s->timer[0]->irq);
     sysbus_init_irq(dev, &s->timer[1]->irq);
-- 
2.38.1


