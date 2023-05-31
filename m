Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A239C718B4B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SZL-0000Rh-NE; Wed, 31 May 2023 16:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SZ4-0000AV-5j
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:37:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SZ2-0003NI-Jf
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:37:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f601c57d8dso1388085e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565419; x=1688157419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEwvjd8H0pBzSI4zIAJ+UnyR+kTgNch6Orzmem2MX0A=;
 b=YWIISxO9hQd5X9nGqB5u96JUNy3fPpsO7x9uZgjm3fkI+GMCo4/lJq+GTqQXwV6QJ7
 c3Fl8UvYgu5xmQUz0n4rlDV9tJmqTwHvQ2T+REUhpM7mQKFsgK6uxBMHgaE4YCxbG1vu
 3uJrv/nLewPkNiPYQKJ77fl8xR6L4bhTVj4mMzZXYToiijdIXzOkKikCrNM3AGMgDXqk
 R0luTWqA4cslZrtbGpw2Pi/gzrRxmxwxEk4nqEFglmUI4IYJ3CvSQFSpgClV08/pCraR
 XIDqaE7jlYa39fWjJ4O5Dg7PjDCeCgWHKMLX4J43PM88I3RPBdStXneXc8IjySRtQraL
 OKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565419; x=1688157419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEwvjd8H0pBzSI4zIAJ+UnyR+kTgNch6Orzmem2MX0A=;
 b=EkrPeAaoiIy1shSnFLON4TezzZzCwAYHgr02ug6V+UDIKBBSDJ4righTkfDIQVlToy
 2dHjzGmVRuCbcnEuJPDCSYpevmTwRmbmpxCap7J+C0qBvozOmARPklgZqDB645ubBz9J
 7nX+zQEorlJo7nhEZNpzEiwmNYeoONSHD9yaEv7B8CCuP1z+U1ut3pjUATd/aEDSSGYL
 x4O9B29OmvRnFoFJU5BwWUVqJBL07SBORdGtsRGd3FRlJs+LmNdxIaBjtQYbtyS2RDbm
 SwoI6Xpawm/aS6uG33+TAMazNfNp+a6o/if75fHXbe9NwHnkUUoLQ2D9bpwHTnN1ux+j
 kwRQ==
X-Gm-Message-State: AC+VfDyFkf6y1gw/MB6tIyoXTnM5uO98o30hrroBKR0hfmo2Dbjg4uC1
 nT4CLVYNm/5BvtHmFwJcWJGf4pyIo7EsFfY6hRU=
X-Google-Smtp-Source: ACHHUZ6sQYqy9FAy0lkMATn/+e1xJwnAIFyA5FkPNnLjs4S62WmbPa3F5zk0Jr3N6cSIJMQAJXcRgA==
X-Received: by 2002:a05:600c:3d1b:b0:3f5:867:1aba with SMTP id
 bh27-20020a05600c3d1b00b003f508671abamr301535wmb.15.1685565418864; 
 Wed, 31 May 2023 13:36:58 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a05600c0b4f00b003f611b2aedesm22011624wmr.38.2023.05.31.13.36.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:36:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/15] hw/timer/arm_timer: Use array of frequency in SP804State
Date: Wed, 31 May 2023 22:35:54 +0200
Message-Id: <20230531203559.29140-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

SP804State use arrays for timers and IRQ levels. Be consistent
and use another one for the frequencies. This will allow to
simplify using for() loop statement in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 510ec74a51..4d31f917f6 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -204,7 +204,7 @@ struct SP804State {
 
     MemoryRegion iomem;
     ArmTimerState *timer[2];
-    uint32_t freq0, freq1;
+    uint32_t freq[2];
     int level[2];
     qemu_irq irq;
 };
@@ -308,8 +308,8 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 {
     SP804State *s = SP804(dev);
 
-    s->timer[0] = arm_timer_new(s->freq0);
-    s->timer[1] = arm_timer_new(s->freq1);
+    s->timer[0] = arm_timer_new(s->freq[0]);
+    s->timer[1] = arm_timer_new(s->freq[1]);
     s->timer[0]->irq = qemu_allocate_irq(sp804_set_irq, s, 0);
     s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
 }
@@ -324,8 +324,8 @@ static void sp804_unrealize(DeviceState *dev)
 }
 
 static Property sp804_properties[] = {
-    DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
-    DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
+    DEFINE_PROP_UINT32("freq0", SP804State, freq[0], 1000000),
+    DEFINE_PROP_UINT32("freq1", SP804State, freq[1], 1000000),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.38.1


