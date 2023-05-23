Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214470E9E0
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:59:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bu1-0004MG-2e; Tue, 23 May 2023 19:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btk-0004Hw-RT
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btX-0001nE-Ex
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:34 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d4e4598f0so147454b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886302; x=1687478302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuRyDk0Qj/U/m/Fk9xebGBVdcrGRTNv4rYYxEUzzoxI=;
 b=H8GxB9qFWv8yWGLeU0JrA+0ZDfFUkOxgMACD8doJGDPncleM2w/b9n9FUgR6YJbwOd
 N2/CAQNBvcSGrpTAh5aenEmOpfrOi9jNo00hDX0jGSSSUJg4ZbVDv+t1K+W5dgArmRc+
 xMZwxXZ1ZHdEH9f6zLmfkSQ7ZaorhGhVF5SgDpTWE8f9+3/L0DougXh7b3ox+ZTIJhvy
 FzNaLrXFL5+IPe13jHQodthww/KE3h46b4txZtKdyOx1TEMbgjgSTogEFepxTZh3WaWS
 O+I5DWjtm4XjDdkxAgerYTVXepyePLgcCFMH27GdLZNYLbmfjynfkOEFvxoWCJTZFw84
 i1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886302; x=1687478302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuRyDk0Qj/U/m/Fk9xebGBVdcrGRTNv4rYYxEUzzoxI=;
 b=bAXlvZ1KdhBDJ9RTBewCJdhaac4X65F8GEpZAVVJgVfuCM9L+T8Jo+iMSfCOlO37YQ
 nf3Gp8+3KIZJzzusDhgjl2B9dXZPymf9dvdgTK6hPPiI9U3Hfk8AHYjVB8JUySY3j8Pa
 VrqqdrnRc2VS5Gbm0G7iHKeiuQMOUs+UEiBuvWXbZRLmoUBIf7TxbcfYKfIQg+1dMhRf
 iLuTAV0vmctS24rMdjhZmERcMi97hohJvRJweaiLE3UV6PgcXBaytryhyq5twq1t/hUO
 8NRwUM/UHQBXQIpAEbilf+TVQrKxWgTQ+n83O5H71CKZHjcA8pjCIBQTHEjFiObwRDHN
 Zysw==
X-Gm-Message-State: AC+VfDyzIwsdcBceJfTrsg3NQXN1drUpDEljiTOVwxYVzsW2Kp+LH8ya
 VTyOw3nI3b4fmVOdckbKIHlU+VTNh0VUhJpLx/I=
X-Google-Smtp-Source: ACHHUZ4Ur/I5njRqoEoj+L7Ru6aHMOThYIlOasIb/xUVqouWCf8FbYkwP1HCZ5CbrZViSM5W3tTIyw==
X-Received: by 2002:a05:6a00:842:b0:64f:4197:8d93 with SMTP id
 q2-20020a056a00084200b0064f41978d93mr848640pfk.24.1684886302013; 
 Tue, 23 May 2023 16:58:22 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 19/28] accel/tcg: Remove cpu_atomic_{ld,st}o_*_mmu
Date: Tue, 23 May 2023 16:57:55 -0700
Message-Id: <20230523235804.747803-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


