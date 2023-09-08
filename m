Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4E798B2F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeevw-00053y-Ek; Fri, 08 Sep 2023 13:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevu-000508-Ac
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-00017P-KS
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso26190985e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192765; x=1694797565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T5BuOUY8CxihCyBZWgBxJGsKeGw+bLmVOX2rXRtMF1E=;
 b=PVMRceFWJ2H97rJT5O2miNKihIg0dDhnQISHpCH60cn4ZQDoeBlw0scsRvo1Osnrly
 nf/L2nIOf6+bomnpDGRrqEDPYDJWK09+4e3N+9JYldRsensfN7fzW06VlkjxG1rClGdi
 l4VcQYsCpfax2bNtrpeoDHSs8RheyLvse2UkYcpzZ8/7Y2EWbk7scT9A/a/WG8duR8f2
 IXfdHwTUVmqMhvvw42YwmFvk0fT30/eh2ygohZ7n/4JhvN6J2X2hfUlwJ78Vi2eKwti9
 sljY5e1/Ayw5Pny4ZKaYS9yQNdU78fYFls1Rw1gyrZenPXDAk+45HAJCx1vndAFA6s0A
 Ywjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192765; x=1694797565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5BuOUY8CxihCyBZWgBxJGsKeGw+bLmVOX2rXRtMF1E=;
 b=tNW1vnJTHL0TSWs7ZnpkeppxT9zi1jBdBQ8jxXv6UXGtWeP2Ikr0YcFAUL0JI/eQ5N
 shFfDztwnxjntleXZRCskO+YC7kKdDMnmwRQXHUI4iXx3rZLGnQhKpxF9uP8Zyq+2YEU
 kzNS1c/Q3HT8tLQOumd1O6AjtBA37mnN1KCybp9XkATQ7PxwlXK4o0M1OkZLHY9PHVly
 B+YF6+YTvxe0tEYP52Pr6qgf/YToPnt898WjCjaQdw1jdTMlUBivbd4h6L6rs9zUpAg4
 l7NqwZG/rIiQ03F7jUyjRS56dokkdBQqU0Ae168eyDzL5kO7XhRaZfPQe3ptvBWJiCyV
 /QGg==
X-Gm-Message-State: AOJu0Yx4wpSJm/i/a2W4oG2lm3akcHZcbiG875UsFDlrNB84EnOXN5fa
 yWCwnlSO1uKAOcckcxOXHwLtzPe5I4x/cObY0Go=
X-Google-Smtp-Source: AGHT+IHVx2McdKWcmbqJstIzq6lFyV9lET1M5rFaKcSp9sixvm+44jH7HjyzIFwIEudYqUWo6oEfeg==
X-Received: by 2002:a7b:c84b:0:b0:401:d2cb:e6f2 with SMTP id
 c11-20020a7bc84b000000b00401d2cbe6f2mr2543336wml.32.1694192764611; 
 Fri, 08 Sep 2023 10:06:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/26] target/arm: Implement FEAT_FPAC and FEAT_FPACCOMBINE
Date: Fri,  8 Sep 2023 18:05:40 +0100
Message-Id: <20230908170557.773048-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230829232335.965414-10-richard.henderson@linaro.org
Message-Id: <20230609172324.982888-8-aaron@os.amperecomputing.com>
[rth: Simplify fpac comparison, reusing cmp_mask]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst |  2 ++
 target/arm/syndrome.h         |  7 +++++++
 target/arm/tcg/cpu64.c        |  2 +-
 target/arm/tcg/pauth_helper.c | 18 +++++++++++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b5a667527b5..305b36b19e7 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -35,6 +35,8 @@ the following architecture extensions:
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FPAC (Faulting on AUT* instructions)
+- FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 62254d0e518..8a6b8f8162a 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -49,6 +49,7 @@ enum arm_exception_class {
     EC_SYSTEMREGISTERTRAP     = 0x18,
     EC_SVEACCESSTRAP          = 0x19,
     EC_ERETTRAP               = 0x1a,
+    EC_PACFAIL                = 0x1c,
     EC_SMETRAP                = 0x1d,
     EC_GPC                    = 0x1e,
     EC_INSNABORT              = 0x20,
@@ -232,6 +233,12 @@ static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
         | (is_16bit ? 0 : ARM_EL_IL) | etype;
 }
 
+static inline uint32_t syn_pacfail(bool data, int keynumber)
+{
+    int error_code = (data << 1) | keynumber;
+    return (EC_PACFAIL << ARM_EL_EC_SHIFT) | ARM_EL_IL | error_code;
+}
+
 static inline uint32_t syn_pactrap(void)
 {
     return EC_PACTRAP << ARM_EL_EC_SHIFT;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index be103702505..ef222da57d4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -803,7 +803,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_2);
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index c05c5b30ff9..4da2962ad5b 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -396,6 +396,14 @@ static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
     }
 }
 
+static G_NORETURN
+void pauth_fail_exception(CPUARMState *env, bool data,
+                          int keynumber, uintptr_t ra)
+{
+    raise_exception_ra(env, EXCP_UDEF, syn_pacfail(data, keynumber),
+                       exception_target_el(env), ra);
+}
+
 static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                            ARMPACKey *key, bool data, int keynumber,
                            uintptr_t ra, bool is_combined)
@@ -416,7 +424,15 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     cmp_mask &= ~MAKE_64BIT_MASK(55, 1);
 
     if (pauth_feature >= PauthFeat_2) {
-        return ptr ^ (pac & cmp_mask);
+        ARMPauthFeature fault_feature =
+            is_combined ? PauthFeat_FPACCOMBINED : PauthFeat_FPAC;
+        uint64_t result = ptr ^ (pac & cmp_mask);
+
+        if (pauth_feature >= fault_feature
+            && ((result ^ sextract64(result, 55, 1)) & cmp_mask)) {
+            pauth_fail_exception(env, data, keynumber, ra);
+        }
+        return result;
     }
 
     if ((pac ^ ptr) & cmp_mask) {
-- 
2.34.1


