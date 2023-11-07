Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B647E33AA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:12:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CV7-0006gH-Al; Mon, 06 Nov 2023 22:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUu-0006df-FL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:25 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUf-000255-RC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:24 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso5528588b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326668; x=1699931468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uo0Zhvofbd6vpRMbc6PjwjiK07TZFi7sIhEIgzM+1zU=;
 b=E0FQW/C5/kZVx8gvMj9a0bFIjUmjmh/0jar/zrJ+QfMMmPRSJ7PMjtyqOgtGB34sHW
 FhdAM7IZGcQVNmPtS0V2BhSdtOY9kqgIku42gk/HfzYu1ynm5GaA6qtsUhzM3JcET1tT
 KvVfZ4BX8Zz4QXC0ISkCJe4B3+BfjGARAXtxbOrpewlr+/+F45M85n9qEjOIQ8Cpp8ZW
 BYFUchV3kc0VFD+8Fow3nvvB9E5e0KCKUSLksA0JufHxWuUyVrFHm0s6LR6aau55x+HW
 65+TuwQKgBMWe4gepBFbgMDRMTIIRZKwuI27GY5WeU70amxAdyqZKLtkzMnvwePKos6g
 aMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326668; x=1699931468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uo0Zhvofbd6vpRMbc6PjwjiK07TZFi7sIhEIgzM+1zU=;
 b=K91BHI7jsvPmOVrfi9B1BfYlXPidspRgAxHnfX2G4ygiCVmURbLUQX292+IOKUP0gE
 f0LdO/w3O0oH1n712ejB5mpbMhkNIQhf4w3kycOaZPYAiBREnQEDQJmPdxAPaYmdUFl4
 WAUBMdNMMP+IWy8KNE5OxqWoYVcB51es4okB7F7axzvt6hzw/jNgW5vkRKc4uAMRUfIr
 bW4GbEaPxr2cFNEdNBveRvdovKx5kkAKzywRFyp8St17D07FrsfoauclRgxpSVzRQupK
 j8O8wbWrnJGdeMMPi+fPNSJKna0BAVMTg6oseOHpaJEjU4DCSfWVj+wizNFCR7riOnP4
 VkNw==
X-Gm-Message-State: AOJu0YydTc+NsybGzpbz/zszoUEXmwsMJVv+8GrP62e3Zoc2omZO0bhg
 w5GPyEDyelqHVHE+zl+vedsAhR3OrW9VQ3mHcpo=
X-Google-Smtp-Source: AGHT+IGCSuthHdjci7VFZB+EmCJ/lRFdP3bQkrL4CSig6pSNM0R0ODfT3bj9/F8CCJssiW1sKsyxnA==
X-Received: by 2002:a05:6a20:2d2c:b0:17a:f37e:ddc2 with SMTP id
 g44-20020a056a202d2c00b0017af37eddc2mr41266271pzl.47.1699326668399; 
 Mon, 06 Nov 2023 19:11:08 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gw13-20020a17090b0a4d00b0026f4bb8b2casm6246253pjb.6.2023.11.06.19.11.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:11:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 80/85] target/hppa: Update IIAOQ, IIASQ for pa2.0
Date: Mon,  6 Nov 2023 19:04:02 -0800
Message-Id: <20231107030407.8979-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

These registers have a different format for pa2.0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c | 46 ++++++++++++++++++++++++----------------
 target/hppa/sys_helper.c | 10 +++++++++
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index a11d607b31..54875442e7 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -102,11 +102,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
     int i = cs->exception_index;
-    target_ulong iaoq_f = env->iaoq_f;
-    target_ulong iaoq_b = env->iaoq_b;
-    uint64_t iasq_f = env->iasq_f;
-    uint64_t iasq_b = env->iasq_b;
-    target_ulong old_psw;
+    uint64_t old_psw;
 
     /* As documented in pa2.0 -- interruption handling.  */
     /* step 1 */
@@ -118,10 +114,25 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                      (i == EXCP_HPMC ? PSW_M : 0));
 
     /* step 3 */
-    env->cr[CR_IIASQ] = iasq_f >> 32;
-    env->cr_back[0] = iasq_b >> 32;
-    env->cr[CR_IIAOQ] = iaoq_f;
-    env->cr_back[1] = iaoq_b;
+    /*
+     * For pa1.x, IIASQ is simply a copy of IASQ.
+     * For pa2.0, IIASQ is the top bits of the virtual address,
+     *            or zero if translation is disabled.
+     */
+    if (!hppa_is_pa20(env)) {
+        env->cr[CR_IIASQ] = env->iasq_f >> 32;
+        env->cr_back[0] = env->iasq_b >> 32;
+    } else if (old_psw & PSW_C) {
+        env->cr[CR_IIASQ] =
+            hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
+        env->cr_back[0] =
+            hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
+    } else {
+        env->cr[CR_IIASQ] = 0;
+        env->cr_back[0] = 0;
+    }
+    env->cr[CR_IIAOQ] = env->iaoq_f;
+    env->cr_back[1] = env->iaoq_b;
 
     if (old_psw & PSW_Q) {
         /* step 5 */
@@ -154,14 +165,13 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                 /* ??? An alternate fool-proof method would be to store the
                    instruction data into the unwind info.  That's probably
                    a bit too much in the way of extra storage required.  */
-                vaddr vaddr;
-                hwaddr paddr;
+                vaddr vaddr = env->iaoq_f & -4;
+                hwaddr paddr = vaddr;
 
-                paddr = vaddr = iaoq_f & -4;
                 if (old_psw & PSW_C) {
                     int prot, t;
 
-                    vaddr = hppa_form_gva_psw(old_psw, iasq_f, vaddr);
+                    vaddr = hppa_form_gva_psw(old_psw, env->iasq_f, vaddr);
                     t = hppa_get_physical_address(env, vaddr, MMU_KERNEL_IDX,
                                                   0, &paddr, &prot, NULL);
                     if (t >= 0) {
@@ -191,14 +201,14 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
     /* step 7 */
     if (i == EXCP_TOC) {
-        env->iaoq_f = FIRMWARE_START;
+        env->iaoq_f = hppa_form_gva(env, 0, FIRMWARE_START);
         /* help SeaBIOS and provide iaoq_b and iasq_back in shadow regs */
         env->gr[24] = env->cr_back[0];
         env->gr[25] = env->cr_back[1];
     } else {
-        env->iaoq_f = env->cr[CR_IVA] + 32 * i;
+        env->iaoq_f = hppa_form_gva(env, 0, env->cr[CR_IVA] + 32 * i);
     }
-    env->iaoq_b = env->iaoq_f + 4;
+    env->iaoq_b = hppa_form_gva(env, 0, env->iaoq_f + 4);
     env->iasq_f = 0;
     env->iasq_b = 0;
 
@@ -251,8 +261,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         qemu_log("INT %6d: %s @ " TARGET_FMT_lx "," TARGET_FMT_lx
                  " -> " TARGET_FMT_lx " " TARGET_FMT_lx "\n",
                  ++count, name,
-                 hppa_form_gva(env, iasq_f, iaoq_f),
-                 hppa_form_gva(env, iasq_b, iaoq_b),
+                 hppa_form_gva(env, env->iasq_f, env->iaoq_f),
+                 hppa_form_gva(env, env->iasq_b, env->iaoq_b),
                  env->iaoq_f,
                  hppa_form_gva(env, (uint64_t)env->cr[CR_ISR] << 32,
                                env->cr[CR_IOR]));
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 8850576ac3..a59245eed3 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -80,6 +80,16 @@ void HELPER(rfi)(CPUHPPAState *env)
     env->iasq_b = (uint64_t)env->cr_back[0] << 32;
     env->iaoq_f = env->cr[CR_IIAOQ];
     env->iaoq_b = env->cr_back[1];
+
+    /*
+     * For pa2.0, IIASQ is the top bits of the virtual address.
+     * To recreate the space identifier, remove the offset bits.
+     */
+    if (hppa_is_pa20(env)) {
+        env->iasq_f &= ~env->iaoq_f;
+        env->iasq_b &= ~env->iaoq_b;
+    }
+
     cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
 }
 
-- 
2.34.1


