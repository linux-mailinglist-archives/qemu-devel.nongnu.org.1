Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137F79DD52
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 03:00:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgEDW-0001rF-Ad; Tue, 12 Sep 2023 20:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgEDD-0001oH-Ji; Tue, 12 Sep 2023 20:58:36 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgED8-0003OK-Cd; Tue, 12 Sep 2023 20:58:35 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-26fb8225268so4232094a91.1; 
 Tue, 12 Sep 2023 17:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694566707; x=1695171507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hDHvb31og+VI+O/EVA7efVbomncJGK2s9YukfkzVNU=;
 b=bSzIRGjEf56crf55K8A0CDTlm/BNLU4Y3E8DdglGuCCdVNh9RxyqKPWAPO4JmhKXfv
 HnWnDsn32975+7e1tOZNy/T+m6yrGwbXtRjmI92Bg7avUuR5dKjN5m2MpWHkjrzy4x4N
 NtF67FyoRYLr6rkQj4AU9jR+C/tWauqYh0dQMw2Xbgx2dFpYv3sErgqv9L4bW1gJQuZW
 DZPM5F/avXXMMGQ+ryQhN+fNAZpS8it4xC8pEmczJsktE1z+UN2nTlmcQB6+LU+xj1Rh
 XNlF+Ow39J7tsLK7iihZ5iklcV8/4CiAKW970s1kJjleQRJ5xMOurOWKZSq7SWMJoyJx
 DEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694566707; x=1695171507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hDHvb31og+VI+O/EVA7efVbomncJGK2s9YukfkzVNU=;
 b=qXFD7UOF/qGok6rqA9a6BqeJW7DNWaTj/tNpDNzI5VNi7h+uzsjBym2k52hDH2c4ry
 Z8FqSnWk2h1RZkFdlkviCIlKOIVqv8+XQeOw5R1DWQvLIKI/fbS9VY/fMHRMaq0p3fbV
 MPAVT5j+PWj1h4X3y4+2G5qNTDWgY8Yafi9eoHM9U0D5IImrL+O0dfhYyaV/9YGf/udX
 pjEOUisBOZiWxiWJiVPI2uG8fdrnvbDPdCP0CWtodVxttM3Ka0NJpjEZm1wxvA3cXdtt
 NU+32jLUH3pEgJl9zPNzdBXwlglt+kA2Z8XQR+BTIh3+ghjDlEycIgWyCNbxjSb4Uoti
 cuRw==
X-Gm-Message-State: AOJu0Yztl5UsB2k5eBHQlkZJ0YLZTPr2XgNIUWLlFulcgwyKRhh7Pi8n
 yF8ahREEpipMORt0bnMQrztX5mTysRc=
X-Google-Smtp-Source: AGHT+IF81hd431Kdi6VNRwW3Rjj8Fma3yFIO0wiK3NjJ+rV4pgYKm0j1y12OZRmtsmKXH3EATWDfMA==
X-Received: by 2002:a17:90a:64c8:b0:267:eeee:ab17 with SMTP id
 i8-20020a17090a64c800b00267eeeeab17mr798742pjm.45.1694566706829; 
 Tue, 12 Sep 2023 17:58:26 -0700 (PDT)
Received: from wheely.local0.net ([193.114.103.68])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a17090a588200b0026f4bb8b2casm208868pji.6.2023.09.12.17.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 17:58:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] target/ppc: Change CR registers from i32 to tl
Date: Wed, 13 Sep 2023 10:58:12 +1000
Message-Id: <20230913005814.413113-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913005814.413113-1-npiggin@gmail.com>
References: <20230913005814.413113-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

tl is more convenient to work with because it matches most other
registers.

Change the type to tl. Keep generated code changes to a minimum with
trivial conversions (e.g., tcg_gen_trunc_tl_i32 -> tcg_gen_mov_tl).
Optimisation is done with a subsequent change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                             |   2 +-
 target/ppc/cpu_init.c                        |   2 +-
 target/ppc/dfp_helper.c                      |  12 +-
 target/ppc/fpu_helper.c                      |  38 ++--
 target/ppc/helper.h                          | 124 +++++-----
 target/ppc/int_helper.c                      |  58 ++---
 target/ppc/machine.c                         |   2 +-
 target/ppc/translate.c                       | 224 +++++++++----------
 target/ppc/translate/fixedpoint-impl.c.inc   |   2 +-
 target/ppc/translate/fp-impl.c.inc           |  26 +--
 target/ppc/translate/spe-impl.c.inc          |  18 +-
 target/ppc/translate/storage-ctrl-impl.c.inc |   4 +-
 target/ppc/translate/vmx-impl.c.inc          |  24 +-
 target/ppc/translate/vsx-impl.c.inc          |   6 +-
 14 files changed, 271 insertions(+), 271 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 173e4c351a..2cc3622148 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1107,7 +1107,7 @@ struct CPUArchState {
     target_ulong gprh[32]; /* storage for GPR MSB, used by the SPE extension */
     target_ulong lr;
     target_ulong ctr;
-    uint32_t crf[8];       /* condition register */
+    target_ulong crf[8];       /* condition register */
 #if defined(TARGET_PPC64)
     target_ulong cfar;
 #endif
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7ab5ee92d9..f94dcf7de6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7481,7 +7481,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
     qemu_fprintf(f, "CR ");
     for (i = 0; i < 8; i++)
-        qemu_fprintf(f, "%01x", env->crf[i]);
+        qemu_fprintf(f, "%01x", (uint32_t)env->crf[i]);
     qemu_fprintf(f, "  [");
     for (i = 0; i < 8; i++) {
         char a = '-';
diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index 5967ea07a9..822bb28877 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -493,7 +493,7 @@ DFP_HELPER_TAB(DDIV, decNumberDivide, DIV_PPs, 64)
 DFP_HELPER_TAB(DDIVQ, decNumberDivide, DIV_PPs, 128)
 
 #define DFP_HELPER_BF_AB(op, dnop, postprocs, size)                            \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)           \
+target_ulong helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)       \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
     dfp_prepare_decimal##size(&dfp, a, b, env);                                \
@@ -525,7 +525,7 @@ DFP_HELPER_BF_AB(DCMPO, decNumberCompare, CMPO_PPs, 64)
 DFP_HELPER_BF_AB(DCMPOQ, decNumberCompare, CMPO_PPs, 128)
 
 #define DFP_HELPER_TSTDC(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)      \
+target_ulong helper_##op(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)  \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int match = 0;                                                       \
@@ -553,7 +553,7 @@ DFP_HELPER_TSTDC(DTSTDC, 64)
 DFP_HELPER_TSTDC(DTSTDCQ, 128)
 
 #define DFP_HELPER_TSTDG(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)      \
+target_ulong helper_##op(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)  \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int minexp, maxexp, nzero_digits, nzero_idx, is_negative, is_zero,   \
@@ -608,7 +608,7 @@ DFP_HELPER_TSTDG(DTSTDG, 64)
 DFP_HELPER_TSTDG(DTSTDGQ, 128)
 
 #define DFP_HELPER_TSTEX(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)     \
+target_ulong helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b) \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int expa, expb, a_is_special, b_is_special;                          \
@@ -640,7 +640,7 @@ DFP_HELPER_TSTEX(DTSTEX, 64)
 DFP_HELPER_TSTEX(DTSTEXQ, 128)
 
 #define DFP_HELPER_TSTSF(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)     \
+target_ulong helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b) \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     unsigned k;                                                          \
@@ -677,7 +677,7 @@ DFP_HELPER_TSTSF(DTSTSF, 64)
 DFP_HELPER_TSTSF(DTSTSFQ, 128)
 
 #define DFP_HELPER_TSTSFI(op, size)                                     \
-uint32_t helper_##op(CPUPPCState *env, uint32_t a, ppc_fprp_t *b)       \
+target_ulong helper_##op(CPUPPCState *env, uint32_t a, ppc_fprp_t *b)   \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
     unsigned uim;                                                       \
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 03150a0f10..0612798022 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -903,7 +903,7 @@ uint64_t helper_FSEL(uint64_t a, uint64_t b, uint64_t c)
     }
 }
 
-uint32_t helper_ftdiv(uint64_t fra, uint64_t frb)
+target_ulong helper_ftdiv(uint64_t fra, uint64_t frb)
 {
     int fe_flag = 0;
     int fg_flag = 0;
@@ -939,7 +939,7 @@ uint32_t helper_ftdiv(uint64_t fra, uint64_t frb)
     return 0x8 | (fg_flag ? 4 : 0) | (fe_flag ? 2 : 0);
 }
 
-uint32_t helper_ftsqrt(uint64_t frb)
+target_ulong helper_ftsqrt(uint64_t frb)
 {
     int fe_flag = 0;
     int fg_flag = 0;
@@ -1285,7 +1285,7 @@ HELPER_SPE_VECTOR_ARITH(fsmul);
 HELPER_SPE_VECTOR_ARITH(fsdiv);
 
 /* Single-precision floating-point comparisons */
-static inline uint32_t efscmplt(CPUPPCState *env, uint32_t op1, uint32_t op2)
+static inline target_ulong efscmplt(CPUPPCState *env, uint32_t op1, uint32_t op2)
 {
     CPU_FloatU u1, u2;
 
@@ -1294,7 +1294,7 @@ static inline uint32_t efscmplt(CPUPPCState *env, uint32_t op1, uint32_t op2)
     return float32_lt(u1.f, u2.f, &env->vec_status) ? 4 : 0;
 }
 
-static inline uint32_t efscmpgt(CPUPPCState *env, uint32_t op1, uint32_t op2)
+static inline target_ulong efscmpgt(CPUPPCState *env, uint32_t op1, uint32_t op2)
 {
     CPU_FloatU u1, u2;
 
@@ -1303,7 +1303,7 @@ static inline uint32_t efscmpgt(CPUPPCState *env, uint32_t op1, uint32_t op2)
     return float32_le(u1.f, u2.f, &env->vec_status) ? 0 : 4;
 }
 
-static inline uint32_t efscmpeq(CPUPPCState *env, uint32_t op1, uint32_t op2)
+static inline target_ulong efscmpeq(CPUPPCState *env, uint32_t op1, uint32_t op2)
 {
     CPU_FloatU u1, u2;
 
@@ -1312,26 +1312,26 @@ static inline uint32_t efscmpeq(CPUPPCState *env, uint32_t op1, uint32_t op2)
     return float32_eq(u1.f, u2.f, &env->vec_status) ? 4 : 0;
 }
 
-static inline uint32_t efststlt(CPUPPCState *env, uint32_t op1, uint32_t op2)
+static inline target_ulong efststlt(CPUPPCState *env, uint32_t op1, uint32_t op2)
 {
     /* XXX: TODO: ignore special values (NaN, infinites, ...) */
     return efscmplt(env, op1, op2);
 }
 
-static inline uint32_t efststgt(CPUPPCState *env, uint32_t op1, uint32_t op2)
+static inline target_ulong efststgt(CPUPPCState *env, uint32_t op1, uint32_t op2)
 {
     /* XXX: TODO: ignore special values (NaN, infinites, ...) */
     return efscmpgt(env, op1, op2);
 }
 
-static inline uint32_t efststeq(CPUPPCState *env, uint32_t op1, uint32_t op2)
+static inline target_ulong efststeq(CPUPPCState *env, uint32_t op1, uint32_t op2)
 {
     /* XXX: TODO: ignore special values (NaN, infinites, ...) */
     return efscmpeq(env, op1, op2);
 }
 
 #define HELPER_SINGLE_SPE_CMP(name)                                     \
-    uint32_t helper_e##name(CPUPPCState *env, uint32_t op1, uint32_t op2) \
+    target_ulong helper_e##name(CPUPPCState *env, uint32_t op1, uint32_t op2) \
     {                                                                   \
         return e##name(env, op1, op2);                                  \
     }
@@ -1348,13 +1348,13 @@ HELPER_SINGLE_SPE_CMP(fscmpgt);
 /* efscmpeq */
 HELPER_SINGLE_SPE_CMP(fscmpeq);
 
-static inline uint32_t evcmp_merge(int t0, int t1)
+static inline target_ulong evcmp_merge(int t0, int t1)
 {
     return (t0 << 3) | (t1 << 2) | ((t0 | t1) << 1) | (t0 & t1);
 }
 
 #define HELPER_VECTOR_SPE_CMP(name)                                     \
-    uint32_t helper_ev##name(CPUPPCState *env, uint64_t op1, uint64_t op2) \
+    target_ulong helper_ev##name(CPUPPCState *env, uint64_t op1, uint64_t op2) \
     {                                                                   \
         return evcmp_merge(e##name(env, op1 >> 32, op2 >> 32),          \
                            e##name(env, op1, op2));                     \
@@ -1607,7 +1607,7 @@ uint64_t helper_efddiv(CPUPPCState *env, uint64_t op1, uint64_t op2)
 }
 
 /* Double precision floating point helpers */
-uint32_t helper_efdtstlt(CPUPPCState *env, uint64_t op1, uint64_t op2)
+target_ulong helper_efdtstlt(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1616,7 +1616,7 @@ uint32_t helper_efdtstlt(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return float64_lt(u1.d, u2.d, &env->vec_status) ? 4 : 0;
 }
 
-uint32_t helper_efdtstgt(CPUPPCState *env, uint64_t op1, uint64_t op2)
+target_ulong helper_efdtstgt(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1625,7 +1625,7 @@ uint32_t helper_efdtstgt(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return float64_le(u1.d, u2.d, &env->vec_status) ? 0 : 4;
 }
 
-uint32_t helper_efdtsteq(CPUPPCState *env, uint64_t op1, uint64_t op2)
+target_ulong helper_efdtsteq(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1634,19 +1634,19 @@ uint32_t helper_efdtsteq(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return float64_eq_quiet(u1.d, u2.d, &env->vec_status) ? 4 : 0;
 }
 
-uint32_t helper_efdcmplt(CPUPPCState *env, uint64_t op1, uint64_t op2)
+target_ulong helper_efdcmplt(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     /* XXX: TODO: test special values (NaN, infinites, ...) */
     return helper_efdtstlt(env, op1, op2);
 }
 
-uint32_t helper_efdcmpgt(CPUPPCState *env, uint64_t op1, uint64_t op2)
+target_ulong helper_efdcmpgt(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     /* XXX: TODO: test special values (NaN, infinites, ...) */
     return helper_efdtstgt(env, op1, op2);
 }
 
-uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
+target_ulong helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     /* XXX: TODO: test special values (NaN, infinites, ...) */
     return helper_efdtsteq(env, op1, op2);
@@ -2585,11 +2585,11 @@ VSX_MAX_MINJ(XSMINJDP, 0);
  *   exp   - expected result of comparison
  */
 #define VSX_CMP(op, nels, tp, fld, cmp, svxvc, exp)                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                     \
+target_ulong helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                 \
                      ppc_vsr_t *xa, ppc_vsr_t *xb)                        \
 {                                                                         \
     ppc_vsr_t t = *xt;                                                    \
-    uint32_t crf6 = 0;                                                    \
+    target_ulong crf6 = 0;                                                \
     int i;                                                                \
     int all_true = 1;                                                     \
     int all_false = 1;                                                    \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee1e7..205792141d 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -67,7 +67,7 @@ DEF_HELPER_FLAGS_2(PEXTD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_1(CDTBCD, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(CBCDTD, TCG_CALL_NO_RWG_SE, tl, tl)
 #if defined(TARGET_PPC64)
-DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
+DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_3(srad, tl, env, tl, tl)
@@ -134,8 +134,8 @@ DEF_HELPER_2(frsqrte, i64, env, i64)
 DEF_HELPER_2(frsqrtes, i64, env, i64)
 DEF_HELPER_FLAGS_3(FSEL, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 
-DEF_HELPER_FLAGS_2(ftdiv, TCG_CALL_NO_RWG_SE, i32, i64, i64)
-DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, i32, i64)
+DEF_HELPER_FLAGS_2(ftdiv, TCG_CALL_NO_RWG_SE, tl, i64, i64)
+DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, tl, i64)
 
 #define dh_alias_avr ptr
 #define dh_ctype_avr ppc_avr_t *
@@ -229,10 +229,10 @@ DEF_HELPER_4(VINSBLX, void, env, avr, i64, tl)
 DEF_HELPER_4(VINSHLX, void, env, avr, i64, tl)
 DEF_HELPER_4(VINSWLX, void, env, avr, i64, tl)
 DEF_HELPER_4(VINSDLX, void, env, avr, i64, tl)
-DEF_HELPER_FLAGS_2(VSTRIBL, TCG_CALL_NO_RWG, i32, avr, avr)
-DEF_HELPER_FLAGS_2(VSTRIBR, TCG_CALL_NO_RWG, i32, avr, avr)
-DEF_HELPER_FLAGS_2(VSTRIHL, TCG_CALL_NO_RWG, i32, avr, avr)
-DEF_HELPER_FLAGS_2(VSTRIHR, TCG_CALL_NO_RWG, i32, avr, avr)
+DEF_HELPER_FLAGS_2(VSTRIBL, TCG_CALL_NO_RWG, tl, avr, avr)
+DEF_HELPER_FLAGS_2(VSTRIBR, TCG_CALL_NO_RWG, tl, avr, avr)
+DEF_HELPER_FLAGS_2(VSTRIHL, TCG_CALL_NO_RWG, tl, avr, avr)
+DEF_HELPER_FLAGS_2(VSTRIHR, TCG_CALL_NO_RWG, tl, avr, avr)
 DEF_HELPER_FLAGS_2(vupkhpx, TCG_CALL_NO_RWG, void, avr, avr)
 DEF_HELPER_FLAGS_2(vupklpx, TCG_CALL_NO_RWG, void, avr, avr)
 DEF_HELPER_FLAGS_2(vupkhsb, TCG_CALL_NO_RWG, void, avr, avr)
@@ -345,21 +345,21 @@ DEF_HELPER_FLAGS_3(vshasigmaw, TCG_CALL_NO_RWG, void, avr, avr, i32)
 DEF_HELPER_FLAGS_3(vshasigmad, TCG_CALL_NO_RWG, void, avr, avr, i32)
 DEF_HELPER_FLAGS_4(vpermxor, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
 
-DEF_HELPER_FLAGS_4(bcdadd, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_4(bcdsub, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_3(bcdcfn, TCG_CALL_NO_RWG, i32, avr, avr, i32)
-DEF_HELPER_FLAGS_3(bcdctn, TCG_CALL_NO_RWG, i32, avr, avr, i32)
-DEF_HELPER_FLAGS_3(bcdcfz, TCG_CALL_NO_RWG, i32, avr, avr, i32)
-DEF_HELPER_FLAGS_3(bcdctz, TCG_CALL_NO_RWG, i32, avr, avr, i32)
-DEF_HELPER_FLAGS_3(bcdcfsq, TCG_CALL_NO_RWG, i32, avr, avr, i32)
-DEF_HELPER_FLAGS_3(bcdctsq, TCG_CALL_NO_RWG, i32, avr, avr, i32)
-DEF_HELPER_FLAGS_4(bcdcpsgn, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_3(bcdsetsgn, TCG_CALL_NO_RWG, i32, avr, avr, i32)
-DEF_HELPER_FLAGS_4(bcds, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_4(bcdus, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_4(bcdsr, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_4(bcdtrunc, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_4(bcdutrunc, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_4(bcdadd, TCG_CALL_NO_RWG, tl, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_4(bcdsub, TCG_CALL_NO_RWG, tl, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_3(bcdcfn, TCG_CALL_NO_RWG, tl, avr, avr, i32)
+DEF_HELPER_FLAGS_3(bcdctn, TCG_CALL_NO_RWG, tl, avr, avr, i32)
+DEF_HELPER_FLAGS_3(bcdcfz, TCG_CALL_NO_RWG, tl, avr, avr, i32)
+DEF_HELPER_FLAGS_3(bcdctz, TCG_CALL_NO_RWG, tl, avr, avr, i32)
+DEF_HELPER_FLAGS_3(bcdcfsq, TCG_CALL_NO_RWG, tl, avr, avr, i32)
+DEF_HELPER_FLAGS_3(bcdctsq, TCG_CALL_NO_RWG, tl, avr, avr, i32)
+DEF_HELPER_FLAGS_4(bcdcpsgn, TCG_CALL_NO_RWG, tl, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_3(bcdsetsgn, TCG_CALL_NO_RWG, tl, avr, avr, i32)
+DEF_HELPER_FLAGS_4(bcds, TCG_CALL_NO_RWG, tl, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_4(bcdus, TCG_CALL_NO_RWG, tl, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_4(bcdsr, TCG_CALL_NO_RWG, tl, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_4(bcdtrunc, TCG_CALL_NO_RWG, tl, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_4(bcdutrunc, TCG_CALL_NO_RWG, tl, avr, avr, avr, i32)
 
 DEF_HELPER_4(xsadddp, void, env, vsr, vsr, vsr)
 DEF_HELPER_5(xsaddqp, void, env, i32, vsr, vsr, vsr)
@@ -473,10 +473,10 @@ DEF_HELPER_5(xvnmadddp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmsubdp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaxdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmindp, void, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpnedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, tl, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, tl, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, tl, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpnedp, TCG_CALL_NO_RWG, tl, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvcvdpsp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvdpsxds, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvdpsxws, void, env, vsr, vsr)
@@ -507,10 +507,10 @@ DEF_HELPER_5(xvnmaddsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmsubsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaxsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvminsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpnesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, tl, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, tl, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, tl, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(xvcmpnesp, TCG_CALL_NO_RWG, tl, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvcvspdp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvsphp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvhpsp, void, env, vsr, vsr)
@@ -613,18 +613,18 @@ DEF_HELPER_3(evfsadd, i64, env, i64, i64)
 DEF_HELPER_3(evfssub, i64, env, i64, i64)
 DEF_HELPER_3(evfsmul, i64, env, i64, i64)
 DEF_HELPER_3(evfsdiv, i64, env, i64, i64)
-DEF_HELPER_3(efststlt, i32, env, i32, i32)
-DEF_HELPER_3(efststgt, i32, env, i32, i32)
-DEF_HELPER_3(efststeq, i32, env, i32, i32)
-DEF_HELPER_3(efscmplt, i32, env, i32, i32)
-DEF_HELPER_3(efscmpgt, i32, env, i32, i32)
-DEF_HELPER_3(efscmpeq, i32, env, i32, i32)
-DEF_HELPER_3(evfststlt, i32, env, i64, i64)
-DEF_HELPER_3(evfststgt, i32, env, i64, i64)
-DEF_HELPER_3(evfststeq, i32, env, i64, i64)
-DEF_HELPER_3(evfscmplt, i32, env, i64, i64)
-DEF_HELPER_3(evfscmpgt, i32, env, i64, i64)
-DEF_HELPER_3(evfscmpeq, i32, env, i64, i64)
+DEF_HELPER_3(efststlt, tl, env, i32, i32)
+DEF_HELPER_3(efststgt, tl, env, i32, i32)
+DEF_HELPER_3(efststeq, tl, env, i32, i32)
+DEF_HELPER_3(efscmplt, tl, env, i32, i32)
+DEF_HELPER_3(efscmpgt, tl, env, i32, i32)
+DEF_HELPER_3(efscmpeq, tl, env, i32, i32)
+DEF_HELPER_3(evfststlt, tl, env, i64, i64)
+DEF_HELPER_3(evfststgt, tl, env, i64, i64)
+DEF_HELPER_3(evfststeq, tl, env, i64, i64)
+DEF_HELPER_3(evfscmplt, tl, env, i64, i64)
+DEF_HELPER_3(evfscmpgt, tl, env, i64, i64)
+DEF_HELPER_3(evfscmpeq, tl, env, i64, i64)
 DEF_HELPER_2(efdcfsi, i64, env, i32)
 DEF_HELPER_2(efdcfsid, i64, env, i64)
 DEF_HELPER_2(efdcfui, i64, env, i32)
@@ -645,12 +645,12 @@ DEF_HELPER_3(efdadd, i64, env, i64, i64)
 DEF_HELPER_3(efdsub, i64, env, i64, i64)
 DEF_HELPER_3(efdmul, i64, env, i64, i64)
 DEF_HELPER_3(efddiv, i64, env, i64, i64)
-DEF_HELPER_3(efdtstlt, i32, env, i64, i64)
-DEF_HELPER_3(efdtstgt, i32, env, i64, i64)
-DEF_HELPER_3(efdtsteq, i32, env, i64, i64)
-DEF_HELPER_3(efdcmplt, i32, env, i64, i64)
-DEF_HELPER_3(efdcmpgt, i32, env, i64, i64)
-DEF_HELPER_3(efdcmpeq, i32, env, i64, i64)
+DEF_HELPER_3(efdtstlt, tl, env, i64, i64)
+DEF_HELPER_3(efdtstgt, tl, env, i64, i64)
+DEF_HELPER_3(efdtsteq, tl, env, i64, i64)
+DEF_HELPER_3(efdcmplt, tl, env, i64, i64)
+DEF_HELPER_3(efdcmpgt, tl, env, i64, i64)
+DEF_HELPER_3(efdcmpeq, tl, env, i64, i64)
 
 #if !defined(CONFIG_USER_ONLY)
 DEF_HELPER_2(4xx_tlbre_hi, tl, env, tl)
@@ -770,20 +770,20 @@ DEF_HELPER_4(DMUL, void, env, fprp, fprp, fprp)
 DEF_HELPER_4(DMULQ, void, env, fprp, fprp, fprp)
 DEF_HELPER_4(DDIV, void, env, fprp, fprp, fprp)
 DEF_HELPER_4(DDIVQ, void, env, fprp, fprp, fprp)
-DEF_HELPER_3(DCMPO, i32, env, fprp, fprp)
-DEF_HELPER_3(DCMPOQ, i32, env, fprp, fprp)
-DEF_HELPER_3(DCMPU, i32, env, fprp, fprp)
-DEF_HELPER_3(DCMPUQ, i32, env, fprp, fprp)
-DEF_HELPER_3(DTSTDC, i32, env, fprp, i32)
-DEF_HELPER_3(DTSTDCQ, i32, env, fprp, i32)
-DEF_HELPER_3(DTSTDG, i32, env, fprp, i32)
-DEF_HELPER_3(DTSTDGQ, i32, env, fprp, i32)
-DEF_HELPER_3(DTSTEX, i32, env, fprp, fprp)
-DEF_HELPER_3(DTSTEXQ, i32, env, fprp, fprp)
-DEF_HELPER_3(DTSTSF, i32, env, fprp, fprp)
-DEF_HELPER_3(DTSTSFQ, i32, env, fprp, fprp)
-DEF_HELPER_3(DTSTSFI, i32, env, i32, fprp)
-DEF_HELPER_3(DTSTSFIQ, i32, env, i32, fprp)
+DEF_HELPER_3(DCMPO, tl, env, fprp, fprp)
+DEF_HELPER_3(DCMPOQ, tl, env, fprp, fprp)
+DEF_HELPER_3(DCMPU, tl, env, fprp, fprp)
+DEF_HELPER_3(DCMPUQ, tl, env, fprp, fprp)
+DEF_HELPER_3(DTSTDC, tl, env, fprp, i32)
+DEF_HELPER_3(DTSTDCQ, tl, env, fprp, i32)
+DEF_HELPER_3(DTSTDG, tl, env, fprp, i32)
+DEF_HELPER_3(DTSTDGQ, tl, env, fprp, i32)
+DEF_HELPER_3(DTSTEX, tl, env, fprp, fprp)
+DEF_HELPER_3(DTSTEXQ, tl, env, fprp, fprp)
+DEF_HELPER_3(DTSTSF, tl, env, fprp, fprp)
+DEF_HELPER_3(DTSTSFQ, tl, env, fprp, fprp)
+DEF_HELPER_3(DTSTSFI, tl, env, i32, fprp)
+DEF_HELPER_3(DTSTSFIQ, tl, env, i32, fprp)
 DEF_HELPER_5(DQUAI, void, env, fprp, fprp, i32, i32)
 DEF_HELPER_5(DQUAIQ, void, env, fprp, fprp, i32, i32)
 DEF_HELPER_5(DQUA, void, env, fprp, fprp, fprp, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 96cdb3c7e3..3ddff63509 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -158,7 +158,7 @@ uint64_t helper_divde(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
 /* When you XOR the pattern and there is a match, that byte will be zero */
 #define hasvalue(x, n)  (haszero((x) ^ pattern(n)))
 
-uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
+target_ulong helper_cmpeqb(target_ulong ra, target_ulong rb)
 {
     return hasvalue(rb, ra) ? CRF_GT : 0;
 }
@@ -1788,7 +1788,7 @@ VEXTRACT(d, u64)
 #undef VEXTRACT
 
 #define VSTRI(NAME, ELEM, NUM_ELEMS, LEFT) \
-uint32_t helper_##NAME(ppc_avr_t *t, ppc_avr_t *b) \
+target_ulong helper_##NAME(ppc_avr_t *t, ppc_avr_t *b) \
 {                                                   \
     int i, idx, crf = 0;                            \
                                                     \
@@ -2269,7 +2269,7 @@ static bool bcd_is_valid(ppc_avr_t *bcd)
     return true;
 }
 
-static int bcd_cmp_zero(ppc_avr_t *bcd)
+static target_ulong bcd_cmp_zero(ppc_avr_t *bcd)
 {
     if (bcd->VsrD(0) == 0 && (bcd->VsrD(1) >> 4) == 0) {
         return CRF_EQ;
@@ -2354,7 +2354,7 @@ static void bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
     *overflow = carry;
 }
 
-uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
 
     int sgna = bcd_get_sgn(a);
@@ -2362,7 +2362,7 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     int invalid = (sgna == 0) || (sgnb == 0);
     int overflow = 0;
     int zero = 0;
-    uint32_t cr = 0;
+    target_ulong cr = 0;
     ppc_avr_t result = { .u64 = { 0, 0 } };
 
     if (!invalid) {
@@ -2401,7 +2401,7 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdsub(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdsub(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     ppc_avr_t bcopy = *b;
     int sgnb = bcd_get_sgn(b);
@@ -2415,10 +2415,10 @@ uint32_t helper_bcdsub(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return helper_bcdadd(r, a, &bcopy, ps);
 }
 
-uint32_t helper_bcdcfn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdcfn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
-    int cr = 0;
+    target_ulong cr = 0;
     uint16_t national = 0;
     uint16_t sgnb = get_national_digit(b, 0);
     ppc_avr_t ret = { .u64 = { 0, 0 } };
@@ -2451,10 +2451,10 @@ uint32_t helper_bcdcfn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdctn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdctn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
-    int cr = 0;
+    target_ulong cr = 0;
     int sgnb = bcd_get_sgn(b);
     int invalid = (sgnb == 0);
     ppc_avr_t ret = { .u64 = { 0, 0 } };
@@ -2485,10 +2485,10 @@ uint32_t helper_bcdctn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
-    int cr = 0;
+    target_ulong cr = 0;
     int invalid = 0;
     int zone_digit = 0;
     int zone_lead = ps ? 0xF : 0x3;
@@ -2529,10 +2529,10 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
-    int cr = 0;
+    target_ulong cr = 0;
     uint8_t digit = 0;
     int sgnb = bcd_get_sgn(b);
     int zone_lead = (ps) ? 0xF0 : 0x30;
@@ -2588,10 +2588,10 @@ static inline int ucmp128(uint64_t alo, uint64_t ahi,
         (ahi > bhi ? 1 : -1);
 }
 
-uint32_t helper_bcdcfsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdcfsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
-    int cr;
+    target_ulong cr;
     uint64_t lo_value;
     uint64_t hi_value;
     uint64_t rem;
@@ -2646,10 +2646,10 @@ uint32_t helper_bcdcfsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdctsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdctsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     uint8_t i;
-    int cr;
+    target_ulong cr;
     uint64_t carry;
     uint64_t unused;
     uint64_t lo_value;
@@ -2686,7 +2686,7 @@ uint32_t helper_bcdctsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     int i;
     int invalid = 0;
@@ -2709,7 +2709,7 @@ uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(r);
 }
 
-uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int sgnb = bcd_get_sgn(b);
 
@@ -2723,9 +2723,9 @@ uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(r);
 }
 
-uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
-    int cr;
+    target_ulong cr;
     int i = a->VsrSB(7);
     bool ox_flag = false;
     int sgnb = bcd_get_sgn(b);
@@ -2759,9 +2759,9 @@ uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
-    int cr;
+    target_ulong cr;
     int i;
     int invalid = 0;
     bool ox_flag = false;
@@ -2796,9 +2796,9 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
-    int cr;
+    target_ulong cr;
     int unused = 0;
     int invalid = 0;
     bool ox_flag = false;
@@ -2842,10 +2842,10 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     uint64_t mask;
-    uint32_t ox_flag = 0;
+    target_ulong ox_flag = 0;
     int i = a->VsrSH(3) + 1;
     ppc_avr_t ret = *b;
 
@@ -2875,7 +2875,7 @@ uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(&ret) | ox_flag;
 }
 
-uint32_t helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+target_ulong helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     int i;
     uint64_t mask;
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 68cbdffecd..eef6dffed7 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -725,7 +725,7 @@ const VMStateDescription vmstate_ppc_cpu = {
 #if !defined(TARGET_PPC64)
         VMSTATE_UINTTL_ARRAY(env.gprh, PowerPCCPU, 32),
 #endif
-        VMSTATE_UINT32_ARRAY(env.crf, PowerPCCPU, 8),
+        VMSTATE_ARRAY(env.crf, PowerPCCPU, 8, 0, vmstate_info_uint32, target_ulong),
         VMSTATE_UINTTL(env.nip, PowerPCCPU),
 
         /* SPRs */
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5c28afbbb8..3472697b30 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -63,7 +63,7 @@ static char cpu_reg_names[10 * 3 + 22 * 4   /* GPR */
                           + 8 * 5           /* CRF */];
 static TCGv cpu_gpr[32];
 static TCGv cpu_gprh[32];
-static TCGv_i32 cpu_crf[8];
+static TCGv cpu_crf[8];
 static TCGv cpu_nip;
 static TCGv cpu_msr;
 static TCGv cpu_ctr;
@@ -92,8 +92,8 @@ void ppc_translate_init(void)
 
     for (i = 0; i < 8; i++) {
         snprintf(p, cpu_reg_names_size, "crf%d", i);
-        cpu_crf[i] = tcg_global_mem_new_i32(cpu_env,
-                                            offsetof(CPUPPCState, crf[i]), p);
+        cpu_crf[i] = tcg_global_mem_new(cpu_env,
+                                        offsetof(CPUPPCState, crf[i]), p);
         p += 5;
         cpu_reg_names_size -= 5;
     }
@@ -1473,7 +1473,7 @@ static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv_i32 t = tcg_temp_new_i32();
+    TCGv t = tcg_temp_new();
 
     tcg_gen_movi_tl(t0, CRF_EQ);
     tcg_gen_movi_tl(t1, CRF_LT);
@@ -1483,9 +1483,9 @@ static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
     tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU),
                        t0, arg0, arg1, t1, t0);
 
-    tcg_gen_trunc_tl_i32(t, t0);
-    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
-    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t);
+    tcg_gen_mov_tl(t, t0);
+    tcg_gen_mov_tl(cpu_crf[crf], cpu_so);
+    tcg_gen_or_tl(cpu_crf[crf], cpu_crf[crf], t);
 }
 
 static inline void gen_op_cmpi(TCGv arg0, target_ulong arg1, int s, int crf)
@@ -1527,35 +1527,35 @@ static inline void gen_set_Rc0(DisasContext *ctx, TCGv reg)
 /* cmprb - range comparison: isupper, isaplha, islower*/
 static void gen_cmprb(DisasContext *ctx)
 {
-    TCGv_i32 src1 = tcg_temp_new_i32();
-    TCGv_i32 src2 = tcg_temp_new_i32();
-    TCGv_i32 src2lo = tcg_temp_new_i32();
-    TCGv_i32 src2hi = tcg_temp_new_i32();
-    TCGv_i32 crf = cpu_crf[crfD(ctx->opcode)];
+    TCGv src1 = tcg_temp_new();
+    TCGv src2 = tcg_temp_new();
+    TCGv src2lo = tcg_temp_new();
+    TCGv src2hi = tcg_temp_new();
+    TCGv crf = cpu_crf[crfD(ctx->opcode)];
 
-    tcg_gen_trunc_tl_i32(src1, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(src2, cpu_gpr[rB(ctx->opcode)]);
+    tcg_gen_mov_tl(src1, cpu_gpr[rA(ctx->opcode)]);
+    tcg_gen_mov_tl(src2, cpu_gpr[rB(ctx->opcode)]);
 
-    tcg_gen_andi_i32(src1, src1, 0xFF);
-    tcg_gen_ext8u_i32(src2lo, src2);
-    tcg_gen_shri_i32(src2, src2, 8);
-    tcg_gen_ext8u_i32(src2hi, src2);
+    tcg_gen_andi_tl(src1, src1, 0xFF);
+    tcg_gen_ext8u_tl(src2lo, src2);
+    tcg_gen_shri_tl(src2, src2, 8);
+    tcg_gen_ext8u_tl(src2hi, src2);
 
-    tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
-    tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
-    tcg_gen_and_i32(crf, src2lo, src2hi);
+    tcg_gen_setcond_tl(TCG_COND_LEU, src2lo, src2lo, src1);
+    tcg_gen_setcond_tl(TCG_COND_LEU, src2hi, src1, src2hi);
+    tcg_gen_and_tl(crf, src2lo, src2hi);
 
     if (ctx->opcode & 0x00200000) {
-        tcg_gen_shri_i32(src2, src2, 8);
-        tcg_gen_ext8u_i32(src2lo, src2);
-        tcg_gen_shri_i32(src2, src2, 8);
-        tcg_gen_ext8u_i32(src2hi, src2);
-        tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
-        tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
-        tcg_gen_and_i32(src2lo, src2lo, src2hi);
-        tcg_gen_or_i32(crf, crf, src2lo);
+        tcg_gen_shri_tl(src2, src2, 8);
+        tcg_gen_ext8u_tl(src2lo, src2);
+        tcg_gen_shri_tl(src2, src2, 8);
+        tcg_gen_ext8u_tl(src2hi, src2);
+        tcg_gen_setcond_tl(TCG_COND_LEU, src2lo, src2lo, src1);
+        tcg_gen_setcond_tl(TCG_COND_LEU, src2hi, src1, src2hi);
+        tcg_gen_and_tl(src2lo, src2lo, src2hi);
+        tcg_gen_or_tl(crf, crf, src2lo);
     }
-    tcg_gen_shli_i32(crf, crf, CRF_GT_BIT);
+    tcg_gen_shli_tl(crf, crf, CRF_GT_BIT);
 }
 
 #if defined(TARGET_PPC64)
@@ -1575,7 +1575,7 @@ static void gen_isel(DisasContext *ctx)
     TCGv t0 = tcg_temp_new();
     TCGv zr;
 
-    tcg_gen_extu_i32_tl(t0, cpu_crf[bi >> 2]);
+    tcg_gen_mov_tl(t0, cpu_crf[bi >> 2]);
     tcg_gen_andi_tl(t0, t0, mask);
 
     zr = tcg_constant_tl(0);
@@ -3829,7 +3829,7 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
     tcg_gen_or_tl(cr0, cr0, t0);
 
     gen_set_label(lfail);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
+    tcg_gen_mov_tl(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 
@@ -3928,7 +3928,7 @@ static void gen_stqcx_(DisasContext *ctx)
     tcg_gen_or_tl(cr0, cr0, t0);
 
     gen_set_label(lfail);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
+    tcg_gen_mov_tl(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 #endif /* defined(TARGET_PPC64) */
@@ -4350,14 +4350,14 @@ static void gen_bcond(DisasContext *ctx, int type)
         /* Test CR */
         uint32_t bi = BI(ctx->opcode);
         uint32_t mask = 0x08 >> (bi & 0x03);
-        TCGv_i32 temp = tcg_temp_new_i32();
+        TCGv temp = tcg_temp_new();
 
         if (bo & 0x8) {
-            tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
-            tcg_gen_brcondi_i32(TCG_COND_EQ, temp, 0, l1);
+            tcg_gen_andi_tl(temp, cpu_crf[bi >> 2], mask);
+            tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, l1);
         } else {
-            tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
-            tcg_gen_brcondi_i32(TCG_COND_NE, temp, 0, l1);
+            tcg_gen_andi_tl(temp, cpu_crf[bi >> 2], mask);
+            tcg_gen_brcondi_tl(TCG_COND_NE, temp, 0, l1);
         }
     }
     gen_update_cfar(ctx, ctx->cia);
@@ -4410,51 +4410,51 @@ static void glue(gen_, name)(DisasContext *ctx)                               \
 {                                                                             \
     uint8_t bitmask;                                                          \
     int sh;                                                                   \
-    TCGv_i32 t0, t1;                                                          \
+    TCGv t0, t1;                                                              \
     sh = (crbD(ctx->opcode) & 0x03) - (crbA(ctx->opcode) & 0x03);             \
-    t0 = tcg_temp_new_i32();                                                  \
+    t0 = tcg_temp_new();                                                      \
     if (sh > 0)                                                               \
-        tcg_gen_shri_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2], sh);            \
+        tcg_gen_shri_tl(t0, cpu_crf[crbA(ctx->opcode) >> 2], sh);             \
     else if (sh < 0)                                                          \
-        tcg_gen_shli_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2], -sh);           \
+        tcg_gen_shli_tl(t0, cpu_crf[crbA(ctx->opcode) >> 2], -sh);            \
     else                                                                      \
-        tcg_gen_mov_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2]);                 \
-    t1 = tcg_temp_new_i32();                                                  \
+        tcg_gen_mov_tl(t0, cpu_crf[crbA(ctx->opcode) >> 2]);                  \
+    t1 = tcg_temp_new();                                                      \
     sh = (crbD(ctx->opcode) & 0x03) - (crbB(ctx->opcode) & 0x03);             \
     if (sh > 0)                                                               \
-        tcg_gen_shri_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2], sh);            \
+        tcg_gen_shri_tl(t1, cpu_crf[crbB(ctx->opcode) >> 2], sh);             \
     else if (sh < 0)                                                          \
-        tcg_gen_shli_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2], -sh);           \
+        tcg_gen_shli_tl(t1, cpu_crf[crbB(ctx->opcode) >> 2], -sh);            \
     else                                                                      \
-        tcg_gen_mov_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2]);                 \
+        tcg_gen_mov_tl(t1, cpu_crf[crbB(ctx->opcode) >> 2]);                  \
     tcg_op(t0, t0, t1);                                                       \
     bitmask = 0x08 >> (crbD(ctx->opcode) & 0x03);                             \
-    tcg_gen_andi_i32(t0, t0, bitmask);                                        \
-    tcg_gen_andi_i32(t1, cpu_crf[crbD(ctx->opcode) >> 2], ~bitmask);          \
-    tcg_gen_or_i32(cpu_crf[crbD(ctx->opcode) >> 2], t0, t1);                  \
+    tcg_gen_andi_tl(t0, t0, bitmask);                                         \
+    tcg_gen_andi_tl(t1, cpu_crf[crbD(ctx->opcode) >> 2], ~bitmask);           \
+    tcg_gen_or_tl(cpu_crf[crbD(ctx->opcode) >> 2], t0, t1);                   \
 }
 
 /* crand */
-GEN_CRLOGIC(crand, tcg_gen_and_i32, 0x08);
+GEN_CRLOGIC(crand, tcg_gen_and_tl, 0x08);
 /* crandc */
-GEN_CRLOGIC(crandc, tcg_gen_andc_i32, 0x04);
+GEN_CRLOGIC(crandc, tcg_gen_andc_tl, 0x04);
 /* creqv */
-GEN_CRLOGIC(creqv, tcg_gen_eqv_i32, 0x09);
+GEN_CRLOGIC(creqv, tcg_gen_eqv_tl, 0x09);
 /* crnand */
-GEN_CRLOGIC(crnand, tcg_gen_nand_i32, 0x07);
+GEN_CRLOGIC(crnand, tcg_gen_nand_tl, 0x07);
 /* crnor */
-GEN_CRLOGIC(crnor, tcg_gen_nor_i32, 0x01);
+GEN_CRLOGIC(crnor, tcg_gen_nor_tl, 0x01);
 /* cror */
-GEN_CRLOGIC(cror, tcg_gen_or_i32, 0x0E);
+GEN_CRLOGIC(cror, tcg_gen_or_tl, 0x0E);
 /* crorc */
-GEN_CRLOGIC(crorc, tcg_gen_orc_i32, 0x0D);
+GEN_CRLOGIC(crorc, tcg_gen_orc_tl, 0x0D);
 /* crxor */
-GEN_CRLOGIC(crxor, tcg_gen_xor_i32, 0x06);
+GEN_CRLOGIC(crxor, tcg_gen_xor_tl, 0x06);
 
 /* mcrf */
 static void gen_mcrf(DisasContext *ctx)
 {
-    tcg_gen_mov_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfS(ctx->opcode)]);
+    tcg_gen_mov_tl(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfS(ctx->opcode)]);
 }
 
 /***                           System linkage                              ***/
@@ -4639,18 +4639,18 @@ static void gen_tdi(DisasContext *ctx)
 /* mcrxr */
 static void gen_mcrxr(DisasContext *ctx)
 {
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t1 = tcg_temp_new_i32();
-    TCGv_i32 dst = cpu_crf[crfD(ctx->opcode)];
-
-    tcg_gen_trunc_tl_i32(t0, cpu_so);
-    tcg_gen_trunc_tl_i32(t1, cpu_ov);
-    tcg_gen_trunc_tl_i32(dst, cpu_ca);
-    tcg_gen_shli_i32(t0, t0, 3);
-    tcg_gen_shli_i32(t1, t1, 2);
-    tcg_gen_shli_i32(dst, dst, 1);
-    tcg_gen_or_i32(dst, dst, t0);
-    tcg_gen_or_i32(dst, dst, t1);
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv dst = cpu_crf[crfD(ctx->opcode)];
+
+    tcg_gen_mov_tl(t0, cpu_so);
+    tcg_gen_mov_tl(t1, cpu_ov);
+    tcg_gen_mov_tl(dst, cpu_ca);
+    tcg_gen_shli_tl(t0, t0, 3);
+    tcg_gen_shli_tl(t1, t1, 2);
+    tcg_gen_shli_tl(dst, dst, 1);
+    tcg_gen_or_tl(dst, dst, t0);
+    tcg_gen_or_tl(dst, dst, t1);
 
     tcg_gen_movi_tl(cpu_so, 0);
     tcg_gen_movi_tl(cpu_ov, 0);
@@ -4663,7 +4663,7 @@ static void gen_mcrxrx(DisasContext *ctx)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv_i32 dst = cpu_crf[crfD(ctx->opcode)];
+    TCGv dst = cpu_crf[crfD(ctx->opcode)];
 
     /* copy OV and OV32 */
     tcg_gen_shli_tl(t0, cpu_ov, 1);
@@ -4673,7 +4673,7 @@ static void gen_mcrxrx(DisasContext *ctx)
     tcg_gen_shli_tl(t1, cpu_ca, 1);
     tcg_gen_or_tl(t1, t1, cpu_ca32);
     tcg_gen_or_tl(t0, t0, t1);
-    tcg_gen_trunc_tl_i32(dst, t0);
+    tcg_gen_mov_tl(dst, t0);
 }
 #endif
 
@@ -4686,28 +4686,28 @@ static void gen_mfcr(DisasContext *ctx)
         crm = CRM(ctx->opcode);
         if (likely(crm && ((crm & (crm - 1)) == 0))) {
             crn = ctz32(crm);
-            tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], cpu_crf[7 - crn]);
+            tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_crf[7 - crn]);
             tcg_gen_shli_tl(cpu_gpr[rD(ctx->opcode)],
                             cpu_gpr[rD(ctx->opcode)], crn * 4);
         }
     } else {
-        TCGv_i32 t0 = tcg_temp_new_i32();
-        tcg_gen_mov_i32(t0, cpu_crf[0]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[1]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[2]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[3]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[4]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[5]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[6]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[7]);
-        tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t0);
+        TCGv t0 = tcg_temp_new();
+        tcg_gen_mov_tl(t0, cpu_crf[0]);
+        tcg_gen_shli_tl(t0, t0, 4);
+        tcg_gen_or_tl(t0, t0, cpu_crf[1]);
+        tcg_gen_shli_tl(t0, t0, 4);
+        tcg_gen_or_tl(t0, t0, cpu_crf[2]);
+        tcg_gen_shli_tl(t0, t0, 4);
+        tcg_gen_or_tl(t0, t0, cpu_crf[3]);
+        tcg_gen_shli_tl(t0, t0, 4);
+        tcg_gen_or_tl(t0, t0, cpu_crf[4]);
+        tcg_gen_shli_tl(t0, t0, 4);
+        tcg_gen_or_tl(t0, t0, cpu_crf[5]);
+        tcg_gen_shli_tl(t0, t0, 4);
+        tcg_gen_or_tl(t0, t0, cpu_crf[6]);
+        tcg_gen_shli_tl(t0, t0, 4);
+        tcg_gen_or_tl(t0, t0, cpu_crf[7]);
+        tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], t0);
     }
 }
 
@@ -4799,19 +4799,19 @@ static void gen_mtcrf(DisasContext *ctx)
     crm = CRM(ctx->opcode);
     if (likely((ctx->opcode & 0x00100000))) {
         if (crm && ((crm & (crm - 1)) == 0)) {
-            TCGv_i32 temp = tcg_temp_new_i32();
+            TCGv temp = tcg_temp_new();
             crn = ctz32(crm);
-            tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
-            tcg_gen_shri_i32(temp, temp, crn * 4);
-            tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
+            tcg_gen_mov_tl(temp, cpu_gpr[rS(ctx->opcode)]);
+            tcg_gen_shri_tl(temp, temp, crn * 4);
+            tcg_gen_andi_tl(cpu_crf[7 - crn], temp, 0xf);
         }
     } else {
-        TCGv_i32 temp = tcg_temp_new_i32();
-        tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
+        TCGv temp = tcg_temp_new();
+        tcg_gen_mov_tl(temp, cpu_gpr[rS(ctx->opcode)]);
         for (crn = 0 ; crn < 8 ; crn++) {
             if (crm & (1 << crn)) {
-                    tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
-                    tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
+                    tcg_gen_shri_tl(cpu_crf[7 - crn], temp, crn * 4);
+                    tcg_gen_andi_tl(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
             }
         }
     }
@@ -4963,14 +4963,14 @@ static void gen_mtspr(DisasContext *ctx)
 /* setb */
 static void gen_setb(DisasContext *ctx)
 {
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t8 = tcg_constant_i32(8);
-    TCGv_i32 tm1 = tcg_constant_i32(-1);
+    TCGv t0 = tcg_temp_new();
+    TCGv t8 = tcg_constant_tl(8);
+    TCGv tm1 = tcg_constant_tl(-1);
     int crf = crfS(ctx->opcode);
 
-    tcg_gen_setcondi_i32(TCG_COND_GEU, t0, cpu_crf[crf], 4);
-    tcg_gen_movcond_i32(TCG_COND_GEU, t0, cpu_crf[crf], t8, tm1, t0);
-    tcg_gen_ext_i32_tl(cpu_gpr[rD(ctx->opcode)], t0);
+    tcg_gen_setcondi_tl(TCG_COND_GEU, t0, cpu_crf[crf], 4);
+    tcg_gen_movcond_tl(TCG_COND_GEU, t0, cpu_crf[crf], t8, tm1, t0);
+    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], t0);
 }
 #endif
 
@@ -5826,9 +5826,9 @@ static void gen_tlbsx_40x(DisasContext *ctx)
     gen_helper_4xx_tlbsx(cpu_gpr[rD(ctx->opcode)], cpu_env, t0);
     if (Rc(ctx->opcode)) {
         TCGLabel *l1 = gen_new_label();
-        tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+        tcg_gen_mov_tl(cpu_crf[0], cpu_so);
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr[rD(ctx->opcode)], -1, l1);
-        tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], 0x02);
+        tcg_gen_ori_tl(cpu_crf[0], cpu_crf[0], 0x02);
         gen_set_label(l1);
     }
 #endif /* defined(CONFIG_USER_ONLY) */
@@ -5899,9 +5899,9 @@ static void gen_tlbsx_440(DisasContext *ctx)
     gen_helper_440_tlbsx(cpu_gpr[rD(ctx->opcode)], cpu_env, t0);
     if (Rc(ctx->opcode)) {
         TCGLabel *l1 = gen_new_label();
-        tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+        tcg_gen_mov_tl(cpu_crf[0], cpu_so);
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr[rD(ctx->opcode)], -1, l1);
-        tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], 0x02);
+        tcg_gen_ori_tl(cpu_crf[0], cpu_crf[0], 0x02);
         gen_set_label(l1);
     }
 #endif /* defined(CONFIG_USER_ONLY) */
@@ -6146,7 +6146,7 @@ static inline void gen_##name(DisasContext *ctx)               \
      *     CR[0] = 0b0 || MSR[TS] || 0b0                       \
      *           = 0b0 || 0b00    || 0b0                       \
      */                                                        \
-    tcg_gen_movi_i32(cpu_crf[0], 0);                           \
+    tcg_gen_movi_tl(cpu_crf[0], 0);                            \
 }
 
 GEN_TM_NOOP(tend);
@@ -6188,7 +6188,7 @@ static void gen_tcheck(DisasContext *ctx)
      * CR[CRF] = TDOOMED || MSR[TS] || 0b0
      *         = 0b1 || 0b00 || 0b0
      */
-    tcg_gen_movi_i32(cpu_crf[crfD(ctx->opcode)], 0x8);
+    tcg_gen_movi_tl(cpu_crf[crfD(ctx->opcode)], 0x8);
 }
 
 #if defined(CONFIG_USER_ONLY)
@@ -6215,7 +6215,7 @@ static inline void gen_##name(DisasContext *ctx)               \
      *   CR[0] = 0b0 || MSR[TS] || 0b0                         \
      *         = 0b0 || 0b00 | 0b0                             \
      */                                                        \
-    tcg_gen_movi_i32(cpu_crf[0], 0);                           \
+    tcg_gen_movi_tl(cpu_crf[0], 0);                            \
 }
 
 #endif
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 7ff7e1ec46..1ad4049df6 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -344,7 +344,7 @@ static bool do_set_bool_cond(DisasContext *ctx, arg_X_bi *a, bool neg, bool rev)
     TCGv temp = tcg_temp_new();
     TCGv zero = tcg_constant_tl(0);
 
-    tcg_gen_extu_i32_tl(temp, cpu_crf[a->bi >> 2]);
+    tcg_gen_mov_tl(temp, cpu_crf[a->bi >> 2]);
     tcg_gen_andi_tl(temp, temp, mask);
     if (neg) {
         tcg_gen_negsetcond_tl(cond, cpu_gpr[a->rt], temp, zero);
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 874774eade..4e355cb379 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -18,9 +18,9 @@ static inline void gen_compute_fprf_float64(TCGv_i64 arg)
 #if defined(TARGET_PPC64)
 static void gen_set_cr1_from_fpscr(DisasContext *ctx)
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_trunc_tl_i32(tmp, cpu_fpscr);
-    tcg_gen_shri_i32(cpu_crf[1], tmp, 28);
+    TCGv tmp = tcg_temp_new();
+    tcg_gen_mov_tl(tmp, cpu_fpscr);
+    tcg_gen_shri_tl(cpu_crf[1], tmp, 28);
 }
 #else
 static void gen_set_cr1_from_fpscr(DisasContext *ctx)
@@ -533,8 +533,8 @@ static void gen_mcrfs(DisasContext *ctx)
     nibble = 7 - bfa;
     shift = 4 * nibble;
     tcg_gen_shri_tl(tmp, cpu_fpscr, shift);
-    tcg_gen_trunc_tl_i32(cpu_crf[crfD(ctx->opcode)], tmp);
-    tcg_gen_andi_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcode)],
+    tcg_gen_mov_tl(cpu_crf[crfD(ctx->opcode)], tmp);
+    tcg_gen_andi_tl(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcode)],
                      0xf);
     tcg_gen_extu_tl_i64(tnew_fpscr, cpu_fpscr);
     /* Only the exception bits (including FX) should be cleared if read */
@@ -694,8 +694,8 @@ static void gen_mtfsb0(DisasContext *ctx)
         gen_helper_fpscr_clrbit(cpu_env, tcg_constant_i32(crb));
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
-        tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
+        tcg_gen_mov_tl(cpu_crf[1], cpu_fpscr);
+        tcg_gen_shri_tl(cpu_crf[1], cpu_crf[1], FPSCR_OX);
     }
 }
 
@@ -714,8 +714,8 @@ static void gen_mtfsb1(DisasContext *ctx)
         gen_helper_fpscr_setbit(cpu_env, tcg_constant_i32(crb));
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
-        tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
+        tcg_gen_mov_tl(cpu_crf[1], cpu_fpscr);
+        tcg_gen_shri_tl(cpu_crf[1], cpu_crf[1], FPSCR_OX);
     }
     /* We can raise a deferred exception */
     gen_helper_fpscr_check_status(cpu_env);
@@ -750,8 +750,8 @@ static void gen_mtfsf(DisasContext *ctx)
     get_fpr(t1, rB(ctx->opcode));
     gen_helper_store_fpscr(cpu_env, t1, t0);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
-        tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
+        tcg_gen_mov_tl(cpu_crf[1], cpu_fpscr);
+        tcg_gen_shri_tl(cpu_crf[1], cpu_crf[1], FPSCR_OX);
     }
     /* We can raise a deferred exception */
     gen_helper_fpscr_check_status(cpu_env);
@@ -779,8 +779,8 @@ static void gen_mtfsfi(DisasContext *ctx)
     t1 = tcg_constant_i32(1 << sh);
     gen_helper_store_fpscr(cpu_env, t0, t1);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
-        tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
+        tcg_gen_mov_tl(cpu_crf[1], cpu_fpscr);
+        tcg_gen_shri_tl(cpu_crf[1], cpu_crf[1], FPSCR_OX);
     }
     /* We can raise a deferred exception */
     gen_helper_fpscr_check_status(cpu_env);
diff --git a/target/ppc/translate/spe-impl.c.inc b/target/ppc/translate/spe-impl.c.inc
index f4a858487d..a456cadfb5 100644
--- a/target/ppc/translate/spe-impl.c.inc
+++ b/target/ppc/translate/spe-impl.c.inc
@@ -269,19 +269,19 @@ static inline void gen_##name(DisasContext *ctx)                              \
                                                                               \
     tcg_gen_brcond_tl(tcg_cond, cpu_gpr[rA(ctx->opcode)],                     \
                        cpu_gpr[rB(ctx->opcode)], l1);                         \
-    tcg_gen_movi_i32(cpu_crf[crfD(ctx->opcode)], 0);                          \
+    tcg_gen_movi_tl(cpu_crf[crfD(ctx->opcode)], 0);                           \
     tcg_gen_br(l2);                                                           \
     gen_set_label(l1);                                                        \
-    tcg_gen_movi_i32(cpu_crf[crfD(ctx->opcode)],                              \
+    tcg_gen_movi_tl(cpu_crf[crfD(ctx->opcode)],                               \
                      CRF_CL | CRF_CH_OR_CL | CRF_CH_AND_CL);                  \
     gen_set_label(l2);                                                        \
     tcg_gen_brcond_tl(tcg_cond, cpu_gprh[rA(ctx->opcode)],                    \
                        cpu_gprh[rB(ctx->opcode)], l3);                        \
-    tcg_gen_andi_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcode)],  \
+    tcg_gen_andi_tl(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcode)],   \
                      ~(CRF_CH | CRF_CH_AND_CL));                              \
     tcg_gen_br(l4);                                                           \
     gen_set_label(l3);                                                        \
-    tcg_gen_ori_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcode)],   \
+    tcg_gen_ori_tl(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcode)],    \
                     CRF_CH | CRF_CH_OR_CL);                                   \
     gen_set_label(l4);                                                        \
 }
@@ -363,17 +363,17 @@ static inline void gen_evsel(DisasContext *ctx)
     TCGLabel *l2 = gen_new_label();
     TCGLabel *l3 = gen_new_label();
     TCGLabel *l4 = gen_new_label();
-    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv t0 = tcg_temp_new();
 
-    tcg_gen_andi_i32(t0, cpu_crf[ctx->opcode & 0x07], 1 << 3);
-    tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0, l1);
+    tcg_gen_andi_tl(t0, cpu_crf[ctx->opcode & 0x07], 1 << 3);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, l1);
     tcg_gen_mov_tl(cpu_gprh[rD(ctx->opcode)], cpu_gprh[rA(ctx->opcode)]);
     tcg_gen_br(l2);
     gen_set_label(l1);
     tcg_gen_mov_tl(cpu_gprh[rD(ctx->opcode)], cpu_gprh[rB(ctx->opcode)]);
     gen_set_label(l2);
-    tcg_gen_andi_i32(t0, cpu_crf[ctx->opcode & 0x07], 1 << 2);
-    tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0, l3);
+    tcg_gen_andi_tl(t0, cpu_crf[ctx->opcode & 0x07], 1 << 2);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, l3);
     tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
     tcg_gen_br(l4);
     gen_set_label(l3);
diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
index faa7b04bbc..bd381039e4 100644
--- a/target/ppc/translate/storage-ctrl-impl.c.inc
+++ b/target/ppc/translate/storage-ctrl-impl.c.inc
@@ -141,9 +141,9 @@ static bool trans_SLBFEE(DisasContext *ctx, arg_SLBFEE *a)
                              cpu_gpr[a->rb]);
     l1 = gen_new_label();
     l2 = gen_new_label();
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+    tcg_gen_mov_tl(cpu_crf[0], cpu_so);
     tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr[a->rt], -1, l1);
-    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
+    tcg_gen_ori_tl(cpu_crf[0], cpu_crf[0], CRF_EQ);
     tcg_gen_br(l2);
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_gpr[a->rt], 0);
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 6d7669aabd..48d43e84e9 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -1230,7 +1230,7 @@ static void do_vcmp_rc(int vrt)
     tcg_gen_shli_i64(set, set, 3);
 
     tcg_gen_or_i64(tmp, set, clr);
-    tcg_gen_extrl_i64_i32(cpu_crf[6], tmp);
+    tcg_gen_trunc_i64_tl(cpu_crf[6], tmp);
 }
 
 static bool do_vcmp(DisasContext *ctx, arg_VC *a, TCGCond cond, int vece)
@@ -1347,9 +1347,9 @@ static bool trans_VCMPEQUQ(DisasContext *ctx, arg_VC *a)
     set_avr64(a->vrt, t1, false);
 
     if (a->rc) {
-        tcg_gen_extrl_i64_i32(cpu_crf[6], t1);
-        tcg_gen_andi_i32(cpu_crf[6], cpu_crf[6], 0xa);
-        tcg_gen_xori_i32(cpu_crf[6], cpu_crf[6], 0x2);
+        tcg_gen_trunc_i64_tl(cpu_crf[6], t1);
+        tcg_gen_andi_tl(cpu_crf[6], cpu_crf[6], 0xa);
+        tcg_gen_xori_tl(cpu_crf[6], cpu_crf[6], 0x2);
     }
     return true;
 }
@@ -1377,9 +1377,9 @@ static bool do_vcmpgtq(DisasContext *ctx, arg_VC *a, bool sign)
     set_avr64(a->vrt, t1, false);
 
     if (a->rc) {
-        tcg_gen_extrl_i64_i32(cpu_crf[6], t1);
-        tcg_gen_andi_i32(cpu_crf[6], cpu_crf[6], 0xa);
-        tcg_gen_xori_i32(cpu_crf[6], cpu_crf[6], 0x2);
+        tcg_gen_trunc_i64_tl(cpu_crf[6], t1);
+        tcg_gen_andi_tl(cpu_crf[6], cpu_crf[6], 0xa);
+        tcg_gen_xori_tl(cpu_crf[6], cpu_crf[6], 0x2);
     }
     return true;
 }
@@ -1411,15 +1411,15 @@ static bool do_vcmpq(DisasContext *ctx, arg_VX_bf *a, bool sign)
     tcg_gen_brcond_i64(TCG_COND_GTU, vra, vrb, gt);
     tcg_gen_brcond_i64(TCG_COND_LTU, vra, vrb, lt);
 
-    tcg_gen_movi_i32(cpu_crf[a->bf], CRF_EQ);
+    tcg_gen_movi_tl(cpu_crf[a->bf], CRF_EQ);
     tcg_gen_br(done);
 
     gen_set_label(gt);
-    tcg_gen_movi_i32(cpu_crf[a->bf], CRF_GT);
+    tcg_gen_movi_tl(cpu_crf[a->bf], CRF_GT);
     tcg_gen_br(done);
 
     gen_set_label(lt);
-    tcg_gen_movi_i32(cpu_crf[a->bf], CRF_LT);
+    tcg_gen_movi_tl(cpu_crf[a->bf], CRF_LT);
     tcg_gen_br(done);
 
     gen_set_label(done);
@@ -2262,7 +2262,7 @@ TRANS(VCNTMBW, do_vcntmb, MO_32)
 TRANS(VCNTMBD, do_vcntmb, MO_64)
 
 static bool do_vstri(DisasContext *ctx, arg_VX_tb_rc *a,
-                     void (*gen_helper)(TCGv_i32, TCGv_ptr, TCGv_ptr))
+                     void (*gen_helper)(TCGv, TCGv_ptr, TCGv_ptr))
 {
     TCGv_ptr vrt, vrb;
 
@@ -2275,7 +2275,7 @@ static bool do_vstri(DisasContext *ctx, arg_VX_tb_rc *a,
     if (a->rc) {
         gen_helper(cpu_crf[6], vrt, vrb);
     } else {
-        TCGv_i32 discard = tcg_temp_new_i32();
+        TCGv discard = tcg_temp_new();
         gen_helper(discard, vrt, vrb);
     }
     return true;
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 0f5b0056f1..3aaf358250 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -791,7 +791,7 @@ TRANS(XVCPSGNDP, do_xvcpsgn, MO_64)
 #define VSX_CMP(name, op1, op2, inval, type)                                  \
 static void gen_##name(DisasContext *ctx)                                     \
 {                                                                             \
-    TCGv_i32 ignored;                                                         \
+    TCGv ignored;                                                             \
     TCGv_ptr xt, xa, xb;                                                      \
     if (unlikely(!ctx->vsx_enabled)) {                                        \
         gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
@@ -803,7 +803,7 @@ static void gen_##name(DisasContext *ctx)                                     \
     if ((ctx->opcode >> (31 - 21)) & 1) {                                     \
         gen_helper_##name(cpu_crf[6], cpu_env, xt, xa, xb);                   \
     } else {                                                                  \
-        ignored = tcg_temp_new_i32();                                         \
+        ignored = tcg_temp_new();                                             \
         gen_helper_##name(ignored, cpu_env, xt, xa, xb);                      \
     }                                                                         \
 }
@@ -1808,7 +1808,7 @@ static bool trans_XVTLSBB(DisasContext *ctx, arg_XX2_bf_xb *a)
     tcg_gen_shli_i64(all_true, all_true, 3);
 
     tcg_gen_or_i64(t0, all_false, all_true);
-    tcg_gen_extrl_i64_i32(cpu_crf[a->bf], t0);
+    tcg_gen_trunc_i64_tl(cpu_crf[a->bf], t0);
     return true;
 }
 
-- 
2.40.1


