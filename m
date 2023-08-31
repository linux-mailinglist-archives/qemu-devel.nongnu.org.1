Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418978EB0A
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:49:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBQ-00048g-Jo; Thu, 31 Aug 2023 06:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfBB-0003dj-DE
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB6-00045I-I6
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso6206435e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478730; x=1694083530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iww7+LJWf4cwL5sY9fwZhO6FiOKCwKe0fmXzE0E9OwM=;
 b=JvD3K4bT+a3SnmJWTGNZg1XEjb9X+IyJfGq+qdS3YhsYOAsxvOzLpCbEoontKIUoNF
 zRPr9m6fGJNzhovYRqCujmC6rLij05RmRh3/MEBsKVByBf8tk7YwX3FCt1b4nIlKoHIA
 4LEZRVLqR6N/gDbbYJpy7HFMdvxcDuFLd5TMhp7HwuccusClv2PRoAE8LLU7xKQWROc5
 OkdNWvo7kiCzZKN4kH8EDGXz+8JvJ3ntYkW9RqFspKzfpsIPMbTM9CBveXcVHD4ns2Y1
 lQgRHso5oli9w+XtULmjmobSx/47cRgnWaL9GKqDHndaBh2sGquuS5Ah2WwYZ/S/BRZA
 XYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478730; x=1694083530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iww7+LJWf4cwL5sY9fwZhO6FiOKCwKe0fmXzE0E9OwM=;
 b=ILIWrTWU6t/raDE8/9pVVspxT2/dMewt88vphjk1GcAfFYhUahFp76SPj76AdeZl0f
 xUOBoOhPs7loFXVDMnPLyYyXtqvhYFbbZmDdSP7f6fZLq5jP5k5aBvK7hcic/9Iyr9AN
 r49L0oi0snNp/NWe+GzrURHH8k6CfVdfkcbr/VZc35SLr1B0bFg3AL8ln4jvWGy7g59v
 4qTt84U1LzStv8OOm2bQYuO+HUNudlX7gL5psj21k8md1/VrdR7uQt6b/TOD32fxy8FP
 1Zk4FlYJZJ4KEMCAHT1rms8WokT2G2CMxPmRuXADDtSagxLwTByDiCu+Ve6ksSOCgyNx
 3Fgg==
X-Gm-Message-State: AOJu0YyYpBeS75jaKbQUpIToWLFEGWftwj0uGiCJNEsFm5XvkE7tb+5w
 F2xr62p8yiOmHAUFDKZeg5jIEvz/Ti6S051A7VM=
X-Google-Smtp-Source: AGHT+IGBwB7s0OtFR+0BjcIQ02fAgU/8Ixse5vnBCYQw5I3h5CfmSEjB8XOSmyqi5SZmmrBN4PMolw==
X-Received: by 2002:adf:f2d1:0:b0:314:dc0:2fca with SMTP id
 d17-20020adff2d1000000b003140dc02fcamr3494265wrp.29.1693478730193; 
 Thu, 31 Aug 2023 03:45:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/24] target/arm: Do all "ARM_FEATURE_X implies Y" checks in
 post_init
Date: Thu, 31 Aug 2023 11:45:17 +0100
Message-Id: <20230831104519.3520658-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230724174335.2150499-2-peter.maydell@linaro.org
---
 target/arm/cpu.c | 179 +++++++++++++++++++++++++----------------------
 1 file changed, 97 insertions(+), 82 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 17540300feb..0bb05854419 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1356,17 +1356,108 @@ unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
       NANOSECONDS_PER_SECOND / cpu->gt_cntfrq_hz : 1;
 }
 
+static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    bool no_aa32 = false;
+
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
+        /*
+         * v7 Virtualization Extensions. In real hardware this implies
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
+        /*
+         * Always define VBAR for V7 CPUs even if it doesn't exist in
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
@@ -1588,7 +1679,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUARMState *env = &cpu->env;
     int pagebits;
     Error *local_err = NULL;
-    bool no_aa32 = false;
 
     /* Use pc-relative instructions in system-mode */
 #ifndef CONFIG_USER_ONLY
@@ -1869,81 +1959,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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


