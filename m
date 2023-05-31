Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D97718B50
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:38:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SYf-0007af-U8; Wed, 31 May 2023 16:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYT-0007Iv-I0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYP-0003Eg-VO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d20548adso63680f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565379; x=1688157379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5b8V9q6QA/WPM4HyTDg8f1UskvZE7C+FUlDujJKJpg=;
 b=X5nVFwk17NlI83u+mz3mJJemZFUKk5Ui803GxBDR5O0tTV3YOH9omve+U2DxMZxeDF
 RbkMEGdzE4znJvim3OhszWbHADWD/mqbUYyYvpnh4iFp+3VNH6zkqDb8GOhZqmuRNvye
 vShyvnlZPxA9j4+lxnvYPZYj1BA99VyHnRzd2ioDONjaHXniSeIxD0zSO3Jzj67hozrD
 W87QWLV/H8DtszAM+pu2U2CvEkigPj38ZEbsVWVVxlPg1f0xTy6DhoSSiTjG/epXUfLI
 QRvzoPJwnPku98nXWWzYlw0qZgQ1ZDUFs1A5/z/uhZlB+7b2hkHU0u/t4AQc3/YfRf8c
 lHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565379; x=1688157379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E5b8V9q6QA/WPM4HyTDg8f1UskvZE7C+FUlDujJKJpg=;
 b=iA+pmWxugVBO376Q1xlF+XT66Eofy0Jba18NIGViytT074uoJYojqRJZ7gX8c1wNTh
 DhFFEeG2u2zt9014fuHc8yX9VUBgy4NkD6sDhi3zG+xAugRZtY6LhTxfQpwSA1GxvZwe
 06b+9qEVPOxCFgzXNVZw/fuq6VZCFzpP/FDArlqW0BLUDCdV87tjLqkeyOgLS8V3eUpn
 uU02LY0mI+CyyFdePAauV7cbRGwKdso1Y7CuYLewqe9sERNSLXEYtKZJtNmtcWqmRIuu
 N0Mod1xyy4FgQUYMbIVBniC2dgNBF/1G5KxNemaTH4LRmUlzWHihAZmhKggiq1W8E5Ja
 V/Hg==
X-Gm-Message-State: AC+VfDwUTXsyssgq3OrK4vtC1ItMKVS+brejmOWuokZHsLfuqDRifvSk
 R95ZjtGB3/9csZREr5a/cXJQ2B3t4tmpqd8Rt/s=
X-Google-Smtp-Source: ACHHUZ6ZAQu3uQ+XnEHRWI7hPIoPUrWjoC0ZHywBDozr6nxArvjpdsCYFPZRCHezQJzvjAAjnqJKiQ==
X-Received: by 2002:adf:f742:0:b0:306:297b:927f with SMTP id
 z2-20020adff742000000b00306297b927fmr154149wrp.25.1685565379692; 
 Wed, 31 May 2023 13:36:19 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 a14-20020adfe5ce000000b003078354f774sm7945369wrn.36.2023.05.31.13.36.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:36:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/15] hw/timer/arm_timer: Add missing sp804_unrealize()
 handler
Date: Wed, 31 May 2023 22:35:47 +0200
Message-Id: <20230531203559.29140-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Release the IRQs allocated in sp804_realize() in the
corresponding sp804_unrealize() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 36f6586f80..5caf42649a 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -309,6 +309,15 @@ static void sp804_realize(DeviceState *dev, Error **errp)
     s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
 }
 
+static void sp804_unrealize(DeviceState *dev)
+{
+    SP804State *s = SP804(dev);
+
+    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
+        qemu_free_irq(s->timer[i]->irq);
+    }
+}
+
 static Property sp804_properties[] = {
     DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
     DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
@@ -320,6 +329,7 @@ static void sp804_class_init(ObjectClass *klass, void *data)
     DeviceClass *k = DEVICE_CLASS(klass);
 
     k->realize = sp804_realize;
+    k->unrealize = sp804_unrealize;
     device_class_set_props(k, sp804_properties);
     k->vmsd = &vmstate_sp804;
 }
-- 
2.38.1


