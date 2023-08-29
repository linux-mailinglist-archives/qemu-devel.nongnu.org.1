Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE878D0A0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:30:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83r-0003oG-BY; Tue, 29 Aug 2023 19:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83o-0003dp-T2
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83j-0001Mh-55
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf57366ccdso2210695ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351422; x=1693956222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5PvsEisUhmViwuTX1kAnQipV1YYI3hKBjw90v7ICj0=;
 b=gJw5cozjVpEviyGyfZfGykTLkXQfc2HTUmdKH1diieOEI3dRQ9JM8PwKBwTeZTDPvY
 GbS0G54VgiGzae2CM0U8T+oCc+QiPk7k3ZxWeetvOs7VTsMxuODu5KLF+zSruRAKhhlI
 XnczB5BZRhULibelN2nBdNsdgO9a9R+5Bqx/Vjsp75TC1iS/7L0CQ5sMjGsekn/XRIbY
 StpOC9u2R57dYiBC0r/SbXbzQHTWZUyVA0xXvuxoyu1u4UPe9b2CBUwJia8hcaDpbvG1
 gP2uaLfYyzU262UW68EoCthc+dPKV+gn5sY0DPgy2nPHUT2NoyGNiuKOnReuSF38C2lo
 tVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351422; x=1693956222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5PvsEisUhmViwuTX1kAnQipV1YYI3hKBjw90v7ICj0=;
 b=fX+WXdpk+FlWIKJK3mZVKTFiEEtsDf7Z0LpKW7zqhJvIzrwMaUC+L70bpUAVhS3thh
 k3i4t3BIJ9u23zY44enKqvVBh48gSMU343w3dFPDHV5dbV8BjavLC8R3+6YxwCzxbxe7
 1IIMovFYOYiNecZGmTfIt9u1+BhZHTdkjQnAIH+GtboLgSYxRFlSfrdJSEKNCB8nASGF
 Taeubj88nZqWpd+8Bx7/tFtUoJnkXgoK9VNR8vybyRjMGHX/F/Ea/BNrEha79UZwU1/a
 qMis554HbPjJDgDUNySHulzfh9H5JUGlvttrh964I5JBeOgU5NGL5s0S70pnf1skSzSR
 8dnw==
X-Gm-Message-State: AOJu0YziK9mtI2knA6IMVJWQNqaq8gRPopjgmyQxA5qYXyOXEihW23x+
 Y855hIejr6LyAu2Pr+yAENPYs2t8xBKHTQhq+HE=
X-Google-Smtp-Source: AGHT+IGUzOFo23vXQ+e0PPbFxHHLQySUiAA3VACsN3wkHdQ4Wj+jD6BlGRg9cJoQ8yUnlZfHbIkX2g==
X-Received: by 2002:a17:902:c950:b0:1bd:e258:a256 with SMTP id
 i16-20020a170902c95000b001bde258a256mr1020157pla.32.1693351421791; 
 Tue, 29 Aug 2023 16:23:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 05/12] target/arm: Implement FEAT_PACQARMA3
Date: Tue, 29 Aug 2023 16:23:28 -0700
Message-Id: <20230829232335.965414-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Implement the QARMA3 cryptographic algorithm for PAC calculation.
Implement a cpu feature to select the algorithm and document it.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230609172324.982888-4-aaron@os.amperecomputing.com>
[rth: Merge cpu feature addition from another patch.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/cpu-features.rst | 21 ++++++++-----
 docs/system/arm/emulation.rst    |  3 ++
 target/arm/cpu.h                 |  1 +
 target/arm/arm-qmp-cmds.c        |  2 +-
 target/arm/cpu64.c               | 24 ++++++++++++--
 target/arm/tcg/pauth_helper.c    | 54 ++++++++++++++++++++++++++------
 tests/qtest/arm-cpu-features.c   | 12 ++++++-
 7 files changed, 94 insertions(+), 23 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 6bb88a40c7..a5fb929243 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -210,15 +210,20 @@ TCG VCPU Features
 TCG VCPU features are CPU features that are specific to TCG.
 Below is the list of TCG VCPU features and their descriptions.
 
-``pauth-impdef``
-  When ``FEAT_Pauth`` is enabled, either the *impdef* (Implementation
-  Defined) algorithm is enabled or the *architected* QARMA algorithm
-  is enabled.  By default the impdef algorithm is disabled, and QARMA
-  is enabled.
+``pauth``
+  Enable or disable ``FEAT_Pauth`` entirely.
 
-  The architected QARMA algorithm has good cryptographic properties,
-  but can be quite slow to emulate.  The impdef algorithm used by QEMU
-  is non-cryptographic but significantly faster.
+``pauth-impdef``
+  When ``pauth`` is enabled, select the QEMU implementation defined algorithm.
+
+``pauth-qarma3``
+  When ``pauth`` is enabled, select the architected QARMA3 algorithm.
+
+Without either ``pauth-impdef`` or ``pauth-qarma3`` enabled,
+the architected QARMA5 algorithm is used.  The architected QARMA5
+and QARMA3 algorithms have good cryptographic properties, but can
+be quite slow to emulate.  The impdef algorithm used by QEMU is
+non-cryptographic but significantly faster.
 
 SVE CPU Properties
 ==================
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bdafc68819..06af20d10f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -55,6 +55,9 @@ the following architecture extensions:
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
+- FEAT_PACIMP (Pointer authentication - IMPLEMENTATION DEFINED algorithm)
+- FEAT_PACQARMA3 (Pointer authentication - QARMA3 algorithm)
+- FEAT_PACQARMA5 (Pointer authentication - QARMA5 algorithm)
 - FEAT_PAN (Privileged access never)
 - FEAT_PAN2 (AT S1E1R and AT S1E1W instruction variants affected by PSTATE.PAN)
 - FEAT_PAN3 (Support for SCTLR_ELx.EPAN)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0e2545d631..cfca42293a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1072,6 +1072,7 @@ struct ArchCPU {
      */
     bool prop_pauth;
     bool prop_pauth_impdef;
+    bool prop_pauth_qarma3;
     bool prop_lpa2;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index c8fa524002..b53d5efe13 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -95,7 +95,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
-    "pauth", "pauth-impdef",
+    "pauth", "pauth-impdef", "pauth-qarma3",
     NULL
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index fd584a31da..f3d87e001f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -474,7 +474,7 @@ void aarch64_add_sme_properties(Object *obj)
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
 {
     ARMPauthFeature features = cpu_isar_feature(pauth_feature, cpu);
-    uint64_t isar1;
+    uint64_t isar1, isar2;
 
     /*
      * These properties enable or disable Pauth as a whole, or change
@@ -490,6 +490,10 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, 0);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 0);
 
+    isar2 = cpu->isar.id_aa64isar2;
+    isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
+    isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
+
     if (kvm_enabled() || hvf_enabled()) {
         /*
          * Exit early if PAuth is enabled and fall through to disable it.
@@ -510,26 +514,39 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
         }
 
         if (cpu->prop_pauth) {
+            if (cpu->prop_pauth_impdef && cpu->prop_pauth_qarma3) {
+                error_setg(errp,
+                           "cannot enable both pauth-impdef and pauth-qarma3");
+                return;
+            }
+
             if (cpu->prop_pauth_impdef) {
                 isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, features);
                 isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 1);
+            } else if (cpu->prop_pauth_qarma3) {
+                isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, features);
+                isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 1);
             } else {
                 isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
                 isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
             }
-        } else if (cpu->prop_pauth_impdef) {
-            error_setg(errp, "cannot enable pauth-impdef without pauth");
+        } else if (cpu->prop_pauth_impdef || cpu->prop_pauth_qarma3) {
+            error_setg(errp, "cannot enable pauth-impdef or "
+                       "pauth-qarma3 without pauth");
             error_append_hint(errp, "Add pauth=on to the CPU property list.\n");
         }
     }
 
     cpu->isar.id_aa64isar1 = isar1;
+    cpu->isar.id_aa64isar2 = isar2;
 }
 
 static Property arm_cpu_pauth_property =
     DEFINE_PROP_BOOL("pauth", ARMCPU, prop_pauth, true);
 static Property arm_cpu_pauth_impdef_property =
     DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
+static Property arm_cpu_pauth_qarma3_property =
+    DEFINE_PROP_BOOL("pauth-qarma3", ARMCPU, prop_pauth_qarma3, false);
 
 void aarch64_add_pauth_properties(Object *obj)
 {
@@ -549,6 +566,7 @@ void aarch64_add_pauth_properties(Object *obj)
         cpu->prop_pauth = cpu_isar_feature(aa64_pauth, cpu);
     } else {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_impdef_property);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma3_property);
     }
 }
 
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 6271a84ec9..bb03409ee5 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -96,6 +96,21 @@ static uint64_t pac_sub(uint64_t i)
     return o;
 }
 
+static uint64_t pac_sub1(uint64_t i)
+{
+    static const uint8_t sub1[16] = {
+        0xa, 0xd, 0xe, 0x6, 0xf, 0x7, 0x3, 0x5,
+        0x9, 0x8, 0x0, 0xc, 0xb, 0x1, 0x2, 0x4,
+    };
+    uint64_t o = 0;
+    int b;
+
+    for (b = 0; b < 64; b += 4) {
+        o |= (uint64_t)sub1[(i >> b) & 0xf] << b;
+    }
+    return o;
+}
+
 static uint64_t pac_inv_sub(uint64_t i)
 {
     static const uint8_t inv_sub[16] = {
@@ -209,7 +224,7 @@ static uint64_t tweak_inv_shuffle(uint64_t i)
 }
 
 static uint64_t pauth_computepac_architected(uint64_t data, uint64_t modifier,
-                                             ARMPACKey key)
+                                             ARMPACKey key, bool isqarma3)
 {
     static const uint64_t RC[5] = {
         0x0000000000000000ull,
@@ -219,6 +234,7 @@ static uint64_t pauth_computepac_architected(uint64_t data, uint64_t modifier,
         0x452821E638D01377ull,
     };
     const uint64_t alpha = 0xC0AC29B7C97C50DDull;
+    int iterations = isqarma3 ? 2 : 4;
     /*
      * Note that in the ARM pseudocode, key0 contains bits <127:64>
      * and key1 contains bits <63:0> of the 128-bit key.
@@ -231,7 +247,7 @@ static uint64_t pauth_computepac_architected(uint64_t data, uint64_t modifier,
     runningmod = modifier;
     workingval = data ^ key0;
 
-    for (i = 0; i <= 4; ++i) {
+    for (i = 0; i <= iterations; ++i) {
         roundkey = key1 ^ runningmod;
         workingval ^= roundkey;
         workingval ^= RC[i];
@@ -239,32 +255,48 @@ static uint64_t pauth_computepac_architected(uint64_t data, uint64_t modifier,
             workingval = pac_cell_shuffle(workingval);
             workingval = pac_mult(workingval);
         }
-        workingval = pac_sub(workingval);
+        if (isqarma3) {
+            workingval = pac_sub1(workingval);
+        } else {
+            workingval = pac_sub(workingval);
+        }
         runningmod = tweak_shuffle(runningmod);
     }
     roundkey = modk0 ^ runningmod;
     workingval ^= roundkey;
     workingval = pac_cell_shuffle(workingval);
     workingval = pac_mult(workingval);
-    workingval = pac_sub(workingval);
+    if (isqarma3) {
+        workingval = pac_sub1(workingval);
+    } else {
+        workingval = pac_sub(workingval);
+    }
     workingval = pac_cell_shuffle(workingval);
     workingval = pac_mult(workingval);
     workingval ^= key1;
     workingval = pac_cell_inv_shuffle(workingval);
-    workingval = pac_inv_sub(workingval);
+    if (isqarma3) {
+        workingval = pac_sub1(workingval);
+    } else {
+        workingval = pac_inv_sub(workingval);
+    }
     workingval = pac_mult(workingval);
     workingval = pac_cell_inv_shuffle(workingval);
     workingval ^= key0;
     workingval ^= runningmod;
-    for (i = 0; i <= 4; ++i) {
-        workingval = pac_inv_sub(workingval);
-        if (i < 4) {
+    for (i = 0; i <= iterations; ++i) {
+        if (isqarma3) {
+            workingval = pac_sub1(workingval);
+        } else {
+            workingval = pac_inv_sub(workingval);
+        }
+        if (i < iterations) {
             workingval = pac_mult(workingval);
             workingval = pac_cell_inv_shuffle(workingval);
         }
         runningmod = tweak_inv_shuffle(runningmod);
         roundkey = key1 ^ runningmod;
-        workingval ^= RC[4 - i];
+        workingval ^= RC[iterations - i];
         workingval ^= roundkey;
         workingval ^= alpha;
     }
@@ -283,7 +315,9 @@ static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
                                  uint64_t modifier, ARMPACKey key)
 {
     if (cpu_isar_feature(aa64_pauth_qarma5, env_archcpu(env))) {
-        return pauth_computepac_architected(data, modifier, key);
+        return pauth_computepac_architected(data, modifier, key, false);
+    } else if (cpu_isar_feature(aa64_pauth_qarma3, env_archcpu(env))) {
+        return pauth_computepac_architected(data, modifier, key, true);
     } else {
         return pauth_computepac_impdef(data, modifier, key);
     }
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 3fc33fc24d..a8a4c668ad 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -417,12 +417,22 @@ static void pauth_tests_default(QTestState *qts, const char *cpu_type)
 {
     assert_has_feature_enabled(qts, cpu_type, "pauth");
     assert_has_feature_disabled(qts, cpu_type, "pauth-impdef");
+    assert_has_feature_disabled(qts, cpu_type, "pauth-qarma3");
     assert_set_feature(qts, cpu_type, "pauth", false);
     assert_set_feature(qts, cpu_type, "pauth", true);
     assert_set_feature(qts, cpu_type, "pauth-impdef", true);
     assert_set_feature(qts, cpu_type, "pauth-impdef", false);
-    assert_error(qts, cpu_type, "cannot enable pauth-impdef without pauth",
+    assert_set_feature(qts, cpu_type, "pauth-qarma3", true);
+    assert_set_feature(qts, cpu_type, "pauth-qarma3", false);
+    assert_error(qts, cpu_type,
+                 "cannot enable pauth-impdef or pauth-qarma3 without pauth",
                  "{ 'pauth': false, 'pauth-impdef': true }");
+    assert_error(qts, cpu_type,
+                 "cannot enable pauth-impdef or pauth-qarma3 without pauth",
+                 "{ 'pauth': false, 'pauth-qarma3': true }");
+    assert_error(qts, cpu_type,
+                 "cannot enable both pauth-impdef and pauth-qarma3",
+                 "{ 'pauth': true, 'pauth-impdef': true, 'pauth-qarma3': true }");
 }
 
 static void test_query_cpu_model_expansion(const void *data)
-- 
2.34.1


