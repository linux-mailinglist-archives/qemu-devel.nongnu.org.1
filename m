Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E42DB8CF726
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 02:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZl-0007gg-39; Sun, 26 May 2024 20:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZO-0007ID-9X
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZK-0003hk-2l
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8eba8dcfcso2265514b3a.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771023; x=1717375823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StedKx2if52BenXHp9OmhhxzvGoDONYhwtdzrxe9+sA=;
 b=N671Vlv9cuhdbJbK/NUoVgALEYRnbE4/VwUHSP7NKwOfdzjDKO/Es+rIj+GqkU8KNy
 fNd8Fu39ZLGaSJzP8vASDrmbRgs2ub8LjDtdTnFMhho37sJkBByZAqnEtwBby1JF9LRr
 Un4cumerubelcajuNjNvOwO3VZjjfI/mcbMeXanQBdPXYVyoeG042gb7ofMKApEh9cta
 0vWYuFVPM/tE1gTCKaozHrxPDTI+n9Ub6WQDvI2hW3EKwRXmYsuAuVixnFKS+7JlMuBg
 3jPMXF2EHdW69MjzjEtsqPH5vHN+Dyy6MKnwvEldSz8O4M8LvKy+cyPpngpHj+p8DClJ
 7Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771023; x=1717375823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StedKx2if52BenXHp9OmhhxzvGoDONYhwtdzrxe9+sA=;
 b=grQ0DvTxImcSGZQG/pMZjfSpZZ/e4LjxEpbeNtS8trpwA1MmY6G5BQJoBJk8PRS4Qe
 J+vEgpuSZNukqzaqpDXUco7YWUYXWYPz68VUUSJ3oBNX4hrkrRTTVmaZ1sEzNGIZN1Xv
 goNnW8XTWBXykDWkGv5XD+oMLEeOu1fNq92jq+tkLINdLno4eO2y210TYys69e2H2ACO
 BF3UW/4P/MXfFlRYF9+k/8AXSfUurQ4COkSKLlDtwe7D0rsO75USFZ4Ryfr3xlVxyySt
 2ftUfkCQhNihCXJCJVHj3pAyyWiphFTLn8J19Jf4Mu+WBHMH6vb4OGlrffbgn0N8yWA+
 HyfA==
X-Gm-Message-State: AOJu0YygunrjXNm4sEThxwWjgVVtCrpYWWM48Wi+X43OdSWzDqtd3udT
 sikcD+cc+pWTYnvbS1eGls+MoCoY5sXwrCC0S2QWQJ/T/gU1UMAMalwFIPBAltm6UbHGLZhnLJg
 N
X-Google-Smtp-Source: AGHT+IHc9uOfJZj3RfzYnjqaLaact8b/55e6Y7sYdz3wkZOuOeonVgLHeAUVJr2lgZ6InFkuElGa4w==
X-Received: by 2002:a05:6a21:996:b0:1b1:d403:5272 with SMTP id
 adf61e73a8af0-1b212e659e2mr8305666637.57.1716771022694; 
 Sun, 26 May 2024 17:50:22 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 25/28] target/i386: Convert do_xrstor to X86Access
Date: Sun, 26 May 2024 17:49:58 -0700
Message-Id: <20240527005001.642825-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 106 +++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 42 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f5748b72b8..1ac61c5d7d 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2903,51 +2903,38 @@ void helper_fxrstor(CPUX86State *env, target_ulong ptr)
     do_fxrstor(&ac, ptr);
 }
 
-static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr_t ra)
+static bool valid_xrstor_header(X86Access *ac, uint64_t *pxsbv,
+                                target_ulong ptr)
 {
     uint64_t xstate_bv, xcomp_bv, reserve0;
-    X86Access ac;
-    unsigned size, size_ext;
 
-    rfbm &= env->xcr0;
+    xstate_bv = access_ldq(ac, ptr + XO(header.xstate_bv));
+    xcomp_bv = access_ldq(ac, ptr + XO(header.xcomp_bv));
+    reserve0 = access_ldq(ac, ptr + XO(header.reserve0));
+    *pxsbv = xstate_bv;
 
-    size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
-    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
-
-    xstate_bv = access_ldq(&ac, ptr + XO(header.xstate_bv));
-
-    if ((int64_t)xstate_bv < 0) {
-        /* FIXME: Compact form.  */
-        raise_exception_ra(env, EXCP0D_GPF, ra);
+    /*
+     * XCOMP_BV bit 63 indicates compact form, which we do not support,
+     * and thus must raise #GP.  That leaves us in standard form.
+     * In standard form, bytes 23:8 must be zero -- which is both
+     * XCOMP_BV and the following 64-bit field.
+     */
+    if (xcomp_bv || reserve0) {
+        return false;
     }
 
-    /* Standard form.  */
-
     /* The XSTATE_BV field must not set bits not present in XCR0.  */
-    if (xstate_bv & ~env->xcr0) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
+    return (xstate_bv & ~ac->env->xcr0) == 0;
+}
 
-    /* The XCOMP_BV field must be zero.  Note that, as of the April 2016
-       revision, the description of the XSAVE Header (Vol 1, Sec 13.4.2)
-       describes only XCOMP_BV, but the description of the standard form
-       of XRSTOR (Vol 1, Sec 13.8.1) checks bytes 23:8 for zero, which
-       includes the next 64-bit field.  */
-    xcomp_bv = access_ldq(&ac, ptr + XO(header.xcomp_bv));
-    reserve0 = access_ldq(&ac, ptr + XO(header.reserve0));
-    if (xcomp_bv || reserve0) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
-    size_ext = xsave_area_size(rfbm & xstate_bv, false);
-    if (size < size_ext) {
-        /* TODO: See if existing page probe has covered extra size. */
-        access_prepare(&ac, env, ptr, size_ext, MMU_DATA_LOAD, ra);
-    }
+static void do_xrstor(X86Access *ac, target_ulong ptr,
+                      uint64_t rfbm, uint64_t xstate_bv)
+{
+    CPUX86State *env = ac->env;
 
     if (rfbm & XSTATE_FP_MASK) {
         if (xstate_bv & XSTATE_FP_MASK) {
-            do_xrstor_fpu(&ac, ptr);
+            do_xrstor_fpu(ac, ptr);
         } else {
             do_fninit(env);
             memset(env->fpregs, 0, sizeof(env->fpregs));
@@ -2956,23 +2943,23 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_SSE_MASK) {
         /* Note that the standard form of XRSTOR loads MXCSR from memory
            whether or not the XSTATE_BV bit is set.  */
-        do_xrstor_mxcsr(&ac, ptr);
+        do_xrstor_mxcsr(ac, ptr);
         if (xstate_bv & XSTATE_SSE_MASK) {
-            do_xrstor_sse(&ac, ptr);
+            do_xrstor_sse(ac, ptr);
         } else {
             do_clear_sse(env);
         }
     }
     if (rfbm & XSTATE_YMM_MASK) {
         if (xstate_bv & XSTATE_YMM_MASK) {
-            do_xrstor_ymmh(&ac, ptr + XO(avx_state));
+            do_xrstor_ymmh(ac, ptr + XO(avx_state));
         } else {
             do_clear_ymmh(env);
         }
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(&ac, ptr + XO(bndreg_state));
+            do_xrstor_bndregs(ac, ptr + XO(bndreg_state));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -2981,7 +2968,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(&ac, ptr + XO(bndcsr_state));
+            do_xrstor_bndcsr(ac, ptr + XO(bndcsr_state));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -2990,7 +2977,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_PKRU_MASK) {
         uint64_t old_pkru = env->pkru;
         if (xstate_bv & XSTATE_PKRU_MASK) {
-            do_xrstor_pkru(&ac, ptr + XO(pkru_state));
+            do_xrstor_pkru(ac, ptr + XO(pkru_state));
         } else {
             env->pkru = 0;
         }
@@ -3006,9 +2993,27 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
     uintptr_t ra = GETPC();
+    X86Access ac;
+    uint64_t xstate_bv;
+    unsigned size, size_ext;
 
     do_xsave_chk(env, ptr, ra);
-    do_xrstor(env, ptr, rfbm, ra);
+
+    /* Begin with just the minimum size to validate the header. */
+    size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
+    if (!valid_xrstor_header(&ac, &xstate_bv, ptr)) {
+        raise_exception_ra(env, EXCP0D_GPF, ra);
+    }
+
+    rfbm &= env->xcr0;
+    size_ext = xsave_area_size(rfbm & xstate_bv, false);
+    if (size < size_ext) {
+        /* TODO: See if existing page probe has covered extra size. */
+        access_prepare(&ac, env, ptr, size_ext, MMU_DATA_LOAD, ra);
+    }
+
+    do_xrstor(&ac, ptr, rfbm, xstate_bv);
 }
 
 #if defined(CONFIG_USER_ONLY)
@@ -3066,7 +3071,24 @@ void cpu_x86_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 
 void cpu_x86_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xrstor(env, ptr, rfbm, 0);
+    X86Access ac;
+    uint64_t xstate_bv;
+    unsigned size;
+
+    /*
+     * Since this is only called from user-level signal handling,
+     * we should have done the job correctly there.
+     */
+    assert((rfbm & ~env->xcr0) == 0);
+    size = xsave_area_size(rfbm, false);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
+
+    if (!valid_xrstor_header(&ac, &xstate_bv, ptr)) {
+        /* TODO: Report failure to caller. */
+        xstate_bv &= env->xcr0;
+    }
+
+    do_xrstor(&ac, ptr, rfbm, xstate_bv);
 }
 #endif
 
-- 
2.34.1


