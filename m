Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D76177DEA3D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:40:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMeQ-0006Ty-AW; Wed, 01 Nov 2023 21:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeJ-000688-80
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:32 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeG-0004Ia-G3
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:30 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b40d5ea323so266561b6e.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889047; x=1699493847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uo0Zhvofbd6vpRMbc6PjwjiK07TZFi7sIhEIgzM+1zU=;
 b=i9du1G2HePqf5LaO8EGEm7OlWIGs8AN6jHS2yfSHdEkYfhwCcFEw1NdZth7ErdyCxr
 hSWMjk9FHRa0FE6HV7HFwYITWt1DXJpe/gVHHvopgftGZhac8sLFxYVXjraqFg3k9jmk
 8b7Mn++jlI+n1tnlEPzTcv88bZ0wxMOTv2xHH0YhY151mTpR0fP8spIWfcfA4QKCcmcv
 0j5TxiBiTgMdUDfZ6Y3eyLVwjtVj3GO0TeKbVny0yz1kTVmKf7BEFkavrspfpUAsEmIR
 ljgWuXYWTK3SG5Vif+ca9lU91V/SRJcQUq3jl2gXK5Ii3fhwLgbJqiWXrlqOQx1mK3ZB
 jN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889047; x=1699493847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uo0Zhvofbd6vpRMbc6PjwjiK07TZFi7sIhEIgzM+1zU=;
 b=En66LpxgMF01n0L5BMUtiuSrpWhMOzQGmRkCf3Vj+x57kpxA/JI74WIoqXNrDNHLqK
 oEGhxikxPoudNe4CmtadEwz14h/DOuiLIpRMEECjZLe8vqQl8/jQmGOPyHAYN+eigVgf
 rJ9mWX2zWksPbLgnF5HMnsn63QP2gCrYR4pazwEoar0i/nYMS+oBukpg0wcQOFbWYRtc
 8aSXdPRywvnstIb6wz5rmHHyHs5bjSt3vnHpAJZS0WM6Kah+gVWZDwGKf+2whRYkk3+Q
 FbekGzArqmbrwON12jCfBghnaLuzmo7QvB5lLk5V7U2ZEsZpkRdzZmrQoVFAYvbwmmJ+
 MRdg==
X-Gm-Message-State: AOJu0YzSOsMD1zbTTzBIQTtIR4fAzYM4zWekpbUbxAtZJDjGxkjCZN00
 6rjGKs5gTG31QHbK6NSz8SyPojzNtqPAn892q+w=
X-Google-Smtp-Source: AGHT+IFXZfEdInA/EiU2NMj/Y4h4oPKoTGdbqmNdQD1nui2VEmWUcFXzD1wjRNNouoGqF7UHCNxPvQ==
X-Received: by 2002:a54:4794:0:b0:3b2:dd03:12ff with SMTP id
 o20-20020a544794000000b003b2dd0312ffmr18532807oic.8.1698889047257; 
 Wed, 01 Nov 2023 18:37:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 82/88] target/hppa: Update IIAOQ, IIASQ for pa2.0
Date: Wed,  1 Nov 2023 18:30:10 -0700
Message-Id: <20231102013016.369010-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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


