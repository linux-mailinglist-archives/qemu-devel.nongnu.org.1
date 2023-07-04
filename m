Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E45747481
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNZ-0006U9-SA; Tue, 04 Jul 2023 10:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNW-00063g-Cx
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNT-0003HS-JE
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbd33a573cso29731965e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482298; x=1691074298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgqnt2VX3X1H7hrQYVz6F1zcu6hxE23p/SOYvZ7/smg=;
 b=IbEpMfAQNaks5OtQCxWJ65MC1we/3JI3XmlZcyjC97imIfLZcYPtR3XCH02u3u6XpC
 BkfjiOmqKTSMe3SFdMXp1M/0cZWXoGCd91YS6jvmhiQP3E5qsoMF3TZt6Xba3PM6qXyu
 iIPRM6rRqovJk4TUo1ruuE4qb9KdSB+Hk/cF/azlAVnxDKSGsmcVTnOvEephnCGcMNOj
 PYNTiTaK6StHtKMIOc7eV9YjtTjeZVuEH/fiwpJyEd5GvceDbrlUu1TslyTxOP/FQ0kC
 HEVd+pDa8quxpbEDgwGDsiZ7Ql+Jl3TDeEB3Y96BAH/57wFhT/4VuSu2sZkBUURdWTMz
 a1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482298; x=1691074298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgqnt2VX3X1H7hrQYVz6F1zcu6hxE23p/SOYvZ7/smg=;
 b=jr2qljB/6xhRxYP7qqt+818NVwCoqHcy8Ox88N02SKTwQLRxuo1pqmT4lVeHDJwfVx
 Ret7uJTmdj0PFAKrHaJFdbwz3xunh/MvTPOHM3RMM1j1m3qlr2Mvv+bO4gdxr/1os8Pu
 YLt7LTF+gBH5s6to2FsmL/Zrq2bnjHOi4gBebPTPNm2SVH0ebM62FrAzosWKS3GYQ+a+
 pnv3j2Z2etXDExxKjgPLml9vbmXCNr16tYOZhssWTDN0Cf8ctHG0lvPEXI89VwbD1bnE
 HHlE2Iy+rYAPp8nHOqiPoubt+UFJFa8B4TkG1CWJhNur7+VoztQVieUQ3hzeg+WkaIOZ
 /peA==
X-Gm-Message-State: AC+VfDyr+jkqxT9O041Hxosr3L743qoKTiLE+05LdlebRhSEwNwMLUS4
 56DLt2+Q88b4cyaRcE76ICbulP3kCOcIwehZGmA=
X-Google-Smtp-Source: ACHHUZ6EuvgSQlsjeT/uaTMgi4m2t0aHuRrYYR8A661D9lOXLXZtl9EnOxIoT+/HZQQDaY/qD/W6jw==
X-Received: by 2002:a05:600c:2049:b0:3f9:b31d:5689 with SMTP id
 p9-20020a05600c204900b003f9b31d5689mr10696015wmg.36.1688482297790; 
 Tue, 04 Jul 2023 07:51:37 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c220700b003fa999cefc0sm24555314wml.36.2023.07.04.07.51.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/19] hw/timer/arm_timer: Extract icp_pit_realize() from
 icp_pit_init()
Date: Tue,  4 Jul 2023 16:50:09 +0200
Message-Id: <20230704145012.49870-17-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

To make the next commit easier to digest, extract icp_pit_realize()
from icp_pit_init() as a preliminary step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index aae7f3cf9d..30e29cc166 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -408,8 +408,6 @@ static void icp_pit_init(Object *obj)
     for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
         s->timer[i] = arm_timer_new(tmr_freq[i], s->irq_in[i]);
         sysbus_init_irq(dev, &s->irq[i]);
-        sysbus_connect_irq(dev, i,
-                           qdev_get_gpio_in_named(DEVICE(obj), "timer-in", i));
     }
 
     memory_region_init_io(&s->iomem, obj, &icp_pit_ops, s,
@@ -419,12 +417,31 @@ static void icp_pit_init(Object *obj)
        save themselves.  */
 }
 
+static void icp_pit_realize(DeviceState *dev, Error **errp)
+{
+    IntegratorPIT *s = INTEGRATOR_PIT(dev);
+
+    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
+        SysBusDevice *tmr = SYS_BUS_DEVICE(&s->timer[i]);
+
+        sysbus_connect_irq(tmr, i, qdev_get_gpio_in_named(dev, "timer-in", i));
+    }
+}
+
+static void icp_pit_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    k->realize = icp_pit_realize;
+}
+
 static const TypeInfo arm_timer_types[] = {
     {
         .name           = TYPE_INTEGRATOR_PIT,
         .parent         = TYPE_SYS_BUS_DEVICE,
         .instance_size  = sizeof(IntegratorPIT),
         .instance_init  = icp_pit_init,
+        .class_init     = icp_pit_class_init,
 
     }, {
         .name           = TYPE_SP804_TIMER,
-- 
2.38.1


