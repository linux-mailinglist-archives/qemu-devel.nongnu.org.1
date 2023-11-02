Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 903217DEA52
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:44:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMeT-0006aR-Eh; Wed, 01 Nov 2023 21:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeJ-0006BA-GG
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeF-0004IQ-Tf
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6c0f14d6875so475586b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889046; x=1699493846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8fr3+CRJQ2fSyTIfaR9JmF1licLAR+9v7s8wM6sbYc=;
 b=qocJiGYF7GrzYxqW/Q/7plufTCnRFgIbK05yjToCR48tBsXgn69AZ9rmqqkoI7dhWJ
 eLLJ/noslY9BBrw0ZcznObQCaX0oULayWREKo2YWucSFJ6oRVw/lIXiUuvzXZIXJg270
 o4nDBgtOHyELybFEceNWyTcG2fY1B+g7nTLV3OauZQKmkdirGV9TT9JOkZ9cYnL+psSj
 p4wiX/CVuJ+iqFweKbkCWQYMoRXQuvJMW2zyXYPtfv9uM38D21LxXLTidFOeWPKcVVJr
 js8QDmt+zW2cv2w8AVa4MDH/GqAbVrkJxdL+VBeznnb2i0BXf0L+PY/xp0+KkDVfNKIb
 HtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889046; x=1699493846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8fr3+CRJQ2fSyTIfaR9JmF1licLAR+9v7s8wM6sbYc=;
 b=Q4ut4iF7BCzVXDLhUED72uhSY5FOtJVpaVEzlxjYjaqkoYIP3ryEcF7ZkW5K7KfFll
 C5FA8yaARebgiKXNdxtdSoFldKUrzingZ41eIDIScLZAo/+RJuJ9s+xah5uIM0L2641/
 G7MrBKi9HrX+Ik2n4gqFKeeFD0vkzArxiNINP35hXVZ16cmIvnhr6qVYxYRbgkQoM5nv
 Bo7GnvF1I0sqfciKevhVMS304nN+YT6SiT/yaVKDKz631bg1FGLZxu0kTSrgMAafkv/c
 8mXQqyXgDQJzbikKuSXZziue4ToyaJ3/triNzELDbZ+91HxZQCVbbNnxcmHMzCg29kvU
 szcw==
X-Gm-Message-State: AOJu0YxAfKLmkuZCFiI0hbBef8hV3czlwh6UUh5eMpern9aSwhxouOGX
 gseRTrgSquMLmXWYQNDis3XKZUdKBb5GYqU9b4w=
X-Google-Smtp-Source: AGHT+IFd3KaPriYjQVHvfkfUg6bzz1On7CBy8y1guR2YVoQONoXcKg558qHaY6Ow5UmJ7yOOPpy8NA==
X-Received: by 2002:a05:6a00:cd1:b0:6c0:1096:e7d3 with SMTP id
 b17-20020a056a000cd100b006c01096e7d3mr16849331pfv.18.1698889046413; 
 Wed, 01 Nov 2023 18:37:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 81/88] target/hppa: Create raise_exception_with_ior
Date: Wed,  1 Nov 2023 18:30:09 -0700
Message-Id: <20231102013016.369010-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Handle pa2.0 logic for filling in ISR+IOR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 64 ++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 602e6c809f..858ce6ec7f 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -289,6 +289,53 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return excp == EXCP_DTLB_MISS ? -1 : phys;
 }
 
+G_NORETURN static void
+raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
+                         vaddr addr, bool mmu_disabled)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = excp;
+
+    if (env->psw & PSW_Q) {
+        /*
+         * For pa1.x, the offset and space never overlap, and so we
+         * simply extract the high and low part of the virtual address.
+         *
+         * For pa2.0, the formation of these are described in section
+         * "Interruption Parameter Registers", page 2-15.
+         */
+        env->cr[CR_IOR] = (uint32_t)addr;
+        env->cr[CR_ISR] = addr >> 32;
+
+        if (hppa_is_pa20(env)) {
+            if (mmu_disabled) {
+                /*
+                 * If data translation was disabled, the ISR contains
+                 * the upper portion of the abs address, zero-extended.
+                 */
+                env->cr[CR_ISR] &= 0x3fffffff;
+            } else {
+                /*
+                 * If data translation was enabled, the upper two bits
+                 * of the IOR (the b field) are equal to the two space
+                 * bits from the base register used to form the gva.
+                 */
+                uint64_t b;
+
+                cpu_restore_state(cs, retaddr);
+
+                b = env->gr[env->unwind_breg];
+                b >>= (env->psw & PSW_W ? 62 : 30);
+                env->cr[CR_IOR] |= b << 62;
+
+                cpu_loop_exit(cs);
+            }
+        }
+    }
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                        MMUAccessType type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
@@ -318,14 +365,10 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
             return false;
         }
         trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
+
         /* Failure.  Raise the indicated exception.  */
-        cs->exception_index = excp;
-        if (cpu->env.psw & PSW_Q) {
-            /* ??? Needs tweaking for hppa64.  */
-            cpu->env.cr[CR_IOR] = addr;
-            cpu->env.cr[CR_ISR] = addr >> 32;
-        }
-        cpu_loop_exit_restore(cs, retaddr);
+        raise_exception_with_ior(env, excp, retaddr,
+                                 addr, mmu_idx == MMU_PHYS_IDX);
     }
 
     trace_hppa_tlb_fill_success(env, addr & TARGET_PAGE_MASK,
@@ -553,16 +596,11 @@ target_ulong HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
     excp = hppa_get_physical_address(env, addr, MMU_KERNEL_IDX, 0,
                                      &phys, &prot, NULL);
     if (excp >= 0) {
-        if (env->psw & PSW_Q) {
-            /* ??? Needs tweaking for hppa64.  */
-            env->cr[CR_IOR] = addr;
-            env->cr[CR_ISR] = addr >> 32;
-        }
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
         trace_hppa_tlb_lpa_failed(env, addr);
-        hppa_dynamic_excp(env, excp, GETPC());
+        raise_exception_with_ior(env, excp, GETPC(), addr, false);
     }
     trace_hppa_tlb_lpa_success(env, addr, phys);
     return phys;
-- 
2.34.1


