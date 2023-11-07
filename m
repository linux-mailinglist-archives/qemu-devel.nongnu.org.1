Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EEC7E33E5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CS3-00069e-9T; Mon, 06 Nov 2023 22:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRr-0005eC-6d
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:15 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRk-0001UA-V9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:14 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5b97ca78da8so3507128a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326487; x=1699931287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l8fr3+CRJQ2fSyTIfaR9JmF1licLAR+9v7s8wM6sbYc=;
 b=KMptr+XLAhlUM72vuWtT/p1e+471HQaOhdvJYufNEnBsu8b9+nW5ku0Zui9Som6XgB
 BN+s45Pbdtpr1tz1koaUc7CTYqPofy3KKnYJrdLTpqtYqwGZMdeCBibHWusox2ua9MwD
 +VKJSDINSTVJEJChKtdvyznWpKeD/+hRdSwxtBnCViha4fnP4S604jFJSHnHDkLtgifY
 OFNRWpXpkErqAcLqrsBEHr2buRB8x8IBbhwj6g/Tr+HcYnpmKgzKXXbFye605kXmfl5c
 XEBcYDk7EM4rivIgCewJJRkRsuXmdB/OxT1bWPV6XS4MkaOF+frqt22O2jojP2afIwDz
 3g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326487; x=1699931287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8fr3+CRJQ2fSyTIfaR9JmF1licLAR+9v7s8wM6sbYc=;
 b=VNLUQwUkj1rkE8gw20Gv68b02nh56KTvJF2xOki7jBIkLMoMlAE8GyflEG/ZiM2c2T
 BPdaPnMoIhAJRv/O/lDNKUCHqYrcEU5WsjiWH8eqPxeA9yYSqXtWKiJeM4pxSg/ZHvxj
 OzfiWrc8t6y6y21IahY2Luuio99Y8l+PbC3eS6rDpOkk/3h+zrrSLlEcw+Wi8NPjqqLg
 Zo4qp9AfEKrxBpnAeqPtIcnAqw7vYNFZefxGk327zEK5j/jHr8hbhDyYbP4inu/KUTWS
 U7dBrtZANWqa/xyuNcgzhoLgeLq/SBghLJSW7i4qnEtM3aDnl5EMO99NfmyRqN6aqyJz
 vyEQ==
X-Gm-Message-State: AOJu0YyAKxbkM90RvU/3WsT2540iR38S0JmwPvE0nXdVk4/usVYOOwp2
 5Sf5o/wxpFmubFwCkwEJxYFYqgC7ecdeyjnNZEo=
X-Google-Smtp-Source: AGHT+IFSRTvd7anrNOlZ6xLtIwTu2tBc19BcEmEgLpt2Po6YFHeOVr6V/Mx2bKBlh/kseOWBV+aQRw==
X-Received: by 2002:a05:6a20:7487:b0:15e:b8a1:57b0 with SMTP id
 p7-20020a056a20748700b0015eb8a157b0mr26298031pzd.39.1699326487349; 
 Mon, 06 Nov 2023 19:08:07 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 79/85] target/hppa: Create raise_exception_with_ior
Date: Mon,  6 Nov 2023 19:04:01 -0800
Message-Id: <20231107030407.8979-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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


