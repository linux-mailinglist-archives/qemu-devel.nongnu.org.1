Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA627D1755
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLs-0007pI-Kl; Fri, 20 Oct 2023 16:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLd-0007kQ-M3
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLW-0008BJ-M2
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so1179584b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834629; x=1698439429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc0q97Cx2QaZpbCyXU6bCv+F4YXYfta8rMxuf/N3B78=;
 b=rW/kjKelHxED4dVZpxbclHoxpPgzeOVW9Bx3NWCM7cHYvBKjrHTn2+K4Lp73se4As/
 HcWVShCzKZDjSlrGpyrhKrjW6kgsomJwSClOM8cpFZgIIulhBu/vXXNYvw1C8lzWjgaq
 DF23daqYyVf7xwMBZSaANpjZ6Y7lLV8X1lar6xwn2Fy14I1tvN4Q6HeFtnlRrnZbujQM
 q+c5RUsX5GtvF/qLV1L7zh2aJL3Oh5pEXPPYaPCDr23GJAxBLQ/bWMU8+tHhk2QgkSOZ
 dWW97c+5ZvWvICQJ47Y+GS1gHVwG8Zx0ox02VqONvS/EvvwDJRieNTFWQzgqWUEm3c2M
 dU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834629; x=1698439429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bc0q97Cx2QaZpbCyXU6bCv+F4YXYfta8rMxuf/N3B78=;
 b=lZ68XeQRv39RPora6Ka4SSaONAZkOw5ji98iyF8gkwjMoSsTO96HEg3JvTYtZ0fWFK
 1dX95lPdZJN2yVIE/N+JwBGMSlJ2VF9NRZ32TnYIOnUj+qtfSWzsBPYl780WyxEOvWq2
 Kfp3XNqeo6XsCRcX+xMrQZ7zaWNEO0BYwc0z6ar0Uh1aLK+SpGtXl+H/qx+nsCN9WAgy
 2a+6WWpLQW18kOX3eVjMBap2Uk67UYFLBXAKCuKyWnrShqjB0Qu+Cmzxhz2agKmiGh9+
 RdhGumuOQ00PZR0khgQniIXvbBRUR+uM8Bssc/olBVRxx/xg3pgSFmoDmyY7zA4wBiwY
 iQnw==
X-Gm-Message-State: AOJu0YxPRP1U0SqUMaNFnuTdgsbgAlbGR4YwQz8CSjrBafh+aDmTX7SM
 BM3I2G68rZrdYK5x0yVKNgVBxdBg3Wdc1oAESXw=
X-Google-Smtp-Source: AGHT+IFRrUqCi4F4ezaQ5obwJH+7vkAaJBNwK2avlftUHjM+h601fXnyGJAU6V9UNZwqhhAf6x9dFw==
X-Received: by 2002:a05:6a20:918e:b0:179:f81b:12d9 with SMTP id
 v14-20020a056a20918e00b00179f81b12d9mr3080473pzd.11.1697834629239; 
 Fri, 20 Oct 2023 13:43:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 18/65] target/hppa: Handle absolute addresses for pa2.0
Date: Fri, 20 Oct 2023 13:42:44 -0700
Message-Id: <20231020204331.139847-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
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

With pa2.0, absolute addresses are not the same as physical addresses,
and undergo a transformation based on PSW_W.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  3 +++
 target/hppa/helper.c     |  4 ++--
 target/hppa/mem_helper.c | 49 +++++++++++++++++++++++++++++++++++++---
 target/hppa/sys_helper.c |  9 ++++++++
 4 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e087879399..622b4af890 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -284,6 +284,9 @@ static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
     return hppa_form_gva_psw(env->psw, spc, off);
 }
 
+hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
+hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
+
 /*
  * Since PSW_{I,CB} will never need to be in tb->flags, reuse them.
  * TB_FLAG_SR_SAME indicates that SR4 through SR7 all contain the
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 534a9e374c..6a00085dae 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -109,8 +109,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     cb |= ((psw >>  8) & 1) <<  4;
     env->psw_cb = cb;
 
-    /* If PSW_P changes, it affects how we translate addresses.  */
-    if ((psw ^ old_psw) & PSW_P) {
+    /* If P or W changes, it affects how we translate addresses.  */
+    if ((psw ^ old_psw) & (PSW_P | PSW_W)) {
 #ifndef CONFIG_USER_ONLY
         tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 48cb5b0d76..1a63717571 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -25,6 +25,45 @@
 #include "hw/core/cpu.h"
 #include "trace.h"
 
+hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
+{
+    if (likely(extract64(addr, 58, 4) != 0xf)) {
+        /* Memory address space */
+        return addr & MAKE_64BIT_MASK(0, 62);
+    }
+    if (extract64(addr, 54, 4) != 0) {
+        /* I/O address space */
+        return addr | MAKE_64BIT_MASK(62, 2);
+    }
+    /* PDC address space */
+    return (addr & MAKE_64BIT_MASK(0, 54)) | MAKE_64BIT_MASK(60, 4);
+}
+
+hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
+{
+    if (likely(extract32(addr, 28, 4) != 0xf)) {
+        /* Memory address space */
+        return addr & MAKE_64BIT_MASK(0, 32);
+    }
+    if (extract32(addr, 24, 4) != 0) {
+        /* I/O address space */
+        return addr | MAKE_64BIT_MASK(32, 32);
+    }
+    /* PDC address space */
+    return (addr & MAKE_64BIT_MASK(0, 24)) | MAKE_64BIT_MASK(60, 4);
+}
+
+static hwaddr hppa_abs_to_phys(CPUHPPAState *env, vaddr addr)
+{
+    if (!hppa_is_pa20(env)) {
+        return addr;
+    } else if (env->psw & PSW_W) {
+        return hppa_abs_to_phys_pa2_w1(addr);
+    } else {
+        return hppa_abs_to_phys_pa2_w0(addr);
+    }
+}
+
 static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 {
     int i;
@@ -99,7 +138,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     /* Virtual translation disabled.  Direct map virtual to physical.  */
     if (mmu_idx == MMU_PHYS_IDX) {
-        phys = addr;
+        phys = hppa_abs_to_phys(env, addr);
         prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         goto egress;
     }
@@ -213,7 +252,7 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     /* ??? We really ought to know if the code mmu is disabled too,
        in order to get the correct debugging dumps.  */
     if (!(cpu->env.psw & PSW_D)) {
-        return addr;
+        return hppa_abs_to_phys(&cpu->env, addr);
     }
 
     excp = hppa_get_physical_address(&cpu->env, addr, MMU_KERNEL_IDX, 0,
@@ -299,7 +338,11 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     /* Note that empty->entry_valid == 0 already.  */
     empty->va_b = addr & TARGET_PAGE_MASK;
     empty->va_e = empty->va_b + TARGET_PAGE_SIZE - 1;
-    empty->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
+    /*
+     * FIXME: This is wrong, as this is a pa1.1 function.
+     * But for the moment translate abs address for pa2.0.
+     */
+    empty->pa = hppa_abs_to_phys(env, extract32(reg, 5, 20) << TARGET_PAGE_BITS);
     trace_hppa_tlb_itlba(env, empty, empty->va_b, empty->va_e, empty->pa);
 }
 
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 4bb4cf611c..f0dd5a08e7 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -71,6 +71,15 @@ target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
      * so let this go without comment.
      */
     env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
+
+    /*
+     * Changes to PSW_W change the translation of absolute to physical.
+     * This currently (incorrectly) affects all translations.
+     */
+    if ((psw ^ env->psw) & (PSW_P | PSW_W)) {
+        tlb_flush(env_cpu(env));
+    }
+
     return psw & PSW_SM;
 }
 
-- 
2.34.1


