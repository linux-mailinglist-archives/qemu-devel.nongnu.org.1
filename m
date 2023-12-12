Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144480F2D9
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5hW-0003K7-Qc; Tue, 12 Dec 2023 11:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5hM-0002tG-H4
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:32 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5h9-0007z9-VE
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:32 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3333131e08dso6405755f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398797; x=1703003597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFB3NxAZWWbFr7FqoB9z01YE2CJXVAN7E7QlxKJ0g+s=;
 b=NGIrTjeHHJHMhmSXLiKBD1mY35zbC5HOSrVxuWBXpzNRXnCze1CdPtJXhyNaGM1ey2
 IFeothpMHOS4IaCcLZdRrp93h8UpcbI8hp2k9NuuOjlD5aN+c3zWY7Br52tg6DzfXJQR
 AwWOEH+QgPlzmNp7wBlbqzE2/Sm0UhwMN/aQoxU2Rrn/8AVdc9Z5tmCICDSWlvase6AM
 8mGVZVmUDIIe93vQKy9T9vYgY0mzCekJ0cQai+1DHvA48jtuKxlXPuz+27Svj9+Hv9eH
 oR1q/7sbAPFquWUi85EKFr2tmmUHVdUhYYfUoeEFORJacWGnU5BzJeYSrjKnU3nXJdbY
 tGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398797; x=1703003597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFB3NxAZWWbFr7FqoB9z01YE2CJXVAN7E7QlxKJ0g+s=;
 b=cgs6RxZTrj1AeZvDyouQkUlBnZwu1nnuYjsvg9tD2C/Lg+JvypX9/j1vfaBfV7udjA
 W8AqQJPlmHmkNOXofigpUC5k42B8zVxzGnhHgFjDPyPujlLCFAtJkD59P6jyKdAW9yFs
 Vsi3LQHaJumqCCFx4RAojqLBIPIbTQY6Zo9H1IfYFZeCD/3qrKTLWFKjm4v7X3zHyohf
 mR9wcQqaUE35ekpeGALQi9i7Cde2vpX5yICW0AcF6DrQEsHxMOjJYbaGAC8QDio0zkPS
 uRHwQeX/FLfauEfvqPl3l4bonkDCLYidTVZtxVYZMirNKB3R5qNC4699oeIdTyEpg/d7
 YFTQ==
X-Gm-Message-State: AOJu0Yx21SG+11dlP19gg9tEVn2U3isev3GT2LMdX4/9ITkzQhpy+Yb7
 sQ9SgHCjClDVXfEpgOCLlLLBdGoK+kBouiqRK2Y=
X-Google-Smtp-Source: AGHT+IF/Bv+SYKqQ/vreqMkben2eOy7NiWdMzNo30Nbt3ZjnzqeGSMKoTfcP2S6EA6QlpWI0J9qLLA==
X-Received: by 2002:adf:faca:0:b0:333:85e:a122 with SMTP id
 a10-20020adffaca000000b00333085ea122mr2648323wrs.7.1702398797275; 
 Tue, 12 Dec 2023 08:33:17 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a5d4291000000b0033335d9dcc5sm11246500wrq.64.2023.12.12.08.33.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:33:16 -0800 (PST)
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
Subject: [PATCH 30/33] hw/arm/npcm7xx: Let the A9MPcore create/wire the CPU
 cores
Date: Tue, 12 Dec 2023 17:29:30 +0100
Message-ID: <20231212162935.42910-31-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Set the properties on the mpcore object to let it create and
wire the CPU cores. Remove the redundant code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/npcm7xx.h |  1 -
 hw/arm/npcm7xx.c         | 48 ++++++++++------------------------------
 2 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 7abbf85cbf..e0737fa4de 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -80,7 +80,6 @@ typedef struct NPCM7xxMachineClass {
 struct NPCM7xxState {
     DeviceState         parent;
 
-    ARMCPU              cpu[NPCM7XX_MAX_NUM_CPUS];
     A9MPPrivState       a9mpcore;
 
     MemoryRegion        sram;
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 5b6e968fa9..1154a0f0a5 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -363,9 +363,11 @@ static struct arm_boot_info npcm7xx_binfo = {
 
 void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
 {
+    CortexMPPrivState *mp = CORTEX_MPCORE_PRIV(&soc->a9mpcore);
+
     npcm7xx_binfo.ram_size = machine->ram_size;
 
-    arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
+    arm_load_kernel(mp->cpu[0], machine, &npcm7xx_binfo);
 }
 
 static void npcm7xx_init_fuses(NPCM7xxState *s)
@@ -400,11 +402,6 @@ static void npcm7xx_init(Object *obj)
     NPCM7xxState *s = NPCM7XX(obj);
     int i;
 
-    for (i = 0; i < NPCM7XX_MAX_NUM_CPUS; i++) {
-        object_initialize_child(obj, "cpu[*]", &s->cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a9"));
-    }
-
     object_initialize_child(obj, "a9mpcore", &s->a9mpcore, TYPE_A9MPCORE_PRIV);
     object_initialize_child(obj, "gcr", &s->gcr, TYPE_NPCM7XX_GCR);
     object_property_add_alias(obj, "power-on-straps", OBJECT(&s->gcr),
@@ -471,40 +468,19 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /* CPUs */
-    for (i = 0; i < nc->num_cpus; i++) {
-        object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
-                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
-                                &error_abort);
-        object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
-                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
-        object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
-                                 &error_abort);
-
-        /* Disable security extensions. */
-        object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3", false,
-                                 &error_abort);
-
-        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
-            return;
-        }
-    }
-
     /* A9MPCORE peripherals. Can only fail if we pass bad parameters here. */
-    object_property_set_int(OBJECT(&s->a9mpcore), "num-cores", nc->num_cpus,
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->a9mpcore), "num-irq", NPCM7XX_NUM_IRQ,
-                            &error_abort);
+    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cores", nc->num_cpus);
+    qdev_prop_set_string(DEVICE(&s->a9mpcore), "cpu-type",
+                         ARM_CPU_TYPE_NAME("cortex-a9"));
+    /* Disable security extensions. */
+    qdev_prop_set_bit(DEVICE(&s->a9mpcore), "cpu-has-el3", false);
+    qdev_prop_set_uint64(DEVICE(&s->a9mpcore), "cpu-reset-cbar",
+                         NPCM7XX_GIC_CPU_IF_ADDR);
+    qdev_prop_set_bit(DEVICE(&s->a9mpcore), "cpu-reset-hivecs", true);
+    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "gic-spi-num", NPCM7XX_NUM_IRQ);
     sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, NPCM7XX_CPUP_BA);
 
-    for (i = 0; i < nc->num_cpus; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i,
-                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_IRQ));
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i + nc->num_cpus,
-                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
-    }
-
     /* L2 cache controller */
     sysbus_create_simple("l2x0", NPCM7XX_L2C_BA, NULL);
 
-- 
2.41.0


