Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 431797348B9
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0J8-0002sU-G3; Sun, 18 Jun 2023 17:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0J6-0002qK-6O
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0J4-0006Wh-GY
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687125093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqH8fjFr8PPgqeNcfvETyMoXCnQjhczLQPGBIBmp9lg=;
 b=OI99Pfvv7UDI//jInRrB742yPnXj2rWeIvB0Wmti2MVhGJWxi9o4t8Wr5d5hh5cTfKetXQ
 J/fpmkgE8ZiWKPzbVTrLnMVXZVGRcYYbYhkWbpgWGIyhBATPya4tC2F2xd/ZE1Prm2B/np
 dVFEHmy75SRseKRxqyREil/pgbIvwlU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-DR3VJ9AoNWiVBeyMvcwOTQ-1; Sun, 18 Jun 2023 17:51:32 -0400
X-MC-Unique: DR3VJ9AoNWiVBeyMvcwOTQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31126581e13so3829740f8f.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687125090; x=1689717090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqH8fjFr8PPgqeNcfvETyMoXCnQjhczLQPGBIBmp9lg=;
 b=lpI8cNVGhLWueWdYvIsGoxJrUfwZ1KUcxYM20h/ySiDi4RtIkz4aQkg+nDrzGsLwh+
 AcHBi3hBLw9DfHkumngUPdgnyfJ63cn7ofn7cnaMxjZIebJWimhSk3wj+LqKUlwXj9J+
 WsWTY9kwIn/8QEgTPVTlj7AyO0p0zQab+RCiiGhFONrg45mO2AdBavdjyREMM+5CREej
 VEWIQYe0ycY+GA3IaBQSEIzUqDmYSd0BO2WUYcTK7WOirRyi4EymDu7gChvuYKh88EE4
 PPRZlqULOgyg3NubKdAL2HSpjF6dI7+GNOvznK930tLMJctnYstMrQ602Oqq4vxUn6nE
 grjQ==
X-Gm-Message-State: AC+VfDx/hs6290p4Xz8bKmxsdA9Ci/l0nS1BpC1yK8czlfu3qAds3qi8
 Ky7om2y+8+N6ElR/pGaYbUnOexJ/CvbFfdwOc+JuwpVMzsrYtrefoeCIUqRAnTaQZbFP5MVDyFR
 YncVmaQW8P/O6thiNero5Tu6ZFmf0AQKFdJLf6AlEX8Vu9jj/bVDO/9mifZBnHZbCl8B9gcEHrf
 DjBg==
X-Received: by 2002:a5d:5272:0:b0:307:8651:258e with SMTP id
 l18-20020a5d5272000000b003078651258emr7375330wrc.21.1687125090607; 
 Sun, 18 Jun 2023 14:51:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KXr+S8bypWqTMPU8Q2EZTY/oTovP7SdgvPiKTUVivFSLAeznXLjk5hix9A1iAn0MljUt0IA==
X-Received: by 2002:a5d:5272:0:b0:307:8651:258e with SMTP id
 l18-20020a5d5272000000b003078651258emr7375309wrc.21.1687125090077; 
 Sun, 18 Jun 2023 14:51:30 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 eh9-20020a0564020f8900b0050a276e7ba8sm12272077edb.36.2023.06.18.14.51.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:51:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/i386: implement RDPID in TCG
Date: Sun, 18 Jun 2023 23:51:13 +0200
Message-Id: <20230618215114.107337-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618215114.107337-1-pbonzini@redhat.com>
References: <20230618215114.107337-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

RDPID corresponds to a RDMSR(TSC_AUX); however, it is unprivileged
so for user-mode emulation we must provide the value that the kernel
places in the MSR.  For Linux, it is a combination of the current CPU
and the current NUMA node, both of which can be retrieved with getcpu(2).
For BSD, just return 0.

RDTSCP is reimplemented as RDTSC + RDPID ECX; the differences in terms
of serializability are not relevant to QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/i386/target_cpu.h   |  8 ++++++++
 linux-user/x86_64/target_cpu.h |  1 +
 target/i386/cpu.c              | 10 +++++++++-
 target/i386/helper.h           |  2 +-
 target/i386/tcg/misc_helper.c  | 21 +++++++++++++++------
 target/i386/tcg/translate.c    | 15 +++++++++++++--
 6 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index 52caf788cc3..3539f790222 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -54,4 +54,12 @@ static inline abi_ulong get_sp_from_cpustate(CPUX86State *state)
 {
     return state->regs[R_ESP];
 }
+
+static inline uint32_t get_cpunode(void)
+{
+    unsigned cpu, node;
+    getcpu(&cpu, &node);
+    return (node << 12) | (cpu & 0xfff);
+}
+
 #endif /* I386_TARGET_CPU_H */
diff --git a/linux-user/x86_64/target_cpu.h b/linux-user/x86_64/target_cpu.h
index 9ec7cbb7a4c..dec2e24f5a3 100644
--- a/linux-user/x86_64/target_cpu.h
+++ b/linux-user/x86_64/target_cpu.h
@@ -1 +1,2 @@
+#include "target_syscall.h"
 #include "../i386/target_cpu.h"
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8e12616db5e..68218103108 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -661,9 +661,17 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           /* missing:
           CPUID_7_0_EBX_HLE
           CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
+
+#if defined CONFIG_SOFTMMU || defined CONFIG_LINUX
+#define TCG_7_0_ECX_RDPID CPUID_7_0_ECX_RDPID
+#else
+#define TCG_7_0_ECX_RDPID 0
+#endif
 #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
-          CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES)
+          CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES | \
+          TCG_7_0_ECX_RDPID)
+
 #define TCG_7_0_EDX_FEATURES CPUID_7_0_EDX_FSRM
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC)
diff --git a/target/i386/helper.h b/target/i386/helper.h
index e627a931073..4e308aae643 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -69,8 +69,8 @@ DEF_HELPER_2(into, void, env, int)
 DEF_HELPER_FLAGS_1(single_step, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_1(rechecking_single_step, void, env)
 DEF_HELPER_1(cpuid, void, env)
+DEF_HELPER_FLAGS_1(rdpid, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_1(rdtsc, void, env)
-DEF_HELPER_1(rdtscp, void, env)
 DEF_HELPER_FLAGS_1(rdpmc, TCG_CALL_NO_WG, noreturn, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index 5f7a3061ca5..9bcbf6fd60d 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -24,6 +24,10 @@
 #include "exec/exec-all.h"
 #include "helper-tcg.h"
 
+#if defined CONFIG_USER_ONLY && defined CONFIG_LINUX
+#include "target_cpu.h"
+#endif
+
 /*
  * NOTE: the translator must set DisasContext.cc_op to CC_OP_EFLAGS
  * after generating a call to a helper that uses this.
@@ -75,12 +79,6 @@ void helper_rdtsc(CPUX86State *env)
     env->regs[R_EDX] = (uint32_t)(val >> 32);
 }
 
-void helper_rdtscp(CPUX86State *env)
-{
-    helper_rdtsc(env);
-    env->regs[R_ECX] = (uint32_t)(env->tsc_aux);
-}
-
 G_NORETURN void helper_rdpmc(CPUX86State *env)
 {
     if (((env->cr[4] & CR4_PCE_MASK) == 0 ) &&
@@ -137,3 +135,14 @@ void helper_wrpkru(CPUX86State *env, uint32_t ecx, uint64_t val)
     env->pkru = val;
     tlb_flush(cs);
 }
+
+target_ulong HELPER(rdpid)(CPUX86State *env)
+{
+#if defined CONFIG_SOFTMMU
+    return env->tsc_aux;
+#elif defined CONFIG_LINUX
+    return get_cpunode();
+#else
+    return 0;
+#endif
+}
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9783fe80a30..9023f47fa69 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3924,7 +3924,16 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_cmpxchg8b(s, env, modrm);
             break;
 
-        case 7: /* RDSEED */
+        case 7: /* RDSEED, RDPID with f3 prefix */
+            if (mod == 3 && !(s->prefix & PREFIX_LOCK) &&
+                (s->prefix & PREFIX_REPZ) &&
+                (s->cpuid_ext_features & CPUID_7_0_ECX_RDPID)) {
+                gen_helper_rdpid(s->T0, cpu_env);
+                rm = (modrm & 7) | REX_B(s);
+                gen_op_mov_reg_v(s, dflag, rm, s->T0);
+                break;
+            }
+            /* fallthrough */
         case 6: /* RDRAND */
             if (mod != 3 ||
                 (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
@@ -6108,7 +6117,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             translator_io_start(&s->base);
-            gen_helper_rdtscp(cpu_env);
+            gen_helper_rdtsc(cpu_env);
+            gen_helper_rdpid(s->T0, cpu_env);
+            gen_op_mov_reg_v(s, dflag, R_ECX, s->T0);
             break;
 
         default:
-- 
2.40.1


