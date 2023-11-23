Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13E7F61B3
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:40:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ArT-0002JL-87; Thu, 23 Nov 2023 09:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Ar1-00025Y-Rw
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:56 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Aqy-0002UD-D7
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:55 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-332e7630a9dso15056f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750331; x=1701355131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVWcie4bmzaB0d5l/X4mRechmHi5GyH0Jpi7gVis3Lc=;
 b=cV4vnLZbO9huW2/0n7GwE6JNt5TGVEc9H4KNmIBe2yDGOAnioOGg/wH1BvZvRgstaZ
 iY9+1GbMNvuHbJsnf7Ps54zcJDZ4PilBznk+u4zZ+URiMOhGsNfw11iGxajHlfyn/DSs
 1oZjsJ2bmMbXuvGvufVtEF6kberlgmNqkZWh8Y9afhzTCG+U12bQ2Es7MItguJ+1KUVx
 X+DBK+dJkKTxOpWsNAf4TM5TZhzC58KSsz/Y8DxmLqjFgGSKIqOCNBdFvNHIJvKYZcb/
 hy/FN4r10h+77JyPYlCM04chEsNLx+1lYdJbGBGkMVupHcE3MRqqnzTU/n9OaYtfTd0f
 LUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750331; x=1701355131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVWcie4bmzaB0d5l/X4mRechmHi5GyH0Jpi7gVis3Lc=;
 b=k82Bw/PCUCZKYYOYIHh2tZxbcovLoPqIRB2oCBSY4xu4h5l/JG1D8ktt/OThyYdCmC
 o6dRe4N7vxcwJJZEDGKsSNi8sknTPs+vrnXzmppxAv6dVUkqk/N1M4WQtBq0iGuZeRvL
 bTF7zfIMJhTs3DmCI4nCJINZs6FShf3IiO6HXxpMDyQ9qxTNN5NApELp/7ziTicuF3lp
 3Usq2A5u121cmZBa9wJbmRIOtmw2ZQfc2n31TSubS73lThvScdFBYnI0GI0B7bFGO1rM
 MczZJ/pBjiSmwsOEdl9rA3Rz9nxXq4Ju8/E316XTpqiOgJZNaaIP1TScs8RNOgGwM8dK
 GwKg==
X-Gm-Message-State: AOJu0YxhFg+aZuOACoNCfE7NtLCRhclfb1RbQgSsKU3HxNXz8Io2dVkO
 NxHZ4NWso1YFqQEVOscbYorigQ==
X-Google-Smtp-Source: AGHT+IEpX1y7SN/hJmTz+zAmS/RU7oP0L2JiqaWEQ5l2Bd8Dct/1h/4XKoArZOGdk4FIc1qHN8d4ig==
X-Received: by 2002:a5d:5644:0:b0:32d:81fe:7104 with SMTP id
 j4-20020a5d5644000000b0032d81fe7104mr3649375wrw.63.1700750330739; 
 Thu, 23 Nov 2023 06:38:50 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 cr6-20020a05600004e600b00332cc24a59bsm1802540wrb.109.2023.11.23.06.38.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 06:38:50 -0800 (PST)
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
Subject: [PATCH-for-9.0 v2 4/8] hw: Simplify accesses to the
 CPUState::'start-powered-off' property
Date: Thu, 23 Nov 2023 15:38:08 +0100
Message-ID: <20231123143813.42632-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123143813.42632-1-philmd@linaro.org>
References: <20231123143813.42632-1-philmd@linaro.org>
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

The 'start-powered-off' property has been added to ARM CPUs in
commit 5de164304a ("arm: Allow secondary KVM CPUs to be booted
via PSCI"), then eventually got generalized to all CPUs in commit
c1b701587e ("target/arm: Move start-powered-off property to generic
CPUState"). Since all CPUs have it, no need to check whether it is
available. Updating this property can't fail, so use &error_abort.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armsse.c  | 6 ++----
 hw/arm/armv7m.c  | 8 ++------
 hw/arm/bcm2836.c | 8 ++------
 hw/mips/cps.c    | 7 +++----
 hw/ppc/e500.c    | 2 +-
 hw/sparc/sun4m.c | 2 +-
 6 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 31acbf7347..4672df180f 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1022,10 +1022,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          * later if necessary.
          */
         if (extract32(info->cpuwait_rst, i, 1)) {
-            if (!object_property_set_bool(cpuobj, "start-powered-off", true,
-                                          errp)) {
-                return;
-            }
+            object_property_set_bool(cpuobj, "start-powered-off", true,
+                                     &error_abort);
         }
         if (!s->cpu_fpu[i]) {
             if (!object_property_set_bool(cpuobj, "vfp", false, errp)) {
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index d10abb36a8..cbaebe9bf8 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -318,12 +318,6 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "start-powered-off")) {
-        if (!object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
-                                      s->start_powered_off, errp)) {
-            return;
-        }
-    }
     if (object_property_find(OBJECT(s->cpu), "vfp")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, errp)) {
             return;
@@ -334,6 +328,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
+                             s->start_powered_off, &error_abort);
 
     /*
      * Real M-profile hardware can be configured with a different number of
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 289c30e6b6..b0674a22a6 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -135,12 +135,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                                 bc->peri_base, &error_abort);
 
         /* start powered off if not enabled */
-        if (!object_property_set_bool(OBJECT(&s->cpu[n].core),
-                                      "start-powered-off",
-                                      n >= s->enabled_cpus,
-                                      errp)) {
-            return;
-        }
+        object_property_set_bool(OBJECT(&s->cpu[n].core), "start-powered-off",
+                                 n >= s->enabled_cpus, &error_abort);
 
         if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
             return;
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index b6612c1762..4f12e23ab5 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -78,10 +78,9 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         CPUMIPSState *env = &cpu->env;
 
         /* All VPs are halted on reset. Leave powering up to CPC. */
-        if (!object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
-                                      errp)) {
-            return;
-        }
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
         /* All cores use the same clock tree */
         qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 384226296b..566f1200dd 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -955,7 +955,7 @@ void ppce500_init(MachineState *machine)
          * when implementing non-kernel boot.
          */
         object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
-                                 &error_fatal);
+                                 &error_abort);
         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
 
         if (!firstenv) {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 17bf5f2879..64895aebe3 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -804,7 +804,7 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
 
     qemu_register_reset(sun4m_cpu_reset, cpu);
     object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
-                             &error_fatal);
+                             &error_abort);
     qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
     cpu_sparc_set_id(env, id);
     *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
-- 
2.41.0


