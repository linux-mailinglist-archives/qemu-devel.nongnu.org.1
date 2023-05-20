Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8829E70A92D
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:31:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQa-0003xV-5t; Sat, 20 May 2023 12:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQE-0003i2-Ra
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ8-00034U-Os
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:09 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ae4c5e1388so43577015ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600023; x=1687192023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPL5Chc7uKNtPykCbIf1bx9tBI7z2B/RniQ4iaiA6MY=;
 b=NiebfK18huzPkhni+eWrEvgLUoAeCbNUHXgL1m8ZmVsaZ/tXbk3W1BYq4xbNX5Hara
 mvCjhPbiucajpzL7c25ARj1GHEY3t25etV0sKwlp+T7iklwI5T3QCq3+bXyQR15bn8eu
 qXRBAZyvo1BglRPL2/xBJNkT2wvh5q6WnDJMDb36VOVUjyghU0BJF/+wHnR2DiBtK091
 druZTr95/vDtHcq5qXzxzfxcmCNM5jpje+kyYHjYZK+WgHxKUcraOOZHM60xcoAyCXmt
 itrU93lE7vqPSUaB0BqfRj0Xzj7CR8RO5EQr7pvW8WeM+cDFWRgMuV7X+vu/Y+cMxlBh
 +uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600023; x=1687192023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPL5Chc7uKNtPykCbIf1bx9tBI7z2B/RniQ4iaiA6MY=;
 b=UAdhXAweMW0UvXuSjc0VrmeHD+l2QgKELHpu5JSiuzJyuptHP1Il5UPOJ5ygOT+QbO
 l6BAKb/0WVBo5lU8nv2LGL3q/ExwRMw0CTgG57sqCd+ftagi/2rnWMsGoxeYhUVN895Y
 SF42EG3R/awhB+eb4OZr86eYuqjc3hIAW4oWap9wWYIZmieq1Mw9iRgNI5y4GRACaowR
 VmtTpwMVBfWXgzMxyn9YeRpGJErA+Gt+eEJMgW+54DCPDOCk2j8W+6jLezq9mkBJ1pUl
 inUVSX9MFctmjitPSCTxC/DQGaA7iE+oMla70MGsYaCGtvMT4MquMWO98ccrfqm78v3K
 7v1w==
X-Gm-Message-State: AC+VfDwNdJnPWo6U60yeDFyCPayw5H3LxK3Da+saJQxDbNhvxyFDEI5n
 fB3HBSedba6jvrtHrCoccSFPZ5O/1LFeETTZXrc=
X-Google-Smtp-Source: ACHHUZ6Ks2rnG89DTW5bpZxFrjyFq1QbInoMLa4qRKgCBboqTNzWY0/5MDrfP6xa3lovMBdAOqh7bA==
X-Received: by 2002:a17:902:e811:b0:1af:981b:eeff with SMTP id
 u17-20020a170902e81100b001af981beeffmr2243569plg.64.1684600022784; 
 Sat, 20 May 2023 09:27:02 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:27:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 19/27] accel/tcg: Remove cpu_atomic_{ld,st}o_*_mmu
Date: Sat, 20 May 2023 09:26:26 -0700
Message-Id: <20230520162634.3991009-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Atomic load/store of 128-byte quantities is now handled
by cpu_{ld,st}16_mmu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h   | 61 +++--------------------------------
 include/exec/cpu_ldst.h       |  9 ------
 accel/tcg/atomic_common.c.inc | 14 --------
 3 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 404a530f7c..30eee9d066 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -87,33 +87,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     return ret;
 }
 
-#if DATA_SIZE >= 16
-#if HAVE_ATOMIC128
-ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr,
-                         MemOpIdx oi, uintptr_t retaddr)
-{
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,
-                                         PAGE_READ, retaddr);
-    DATA_TYPE val;
-
-    val = atomic16_read(haddr);
-    ATOMIC_MMU_CLEANUP;
-    atomic_trace_ld_post(env, addr, oi);
-    return val;
-}
-
-void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
-                     MemOpIdx oi, uintptr_t retaddr)
-{
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,
-                                         PAGE_WRITE, retaddr);
-
-    atomic16_set(haddr, val);
-    ATOMIC_MMU_CLEANUP;
-    atomic_trace_st_post(env, addr, oi);
-}
-#endif
-#else
+#if DATA_SIZE < 16
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
@@ -188,7 +162,7 @@ GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
 GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 
 #undef GEN_ATOMIC_HELPER_FN
-#endif /* DATA SIZE >= 16 */
+#endif /* DATA SIZE < 16 */
 
 #undef END
 
@@ -220,34 +194,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     return BSWAP(ret);
 }
 
-#if DATA_SIZE >= 16
-#if HAVE_ATOMIC128
-ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr,
-                         MemOpIdx oi, uintptr_t retaddr)
-{
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,
-                                         PAGE_READ, retaddr);
-    DATA_TYPE val;
-
-    val = atomic16_read(haddr);
-    ATOMIC_MMU_CLEANUP;
-    atomic_trace_ld_post(env, addr, oi);
-    return BSWAP(val);
-}
-
-void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
-                     MemOpIdx oi, uintptr_t retaddr)
-{
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,
-                                         PAGE_WRITE, retaddr);
-
-    val = BSWAP(val);
-    atomic16_set(haddr, val);
-    ATOMIC_MMU_CLEANUP;
-    atomic_trace_st_post(env, addr, oi);
-}
-#endif
-#else
+#if DATA_SIZE < 16
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
@@ -326,7 +273,7 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #undef ADD
 
 #undef GEN_ATOMIC_HELPER_FN
-#endif /* DATA_SIZE >= 16 */
+#endif /* DATA_SIZE < 16 */
 
 #undef END
 #endif /* DATA_SIZE > 1 */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index fc1d3d9301..5939688f69 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -300,15 +300,6 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, target_ulong addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
-Int128 cpu_atomic_ldo_le_mmu(CPUArchState *env, target_ulong addr,
-                             MemOpIdx oi, uintptr_t retaddr);
-Int128 cpu_atomic_ldo_be_mmu(CPUArchState *env, target_ulong addr,
-                             MemOpIdx oi, uintptr_t retaddr);
-void cpu_atomic_sto_le_mmu(CPUArchState *env, target_ulong addr, Int128 val,
-                           MemOpIdx oi, uintptr_t retaddr);
-void cpu_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int128 val,
-                           MemOpIdx oi, uintptr_t retaddr);
-
 #if defined(CONFIG_USER_ONLY)
 
 extern __thread uintptr_t helper_retaddr;
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index fe0eea018f..f255c9e215 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -19,20 +19,6 @@ static void atomic_trace_rmw_post(CPUArchState *env, uint64_t addr,
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_RW);
 }
 
-#if HAVE_ATOMIC128
-static void atomic_trace_ld_post(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi)
-{
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-}
-
-static void atomic_trace_st_post(CPUArchState *env, uint64_t addr,
-                                 MemOpIdx oi)
-{
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
-}
-#endif
-
 /*
  * Atomic helpers callable from TCG.
  * These have a common interface and all defer to cpu_atomic_*
-- 
2.34.1


