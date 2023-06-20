Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C507737034
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd74-0004B0-Sj; Tue, 20 Jun 2023 11:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd72-0004AV-Pz
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd70-0007dW-2x
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cTKqXhIbyrOOMaCgoxgtDDnaaUt/5C5m5ukFQxIg4M=;
 b=PNfwEyOH5draiSQFrafTgO/Gu3Z2QpLpd+m3rsT4D/Psx1/h9CzqIhNbUF6V4c/9JBqL+q
 /SMkaVbWT5B7wl+zbJbt1WmQxMF554txBXTwnksKp0bP8C6mvOcTMK30WdMY+k/lb5hGQn
 Lsodm0GAUQFMbJXQ7NkRuotXNxk+QMI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-ehJUnzK6NKe2wzX3QqVQwA-1; Tue, 20 Jun 2023 11:17:04 -0400
X-MC-Unique: ehJUnzK6NKe2wzX3QqVQwA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51a595bc30dso2790377a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274214; x=1689866214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cTKqXhIbyrOOMaCgoxgtDDnaaUt/5C5m5ukFQxIg4M=;
 b=djP3Xdz9Jv0sMMJJqdl8yyaqLZgrkX0yMYTHMjRSgN9EyZgJOEJDwZ6fHlgPEDgJcF
 LvCoDEN7fSWHjju0UfU+27fX0Zb0I7VwWVtbNaoE2yCclb0fbNYA1RCQ5uamP9ajqRZZ
 531FsG8t7Jr2oFduX2g/KoTJ0UOMR3MjjqMVFGJXwnCcyN3Yuw9UU3/KvIrzBd9LjMYq
 uwFvhXE/43v3jPB/T1lab/mUHVFnkD62pI4rVnaTWvh4PdRZqDPJ47GJSjAfSZoYEGZ7
 99tFkfs6RnAYWqF5kGvjy8gsWqkMJavYxLZ0eBk+cL9VyFyYcBFQwQtpoj45y1mAJAte
 dpPQ==
X-Gm-Message-State: AC+VfDzwHk/X8UfIl2R6q8vcWKAW/gtzzcnLFB/EAI0lHKO/OK6SZ4rx
 sIDIEPd00MeyQ4R/RZBqu+OVAAxcZ27O5Jc/a6J2Zw5i8lMGuhA9Ek4lHazMJ/67VRLO3w2cnWM
 s0UUrgefHFMI1jBvXcYATKSfkZX86q3Ix6qgiM6wJzFprTwcdcHAxZw+5/5p1ooP10doJmLRlFW
 4=
X-Received: by 2002:a05:6402:4409:b0:51a:409f:a0bd with SMTP id
 y9-20020a056402440900b0051a409fa0bdmr11673441eda.19.1687274214043; 
 Tue, 20 Jun 2023 08:16:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZYBQbke9fyipgp0gO+moUF9sMcVdw24TKEeMn8ERjdZgQBPj/b2mXpdECihtiFj29cIbFvQ==
X-Received: by 2002:a05:6402:4409:b0:51a:409f:a0bd with SMTP id
 y9-20020a056402440900b0051a409fa0bdmr11673427eda.19.1687274213746; 
 Tue, 20 Jun 2023 08:16:53 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 v7-20020aa7d647000000b005153b12c9f7sm1358035edr.32.2023.06.20.08.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 10/10] target/i386: implement RDPID in TCG
Date: Tue, 20 Jun 2023 17:16:34 +0200
Message-Id: <20230620151634.21053-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620151634.21053-1-pbonzini@redhat.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
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
 meson.build                   |  1 +
 target/i386/cpu.c             | 10 +++++++++-
 target/i386/helper.h          |  2 +-
 target/i386/tcg/misc_helper.c | 23 +++++++++++++++++------
 target/i386/tcg/translate.c   | 15 +++++++++++++--
 5 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index 34306a6205b..0f6c5a70333 100644
--- a/meson.build
+++ b/meson.build
@@ -2230,6 +2230,7 @@ config_host_data.set('CONFIG_CLOCK_ADJTIME', cc.has_function('clock_adjtime'))
 config_host_data.set('CONFIG_DUP3', cc.has_function('dup3'))
 config_host_data.set('CONFIG_FALLOCATE', cc.has_function('fallocate'))
 config_host_data.set('CONFIG_POSIX_FALLOCATE', cc.has_function('posix_fallocate'))
+config_host_data.set('CONFIG_GETCPU', cc.has_function('getcpu', prefix: gnu_source_prefix))
 # Note that we need to specify prefix: here to avoid incorrectly
 # thinking that Windows has posix_memalign()
 config_host_data.set('CONFIG_POSIX_MEMALIGN', cc.has_function('posix_memalign', prefix: '#include <stdlib.h>'))
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2c71c3ea32b..974e2eb46d7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -674,9 +674,17 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
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
index 49d2f537557..d796f0d2f70 100644
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
index 5f7a3061ca5..66d6bbfcb40 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
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
@@ -137,3 +135,16 @@ void helper_wrpkru(CPUX86State *env, uint32_t ecx, uint64_t val)
     env->pkru = val;
     tlb_flush(cs);
 }
+
+target_ulong HELPER(rdpid)(CPUX86State *env)
+{
+#if defined CONFIG_SOFTMMU
+    return env->tsc_aux;
+#elif defined CONFIG_LINUX && defined CONFIG_GETCPU
+    unsigned cpu, node;
+    getcpu(&cpu, &node);
+    return (node << 12) | (cpu & 0xfff);
+#else
+    return 0;
+#endif
+}
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index af74c842f96..a803bcb96b3 100644
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
@@ -6111,7 +6120,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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


