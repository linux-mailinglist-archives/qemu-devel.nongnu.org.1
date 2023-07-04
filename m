Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95C747487
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNP-0005BM-6w; Tue, 04 Jul 2023 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNC-0004JX-4T
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:22 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNA-0003AT-FV
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:21 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so8636010e87.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482277; x=1691074277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxfHnKj3l6GtT3pvrUKnD3RECUZu48JxXvoYVsgVb2Y=;
 b=FavhkjPSVY75NNK/FISZaV/EhBGjh/nkCkYKrc1hJIO9a8Odm51eDXGcCqAhLlKKBG
 f9JiHbfMlTsgF0oDI8yGSHr7iLUed7AZ//pqNSZ3flFPMBFzyY15QA0HVI0OpakPfArx
 EWC/5J9cMViX8jrS3R1GY+HzQrL+cXOKU5WieoqAHdXCEI3ypWTtklwK2xv/w1ZA4tBI
 m2hPXpEfwaEOZ4vsqFfXRs1iWX1IbZYst8cY5IdVg4O5gXZZ31EsvHhzqqzSBCdC3rGQ
 LmL45e292GVV8YYhpvkp1uOvv9pvtVsOtU09Ah7F80VbXpGYXTZws4/m/jMv84acI8eU
 565w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482277; x=1691074277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxfHnKj3l6GtT3pvrUKnD3RECUZu48JxXvoYVsgVb2Y=;
 b=CELeiMUf6ZXg6oDOfKSs285z8TFu1eCl9iokJt3Aenlf+0oDVvLwsTblBG6Qw7q8HF
 xJ/+Nt43ECF9T6sJVHAWc53+k1mxXv7LSg7PV4mhWetmQVvDB9M5PfhUAb3pDk7QrtrD
 ywBtb3sI1B7PtAou0iu2qq5d2u6niQAgiF7jnP/S/0DXN8fxS52H7qRdhCkKC4SCLQ7b
 /kCl1I+Fiz7GD7AcGHkB6UiNxmlOFjl1VTLpapJ3NIx9zeaO8Miz9UlyrcQw9ET2Gb5q
 88J2d+0b2qh7IU9gHiwzmQmOn2wLS/IcpuyBCEsOLQCI0zZ+LW85oTYGI7sdfeTW/x52
 +oxw==
X-Gm-Message-State: ABy/qLbibKc2Ri+ylnnRLhd37G6EpmSdrpSFyJi7H1ssia8bt6L3amqI
 Fq4YwNDz3oEewne4GUxtK4Pi3B3V/3RFT4N5sYs=
X-Google-Smtp-Source: APBJJlEc7deMsNCJpDn3BlS3QGv2oddRogSBb8TBNW7q+UAFC3KPQppJsjUKsyKBuuCCWpTFBnAKhA==
X-Received: by 2002:a19:5f5a:0:b0:4f9:607a:6504 with SMTP id
 a26-20020a195f5a000000b004f9607a6504mr9739516lfj.29.1688482277092; 
 Tue, 04 Jul 2023 07:51:17 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a05600c225400b003fbb06af219sm18551427wmm.32.2023.07.04.07.51.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/19] hw/timer/arm_timer: Use array of frequency in
 SP804Timer
Date: Tue,  4 Jul 2023 16:50:05 +0200
Message-Id: <20230704145012.49870-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SP804Timer use arrays for timers and IRQ levels. Be consistent
and use another one for the frequencies. This will allow to
simplify using for() loop statement in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 2b5fb75577..0ad0e55df8 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -206,7 +206,7 @@ struct SP804Timer {
 
     MemoryRegion iomem;
     ArmTimer *timer[2];
-    uint32_t freq0, freq1;
+    uint32_t freq[2];
     int level[2];
     qemu_irq irq;
 };
@@ -310,15 +310,15 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 {
     SP804Timer *s = SP804_TIMER(dev);
 
-    s->timer[0] = arm_timer_new(s->freq0);
-    s->timer[1] = arm_timer_new(s->freq1);
+    s->timer[0] = arm_timer_new(s->freq[0]);
+    s->timer[1] = arm_timer_new(s->freq[1]);
     s->timer[0]->irq = qemu_allocate_irq(sp804_set_irq, s, 0);
     s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
 }
 
 static Property sp804_properties[] = {
-    DEFINE_PROP_UINT32("freq0", SP804Timer, freq0, 1000000),
-    DEFINE_PROP_UINT32("freq1", SP804Timer, freq1, 1000000),
+    DEFINE_PROP_UINT32("freq0", SP804Timer, freq[0], 1000000),
+    DEFINE_PROP_UINT32("freq1", SP804Timer, freq[1], 1000000),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.38.1


