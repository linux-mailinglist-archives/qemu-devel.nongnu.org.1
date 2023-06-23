Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7773B29D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 10:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCc1x-0000ff-4i; Fri, 23 Jun 2023 04:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1s-0000dT-9l; Fri, 23 Jun 2023 04:20:29 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1n-0002hP-Ct; Fri, 23 Jun 2023 04:20:27 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so372896a12.1; 
 Fri, 23 Jun 2023 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687508418; x=1690100418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+mfnEVCvr63N6fHKwMF6YaPrDB5JFpRkwNfrijFFDY=;
 b=kNxJBLTaC1mVHt/qlkHAi1KxnTtINMSL7aWQwqerSTnvkIAy7GC0IMOC7L2tZ2gHmF
 1FeCNnaW3JxuUdc77/EDPcup9VnUJ5mTO68mE8HOfEKbWwi+uf6/M868mUJ+T9mdE4EA
 WvdayHSWMrxFpTjqiMoSck61jkfg7ntHeIx5GwwRQNlyrkpjiDTDLiR3bls/2jn1mrjL
 Trf1mDaKOm0lx/tyMg7LdFu0pdRphjjV/qlScUgqah9QmH4XrrVTlTSSx8QOs3FgljIW
 uyCEOmUJd0uHgEyDfPno5/W60g7VTQoDgwhz5KD91WNm3FgrLWdHbc7yE3j+moEER7Qn
 fWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687508418; x=1690100418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+mfnEVCvr63N6fHKwMF6YaPrDB5JFpRkwNfrijFFDY=;
 b=fee/+pxUZu6LV4hJx4A9vP8w+dmK/Ez5hBdEd4GwBJCHYrcFH5NGwMiD1T8oQzX21z
 mEc9KcRGihP/t/ucI70MTaQi7OzryNq8FYVsjXWfNNH04vy2DztW5Ld/tea0ztX7cBnE
 H6xvZoUBG2NVCoScHPkBObB5XerMvQXaMb/Hwlv4C6QIBezO0PZbNAG+mTT1U4xhwQaT
 fwS7blXIWO/uutmqoJ0cfH3JwVn0qlaZYWWhDWEkvc8fiz0DxNSULenPSD7s63zLonah
 ATvGcvAxGqlIox6CVcqZ5B2F9hKKHd08hw+X3+SNHMBv5ZqEfSJqF8nhfpi17ybznarK
 GT0w==
X-Gm-Message-State: AC+VfDz4bhMK3vF4cnuP3EmSouG4wag/9O/Selj3On+mBx9oDc672CfV
 N7jTL2cGa8CvlkpYXUUzA7mkM+z52ok=
X-Google-Smtp-Source: ACHHUZ6COH0Wqx5noo2vtg4wCmpmxjHNgg5e1PBHQdz6p2tpG4cF6q2dW0uk7ZgAGKvA1z1W+MxojQ==
X-Received: by 2002:a05:6a20:4328:b0:125:377c:831d with SMTP id
 h40-20020a056a20432800b00125377c831dmr4134452pzk.3.1687508417723; 
 Fri, 23 Jun 2023 01:20:17 -0700 (PDT)
Received: from wheely.local0.net ([1.146.27.231])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a62e70f000000b0066884d4efdbsm5780604pfh.12.2023.06.23.01.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 01:20:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Subject: [PATCH 1/4] target/ppc: Machine check on invalid real address access
Date: Fri, 23 Jun 2023 18:19:50 +1000
Message-Id: <20230623081953.290875-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623081953.290875-1-npiggin@gmail.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

ppc currently silently accepts invalid real address access. Catch
these and turn them into machine checks. POWER9/10 machine check
codes for invalid real address access are implemented.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c    |  1 +
 target/ppc/excp_helper.c | 35 +++++++++++++++++++++++++++++++++++
 target/ppc/internal.h    |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7bce421a7c..3b23f2d5b6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7267,6 +7267,7 @@ static const struct TCGCPUOps ppc_tcg_ops = {
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
   .do_unaligned_access = ppc_cpu_do_unaligned_access,
+  .do_transaction_failed = ppc_cpu_do_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 12d8a7257b..c9bfa3a827 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1402,7 +1402,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
+        msr |= env->error_code;
         break;
+
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
         break;
@@ -3123,5 +3125,38 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
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
+    case POWERPC_EXCP_970:
+    case POWERPC_EXCP_POWER7:
+    case POWERPC_EXCP_POWER8:
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+        /*
+         * TODO: This does not give the correct machine check code but
+         * it will report a NIP and DAR.
+         */
+        if (access_type == MMU_DATA_LOAD || access_type == MMU_DATA_STORE) {
+            env->spr[SPR_DAR] = vaddr;
+        }
+        break;
+#endif
+    default:
+        /* TODO: Check behaviour for other CPUs, for now do nothing. */
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
2.40.1


