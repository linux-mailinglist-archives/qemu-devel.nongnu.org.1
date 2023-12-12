Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9D580F325
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:36:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5gP-0006nY-1F; Tue, 12 Dec 2023 11:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fy-0006Rw-5d
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:09 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fw-0007h1-82
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:05 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a22deb95d21so157565266b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398719; x=1703003519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Pqc0Rrgak/xeltLwYcUfzRxHhc0ewXusv1vEQMSS3M=;
 b=tASjU4XB7PiG3bwiOhAHnlhNPu03UOMbzpMEKrdZ4RK27vWhwV39Ois23sHMwnYyQu
 bbILCoYCx7V3yQ/vbef9mG4i/XkZm2YPKSAN5KgiN6lZr/SwST/ZdFdCOe29Tdu7NbI5
 E0aU9CVLrHPHO/wRlxRg8/UmXlI4rvaYqC1DUzijmdAbFb5FmtisS1gn7Ljrs7Vub5dx
 3k1i68rkE8n/+pLSA5kdTx75o5NT7fJpH9kMfPTlDREZhh+XBOoF4UmzngpojVSHb6kp
 Qu5LAnOD9ef34/HbxkI/H/8flOtM6S5KpGTm34bJjhKSbJuAEGYpF+Ie8UNLwy8zo7pD
 J1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398719; x=1703003519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Pqc0Rrgak/xeltLwYcUfzRxHhc0ewXusv1vEQMSS3M=;
 b=QInOExky7WRpCWxGRQFmjuarFNQTWaiSgDRO5bJr7NqXQwrCEXhjydB37ZT2jxH46J
 YVyiZ+0sb93ichM7m1YKKk2Ne5Uoz3VJ516GcGHOEQymFMuh6myGMBa4slm46O7YVxWy
 fgOpgA5XTiH6GTjSuI6GSBSb86snn468CzgwHjMCPXwCVx8bISAQMbbYb4bXJq6tqaxN
 mBHobOF0VdVxwfdp/ujOnC0jK8uqEOFiS5aKJaY7qKeCsydiJP/R9LG+pj3NsFIU8YTh
 sihsIQIOPygVS5m5+ek3vlxJmS+h09tZPcEraVyHIgY9lBc4JmIKC+ou9nK3Ih423xwf
 y0hg==
X-Gm-Message-State: AOJu0Yxo+01wYlUyaV+eezV03360OACXpT7lnEirmybuYiYOqNg7Jp1t
 vNgGzLv4wCtIq0TRE0jFNMLRZu0PXpqpWi3vXe8=
X-Google-Smtp-Source: AGHT+IGAoWsuLGoO9Ag1O8wpNAZ/MH7VoxAIftcwIH/sievxL+UsNifhl17EdIKQcgiBfNJqSqy87A==
X-Received: by 2002:a17:907:7156:b0:a1e:36e0:1c79 with SMTP id
 zs22-20020a170907715600b00a1e36e01c79mr2869141ejb.89.1702398719059; 
 Tue, 12 Dec 2023 08:31:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170906564a00b009fea232316bsm6454240ejr.193.2023.12.12.08.31.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:31:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/33] hw/cpu/arm: Introduce TYPE_A7MPCORE_PRIV for Cortex-A7
 MPCore
Date: Tue, 12 Dec 2023 17:29:19 +0100
Message-ID: <20231212162935.42910-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

For QEMU modelling, the only difference between the A15 and A7
MPCore is the latter can have up to 480 SPIs.

In particular, since commit b151de69f6 ("hw/arm: ast2600: Set
AST2600_MAX_IRQ to value from datasheet") the AST2600 machine
initializes its GIC with 256 SPIs, which is more than the 224
maximum of the A15.

Since the A7 was not available, few boards were using the A15.
Replace them by a A7 MPCore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
The comment in a7mp_priv_class_init() is a bit off.
---
 include/hw/cpu/cortex_mpcore.h |  2 ++
 hw/arm/aspeed_ast2600.c        |  3 +--
 hw/arm/fsl-imx6ul.c            |  3 +--
 hw/arm/fsl-imx7.c              |  3 +--
 hw/cpu/a15mpcore.c             | 30 ++++++++++++++++++++++++++++++
 5 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index 7822d5cbc4..4e1aa9f7f7 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -118,4 +118,6 @@ struct A9MPPrivState {
 
 #define TYPE_A15MPCORE_PRIV "a15mpcore_priv"
 
+#define TYPE_A7MPCORE_PRIV "a7mpcore_priv"
+
 #endif
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index ca788e1cf0..88e2a23514 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -171,8 +171,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key");
 
-    object_initialize_child(obj, "a7mpcore", &a->a7mpcore,
-                            TYPE_A15MPCORE_PRIV);
+    object_initialize_child(obj, "a7mpcore", &a->a7mpcore, TYPE_A7MPCORE_PRIV);
 
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
 
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 93908811c5..6e4343efaa 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -40,8 +40,7 @@ static void fsl_imx6ul_init(Object *obj)
     /*
      * A7MPCORE
      */
-    object_initialize_child(obj, "a7mpcore", &s->a7mpcore,
-                            TYPE_A15MPCORE_PRIV);
+    object_initialize_child(obj, "a7mpcore", &s->a7mpcore, TYPE_A7MPCORE_PRIV);
 
     /*
      * CCM
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 8a3e9933c4..bd9266b8b5 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -48,8 +48,7 @@ static void fsl_imx7_init(Object *obj)
     /*
      * A7MPCORE
      */
-    object_initialize_child(obj, "a7mpcore", &s->a7mpcore,
-                            TYPE_A15MPCORE_PRIV);
+    object_initialize_child(obj, "a7mpcore", &s->a7mpcore, TYPE_A7MPCORE_PRIV);
 
     /*
      * GPIOs
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 87b0786781..5f28a97adb 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -121,6 +121,30 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
     /* We currently have no saveable state */
 }
 
+static void a7mp_priv_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    CortexMPPrivClass *cc = CORTEX_MPCORE_PRIV_CLASS(klass);
+
+    cc->container_size = 0x8000;
+
+    cc->gic_class_name = gic_class_name();
+    cc->gic_revision = 2;
+    /*
+     * The Cortex-A7MP may have anything from 0 to 480 external interrupt
+     * IRQ lines (with another 32 internal). We default to 128+32, which
+     * is the number provided by the Cortex-A15MP test chip in the
+     * Versatile Express A15 development board.
+     * Other boards may differ and should set this property appropriately.
+     */
+    cc->gic_spi_default = 160;
+    cc->gic_spi_max = 480;
+
+    device_class_set_parent_realize(dc, a15mp_priv_realize,
+                                    &cc->parent_realize);
+    /* We currently have no saveable state */
+}
+
 static const TypeInfo a15mp_types[] = {
     {
         .name           = TYPE_A15MPCORE_PRIV,
@@ -128,6 +152,12 @@ static const TypeInfo a15mp_types[] = {
         .instance_size  = sizeof(CortexMPPrivState),
         .class_init     = a15mp_priv_class_init,
     },
+    {
+        .name           = TYPE_A7MPCORE_PRIV,
+        .parent         = TYPE_CORTEX_MPCORE_PRIV,
+        .instance_size  = sizeof(CortexMPPrivState),
+        .class_init     = a7mp_priv_class_init,
+    },
 };
 
 DEFINE_TYPES(a15mp_types)
-- 
2.41.0


