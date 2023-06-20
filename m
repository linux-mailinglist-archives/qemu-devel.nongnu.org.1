Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E676B736CC9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBb8j-0007Pm-AD; Tue, 20 Jun 2023 09:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8g-0007Nv-Vj; Tue, 20 Jun 2023 09:11:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8e-0000CV-Mc; Tue, 20 Jun 2023 09:11:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-66869feb7d1so1874508b3a.3; 
 Tue, 20 Jun 2023 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687266675; x=1689858675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alJuG3MYw6CejQf12po0CQZiLPypzNmI2P5dUAwRH0o=;
 b=b+jYElD/GffPe7795ZeXzQL7OSYpD2uSq2xaSLnPa9RU1Z8v7VssylIGixnd+C4o/v
 qV3FapprFT2WdJ/jDB5gISWPfZHWneb2UN2/sofnTT3syRVnOPn6xkydudUNPyPWF078
 syVCbKUNgs7GrUZGAwqyhp78Dt1ioRQ+vfEpboieWT55mJXeOKycvlK9v6zw5B9shpEw
 o6LLxpXuEUo8hA010oxlOHhyqJc0jXV6AV3FspAtq0IN7Xnf3MGicKGcGnOKp1kdGF2O
 2dlqZa6LIkGNrTIoWXLvl6+tM0BdD3g7Hc3Wvn0Bx/yWsjFxBy5fLPQ/b+XhT+akdGVH
 2wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687266675; x=1689858675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alJuG3MYw6CejQf12po0CQZiLPypzNmI2P5dUAwRH0o=;
 b=bSO6ohaEvaM9ikywye0hvP16uho8rL5mZzR+CN54MAWXqqJFaVVs9ZuMd7aNO8xGTc
 m8yS56FV7J5tLLJK35YNGD5nEx847KukJ5IWub2bYdJ7dQ9U7xRwLuLyK/OLIE6ALTDj
 AMVlsZh8foECo4ZmsNXWS31pzLogvprM38CSWF44UfnkbP/GFexIbsZOCOyRwkfVhAt0
 37C01KC5tvWd8uTM4LkHcQKRPDJYJ5XJ0pTalsEm3YiJPPuNB3rPhCcoRYEYqSoyItBB
 9q6T6pvlqcmp7kmdy6mSt5ODPA/ieTQigngm9AhcYIP9eUbgTJ5J+XLNHh05ICwDQhih
 De5g==
X-Gm-Message-State: AC+VfDwDvPCkoQe9OYdXHH32gLa02l/6XZYYyikqSYEVKwCfryMPAHrm
 xz+DLBXQg4YrXRhqhJOzOq4uxwWWQIs=
X-Google-Smtp-Source: ACHHUZ4fI5eEcHBiH3ljhnysLx3R6eGwPKZKYBHk1EQ01sxP6Z9L5z7lqr6UrbSImiPd55hmmaaMXQ==
X-Received: by 2002:a05:6a21:3414:b0:118:b72c:2924 with SMTP id
 yn20-20020a056a21341400b00118b72c2924mr10085254pzb.60.1687266674540; 
 Tue, 20 Jun 2023 06:11:14 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 w5-20020aa78585000000b00652a72b89d1sm1353285pfn.170.2023.06.20.06.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:11:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PATCH 4/4] target/ppc: Implement HEIR SPR
Date: Tue, 20 Jun 2023 23:10:44 +1000
Message-Id: <20230620131044.169110-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620131044.169110-1-npiggin@gmail.com>
References: <20230620131044.169110-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

The hypervisor emulation assistance interrupt modifies HEIR to
contain the value of the instruction which caused the exception.

Only TCG raises HEAI interrupts so this can be made TCG-only.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |  1 +
 target/ppc/cpu_init.c    | 23 +++++++++++++++++++++++
 target/ppc/excp_helper.c | 17 ++++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0ee2adc105..054edf3c80 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1647,6 +1647,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_HMER              (0x150)
 #define SPR_HMEER             (0x151)
 #define SPR_PCR               (0x152)
+#define SPR_HEIR              (0x153)
 #define SPR_BOOKE_LPIDR       (0x152)
 #define SPR_BOOKE_TCR         (0x154)
 #define SPR_BOOKE_TLB0PS      (0x158)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d3d6902e6e..d4a7bf01cc 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1630,6 +1630,7 @@ static void register_8xx_sprs(CPUPPCState *env)
  * HSRR0   => SPR 314 (Power 2.04 hypv)
  * HSRR1   => SPR 315 (Power 2.04 hypv)
  * LPIDR   => SPR 317 (970)
+ * HEIR    => SPR 339 (Power 2.05 hypv) (64-bit reg from 3.1)
  * EPR     => SPR 702 (Power 2.04 emb)
  * perf    => 768-783 (Power 2.04)
  * perf    => 784-799 (Power 2.04)
@@ -5523,6 +5524,24 @@ static void register_power6_common_sprs(CPUPPCState *env)
                  0x00000000);
 }
 
+static void register_HEIR32_spr(CPUPPCState *env)
+{
+    spr_register_hv(env, SPR_HEIR, "HEIR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic32,
+                 0x00000000);
+}
+
+static void register_HEIR64_spr(CPUPPCState *env)
+{
+    spr_register_hv(env, SPR_HEIR, "HEIR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+}
+
 static void register_power8_tce_address_control_sprs(CPUPPCState *env)
 {
     spr_register_kvm(env, SPR_TAR, "TAR",
@@ -5951,6 +5970,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     register_power5p_ear_sprs(env);
     register_power5p_tb_sprs(env);
     register_power6_common_sprs(env);
+    register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
     register_power7_book4_sprs(env);
 
@@ -6073,6 +6093,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     register_power5p_ear_sprs(env);
     register_power5p_tb_sprs(env);
     register_power6_common_sprs(env);
+    register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
@@ -6235,6 +6256,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power5p_ear_sprs(env);
     register_power5p_tb_sprs(env);
     register_power6_common_sprs(env);
+    register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
@@ -6427,6 +6449,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power5p_ear_sprs(env);
     register_power5p_tb_sprs(env);
     register_power6_common_sprs(env);
+    register_HEIR64_spr(env);
     register_power6_dbg_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1de6ea3f03..77bfc18734 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1642,13 +1642,28 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception         */
     case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception        */
     case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt            */
-    case POWERPC_EXCP_HV_EMU:
     case POWERPC_EXCP_HVIRT:     /* Hypervisor virtualization                */
         srr0 = SPR_HSRR0;
         srr1 = SPR_HSRR1;
         new_msr |= (target_ulong)MSR_HVB;
         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
         break;
+#ifdef CONFIG_TCG
+    case POWERPC_EXCP_HV_EMU: {
+        uint32_t insn = ppc_ldl_code(env, env->nip);
+        env->spr[SPR_HEIR] = insn;
+        if (is_prefix_insn(env, insn)) {
+            uint32_t insn2 = ppc_ldl_code(env, env->nip + 4);
+            env->spr[SPR_HEIR] <<= 32;
+            env->spr[SPR_HEIR] |= insn2;
+        }
+        srr0 = SPR_HSRR0;
+        srr1 = SPR_HSRR1;
+        new_msr |= (target_ulong)MSR_HVB;
+        new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
+        break;
+    }
+#endif
     case POWERPC_EXCP_VPU:       /* Vector unavailable exception             */
     case POWERPC_EXCP_VSXU:       /* VSX unavailable exception               */
     case POWERPC_EXCP_FU:         /* Facility unavailable exception          */
-- 
2.40.1


