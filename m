Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E715D7838C6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:26:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYIxi-0006Pv-0s; Tue, 22 Aug 2023 00:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxd-0006Nz-RB
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxY-0007YR-So
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a3daf4cf7so1298994b3a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678339; x=1693283139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYRPHwHql4RJiTHPJiRJM3r+k6GdWisA6scz9yo7XuE=;
 b=DaYvLsjC3fP0uS4n+0iMHnTGVfnFo43wjng2ualMFgXXCWuD8Q+ZVgZXhFB+ds4Jx/
 fMyfUBGTaTXl91I2J75qKn7dNIGmYE7DO2UzM0qcoViNDgTOSpxzD6sSrCXEgL2QNcrx
 EUBry97f68/rKusfhj6bLXcuhWsNdAdOC4M5nSA/VU4tgPz4yLajLAIeHAqSefJmT2Zm
 x+pBQwAzmHv9G5KhQfwxfKaedQ+04LK2IFQ9wsB8CgOBNVABT8fXONG0/9+Dfy7CE46R
 kzzv9Jtdq7PdfvfVM/aYW4ONbVtnecLRoUEQOtVApTySnzCppe68d3yZSmNd9Rfw0Bbs
 01xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678339; x=1693283139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYRPHwHql4RJiTHPJiRJM3r+k6GdWisA6scz9yo7XuE=;
 b=JyBf7yr3uvdECdqyAJ/KuXLvuHWQFR+rq51myTr2XwoYCipQvldC+g5SA3qdlp536k
 iOhRfQC2AxeqisWOmGe3oulcpJAvEwj5iMPAbC6aEOsq5nDjslkD1VD3clc0d8/4guPb
 VZpSUrkrnbqnlX7OgNnKm8wgMmhjoJfLWz/ZnIPwatqjjuYwiEJK+o3wAEUeRGwFC7AN
 mLNGm7eI2uw8hrXthpYnEJBpCmiF7sgLA3F/y/g31W0fceI4GEKg8cby8rwVtWQtKXoE
 1T3Dpjl1VVhruP0AJRAcoMvuNjSair6SAS1Z7mh1SGT5z+IpIOsDdIUVk072iRldM1EC
 WRWg==
X-Gm-Message-State: AOJu0YyDKM/9GoFOCoZUkEjzQWaW5nz43vXR7DhdFfaK9P/eDECsDVH0
 csZWIdRvLgg2/Nstz1vY8de1h+8R7wEVHRjzQb8=
X-Google-Smtp-Source: AGHT+IEbbJ0hWmeh+xsNG7WH/qhVFr1bVbka2oDLt+6Sijruv+LzCj6a9M6SOaAGklCI1kyDfm6pWg==
X-Received: by 2002:a05:6a00:c87:b0:68a:5e3b:93f0 with SMTP id
 a7-20020a056a000c8700b0068a5e3b93f0mr3380872pfv.16.1692678339601; 
 Mon, 21 Aug 2023 21:25:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa7900e000000b0068a3f861b24sm3364908pfo.195.2023.08.21.21.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 21:25:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Aaron Lindsay <aaron@os.amperecomputing.com>
Subject: [PATCH v4 9/9] target/arm: Implement FEAT_FPAC and FEAT_FPACCOMBINE
Date: Mon, 21 Aug 2023 21:25:30 -0700
Message-Id: <20230822042530.1026751-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822042530.1026751-1-richard.henderson@linaro.org>
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


