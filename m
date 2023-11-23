Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C777F61B4
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:40:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6AsO-0003X3-OT; Thu, 23 Nov 2023 09:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6ArG-0002Dt-Jr
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:39:13 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6ArE-0002Vt-Ou
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:39:10 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c83d37a492so12016231fa.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750347; x=1701355147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGiTJB8vH4At7R/cLAjNpyQTepWZvh1pzfnI30rm26o=;
 b=a4rnnAa7w1+vrwFNFCdho6mZBoQJx9Cmlz9oa5gkUMbcN46fPNbWuP5vIi5l54KCmz
 O73nY0jl2DnvnUjC0bGF5uaFSKI7ZyVIXJQGEOzEwAOHHKcFhPtYmtRqZEy986WnI8JJ
 LTssH2/8tYEar04i0K7QgopFFnmCHdDzEOkRy+coY/CKl/QFC8bjjJuJ1A4vHNj1YFrC
 uE1xNMqGICKxuxwm+pbF/eYnRkwN2dkIhAKDhEg/pWDCL+z/TUXxg61/SL0tsj4Cg1RO
 XIIwmy4K/yhY7/2X4Ydsqo5u6olDF+bGP3obXWTaF0pg1DuCRxZMJoqStp5gUdB6B520
 iCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750347; x=1701355147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGiTJB8vH4At7R/cLAjNpyQTepWZvh1pzfnI30rm26o=;
 b=DwdaZavxhzdisaR6Tp88q1t4tVrwcmHgGyoEnDjkV/nfp2JRjfaN+fKiBUK+YD4vzh
 UMeFL12ZMBqZlxA6yqnNwq7GvR4DftgzE1nzTFmLD0vH1o7LA0EwybxgE3MqIab0hM/z
 sVk+zW+h01u4W+9L3akZPn0pw6oWnGN5fVHWQy5jGXFmQSX1214omy2zYjUInhc4yprb
 9hKFjs9ggZUBZNqcFL3dMvfZ53haECdINEYYmofLz7iW2kFUWfXA5pjwVg23dzT06PRi
 53WBgDgrgeJjRZKodfePNrt2dY4fnf9J00G4Md6djEkUEydjlWJlLwu661xLcILtX9aH
 cIAg==
X-Gm-Message-State: AOJu0YySzDLTdgmZJXqJQcmNLcBMxqQpL1SSqgVPXf1mi7vABpq+ieyn
 m6Jr80Rj0/FQIxNvnJdJBczpBg==
X-Google-Smtp-Source: AGHT+IF522fK+oIp7gwInm56VEkMeVSPsnHs0f7Gm+cucJsNEjbKlNWX0+w8YK4+8Fh4Fp3038daaQ==
X-Received: by 2002:a05:651c:19a4:b0:2c8:3888:bbb2 with SMTP id
 bx36-20020a05651c19a400b002c83888bbb2mr4569717ljb.38.1700750347065; 
 Thu, 23 Nov 2023 06:39:07 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05600c34c500b0040b349c91acsm2922438wmq.16.2023.11.23.06.39.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 06:39:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH-for-9.0 v2 6/8] hw: Simplify uses of qdev_prop_set_bit(dev,
 'start-powered-off')
Date: Thu, 23 Nov 2023 15:38:10 +0100
Message-ID: <20231123143813.42632-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123143813.42632-1-philmd@linaro.org>
References: <20231123143813.42632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Simplify few qdev_prop_set_bit("start-powered-off") and re-indent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/allwinner-h3.c  |  3 +--
 hw/arm/allwinner-r40.c |  3 +--
 hw/arm/bcm2836.c       |  4 ++--
 hw/arm/fsl-imx6.c      |  4 +---
 hw/arm/fsl-imx7.c      | 12 +++++-------
 5 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index f05afddf7e..593244464a 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -251,8 +251,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
          * Disable secondary CPUs. Guest EL3 firmware will start
          * them via CPU reset control registers.
          */
-        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "start-powered-off",
-                          i > 0);
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "start-powered-off", i > 0);
 
         /* All exception levels required */
         qdev_prop_set_bit(DEVICE(&s->cpus[i]), "has_el3", true);
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index a0d367c60d..202a158fb8 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -304,8 +304,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
          * Disable secondary CPUs. Guest EL3 firmware will start
          * them via CPU reset control registers.
          */
-        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "start-powered-off",
-                          i > 0);
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "start-powered-off", i > 0);
 
         /* All exception levels required */
         qdev_prop_set_bit(DEVICE(&s->cpus[i]), "has_el3", true);
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 1fdc3be6bb..03e6eb2fb2 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -99,9 +99,9 @@ static void bcm2835_realize(DeviceState *dev, Error **errp)
 
     /* Connect irq/fiq outputs from the interrupt controller. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
-            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_IRQ));
+                       qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
-            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_FIQ));
+                       qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_FIQ));
 }
 
 static void bcm2836_realize(DeviceState *dev, Error **errp)
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 17c399a37e..b7f1738a89 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -127,9 +127,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         }
 
         /* All CPU but CPU 0 start in power off mode */
-        if (i) {
-            qdev_prop_set_bit(DEVICE(&s->cpu[i]), "start-powered-off", true);
-        }
+        qdev_prop_set_bit(DEVICE(&s->cpu[i]), "start-powered-off", i > 0);
 
         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
             return;
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 3138ffeb08..451801f7e8 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -187,13 +187,11 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                     &error_abort);
         }
 
-        if (i) {
-            /*
-             * Secondary CPUs start in powered-down state (and can be
-             * powered up via the SRC system reset controller)
-             */
-            qdev_prop_set_bit(DEVICE(o), "start-powered-off", true);
-        }
+        /*
+         * Secondary CPUs start in powered-down state (and can be
+         * powered up via the SRC system reset controller)
+         */
+        qdev_prop_set_bit(DEVICE(o), "start-powered-off", i > 0);
 
         qdev_realize(DEVICE(o), NULL, &error_abort);
     }
-- 
2.41.0


