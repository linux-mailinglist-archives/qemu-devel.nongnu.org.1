Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444A747488
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNW-0005wp-Eq; Tue, 04 Jul 2023 10:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNG-0004Qm-93
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNE-0003Bh-F4
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31438512cafso2265952f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482282; x=1691074282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzuTpH2SlaRUugw0Q+vEokTxq/EmNFEx2lClbuErT5w=;
 b=L6bJC9PZWfO98ArDSxA87MfqXDAV1km1gyimivtbcW6qe7QO5mhX54b5JnyCDjP8X2
 35aADaIydszdNk3dOMps6sjKAjRZHfZ+cA1mdos0Xn4hS45Bwvp2UwgFvRlRQc6yjQ6q
 AVpE8JDFRdmJX0+zxrusSmJf7Xe79Kjy1bDSC3tP/W7FCS5z9CHNImrhAoVyPxQNlKDR
 SBlhozuiJC+dgOACsw66GOaM29ijB/SdFft8pgxui0wiprP83mPPKtH9mb91CrVCrywF
 mIp6jOBvxS+y+YQCq0h0AYuqpWZo9cE4JCY2OHluNct6+Nl8Idrit1zl0pjVUoHej81L
 HPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482282; x=1691074282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzuTpH2SlaRUugw0Q+vEokTxq/EmNFEx2lClbuErT5w=;
 b=Zjrl1hRZChh9fiUEPKTzC3VxQgNyISSlHxy18HjPKgGT8NVPTDc+gcyB54X3Tk2/Ad
 Dg/K70lh6IJ1sJ1Wx10QpU6fPpFa8hWO/Bqwx//G7agpKT0nWjMvHo1M0tdzf8loBgPK
 S5vhO/So/PbLsNlmPGCbXXmBCIi+oJ7opPq5W8SAnj87SbuBBbviw8x1LSt6CSOZsd8x
 CRKq1SIXrTaXrrXqn/3rDS1YFQxKYNbaWeSxwJytuVs/x9z0KCXeXJmMJz5jVvRhTINC
 QnbtAtbL68Vf6z85cNtlGRWPw7rkSK6QL8nlwcf+aKrPWJILQq8HTWHX6O4q9C+xQIin
 +xkw==
X-Gm-Message-State: ABy/qLaX4c//q8hG9GQRbNNU4tIW4spYlxEl7sjUcnJDIWLAwDIS7uZ9
 qy7vjUyBjfkTwbhAF32MwD1ykbuKgBPRVBDXb2M=
X-Google-Smtp-Source: APBJJlGqi7x81HppSDAuNVrerT/pOT7rb503Lj84trXBV44ljsntxtFoQ2dRAmzfaQYe239hfoVKoQ==
X-Received: by 2002:a05:6000:52:b0:313:ec93:c1c1 with SMTP id
 k18-20020a056000005200b00313ec93c1c1mr11251095wrx.32.1688482282139; 
 Tue, 04 Jul 2023 07:51:22 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adfcd92000000b003140f47224csm16103787wrj.15.2023.07.04.07.51.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/19] hw/timer/arm_timer: Iterate on timers using for()
 loop statement
Date: Tue,  4 Jul 2023 16:50:06 +0200
Message-Id: <20230704145012.49870-14-philmd@linaro.org>
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

The same pattern is used for each timer, 2 or 3 times. To avoid
too much code churn in the next commits, iterate on the number
of timers using a for() loop statement.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 0ad0e55df8..68cd50314f 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -310,10 +310,10 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 {
     SP804Timer *s = SP804_TIMER(dev);
 
-    s->timer[0] = arm_timer_new(s->freq[0]);
-    s->timer[1] = arm_timer_new(s->freq[1]);
-    s->timer[0]->irq = qemu_allocate_irq(sp804_set_irq, s, 0);
-    s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
+    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
+        s->timer[i] = arm_timer_new(s->freq[i]);
+        s->timer[i]->irq = qemu_allocate_irq(sp804_set_irq, s, i);
+    }
 }
 
 static Property sp804_properties[] = {
@@ -382,18 +382,19 @@ static const MemoryRegionOps icp_pit_ops = {
 
 static void icp_pit_init(Object *obj)
 {
+    static const uint32_t tmr_freq[] = {
+        /* Timer 0 runs at the system clock speed (40MHz).  */
+        40000000,
+        /* The other two timers run at 1MHz.  */
+        1000000, 1000000
+    };
     IntegratorPIT *s = INTEGRATOR_PIT(obj);
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


