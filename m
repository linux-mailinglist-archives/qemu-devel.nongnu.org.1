Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A76674B034
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:47:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiV-0006sJ-N8; Fri, 07 Jul 2023 07:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiS-0006Xj-PI; Fri, 07 Jul 2023 07:33:36 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiQ-0006xX-VT; Fri, 07 Jul 2023 07:33:36 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1b0748bc78dso1845909fac.0; 
 Fri, 07 Jul 2023 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729613; x=1691321613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dej50tkFsteNueaQMci7bTrmP7efUeMrQoIO7A5G7sY=;
 b=P7opYRPB2ZtyPa6Bwze2Xk30AQ0/mdL1MAieVIfex2BK8hqM6HmOduZFNZBi2FQh9G
 UztTeO5TZLNUcsQc7jwzx2TqCTTC4x506Dw81Tg4sUXpRNxWsh3gTK2SUBDb4QEQhryu
 Na7s3ia63/f4KrM7H7R6GoGRINZl9Y8QJ7v7p0nQkyM/zmJ6VsTKYjzWS497snOHG1iq
 CithNK6n3o59yu0XI8BFJXBW5oTfRSdPfV3SNkvXKQRoLNfDCDobsVT4rzFzbDtlMDMa
 HjRRnUZUCnfDQ9wZIW2adjK9lU4DTITH6GSNEuZmhdNErtY+wlB07Rfkf4+eNLupwmKP
 a1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729613; x=1691321613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dej50tkFsteNueaQMci7bTrmP7efUeMrQoIO7A5G7sY=;
 b=LJ6wjThR74a04dHudRX5pTK7p/oiDS+MOBsz/P6hAeIy7ADgRRheNSXGrwJxuXemr9
 i2q8c2kq+WFDLDFX2s4Daw22+I3WJDSswZMyc5aySYpThLxN3DaS9N4IYY/1XOrd6NQF
 oVSBps4cpuP66FIGt2wtVyCgsmcSlKoOi/B1o879RvtsxZnsrgbWJMTqo5T3/eAwoDI1
 9MBnx387eBXH2UdlDjxkKzlKeis+Bd8WMCM+UAw2pFAW+5SoE8mAntjstSBJfEUlAKFn
 GZ1ILdXbNXDttRGjnIlVRoJsOvvGzkRATlUtZB0hpF04RwBWbTTrmMmsEQV7F9fUabrX
 FvZw==
X-Gm-Message-State: ABy/qLafHOsr+Xj3tY/MFu5OLXI/8gL0/F1dS2uavKZbepoVJGvJ8Qha
 UuNY1J3V7WV/Ud6r8XSPVR3BykVbGDw=
X-Google-Smtp-Source: APBJJlEZIORzuav8Shkig8/iP9TY7dg3cp8JDlU01X9qujgvx9LwCBIF2dZqnojLlSvxfodNkDNWqg==
X-Received: by 2002:a05:6871:97:b0:1b3:8d35:c850 with SMTP id
 u23-20020a056871009700b001b38d35c850mr2285335oaa.7.1688729613323; 
 Fri, 07 Jul 2023 04:33:33 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:33 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 52/60] target/ppc: Machine check on invalid real address access
 on POWER9/10
Date: Fri,  7 Jul 2023 08:31:00 -0300
Message-ID: <20230707113108.7145-53-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

ppc currently silently accepts invalid real address access. Catch
these and turn them into machine checks on POWER9/10 machines.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230703120301.45313-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu_init.c    |  1 +
 target/ppc/excp_helper.c | 49 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/internal.h    |  5 ++++
 3 files changed, 55 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 720aad9e05..6ac1765a8d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7335,6 +7335,7 @@ static const struct TCGCPUOps ppc_tcg_ops = {
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
   .do_unaligned_access = ppc_cpu_do_unaligned_access,
+  .do_transaction_failed = ppc_cpu_do_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7683ea0fc9..003805b202 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1428,7 +1428,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
+        msr |= env->error_code;
         break;
+
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
         break;
@@ -3188,5 +3190,52 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     env->error_code = insn & 0x03FF0000;
     cpu_loop_exit(cs);
 }
+
+void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                   vaddr vaddr, unsigned size,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, MemTxAttrs attrs,
+                                   MemTxResult response, uintptr_t retaddr)
+{
+    CPUPPCState *env = cs->env_ptr;
+
+    switch (env->excp_model) {
+#if defined(TARGET_PPC64)
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+        /*
+         * Machine check codes can be found in processor User Manual or
+         * Linux or skiboot source.
+         */
+        if (access_type == MMU_DATA_LOAD) {
+            env->spr[SPR_DAR] = vaddr;
+            env->spr[SPR_DSISR] = PPC_BIT(57);
+            env->error_code = PPC_BIT(42);
+
+        } else if (access_type == MMU_DATA_STORE) {
+            /*
+             * MCE for stores in POWER is asynchronous so hardware does
+             * not set DAR, but QEMU can do better.
+             */
+            env->spr[SPR_DAR] = vaddr;
+            env->error_code = PPC_BIT(36) | PPC_BIT(43) | PPC_BIT(45);
+            env->error_code |= PPC_BIT(42);
+
+        } else { /* Fetch */
+            env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
+        }
+        break;
+#endif
+    default:
+        /*
+         * TODO: Check behaviour for other CPUs, for now do nothing.
+         * Could add a basic MCE even if real hardware ignores.
+         */
+        return;
+    }
+
+    cs->exception_index = POWERPC_EXCP_MCHECK;
+    cpu_loop_exit_restore(cs, retaddr);
+}
 #endif /* CONFIG_TCG */
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 901bae6d39..57acb3212c 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -296,6 +296,11 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 G_NORETURN void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                             MMUAccessType access_type, int mmu_idx,
                                             uintptr_t retaddr);
+void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                   vaddr addr, unsigned size,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, MemTxAttrs attrs,
+                                   MemTxResult response, uintptr_t retaddr);
 #endif
 
 FIELD(GER_MSK, XMSK, 0, 4)
-- 
2.41.0


