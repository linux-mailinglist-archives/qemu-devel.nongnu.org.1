Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC76798B32
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew1-0005Pu-7t; Fri, 08 Sep 2023 13:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevx-0005AZ-Jj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-00016r-Kd
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so25932335e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192763; x=1694797563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6anypS2ha39PcSwRZlWS8MqKl6UrBYIZwJyjE/6R9kw=;
 b=aAcxB9ZVQ/MkaZBrPdr54YxOK2DauTvb1hX3YFZKjjK5j4M/CDN8pWBPPf59lC/8Zg
 QaGA+C9KhIeDPnauHXSh8Wce4OTfvTbxcd4TyA36LqgZLhtCG8y8RawrPXJFJM3E24wQ
 gOyNpNHW+Ffd1VxPTupxGCYZGGAdICJtouyRgTGUlmUKFLrpGYMY4jcsCorYsf70L9VX
 IgXqTN4Y7LibjidEE5d+/B75zRomtyDUTrFD+UDlBvGF3wEEQX3y69rRKqzqDQCapSDX
 hZbgAve1BHMrQ8BxPNogQW/lTcZ267FQ5I3sph2pYPyzL3sOEZo+5zUBf6LSUHtHZA/U
 KYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192763; x=1694797563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6anypS2ha39PcSwRZlWS8MqKl6UrBYIZwJyjE/6R9kw=;
 b=OmBSbljDSYAtmqPOURpuYGBQXtq7t4p70QAV5yOCoHnC/0ZBbutz2LNa0jq7G7DQRX
 muprce+G8EXeL98MnpxCSSKxWvlIe9UzTDwvOGW1eK/4fK/wVQH1IME87nJhQf5rJf7b
 Trg9nWSnHd4DdGmWiLXMiVywZZpqedQLqrEDBDBKg2ra54AOC0sBkIJHjOZXFRRQDkzu
 /ANoVkrE3qNf7rq4HDqmhG4s41RqDMx+/4TDQUkrkrg4yNpdh91oucKbFI3o2Qgtsk+d
 rBB+xz8fr0vZTFuJXcSL7iBOwhpetippIN3ytEATN4oUFyx0Ke2u9liZl9S6gWnooTlY
 Je6g==
X-Gm-Message-State: AOJu0Yxet98Cx5xSXeFEml69S6q34OoCvlAp0bRl8B8msVbF9HZdeTvs
 JZIfM04/BN0fxIfIbQ/59RdEykm2/aGLkbJ4h/o=
X-Google-Smtp-Source: AGHT+IGhBDkvLyUMDbskPbmMAn0ELQCuGvK48EpPdvmalP3wdag7vKVqKdIYBXH2hc77v8ItDv+IDA==
X-Received: by 2002:a7b:cc96:0:b0:3fe:1679:ba7b with SMTP id
 p22-20020a7bcc96000000b003fe1679ba7bmr2633442wma.24.1694192762948; 
 Fri, 08 Sep 2023 10:06:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/26] target/arm: Implement FEAT_PACQARMA3
Date: Fri,  8 Sep 2023 18:05:36 +0100
Message-Id: <20230908170557.773048-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Implement the QARMA3 cryptographic algorithm for PAC calculation.
Implement a cpu feature to select the algorithm and document it.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230829232335.965414-6-richard.henderson@linaro.org
Message-Id: <20230609172324.982888-4-aaron@os.amperecomputing.com>
[rth: Merge cpu feature addition from another patch.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 6bb88a40c77..a5fb929243c 100644
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
index 2e6a7c8961e..c4bc4074866 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -57,6 +57,9 @@ the following architecture extensions:
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
index 225a9b5af54..6f75ccfcef9 100644
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
index c8fa5240026..b53d5efe13d 100644
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
index fd584a31da7..f3d87e001f9 100644
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
index 6271a84ec9b..bb03409ee55 100644
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
index 3fc33fc24dd..a8a4c668adb 100644
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


