Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77874747D
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhMh-0003rk-Lr; Tue, 04 Jul 2023 10:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMX-0003jQ-Np
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMO-0002x9-6g
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc0609cd6so56585985e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482230; x=1691074230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhMO8Q1jA2bR32jdxudf4HkyOq0yWx3SI4nwIyth1l8=;
 b=IBTtopKGgYipM7AX6uXCjGv2t+GIJYK/WQkYQOGTEqpY9LvGRW5NX2v+AmtSiFimqF
 BoAnVHBWqcOSfKcyRSNnbaJOth+phlNWqrfAcaw+ZxrDgmNUCpLZyO1X1E5HrVBo4Q1i
 i3tpiDdwiST1+ud0TLnEg3P+VxL/jVVGQZC4OTiLDDpKpLyE/39bMsIYuxWer89YFGki
 fWUb8JVJz1L+y7H4xTA9fTb0Iqj8d8+z8CYI0RbDH3OhbDBGkgq89cEyhxU11Zz/tnaN
 zYbszUrdUbINOSzCe4VVBx75zKh9B0cUrc0i3TkWLof+oBh/d8jKbpbfflvSPGhAK6kl
 HPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482230; x=1691074230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhMO8Q1jA2bR32jdxudf4HkyOq0yWx3SI4nwIyth1l8=;
 b=hfBqkoxbH0Av6PghRgd4Av8DMcx00IR/3D7qqHemh9aZPs2VxTdR1JS4FLynSv43T1
 clw6R0d5GSoJkXivjez3+JSWNnN4Gb4ObX/PK9bB1du5k5+0dNIYKcI62z5EsX0Dmywm
 9BTavNvMq5USuJkV1n2XRfooE97oj6WRzBkmhRmkKqObiZOqkT+WABhFHHWPyBk2ncUI
 NNHxWhjgttZbLYqtwlcj9WimnTSd5a0P6ZA472UPrwmQzBgLMuL8r9yBvxg8vhX3JMlh
 ZoaEyjIr0l8//CFFrihLhApSQItuY1EXMxV3Gp+pGdC4y4yGyRdPBnneYhdD4q3MpNyp
 gUkQ==
X-Gm-Message-State: ABy/qLYD+D89D2VCsINZGD9gX3d969IsnN9J6iUPNjSYVljGLd1pLW1B
 j9gXosBp/Uh0m50b7GEwnlN57B7+27QGIn5hxZA=
X-Google-Smtp-Source: APBJJlHmbieKfNVrZZm5qJ3puEo/p9x1zWqXp+F01nJvSJdd5hoxc4pqG7G9ML4vMYmLCZCxG3c4NA==
X-Received: by 2002:a05:6000:8:b0:314:1b6a:a095 with SMTP id
 h8-20020a056000000800b003141b6aa095mr8827085wrx.23.1688482230613; 
 Tue, 04 Jul 2023 07:50:30 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a5d5681000000b0030647449730sm28783108wrv.74.2023.07.04.07.50.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/19] hw/timer/arm_timer: Move SP804 code around
Date: Tue,  4 Jul 2023 16:49:56 +0200
Message-Id: <20230704145012.49870-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Move sp804_properties[] and sp804_class_init() around
with the rest of SP804 code code. What follows the
"Integrator/CP timer module." is strictly ICP related.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 30a34a9a92..0e5d5d0f6d 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -309,6 +309,21 @@ static void sp804_realize(DeviceState *dev, Error **errp)
     s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
 }
 
+static Property sp804_properties[] = {
+    DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
+    DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sp804_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    k->realize = sp804_realize;
+    device_class_set_props(k, sp804_properties);
+    k->vmsd = &vmstate_sp804;
+}
+
 /* Integrator/CP timer module.  */
 
 #define TYPE_INTEGRATOR_PIT "integrator_pit"
@@ -380,21 +395,6 @@ static void icp_pit_init(Object *obj)
        save themselves.  */
 }
 
-static Property sp804_properties[] = {
-    DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
-    DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void sp804_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *k = DEVICE_CLASS(klass);
-
-    k->realize = sp804_realize;
-    device_class_set_props(k, sp804_properties);
-    k->vmsd = &vmstate_sp804;
-}
-
 static const TypeInfo arm_timer_types[] = {
     {
         .name           = TYPE_INTEGRATOR_PIT,
-- 
2.38.1


