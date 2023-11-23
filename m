Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6D47F61B5
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:40:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6AsO-0003VB-8O; Thu, 23 Nov 2023 09:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6ArO-0002Os-VH
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:39:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6ArM-0002XD-FI
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:39:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b27b498c3so6520395e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750355; x=1701355155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1237N1r1qCpcYS004kuUN2TuaGy1OnSXggczIa7nXrE=;
 b=A6cMCvgEw1QkQiHYWTKMdIVR+vq7ld76SmijW1AfxYgE0sxaPNxHg+zHx3jdHOWyYW
 P/nRmi3ZR3Gr50yWlrx/7PFFEEjDCHxtqH2p5NDDJANwXOPDAWLuyKizuK/UO/gcnYBj
 4MS42ogdGmA5I0ws/YUdmHTeX0ebJjB7HdBPIQFVip+MATOfGcfXSpTpXqzmv2cUjEKI
 yu1jmlktpxmbBfYwoDyZbPx/XCkkX6rr9tSQXxLbQhNDk9bYg+JGS1oBz/b25OYui8yc
 uVByGRhNsTtPG5edemKqk60R+diIGn80LoOwBemn4ZF5Xx/GydRsbzsqvF2tvb8KWauy
 z2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750355; x=1701355155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1237N1r1qCpcYS004kuUN2TuaGy1OnSXggczIa7nXrE=;
 b=tUc0pp9ODFqUPb1LpAmdGzdd6Uzhj281H4Q4VBMMXevmqBy/cLSeFTm/hIKS+Cxtuj
 YPQL3lH0DWaIQYAB2zCnbWWb1diE08NRJCtu+zDCBRtnTQcrjQm4iNXX+yY/UbZ/euIx
 H7e7959Bd3KfP6Rtj6iDgmGq1BXMus9hf9v3Rqi4dHpLluGS/znbsPzwnibbVOgqnoKD
 PeOisSBPGH6Cwp+/13toUzxy1srcdzmXOTT54dgc+29VognhAdxvzBlw0nx0vReRuPRx
 nn9CdUFoWoNI9zeTetk1ce8GIYGDF42Xe/t+6MWq4/9fcczLUHfkzx+6s18zcSy//B+N
 jY2g==
X-Gm-Message-State: AOJu0YzkI5Y0qSXFEme5sb4wvOaR28YegVcXlumQYQ/7ntZDyiq/fOQO
 uDhuSUQqisOHg2QAExTfsxXly8gs1CVtuUvSEwU=
X-Google-Smtp-Source: AGHT+IF+NoAW509sLiqzUIKxEwYj1wKGFHj0e9U8IV+YOgvBPOP8D/q5PIL/mIRkOhEGTVKbmHSGvQ==
X-Received: by 2002:a05:600c:4703:b0:40b:38a8:6c65 with SMTP id
 v3-20020a05600c470300b0040b38a86c65mr405199wmo.26.1700750355139; 
 Thu, 23 Nov 2023 06:39:15 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a1c4c04000000b0040b32edf626sm2163708wmf.31.2023.11.23.06.39.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 06:39:14 -0800 (PST)
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
Subject: [PATCH-for-9.0 v2 7/8] hw/arm/bcm2836: Move code after error checks
Date: Thu, 23 Nov 2023 15:38:11 +0100
Message-ID: <20231123143813.42632-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123143813.42632-1-philmd@linaro.org>
References: <20231123143813.42632-1-philmd@linaro.org>
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

First run the code that can return errors, then on success
run what alters the instance state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 03e6eb2fb2..e56935f3e5 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -119,13 +119,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
-        qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
-        qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
-
     for (n = 0; n < BCM283X_NCPUS; n++) {
         object_property_set_int(OBJECT(&s->cpu[n].core), "mp-affinity",
                                 (bc->clusterid << 8) | n, &error_abort);
@@ -158,6 +151,13 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
     }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
+                    qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
+                    qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
 }
 
 static void bcm283x_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


