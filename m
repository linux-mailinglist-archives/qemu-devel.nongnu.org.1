Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B395798B36
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeevw-00053Z-7M; Fri, 08 Sep 2023 13:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevs-0004yr-Lv
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-00016X-Jf
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso24194785e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192762; x=1694797562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y3fdZw1RfPhJKCd65KPY6TC+lTEu607zM4Lh3UAYxaM=;
 b=vmrz1xvtlFAAt3zz2hp/fOZ1LRxReLPsQAdcdniklO1+SJTpMmsewpeg+bwHNlk2Ne
 XVkasEUReU78UgMo5ScWRx55Qx2JG8um+ukk8OzbGfwfbeu8QnEzkqgRiHr7ZkMCnruK
 VHGw8YAojOWe4T6eCzoC1VpOLaQmzodLCWPv5UFl9b2i9J0yaeLHlFqjByN1+CAriGtQ
 Owvd8mtgyvueWANz1qMQrnhKn/1P8YFXgUrCday4NxP7hRkKTtCG8cqh7YZ5X8Q5elU/
 b6Yd4EcLwjuXQ7CAwh+1w95aBYlDKN8S6ySegC2WUU/rNUB+ALg+Ev+sFFTI5IQHGHRe
 apxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192762; x=1694797562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3fdZw1RfPhJKCd65KPY6TC+lTEu607zM4Lh3UAYxaM=;
 b=isH+lpwfKupbpbBKTKqX5S8pwYyvvv/nl8HSI6JZHiPcSGSxFxNea4aGGinQN04Ape
 fXbhWQNVvpZtzGol49MSsuE+qw06HP2cxAn4/ypd3Jkpsm3IRbBy6CpcrLqRUu/fH1at
 OCff8+OHrS07xcmtPiqe2OmmtnsKLcDjwNa8l8QVLxVJb9ve+xgPulAMZ35iFaonMpW+
 Hjv9RCD2iB1iscEMpRwPVz1j9aGctlyur+1ItGl/69ztwNIN/MI56rFjOCT+PYL52WNg
 /eve8S9cAQogQK1WEE9xHMVZwP5GbDgujLQhusx+ju2hS20otE3LKpCzwKioULsG+/6u
 Tp1A==
X-Gm-Message-State: AOJu0YwovvA7rh641OBVwgeTc/iTiPtdqLHsmBVBGpOXZWSdMawvKKlN
 wmmpcYh0PVZH3YtawNUIF+OnCUP3g1WZpn9Guz0=
X-Google-Smtp-Source: AGHT+IHFMHOi32IOip2wUIfniJ+OzpMb2qPgg+pviFCN0DUYtFc/GrDEWVi6jiZ1W5L1oWyxlz3jxA==
X-Received: by 2002:a1c:f70c:0:b0:402:cf9e:fc84 with SMTP id
 v12-20020a1cf70c000000b00402cf9efc84mr2324482wmh.26.1694192762541; 
 Fri, 08 Sep 2023 10:06:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/26] target/arm: Don't change pauth features when changing
 algorithm
Date: Fri,  8 Sep 2023 18:05:35 +0100
Message-Id: <20230908170557.773048-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We have cpu properties to adjust the pauth algorithm for the
purpose of speed of emulation.  Retain the set of pauth features
supported by the cpu even as the algorithm changes.

This already affects the neoverse-v1 cpu, which has FEAT_EPAC.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230829232335.965414-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c     | 70 +++++++++++++++++++++++++++---------------
 target/arm/tcg/cpu64.c |  2 ++
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 96158093cc6..fd584a31da7 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -473,37 +473,57 @@ void aarch64_add_sme_properties(Object *obj)
 
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
 {
-    int arch_val = 0, impdef_val = 0;
-    uint64_t t;
+    ARMPauthFeature features = cpu_isar_feature(pauth_feature, cpu);
+    uint64_t isar1;
 
-    /* Exit early if PAuth is enabled, and fall through to disable it */
-    if ((kvm_enabled() || hvf_enabled()) && cpu->prop_pauth) {
-        if (!cpu_isar_feature(aa64_pauth, cpu)) {
-            error_setg(errp, "'pauth' feature not supported by %s on this host",
-                       kvm_enabled() ? "KVM" : "hvf");
+    /*
+     * These properties enable or disable Pauth as a whole, or change
+     * the pauth algorithm, but do not change the set of features that
+     * are present.  We have saved a copy of those features above and
+     * will now place it into the field that chooses the algorithm.
+     *
+     * Begin by disabling all fields.
+     */
+    isar1 = cpu->isar.id_aa64isar1;
+    isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, 0);
+    isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 0);
+    isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, 0);
+    isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 0);
+
+    if (kvm_enabled() || hvf_enabled()) {
+        /*
+         * Exit early if PAuth is enabled and fall through to disable it.
+         * The algorithm selection properties are not present.
+         */
+        if (cpu->prop_pauth) {
+            if (features == 0) {
+                error_setg(errp, "'pauth' feature not supported by "
+                           "%s on this host", current_accel_name());
+            }
+            return;
+        }
+    } else {
+        /* Pauth properties are only present when the model supports it. */
+        if (features == 0) {
+            assert(!cpu->prop_pauth);
+            return;
         }
 
-        return;
-    }
-
-    /* TODO: Handle HaveEnhancedPAC, HaveEnhancedPAC2, HaveFPAC. */
-    if (cpu->prop_pauth) {
-        if (cpu->prop_pauth_impdef) {
-            impdef_val = 1;
-        } else {
-            arch_val = 1;
+        if (cpu->prop_pauth) {
+            if (cpu->prop_pauth_impdef) {
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, features);
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 1);
+            } else {
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
+            }
+        } else if (cpu->prop_pauth_impdef) {
+            error_setg(errp, "cannot enable pauth-impdef without pauth");
+            error_append_hint(errp, "Add pauth=on to the CPU property list.\n");
         }
-    } else if (cpu->prop_pauth_impdef) {
-        error_setg(errp, "cannot enable pauth-impdef without pauth");
-        error_append_hint(errp, "Add pauth=on to the CPU property list.\n");
     }
 
-    t = cpu->isar.id_aa64isar1;
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, arch_val);
-    t = FIELD_DP64(t, ID_AA64ISAR1, GPA, arch_val);
-    t = FIELD_DP64(t, ID_AA64ISAR1, API, impdef_val);
-    t = FIELD_DP64(t, ID_AA64ISAR1, GPI, impdef_val);
-    cpu->isar.id_aa64isar1 = t;
+    cpu->isar.id_aa64isar1 = isar1;
 }
 
 static Property arm_cpu_pauth_property =
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0f8972950d6..4a1d9816dfb 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -803,6 +803,8 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_1);
+    t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
     t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 2);    /* FEAT_LRCPC2 */
-- 
2.34.1


