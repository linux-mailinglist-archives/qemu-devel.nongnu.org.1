Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B279B78D080
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83w-0004Vp-Vg; Tue, 29 Aug 2023 19:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83s-00041L-AP
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83m-0001O2-L4
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso39077755ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351425; x=1693956225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYRPHwHql4RJiTHPJiRJM3r+k6GdWisA6scz9yo7XuE=;
 b=SV0bHeYucokZw3B7Y7d0cL91KpJdUemBbUecIWfQ/b3vN7ZexlMYE5Rw+nfJMR6Uw7
 ze4iolneTbSf09B/56mjy5TGv0+wlm6mDyUwJAG6L6geFrpoU0xl/dpM+kTOGpTATwQJ
 bpE0ZDavVs3tXvXoRPQnKHfX7rUZgQkadzoTjRMCZbWPAXXunN7Ee2h53Ve09BZ6xXkH
 sIFCUXMqWBrc1PtQOMhqyj7VXX0IstYtwI/zFFJ1X+zLpLHzu34DGGT4yKORu/wam5AK
 KXBZoNRhHd2JGcQUEhEbIxyddnyIWS7CJCNVYB9C0R1op6/39QvapLAjQoxboeHB13zH
 XT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351425; x=1693956225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYRPHwHql4RJiTHPJiRJM3r+k6GdWisA6scz9yo7XuE=;
 b=ddoLAZ5aY3ZA4eupwjUt6Xiqgl6MS5ydCogHF2oJLAKo7rs6fEMQhMVMTwdGhStGNW
 MJJjMSWWPhMIlYFXnz4bQni4+kdYXeMmF0gp2RrdqlNe+bc/0eEnAsud5d92Ivxd6IrL
 YlNvmqUQTABElkwMB0UAjXuCO7OC8RC8IEWDimIIQWER2NHy7eUQZJv6F4XZ2MO/lKf1
 XULn8zzuED6YMBQCBpE7d4wGimJ+wO54xXL2W1TiZc6d92fRLNJ1ADQVNR4H1kNs+vwn
 J2ADLZhScJKc+WqdkozgevBYDmrWbWSmpA1sSc8WvzJ9ZN0Qo2Jn7XZCkRGS4S5KG3lD
 /25Q==
X-Gm-Message-State: AOJu0Yx6cJDi80/ickpefexNBymfWw0CPNM/mEgU1SUqHVLc+v/pqGAn
 w3/cNgsQzo6OtNUaLYjVtFzJQNKIhxOzjgyJRFU=
X-Google-Smtp-Source: AGHT+IHDP1ZtVriSwSv3vFBLEjvx5MVC3/uBgc3GszGNEHvqhlv692SqeR07Sv+1Lg0kp9Ob+ImNcA==
X-Received: by 2002:a17:902:8e89:b0:1c0:b7f4:5b86 with SMTP id
 bg9-20020a1709028e8900b001c0b7f45b86mr552309plb.65.1693351425350; 
 Tue, 29 Aug 2023 16:23:45 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com,
	qemu-arm@nongnu.org
Subject: [PATCH v5 09/12] target/arm: Implement FEAT_FPAC and FEAT_FPACCOMBINE
Date: Tue, 29 Aug 2023 16:23:32 -0700
Message-Id: <20230829232335.965414-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230609172324.982888-8-aaron@os.amperecomputing.com>
[rth: Simplify fpac comparison, reusing cmp_mask]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst |  2 ++
 target/arm/syndrome.h         |  7 +++++++
 target/arm/tcg/cpu64.c        |  2 +-
 target/arm/tcg/pauth_helper.c | 18 +++++++++++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 54234ac090..8be04edbcc 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -34,6 +34,8 @@ the following architecture extensions:
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FPAC (Faulting on AUT* instructions)
+- FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 62254d0e51..8a6b8f8162 100644
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
index d3be14137e..7734058bb1 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -758,7 +758,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_2);
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index c05c5b30ff..4da2962ad5 100644
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


