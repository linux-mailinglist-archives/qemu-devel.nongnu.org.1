Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E306F7F61B7
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:40:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6As3-0003I1-Jg; Thu, 23 Nov 2023 09:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6ArW-0002Xj-FI
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:39:28 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6ArU-0002Zs-Rb
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:39:26 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-332cc1f176bso626535f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750363; x=1701355163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SliH/Dd/Fz40g7/vYVgjwfZm7k8MHl78S5VUvr4CFSQ=;
 b=iFafsJXZxbcp88GW/FzAYVOkEQPtcwTIZzLN0TTUmNJ17DhomDt2bF+WmiUQi7+cya
 npUHLlF3rJNtxx9X2a7SRXYKJPM6xisYGjXsfASR2P6hx3yVbFsxWnZvvND9k44m91VE
 btDJ3YLLE5/cS3BqND+YCjPqv8fCcsgaA4vBO4YFh4JsVZvd1m9eaj9EIn8ANEzvWy3N
 gP8Oo2sxkOljQVQ7V7BoI8/dqtkmBcmgcIOKd20RBvGn2qbRUwd7Av0uE0Ob7JS9P4W9
 lwEXWZa5cvcOLPTWNHxe1eKu6DylEmUPetzg6kiAIgcCSsqVUMZEf0P8VGCa0+mPw/S+
 c4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750363; x=1701355163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SliH/Dd/Fz40g7/vYVgjwfZm7k8MHl78S5VUvr4CFSQ=;
 b=fNMRqwBGGgBp1H6y0exjRRz+szU/CFvSr8DCY2rUfa4+2SksP4dDoYDzXO238YjWn/
 3YHfaOozmauUXo5XYCDHeNYeMBgk8mnuwAvC1vmmppuYae15LsZDrkHQHbgnaBiW8JWY
 2vOFMFCmaprEdG3z2fa/kNlBvz0d108dPYAm/Q8b6RLkN4R/7IeoAAdFcktytTEher/3
 Og4QjU0jpF+wuGuAV6/P8BRfpIKJb13vk8WXiUQNI6tQLIuJ5PaPji4L5NlWDCc2EOXr
 rq+3rRDwIXK1wgQsA4I2dR3SjgWfcluMxkqWqwSRmOsuFH1WBwTbMHsgCiPR6bSWW/kg
 uP1g==
X-Gm-Message-State: AOJu0YzMRb2REkfHT7O9uzWvsqDFlAbc2CMShfi5HiPGPbwrjt/A1LQm
 isQ/So9oBeiQ8Z30HXCSmd3HIA==
X-Google-Smtp-Source: AGHT+IF6qUhQZan6xU0WnjVucUZAgNU3+H2mqFw5wah21INKPHTkM42fLqvnYgx3dBwwx3ZkPAa/tQ==
X-Received: by 2002:a5d:47c7:0:b0:332:cb51:34ed with SMTP id
 o7-20020a5d47c7000000b00332cb5134edmr4585550wrc.54.1700750363110; 
 Thu, 23 Nov 2023 06:39:23 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a5d6a4f000000b0033169676e83sm1806159wrw.13.2023.11.23.06.39.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 06:39:22 -0800 (PST)
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
Subject: [PATCH-for-9.0 v2 8/8] hw/arm/bcm2836: Add local variable to remove
 various DEVICE() casts
Date: Thu, 23 Nov 2023 15:38:12 +0100
Message-ID: <20231123143813.42632-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123143813.42632-1-philmd@linaro.org>
References: <20231123143813.42632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Cast the CPU to DeviceState once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index e56935f3e5..013cee853d 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -120,6 +120,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
+        DeviceState *cpudev = DEVICE(&s->cpu[n].core);
+
         object_property_set_int(OBJECT(&s->cpu[n].core), "mp-affinity",
                                 (bc->clusterid << 8) | n, &error_abort);
 
@@ -128,27 +130,26 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                                 bc->peri_base, &error_abort);
 
         /* start powered off if not enabled */
-        qdev_prop_set_bit(DEVICE(&s->cpu[n].core), "start-powered-off",
-                          n >= s->enabled_cpus);
+        qdev_prop_set_bit(cpudev, "start-powered-off", n >= s->enabled_cpus);
 
-        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
+        if (!qdev_realize(cpudev, NULL, errp)) {
             return;
         }
 
         /* Connect irq/fiq outputs from the interrupt controller. */
         qdev_connect_gpio_out_named(DEVICE(&s->control), "irq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_IRQ));
+                                    qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
         qdev_connect_gpio_out_named(DEVICE(&s->control), "fiq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_FIQ));
+                                    qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
 
         /* Connect timers from the CPU to the interrupt controller */
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_PHYS,
+        qdev_connect_gpio_out(cpudev, GTIMER_PHYS,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpnsirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_VIRT,
+        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntvirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_HYP,
+        qdev_connect_gpio_out(cpudev, GTIMER_HYP,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cnthpirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
+        qdev_connect_gpio_out(cpudev, GTIMER_SEC,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
     }
 
-- 
2.41.0


