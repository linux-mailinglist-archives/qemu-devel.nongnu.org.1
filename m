Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2C75FE29
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:45:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzb7-0007Di-F0; Mon, 24 Jul 2023 13:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNzay-00079r-Mx
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:43:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNzau-0004GL-QZ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:43:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso45638795e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690220618; x=1690825418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CsX3Xy3TC+raCnXOzd/KXzQRyX2HQEh3TsqIAfXVpmk=;
 b=A602x1ZERoIHMuD51R7ZvuIyH0HFqy2/bRq2cY/mVAmPT55VYI9GaPblZPfck48CvZ
 IUSW15Ba5JJvG1ZZwy/Z+ne+Wmj8YhqlBQjTy5N48164MsSzMVMuwwY+UPO4iHz5+Jsz
 It7fTdWltyhz2CRtvipNnQ53xIOIDrPwheP95MDwm2mPooBQJE4/mcbC4z6REvQ+bvej
 IlyGy0gN8arHbQDYHVdPDMgWHZC7GdOR8Si9izwIc1zG6yoJ9amRfxpmCFDzzuqC0f1d
 zaN6DN5hM4C/bYWynaXl9r4l+SndJ+sgSOpVHcKTn4+k3bp3OBKjC2Gdv3H8x3cygape
 37DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690220618; x=1690825418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CsX3Xy3TC+raCnXOzd/KXzQRyX2HQEh3TsqIAfXVpmk=;
 b=GOwZzqdbVCcBvAW5Kqq91LYJGi1aRRMMeK/ano3ka7+kUjIAo0vnDtg9JY9yGGWhFU
 xGzKixs2/WT9fAmpMwP8o6UL6o5mTkNW85YYkAtdttvCqKm3B+kIZnOIv3yOGR012AqY
 sw5Hj8LYAYE/SYgAEZmo1hHNIOkK/JwMWQmon+E0bnglHXdc8nkEDo6zxQ3xJdft2PR0
 RlpRSb2618ZR/R8Zj42S9kxYtOE6u1rCRHdIvebrmacR6omJy9+br/DYH78RiLbTxcWG
 sI/0c2zAbvH93HJnvQtQlU8RU5RRo5BePwY6qm2P20tCuIzRW/t8fiZtHQJ/5l7rd/cl
 j8iA==
X-Gm-Message-State: ABy/qLbymf1NGqANWwUftdlidD+M7EkEFd1827tH5jHAXfQwNqyolVLD
 kfcCpVdZ3FbZYUoeZxUY6y+WxUwn9mmvglmVd40=
X-Google-Smtp-Source: APBJJlHhZhViAjC3ds3EQmoccV3W5XckQrpx/9e6Nih7VwGL1NhxeiH1A/IK83Jq/7umNJxnhgnNGQ==
X-Received: by 2002:a7b:c851:0:b0:3fb:b5cb:1130 with SMTP id
 c17-20020a7bc851000000b003fbb5cb1130mr8417154wml.34.1690220618333; 
 Mon, 24 Jul 2023 10:43:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a0560001b0300b0030e52d4c1bcsm13687423wrz.71.2023.07.24.10.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 10:43:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.2 1/3] target/arm: Do all "ARM_FEATURE_X implies Y"
 checks in post_init
Date: Mon, 24 Jul 2023 18:43:33 +0100
Message-Id: <20230724174335.2150499-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724174335.2150499-1-peter.maydell@linaro.org>
References: <20230724174335.2150499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Where architecturally one ARM_FEATURE_X flag implies another
ARM_FEATURE_Y, we allow the CPU init function to only set X, and then
set Y for it.  Currently we do this in two places -- we set a few
flags in arm_cpu_post_init() because we need them to decide which
properties to create on the CPU object, and then we do the rest in
arm_cpu_realizefn().  However, this is fragile, because it's easy to
add a new property and not notice that this means that an X-implies-Y
check now has to move from realize to post-init.

As a specific example, the pmsav7-dregion property is conditional
on ARM_FEATURE_PMSA && ARM_FEATURE_V7, which means it won't appear
on the Cortex-M33 and -M55, because they set ARM_FEATURE_V8 and
rely on V8-implies-V7, which doesn't happen until the realizefn.

Move all of these X-implies-Y checks into a new function, which
we call at the top of arm_cpu_post_init(), so the feature bits
are available at that point.

This does now give us the reverse issue, that if there's a feature
bit which is enabled or disabled by the setting of a property then
then X-implies-Y features that are dependent on that property need to
be in realize, not in this new function.  But the only one of those
is the "EL3 implies VBAR" which is already in the right place, so
putting things this way round seems better to me.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 176 +++++++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 82 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 69e2bde3c2d..58301c4b7d8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1356,17 +1356,105 @@ unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
       NANOSECONDS_PER_SECOND / cpu->gt_cntfrq_hz : 1;
 }
 
+static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    bool no_aa32 = false;
+    /*
+     * Some features automatically imply others: set the feature
+     * bits explicitly for these cases.
+     */
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        set_feature(env, ARM_FEATURE_PMSA);
+    }
+
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            set_feature(env, ARM_FEATURE_V7);
+        } else {
+            set_feature(env, ARM_FEATURE_V7VE);
+        }
+    }
+
+    /*
+     * There exist AArch64 cpus without AArch32 support.  When KVM
+     * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
+     * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
+     * As a general principle, we also do not make ID register
+     * consistency checks anywhere unless using TCG, because only
+     * for TCG would a consistency-check failure be a QEMU bug.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        no_aa32 = !cpu_isar_feature(aa64_aa32, cpu);
+    }
+
+    if (arm_feature(env, ARM_FEATURE_V7VE)) {
+        /* v7 Virtualization Extensions. In real hardware this implies
+         * EL2 and also the presence of the Security Extensions.
+         * For QEMU, for backwards-compatibility we implement some
+         * CPUs or CPU configs which have no actual EL2 or EL3 but do
+         * include the various other features that V7VE implies.
+         * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
+         * Security Extensions is ARM_FEATURE_EL3.
+         */
+        assert(!tcg_enabled() || no_aa32 ||
+               cpu_isar_feature(aa32_arm_div, cpu));
+        set_feature(env, ARM_FEATURE_LPAE);
+        set_feature(env, ARM_FEATURE_V7);
+    }
+    if (arm_feature(env, ARM_FEATURE_V7)) {
+        set_feature(env, ARM_FEATURE_VAPA);
+        set_feature(env, ARM_FEATURE_THUMB2);
+        set_feature(env, ARM_FEATURE_MPIDR);
+        if (!arm_feature(env, ARM_FEATURE_M)) {
+            set_feature(env, ARM_FEATURE_V6K);
+        } else {
+            set_feature(env, ARM_FEATURE_V6);
+        }
+
+        /* Always define VBAR for V7 CPUs even if it doesn't exist in
+         * non-EL3 configs. This is needed by some legacy boards.
+         */
+        set_feature(env, ARM_FEATURE_VBAR);
+    }
+    if (arm_feature(env, ARM_FEATURE_V6K)) {
+        set_feature(env, ARM_FEATURE_V6);
+        set_feature(env, ARM_FEATURE_MVFR);
+    }
+    if (arm_feature(env, ARM_FEATURE_V6)) {
+        set_feature(env, ARM_FEATURE_V5);
+        if (!arm_feature(env, ARM_FEATURE_M)) {
+            assert(!tcg_enabled() || no_aa32 ||
+                   cpu_isar_feature(aa32_jazelle, cpu));
+            set_feature(env, ARM_FEATURE_AUXCR);
+        }
+    }
+    if (arm_feature(env, ARM_FEATURE_V5)) {
+        set_feature(env, ARM_FEATURE_V4T);
+    }
+    if (arm_feature(env, ARM_FEATURE_LPAE)) {
+        set_feature(env, ARM_FEATURE_V7MP);
+    }
+    if (arm_feature(env, ARM_FEATURE_CBAR_RO)) {
+        set_feature(env, ARM_FEATURE_CBAR);
+    }
+    if (arm_feature(env, ARM_FEATURE_THUMB2) &&
+        !arm_feature(env, ARM_FEATURE_M)) {
+        set_feature(env, ARM_FEATURE_THUMB_DSP);
+    }
+}
+
 void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    /* M profile implies PMSA. We have to do this here rather than
-     * in realize with the other feature-implication checks because
-     * we look at the PMSA bit to see if we should add some properties.
+    /*
+     * Some features imply others. Figure this out now, because we
+     * are going to look at the feature bits in deciding which
+     * properties to add.
      */
-    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        set_feature(&cpu->env, ARM_FEATURE_PMSA);
-    }
+    arm_cpu_propagate_feature_implications(cpu);
 
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
@@ -1588,7 +1676,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUARMState *env = &cpu->env;
     int pagebits;
     Error *local_err = NULL;
-    bool no_aa32 = false;
 
     /* Use pc-relative instructions in system-mode */
 #ifndef CONFIG_USER_ONLY
@@ -1869,81 +1956,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->isar.id_isar3 = u;
     }
 
-    /* Some features automatically imply others: */
-    if (arm_feature(env, ARM_FEATURE_V8)) {
-        if (arm_feature(env, ARM_FEATURE_M)) {
-            set_feature(env, ARM_FEATURE_V7);
-        } else {
-            set_feature(env, ARM_FEATURE_V7VE);
-        }
-    }
-
-    /*
-     * There exist AArch64 cpus without AArch32 support.  When KVM
-     * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
-     * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
-     * As a general principle, we also do not make ID register
-     * consistency checks anywhere unless using TCG, because only
-     * for TCG would a consistency-check failure be a QEMU bug.
-     */
-    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        no_aa32 = !cpu_isar_feature(aa64_aa32, cpu);
-    }
-
-    if (arm_feature(env, ARM_FEATURE_V7VE)) {
-        /* v7 Virtualization Extensions. In real hardware this implies
-         * EL2 and also the presence of the Security Extensions.
-         * For QEMU, for backwards-compatibility we implement some
-         * CPUs or CPU configs which have no actual EL2 or EL3 but do
-         * include the various other features that V7VE implies.
-         * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
-         * Security Extensions is ARM_FEATURE_EL3.
-         */
-        assert(!tcg_enabled() || no_aa32 ||
-               cpu_isar_feature(aa32_arm_div, cpu));
-        set_feature(env, ARM_FEATURE_LPAE);
-        set_feature(env, ARM_FEATURE_V7);
-    }
-    if (arm_feature(env, ARM_FEATURE_V7)) {
-        set_feature(env, ARM_FEATURE_VAPA);
-        set_feature(env, ARM_FEATURE_THUMB2);
-        set_feature(env, ARM_FEATURE_MPIDR);
-        if (!arm_feature(env, ARM_FEATURE_M)) {
-            set_feature(env, ARM_FEATURE_V6K);
-        } else {
-            set_feature(env, ARM_FEATURE_V6);
-        }
-
-        /* Always define VBAR for V7 CPUs even if it doesn't exist in
-         * non-EL3 configs. This is needed by some legacy boards.
-         */
-        set_feature(env, ARM_FEATURE_VBAR);
-    }
-    if (arm_feature(env, ARM_FEATURE_V6K)) {
-        set_feature(env, ARM_FEATURE_V6);
-        set_feature(env, ARM_FEATURE_MVFR);
-    }
-    if (arm_feature(env, ARM_FEATURE_V6)) {
-        set_feature(env, ARM_FEATURE_V5);
-        if (!arm_feature(env, ARM_FEATURE_M)) {
-            assert(!tcg_enabled() || no_aa32 ||
-                   cpu_isar_feature(aa32_jazelle, cpu));
-            set_feature(env, ARM_FEATURE_AUXCR);
-        }
-    }
-    if (arm_feature(env, ARM_FEATURE_V5)) {
-        set_feature(env, ARM_FEATURE_V4T);
-    }
-    if (arm_feature(env, ARM_FEATURE_LPAE)) {
-        set_feature(env, ARM_FEATURE_V7MP);
-    }
-    if (arm_feature(env, ARM_FEATURE_CBAR_RO)) {
-        set_feature(env, ARM_FEATURE_CBAR);
-    }
-    if (arm_feature(env, ARM_FEATURE_THUMB2) &&
-        !arm_feature(env, ARM_FEATURE_M)) {
-        set_feature(env, ARM_FEATURE_THUMB_DSP);
-    }
 
     /*
      * We rely on no XScale CPU having VFP so we can use the same bits in the
-- 
2.34.1


