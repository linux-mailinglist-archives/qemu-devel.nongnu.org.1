Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287982A198
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeex-0000QH-Ps; Wed, 10 Jan 2024 14:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeu-0008Se-Cu
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNees-0002TT-If
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e4d515cdeso26627585e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916476; x=1705521276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aLkQ6Ut0DrpuWjeMaf8bgkuaiZex3z3XI0gOydKSEI=;
 b=M9s/nf1nMpIU3t5O5i6mBaKfW4RnMdTuo4w8N0xJCe/8PedQHllF2y+be3LAEt+V2G
 UPwE896s2tqPYmUXlC+7ifcHRFReei2zygSIucksMA5SX4YXKggCrNESbJwNX2IIFF6S
 M4oGdZp+uuMWoBNkv/URqdlbpqCacAtFte/V4KKGt3mN0O8lQQLlder9WygGPy8uNxzF
 V23O+oK8+FdOSafpOXX0Jlw+iDiA+65POjR1jT1wSZO4ixwMMnLjsZyljfYm8hA2NPIb
 5HjDJavOwNntjpMXYERGqsVpDDw3tH57lRq9MnE8PnWGdlAll7FeWvCo9NfljJZ5xyIT
 41Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916476; x=1705521276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2aLkQ6Ut0DrpuWjeMaf8bgkuaiZex3z3XI0gOydKSEI=;
 b=bjPEsUNr9WRIcWxgGhBRcDNmFdcLjda1/7Mn1Vdi0EZGPhBj2guKV4JfdZQTFl1wXw
 JGVMaa6g8H3do2qbioxPr1mypROgbakuRXKzHEx8ECI3ClrwbH22oC46CZxNseLGaLRp
 2XqBmuJALpBqBSJy8HfP1o2Qdc0e+FtNaSMFdZzLI2o+OkWnYrAe6yZU/BzWJ+p6ORaN
 BGCjwgcoYUVnf1VuVx5uEm8hmp3/I/1CsPiacPj7c4WbNcM6LHwYKYuaVL1D0ImtnT70
 PrdFW3kbGZ5gd4aNQeZhaxjbcxufBw1wrnrxOaxUwPc1As8n9taqPN6Ubvx+oaCrngEI
 5eOg==
X-Gm-Message-State: AOJu0YyTppRal3MVRPjmFs3ghtK/+AWsVMZ+73ed1t9vAK6ewbeBGs2V
 CBVKvjIGJFINuw1AYX0eCKKSc+UuM8NQsy65fK4faRguu5Y=
X-Google-Smtp-Source: AGHT+IFKUbzd4ecP28gaTWgAI0jnNxOVp9oueGbDldM4JPQ5uZIegpdTaJtARzMAyFP4nZRer9jpnQ==
X-Received: by 2002:a05:600c:500e:b0:40e:47c2:1b5a with SMTP id
 n14-20020a05600c500e00b0040e47c21b5amr860534wmr.4.1704916476525; 
 Wed, 10 Jan 2024 11:54:36 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 fc19-20020a05600c525300b0040d839e7bb3sm3267484wmb.19.2024.01.10.11.54.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/14] hw/arm: Prefer arm_feature(EL2) over
 object_property_find(has_el2)
Date: Wed, 10 Jan 2024 20:53:23 +0100
Message-ID: <20240110195329.3995-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The "has_el2" property is added to ARMCPU when the
ARM_FEATURE_EL2 feature is available. Rather than
checking whether the QOM property is present, directly
check the feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/vexpress.c  | 3 ++-
 hw/arm/virt.c      | 2 +-
 hw/cpu/a15mpcore.c | 9 ++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

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
index afe3897901..7e456375e3 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -74,9 +74,12 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
                                                        &error_abort));
         }
         /* Similarly for virtualization support */
-        has_el2 = object_property_find(cpuobj, "has_el2") &&
-            object_property_get_bool(cpuobj, "has_el2", &error_abort);
-        qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
+        has_el2 = arm_feature(cpu_env(cpu), ARM_FEATURE_EL2);
+        if (has_el2) {
+            qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
+                              object_property_get_bool(cpuobj, "has_el2",
+                                                       &error_abort));
+        }
     }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
-- 
2.41.0


