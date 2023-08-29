Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BEE78D07D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83q-0003kr-Iz; Tue, 29 Aug 2023 19:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83m-0003MD-Sh
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83i-0001MM-FD
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso30682825ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351421; x=1693956221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7JWHxmJ23NmS8KMDWOHbcj7S88Z02RWmeeJJ7xEGx8=;
 b=pmWZkM8YjkFeQ15aBt9RyaK0iaT1IBjp6PR8AZw0TqOcU+2Gqm6MEeykm1YK/Ax7X7
 1d7v+fSfgb5kYns4ifz4Tly5RiIcF/fvRlUTb4gARerIiSRNaUI6Nj3dEc+/OEhDjfPz
 +1UsUwq4RD3Z8245YwUsD43aBkp2jqlncxde3YXP/tP5u65sCAJyn3cpEQicPcwC9iJ4
 CxWWkiJjVjcb1CvrDgQxyZDhZQ4TGdQL65vjEzlk/xn8PgjtxareVmZV5rQcbMWLdRXS
 pW0e+BpoeiUX9pHcauZowWcMMTWwj2qCptlXYrZMayOIkoaFWv+z+uuQOQ+5dWWYLhWZ
 9dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351421; x=1693956221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7JWHxmJ23NmS8KMDWOHbcj7S88Z02RWmeeJJ7xEGx8=;
 b=Yz9KNtbzF5TlPRpPRleGXbyHta+Mvi3908VbcivEKVs6xURKAdhVKb6Sk+cv3Zm8Yq
 iWZ+gKs2Ja9VFc3sAuRHvQ2PF5tzavDXcwUZQmvTmIgMYUL9N7mZylk179zDLzq5ZTlM
 uFt+lFiKxkNs7dPnEJMiRs9FbrpEHlAMLw/dEz8zBDhLYW4Xnfe5jKrcw2lM/NJBEwae
 lhmPtiQjKGigKZgBiMzWrfmNn9yjSiFxm4sBOboppji2sglJOVoHHhi3xIbI5MiKjHTn
 K8n9hA5/nmgFDRV0WzuTVsNTUpRmJhpv+rf+sKpHKBQeGk8GwvH44mSnEFO5HRxiorqK
 l/Qw==
X-Gm-Message-State: AOJu0YwczkHJE5vaHTR+a+ehUXLOJtE+a6fwckNzcOG6R2dOpmp3HoeQ
 5ay4Fb7C7G76vdD0y2qIZ1sVeTTo+XiRWcOeZhg=
X-Google-Smtp-Source: AGHT+IFofvSYxHpXEuACd3CtDGUUTxwiploomMPI03V14ZZXmlq+xeQKXOsEkEfL35aT9/7G/dGYOQ==
X-Received: by 2002:a17:903:4283:b0:1bf:78d:5cd9 with SMTP id
 ju3-20020a170903428300b001bf078d5cd9mr388453plb.67.1693351420955; 
 Tue, 29 Aug 2023 16:23:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 04/12] target/arm: Don't change pauth features when
 changing algorithm
Date: Tue, 29 Aug 2023 16:23:27 -0700
Message-Id: <20230829232335.965414-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have cpu properties to adjust the pauth algorithm for the
purpose of speed of emulation.  Retain the set of pauth features
supported by the cpu even as the algorithm changes.

This already affects the neoverse-v1 cpu, which has FEAT_EPAC.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c     | 70 +++++++++++++++++++++++++++---------------
 target/arm/tcg/cpu64.c |  2 ++
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 96158093cc..fd584a31da 100644
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
index 8019f00bc3..fec6a4875d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -758,6 +758,8 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_1);
+    t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
     t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 2);    /* FEAT_LRCPC2 */
-- 
2.34.1


