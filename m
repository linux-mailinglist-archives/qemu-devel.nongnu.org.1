Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ADF718B4A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SZ3-0008SA-2J; Wed, 31 May 2023 16:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYu-0008Cy-78
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYr-0003LQ-FW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6a6b9c079so881945e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565407; x=1688157407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqmxkSyXDcjXzwtphH1bFAgAKMWrKTeKoHsfOWjfasw=;
 b=fpTM2ur8d/1G9NkfRgb3I606Jl5/sSIsRAUzCAFXspxNnWuxpdNYTgjl2RhyO8Gwuv
 QSSeXsorCiy9TQtZZ1fj1BIIFT95XvUZlg0pEnxGdvNm8mKdO8DIqQC+BcM1HodT45dw
 /cEam/MijEDaBdK9k5MLeFB3Ln3DUUIsD22xI05ob8GsKt30/53v7G2IqPtoD8Tmi4eI
 kvLyOHXDph0AwitdCnjhaP5Plsw3yNQhQM+jPrH7AkduaETdNjpEFqaCV7VAku/ii9kl
 IbOBevb5yl4sp/ntWilSFV3ibriKdJZRbRP5DXy3vbAm1xNhzT5MGkSPVVBzDbXM1pmS
 OZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565407; x=1688157407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqmxkSyXDcjXzwtphH1bFAgAKMWrKTeKoHsfOWjfasw=;
 b=fgCPxgCV52CG47aTEzBtTxBYSN+W+eTIIMth0D47pMClGbAcv3BKDJ+1oZMzxLXlPU
 dYacB7XrKaTATVu9rtsB8PUiPDsM5s/a5BUErcCtVmV6dhD0OnNzPuQcvHLT6iwoTKXb
 +3++Or+FtZsIc/403bmOlit3PoQwcCAVOC8r12Yd/1MuAphttA0f0eK2r3qedh7YTc0R
 bRdFr1Q8sGFP1b47YU43Bi6wcO9B6y5zkrXhqIIdfpFEX4q9N40alUuKK5LIfX4GIM3Q
 RxaBlUsOymXDjbrdSZJaZNzJ34vxrVfqCHKfu2Z9zAI7a5vpTu6guss5fAlZlrD0rltY
 ywuQ==
X-Gm-Message-State: AC+VfDwCYrg2bemu6u3UIQiNufbEV+yg49cs2nz532k8kj+MDVLRV5k5
 HGsiAz2BvXyX9nbVh1/2diWew4n29AOcULZWiTE=
X-Google-Smtp-Source: ACHHUZ7jfKG/4zD3LGDwJ7cNnm34FZkrPsrBMmEFFM213tG6PMlxQ5mFCmzcGUm/Q4u8pr8mFXi9aA==
X-Received: by 2002:a1c:cc03:0:b0:3f6:d40:c89 with SMTP id
 h3-20020a1ccc03000000b003f60d400c89mr306190wmb.12.1685565407595; 
 Wed, 31 May 2023 13:36:47 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a05600c21d500b003f6041f5a6csm21998812wmj.12.2023.05.31.13.36.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:36:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/15] hw/timer/arm_timer: Rename arm_timer_init() ->
 arm_timer_new()
Date: Wed, 31 May 2023 22:35:52 +0200
Message-Id: <20230531203559.29140-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
---
 hw/timer/arm_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 54318d0a57..1f4d66291a 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -177,7 +177,7 @@ static void arm_timer_reset(ArmTimerState *s)
     s->control = TIMER_CTRL_IE;
 }
 
-static ArmTimerState *arm_timer_init(uint32_t freq)
+static ArmTimerState *arm_timer_new(uint32_t freq)
 {
     ArmTimerState *s;
 
@@ -308,8 +308,8 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 {
     SP804State *s = SP804(dev);
 
-    s->timer[0] = arm_timer_init(s->freq0);
-    s->timer[1] = arm_timer_init(s->freq1);
+    s->timer[0] = arm_timer_new(s->freq0);
+    s->timer[1] = arm_timer_new(s->freq1);
     s->timer[0]->irq = qemu_allocate_irq(sp804_set_irq, s, 0);
     s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
 }
@@ -394,10 +394,10 @@ static void icp_pit_init(Object *obj)
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


