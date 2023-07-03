Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68C745BD3
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 14:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGIHX-0001cz-Mi; Mon, 03 Jul 2023 08:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGIHK-0001Sz-2t; Mon, 03 Jul 2023 08:03:39 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGIHC-0003QV-5k; Mon, 03 Jul 2023 08:03:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6686c74183cso3415966b3a.1; 
 Mon, 03 Jul 2023 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688385806; x=1690977806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KucnPHdlb9n3r1OWsGETlskHo07kJsSKPTHtezK9w5Q=;
 b=SiGX23kMNv9HuN0gWyABqIFzq4LTXEeThlZsidIygtiNjqK9N0Bi5BFVq8lRD0H+lK
 ercqOefMs0b5q2EOdylOc4Ep98f4lOy5oQuEnDDb9GEDcP3fmTb7fa62phmxKqEvEvyp
 /ju7rM5O9vE12++eSlQGG+W38XZQQALr9+6As7QLjE6fyyHgOI9LGK8gOz9a5Lk8MpZz
 z+lomN+1T7xebV93QYJR2hV0zdiPhv17Jz/C/n3GomVGI6Vcd1MUEamZcU8DbA6lu6Og
 LIj9tz6EtficChsr2A5UQMPGxtoAXLcAxSk1jHzOdQN4qrnJfPbDfQozcY7eHEB+jiK7
 cTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688385806; x=1690977806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KucnPHdlb9n3r1OWsGETlskHo07kJsSKPTHtezK9w5Q=;
 b=gRCxYhKylcVpp+GAfQHEt9p3JuDTDgQKIaaMAgt8yeFqCO1/9AYeZ0eA5bhFEadE9H
 A/nlYTYVxXlo77ujT+Z9AxDtU+SGqqPa+laZtWIg43ekvNb0xkc3ck71sY3SBf/17PSG
 ZjTdhQreLDhkaJjjh/CGDhvfJ8KV+zqqacJEttLI0ZqVVGWablPOaMcDPYojUf/n7FkK
 eWcsRBbOSkyV7Kjp2DQpciEXis2Quj3xTK2FRVvQH9tiKVFlpyYTf1RA3aGaGilwkstD
 Ko2r2ipGee99QWg9Cd9buBGeVWHmexjIdRls6qKEsj5ZgZ56L7wRjq1P4AmZPq0sh7rn
 i5rg==
X-Gm-Message-State: ABy/qLa/AXycn/HDXF93h5vcrM37m5iZ0XMbXFU+m43vJlI2dBF79aql
 FqWTpS/OZQ5F8rNGnOKgamj+KaxeYvo=
X-Google-Smtp-Source: APBJJlGqp9QLzEf/d9Kd1X+JAr1soSxngJLq3dQEsPRwygtTfmmW4hws4LtgScPO53NVgp9tdlc9SQ==
X-Received: by 2002:a05:6a00:2d1d:b0:67a:a906:9edb with SMTP id
 fa29-20020a056a002d1d00b0067aa9069edbmr12993214pfb.30.1688385806527; 
 Mon, 03 Jul 2023 05:03:26 -0700 (PDT)
Received: from wheely.local0.net ([118.210.96.60])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a62b407000000b00682802ca418sm2901372pfn.79.2023.07.03.05.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 05:03:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v3] target/ppc: Machine check on invalid real address access
 on POWER9/10
Date: Mon,  3 Jul 2023 22:03:01 +1000
Message-Id: <20230703120301.45313-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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
these and turn them into machine checks on POWER9/10 machines.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Only implement this for POWER9/10. Seems like previous IBM processors
  may not catch this, trying to get info.

Since v2:
- Split out from larger series since it is independent.

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
index 354392668e..e49e13a30d 100644
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
@@ -3184,5 +3186,52 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
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
2.40.1


