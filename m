Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9434380F2D1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5gQ-0007EM-OS; Tue, 12 Dec 2023 11:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gC-0006cZ-Ox
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:24 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5g8-0007io-9r
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:19 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3334254cfa3so3344242f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398733; x=1703003533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPUJ99e93udkPbt97Gx+2JACKyskq6RNq0t/1l6oyqU=;
 b=G1pfbBJHJq9G1F3Vo+0oaEg2M+ORqEw+XvgrfWfQDq1Bh/dDW4FqMYkcMNKA/M6Fye
 QdkFEvNtn4+6hfB3SqQZ7tTc67YF164wDtwySvN/glRRSD7sihH4ow5NSwcp5nV5VtRl
 tv90/jymCSgYqEgLNumtptH+0n2w4VDr6/k/YrfvkT5pomjb5wVk5bwOyKDrJ5jcxO8P
 XY5NMxM0pTbifQI5eHGRiuxLsXx+dCN6oNtdda6Ge887XkHHWV0xW5G2NEsSgLaEJ2bW
 vJHqmlRYaXAtcql/c/69UoR/pie+PeMp2L1JPuH0DSN77aE3dmF3PWoBh7Oi2n0blYuK
 BZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398733; x=1703003533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPUJ99e93udkPbt97Gx+2JACKyskq6RNq0t/1l6oyqU=;
 b=AMajFxfOkyRC7snrrP9w3DwOlNmbKlFTpy0KWheNm9EZAul2KJi/Z2h/OV982c1Tc0
 Vks8UZwFU8BGoh/7lAS6slvVY2ygwkUpgjAveSAbfr8dRRY3fnu8dJuiVTbTmE/SebT9
 q8Q26HjijjzBngepMTEJ/JrO2Pctt6RsYSCst3ZdguCtvfgGlpBmnnLREPnSBibCqMA9
 mct1m99kt3OMYgToHGKtMVybEF+kXhRsJzUiTVdhVwnDVqqqUjSC+ly92SHbF54J6jH/
 WOEbjLpK906DCK8PZiqzvhKoDhaXeaHRnqE7L8wwj7zzeqChSNccGxm/oIOXEt5vedtx
 bi0Q==
X-Gm-Message-State: AOJu0YwoOJ3oBRmQLH/OeFaOaQq+hETLN2OSXgA0eQzf4TyBf5FTXG34
 kRZNsWWg/OMs3jhhqt9slRQTnDmW1KXSsM5ZZ7s=
X-Google-Smtp-Source: AGHT+IEps7EKdkb5++jvaAQDg+UtZgye8JE+a9Lp+BPfBbHaJAf6QR1LQY67ntXlsyC85fmm0qc8CA==
X-Received: by 2002:adf:ffc8:0:b0:336:3555:346d with SMTP id
 x8-20020adfffc8000000b003363555346dmr608972wrs.13.1702398733539; 
 Tue, 12 Dec 2023 08:32:13 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff90c000000b00333359b522dsm11213469wrr.77.2023.12.12.08.32.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:32:13 -0800 (PST)
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
Subject: [PATCH 21/33] hw/cpu/arm: Create CPUs once in MPCore parent
Date: Tue, 12 Dec 2023 17:29:21 +0100
Message-ID: <20231212162935.42910-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
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

Add support for creating the MPCore CPU cluster in the
abstract TYPE_CORTEX_MPCORE_PRIV parent realize() handler.

Only do so if the 'cpu-type' property is set, so current
behavior is not modified. Boards will be converted by
setting this property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cpu/cortex_mpcore.h | 12 +++++
 hw/cpu/cortex_mpcore.c         | 88 ++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index 4e1aa9f7f7..9a4fc2404e 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -16,6 +16,7 @@
 #include "hw/misc/a9scu.h"
 #include "hw/timer/a9gtimer.h"
 #include "hw/timer/arm_mptimer.h"
+#include "target/arm/cpu-qom.h"
 
 /*
  * This is a model of the Arm Cortex-A MPCore family of hardware.
@@ -93,13 +94,24 @@ struct CortexMPPrivState {
     SysBusDevice parent_obj;
 
     MemoryRegion container;
+    ARMCPU *cpu[4];
     GICState gic;
 
     /* Properties */
+    uint8_t cluster_id;
     uint32_t num_cores;
 
+    char *cpu_type;
     bool cpu_has_el3;
     bool cpu_has_el2;
+    bool cpu_has_vfp_d32;
+    bool cpu_has_neon;
+    uint64_t cpu_freq_hz;
+    uint64_t cpu_midr;
+    uint32_t cpu_psci_conduit;
+    uint64_t cpu_reset_cbar;
+    bool cpu_reset_hivecs;
+    MemoryRegion *cpu_memory;
 
     uint32_t gic_spi_num;
 };
diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
index 75324268fa..65309636d7 100644
--- a/hw/cpu/cortex_mpcore.c
+++ b/hw/cpu/cortex_mpcore.c
@@ -12,6 +12,7 @@
 #include "hw/cpu/cortex_mpcore.h"
 #include "hw/irq.h"
 #include "sysemu/kvm.h"
+#include "target/arm/cpu.h"
 
 static void cortex_mpcore_priv_set_irq(void *opaque, int irq, int level)
 {
@@ -50,6 +51,12 @@ static void cortex_mpcore_priv_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->num_cores > ARRAY_SIZE(s->cpu)) {
+        error_setg(errp,
+                   "At most %zu CPU cores are supported", ARRAY_SIZE(s->cpu));
+        return;
+    }
+
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cores);
     qdev_prop_set_uint32(gicdev, "num-irq", s->gic_spi_num);
     if (k->gic_priority_bits) {
@@ -75,14 +82,95 @@ static void cortex_mpcore_priv_realize(DeviceState *dev, Error **errp)
 
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, cortex_mpcore_priv_set_irq, s->gic_spi_num - 32);
+
+
+    /* CPU */
+    if (!s->cpu_type) {
+        return;
+    }
+    for (int i = 0; i < s->num_cores; i++) {
+        Object *cpuobj;
+
+        cpuobj = object_new(s->cpu_type);
+        object_property_add_child(OBJECT(dev), "cpu[*]", OBJECT(cpuobj));
+        object_unref(cpuobj);
+        s->cpu[i] = ARM_CPU(cpuobj);
+
+        object_property_set_bool(cpuobj, "neon", s->cpu_has_neon,
+                                &error_abort);
+        object_property_set_bool(cpuobj, "vfp-d32", s->cpu_has_vfp_d32,
+                                &error_abort);
+        if (object_property_find(cpuobj, "has_el3")) {
+            object_property_set_bool(cpuobj, "has_el3", s->cpu_has_el3,
+                                     &error_abort);
+        }
+        if (object_property_find(cpuobj, "has_el2")) {
+            object_property_set_bool(cpuobj, "has_el2", s->cpu_has_el2,
+                                     &error_abort);
+        }
+        if (s->cpu_freq_hz) {
+            object_property_set_int(cpuobj, "cntfrq", s->cpu_freq_hz,
+                                    &error_abort);
+        }
+        object_property_set_int(cpuobj, "midr", s->cpu_midr, &error_abort);
+        object_property_set_bool(cpuobj, "reset-hivecs", s->cpu_reset_hivecs,
+                                 &error_abort);
+        if (s->num_cores == 1) {
+            /* On uniprocessor, the CBAR is set to 0 */
+        } else if (object_property_find(cpuobj, "reset-cbar")) {
+            object_property_set_int(cpuobj, "reset-cbar",
+                                    s->cpu_reset_cbar, &error_abort);
+        }
+        if (i > 0) {
+            /*
+             * Secondary CPUs start in powered-down state (and can be
+             * powered up via the SRC system reset controller)
+             */
+            object_property_set_bool(cpuobj, "start-powered-off", true,
+                                     &error_abort);
+        }
+        if (s->cluster_id) {
+            object_property_set_int(cpuobj, "mp-affinity",
+                                    (s->cluster_id << ARM_AFF1_SHIFT) | i,
+                                    &error_abort);
+        } else {
+            object_property_set_int(cpuobj, "mp-affinity",
+                                    arm_cpu_mp_affinity(i, s->num_cores),
+                                    &error_abort);
+        }
+        object_property_set_int(cpuobj, "psci-conduit",
+                                s->cpu_psci_conduit, &error_abort);
+        if (s->cpu_memory) {
+            object_property_set_link(cpuobj, "memory",
+                                     OBJECT(s->cpu_memory), &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
 }
 
 static Property cortex_mpcore_priv_properties[] = {
+    DEFINE_PROP_UINT8("cluster-id", CortexMPPrivState, cluster_id, 0),
     DEFINE_PROP_UINT32("num-cores", CortexMPPrivState, num_cores, 1),
     DEFINE_PROP_UINT32("num-cpu", CortexMPPrivState, num_cores, 1), /* alias */
 
+    DEFINE_PROP_STRING("cpu-type", CortexMPPrivState, cpu_type),
     DEFINE_PROP_BOOL("cpu-has-el3", CortexMPPrivState, cpu_has_el3, true),
     DEFINE_PROP_BOOL("cpu-has-el2", CortexMPPrivState, cpu_has_el2, false),
+    DEFINE_PROP_BOOL("cpu-has-vfp-d32", CortexMPPrivState, cpu_has_vfp_d32,
+                     true),
+    DEFINE_PROP_BOOL("cpu-has-neon", CortexMPPrivState, cpu_has_neon, true),
+    DEFINE_PROP_UINT64("cpu-freq-hz", CortexMPPrivState, cpu_freq_hz, 0),
+    DEFINE_PROP_UINT64("cpu-midr", CortexMPPrivState, cpu_midr, 0),
+    DEFINE_PROP_UINT32("cpu-psci-conduit", CortexMPPrivState, cpu_psci_conduit,
+                       QEMU_PSCI_CONDUIT_DISABLED),
+    DEFINE_PROP_UINT64("cpu-reset-cbar", CortexMPPrivState, cpu_reset_cbar, 0),
+    DEFINE_PROP_BOOL("cpu-reset-hivecs", CortexMPPrivState, cpu_reset_hivecs,
+                     false),
+    DEFINE_PROP_LINK("cpu-memory", CortexMPPrivState, cpu_memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 
     DEFINE_PROP_UINT32("gic-spi-num", CortexMPPrivState, gic_spi_num, 0),
     DEFINE_PROP_UINT32("num-irq", CortexMPPrivState, gic_spi_num, 0), /* alias */
-- 
2.41.0


