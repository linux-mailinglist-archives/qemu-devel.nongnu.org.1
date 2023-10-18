Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BE7CEAF2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESd-0001fc-Od; Wed, 18 Oct 2023 17:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESH-00017d-LU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:54 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESF-0004Py-Vu
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:53 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2f5aed39cso139979b6e.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665910; x=1698270710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZXU+uJQmMW+4OCGtgI6BB8XXkY8PzpFUr5ZBWJJgxY=;
 b=O+JSM06lhx7BJ0dhSVsnkju510ez08BeqgOpOrFUVIGB8+J2yqgx8p9jJVSi3DYQNo
 VBa0TSdfTlsWvPLHKXRYfJOIQe9NEt+4u9s58KUXmFOPLlZ6I/1YeELvAgpt2kKFNYGN
 fioElGPMop17jiaiDYbevX9TINTnE1+4XX4dHYpYI2m70kYANKOyQV+QxxEc+RsNg7PR
 2FXrEB4S6zS2U8ktVqlldKqQI2I7Kwq9OuWF3yhMOUd00AMQoljNzuXTE5VeJUN4M0iJ
 tURuFT2cev/0V3J8r6uWECMXc0hlBDE69zJrViiamOTe/HAU6IUWH0zN8auduKCYPvWD
 H5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665910; x=1698270710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZXU+uJQmMW+4OCGtgI6BB8XXkY8PzpFUr5ZBWJJgxY=;
 b=Alo8A5eosezsrP62rqSs/TvXJtcdVmdc7tktKd5dw01PQ/7LtFW5a7BT4Rad5v9jKh
 mAJt+wlU1QO9yota9KzeqlfFKDsvJk7iJcb4eU5BGqsYdsVWURToUNj8/n80zZVHSuGM
 8BIBZtB8uP7RclzICMjnOGJFiXwdpeawvHH0MkpDWMNgSrXKtTUFSvC1cPRoITR9G2rX
 OGElRtYbgFb5Vq/DNI3hngMZX3kNNeupy0Pvc+8iG9+9Uj6uL+1LOm7uFJiztJtBzezR
 fUwaLYUZfx+H+WxeOdM+2551Lbd09qmJbC2TaocdlIEWt8Qd50IQcw9fiKM0o+j7NhQ4
 ytMA==
X-Gm-Message-State: AOJu0Yza+FaH17SrJzwzK1YokXwAi1uvgt7if6CSnkHATxbBqSBWklQw
 2c9K50B8/DC3elab4Pmh8n9jPqJ63TBGxXUBjUU=
X-Google-Smtp-Source: AGHT+IH+XuWHDsYdvgiaPEHbruawySBZGuNSo25EvvUPfxz9+7Nms6eZy8evgWuYBrOB9BlCdsipmg==
X-Received: by 2002:a05:6870:10d8:b0:1ea:2e2c:e9e7 with SMTP id
 24-20020a05687010d800b001ea2e2ce9e7mr579020oar.59.1697665910592; 
 Wed, 18 Oct 2023 14:51:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 17/61] target/hppa: Handle absolute addresses for pa2.0
Date: Wed, 18 Oct 2023 14:50:51 -0700
Message-Id: <20231018215135.1561375-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 target/hppa/mem_helper.c | 47 ++++++++++++++++++++++++++++++++++++++--
 target/hppa/sys_helper.c |  9 ++++++++
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 30010858a9..671e43ebd8 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -283,6 +283,9 @@ static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
     return hppa_form_gva_psw(env->psw, spc, off);
 }
 
+hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
+hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
+
 /*
  * Since PSW_{I,CB} will never need to be in tb->flags, reuse them.
  * TB_FLAG_SR_SAME indicates that SR4 through SR7 all contain the
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 40e859ba08..0ef890184a 100644
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
index b2a75f6408..169e878479 100644
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
+    if (!env_archcpu(env)->is_pa20) {
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


