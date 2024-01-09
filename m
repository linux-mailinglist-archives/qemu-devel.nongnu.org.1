Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E3828C27
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:11:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZJ-0004Ju-RM; Tue, 09 Jan 2024 13:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYm-0002wj-80
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:45 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYk-0004Pk-31
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:43 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33761e291c1so1894867f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823838; x=1705428638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzKRv8rSt0g4enhYH8TEbkEK8L7Z/ollqT46K3u21b8=;
 b=v8HxgRQN9EeB06GcX5hDLJ/nJIVOVpjJ+53DlAJRyrS80bSSmW4Yb+xXMSiNL5hXO0
 17OPdlnPNvb2MeOOlOZWGKAPcInbtrKAfQWAHehraAy+gE5enCZozL6x16shc28NVjX7
 j0/2MMC0c9bFzorPiB5rvgpPRUdtAI6wozoiEXClDJ1+CDzgIMY3fpaSjoIiLbmedMst
 7HHjcOMH7AfPfM5R3qTR1TADJACHWU0RVrOisPg1h7hIkG5uJJAI8keSpBp7gbtKQCiw
 x0Gs8n6M+UDl+NiRvMAn1JuVqOS34rscO2Fcx73YzqFyDam6RX3NB9qXOgfbIHWjSO0p
 arXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823838; x=1705428638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzKRv8rSt0g4enhYH8TEbkEK8L7Z/ollqT46K3u21b8=;
 b=xObnmBE3tPoLvJLb3UMUmlsKAiTbO1B8iTDGcdDM6M1+HWlOXAVy7JuMo3Du/LrZsR
 evwwxICZLm6R/Ezy595b7X8Pde7BdLO9rqhifvNtXvD5g/ULY07eKsQwMzcTEk2MYL2c
 JxO4Om8vIyKjmWz9Zar3b+Vgq3jpmnWb92Fym4kNY1SIKBxqHlOdR5cc8UWhGLQOLVkY
 hjuN5ZElVejzG3tugSA4lqLg9lxi6HkjWAeiU5I/XtzVbA0l6ZybLB3UIWkAixK6VPvi
 7W6zOhhvG/DMcGnjifieRDGzRARjThr4kd4rn3T65R0mncFm4MbV5sr4peNHr0fFyJ2v
 kyXw==
X-Gm-Message-State: AOJu0YwFoVHzyDWXxHCEDLn4vC7HIijQTSWKVcIreZBZBCB+zYxdPhFT
 S8C6MgBKVU+qTbsrZrnISILbk87pOSX7TUACnnfqQ3OArxUHoA==
X-Google-Smtp-Source: AGHT+IH/3kbQYMH94lAPMzxFc6qC/itYnaoRJaclfEFfMxujnUkK+tg1K29wr/U1N6iYR3akTCtTTg==
X-Received: by 2002:a05:600c:298c:b0:40d:5aea:c89b with SMTP id
 r12-20020a05600c298c00b0040d5aeac89bmr648301wmd.64.1704823838301; 
 Tue, 09 Jan 2024 10:10:38 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 t6-20020a05600c198600b0040e4a7a7ca3sm4385674wmq.43.2024.01.09.10.10.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/14] hw/arm: Prefer arm_feature(EL2) over
 object_property_find(has_el2)
Date: Tue,  9 Jan 2024 19:09:25 +0100
Message-ID: <20240109180930.90793-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
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

The "has_el2" property is added to ARMCPU when the
ARM_FEATURE_EL2 feature is available. Rather than
checking whether the QOM property is present, directly
check the feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/vexpress.c  | 3 ++-
 hw/arm/virt.c      | 2 +-
 hw/cpu/a15mpcore.c | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index fd981f4c33..753a645c05 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -218,12 +218,13 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
     /* Create the actual CPUs */
     for (n = 0; n < smp_cpus; n++) {
         Object *cpuobj = object_new(cpu_type);
+        ARMCPU *cpu = ARM_CPU(cpuobj);
 
         if (!secure) {
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
         }
         if (!virt) {
-            if (object_property_find(cpuobj, "has_el2")) {
+            if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
                 object_property_set_bool(cpuobj, "has_el2", false, NULL);
             }
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2793121cb4..35eb01a3dc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2146,7 +2146,7 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
         }
 
-        if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
+        if (!vms->virt &&  arm_feature(cpu_env(cs), ARM_FEATURE_EL2)) {
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index cebfe142cf..1fa079b3b8 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -73,9 +73,11 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_bit(gicdev, "has-security-extensions", true);
         }
         /* Similarly for virtualization support */
-        has_el2 = object_property_find(cpuobj, "has_el2") &&
+        has_el2 = arm_feature(cpu_env(cpu), ARM_FEATURE_EL2);
+        if (has_el2) {
             object_property_get_bool(cpuobj, "has_el2", &error_abort);
-        qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
+            qdev_prop_set_bit(gicdev, "has-virtualization-extensions", true);
+        }
     }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
-- 
2.41.0


