Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF173FD25
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE92G-0005Uc-4i; Tue, 27 Jun 2023 09:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE92E-0005Rs-E6; Tue, 27 Jun 2023 09:47:10 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE92B-0001JU-AU; Tue, 27 Jun 2023 09:47:10 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-666e6541c98so4431980b3a.2; 
 Tue, 27 Jun 2023 06:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687873625; x=1690465625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOoc6xClBLtTPdseM08r+kt7dnVw71jVnxQs7RekJek=;
 b=nvWyBNBF/b33TekCNkRSIdHZJIJIkZ7GszZbX47z942E6xJhYAlG9kf36SUVRgS/XP
 9HliRPIyGgJ79h15gWk39Jojny4tt7ricIR9KDmCAbhtGYl71ctZSplG7yKMdDqgokib
 LB/4qA81jidt3tKXX9w7ZNXt1S8KBRx7oKYhNw9ak+vnxqBuB/WkJGV8M9KMZrWiPzZT
 i6HiEuS9lBSLCL4rydyWU4geCXe58Jxd+KBUqjrr119gZb6KFWjdaQAu5SUfMyKz8Eyu
 O/kFrvSX0nGsn1aMPV/MxOu6uCA9ISR6h+5PvUsz9NegicVFnIaJ9iBs+bHoAOAYnhe9
 1nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687873625; x=1690465625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOoc6xClBLtTPdseM08r+kt7dnVw71jVnxQs7RekJek=;
 b=cszWDpDy4P2jDkpPlDqUiEvcdlLvflASZOl6gWrk5zmybQ5k4/6yEqPzEwSf8s3D47
 DutDH06Ec87XT9xXc2zC5x+PCbbEIOjU7lHWSBspRZDLGTwg/9pYuMqTvk82h7Xpik+a
 a7jKkS3i9hpCbXa6PlCNwqxnsL6GkK44Nbv/a82Dfb/Jzs0VAzjZdtizKYl8VbSjLTzB
 itrFMvm0RTYfnRhOKXRtcpjPp3uqDWPSsmqpOO9NZddaVe8DF9/ify+Q5kyui4lJkBGs
 E5ACym+yMgypmipQY81/StDbW9MqxE/fI7NVCe31wN1XhhcGae0DkqPNetN3sYxh+qGS
 5H0g==
X-Gm-Message-State: AC+VfDyxWH19Os+iEWx/fnuiq1Pe9eQcDp7vsDODSHvrWMFkUGAdsCvl
 7lIScn9S8bOvoW0Lq2AP/hSnlxxJuiY=
X-Google-Smtp-Source: ACHHUZ7/ZcKC7sF+IP7p5VSuKlRH4YYGb7x0lnN9hKT+Pd4yv0wUTF5AAitVfroZZB28W8tgQ2ZNgg==
X-Received: by 2002:a05:6a20:7f93:b0:118:eeef:2a25 with SMTP id
 d19-20020a056a207f9300b00118eeef2a25mr46741511pzj.34.1687873625163; 
 Tue, 27 Jun 2023 06:47:05 -0700 (PDT)
Received: from wheely.local0.net (193-116-109-121.tpgi.com.au.
 [193.116.109.121]) by smtp.gmail.com with ESMTPSA id
 d9-20020a63f249000000b0051eff0a70d7sm5741384pgk.94.2023.06.27.06.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 06:47:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 1/4] target/ppc: Machine check on invalid real address
 access on POWER9/10
Date: Tue, 27 Jun 2023 23:46:41 +1000
Message-Id: <20230627134644.260663-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627134644.260663-1-npiggin@gmail.com>
References: <20230627134644.260663-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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
  may not catch this after all, trying to get info.

 target/ppc/cpu_init.c    |  1 +
 target/ppc/excp_helper.c | 49 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/internal.h    |  5 ++++
 3 files changed, 55 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index aeff71d063..a97fb7fe10 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7295,6 +7295,7 @@ static const struct TCGCPUOps ppc_tcg_ops = {
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
   .do_unaligned_access = ppc_cpu_do_unaligned_access,
+  .do_transaction_failed = ppc_cpu_do_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2158390e27..13318fbbb9 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1493,7 +1493,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
+        msr |= env->error_code;
         break;
+
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
         break;
@@ -3253,5 +3255,52 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
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
+         * Machine check codes can be found in User Manual or Linux or
+         * skiboot source.
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
+        } else { /* Fetch */
+
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


