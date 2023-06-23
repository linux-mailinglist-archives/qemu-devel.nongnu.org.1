Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92B73B8A5
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:19:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfQ-0004aY-Pw; Fri, 23 Jun 2023 09:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfO-0004Zr-OT
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfM-0005cQ-Tc
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1TKWKdWTS3EIYTM+VUz4o7AGmp4YH25zCUbvYtLRVc=;
 b=SKdrdEGpaGsiTHT0PsfKnw0JQDyEzztW3m3YYAOeWSgwRGZ56xasg5RKtOSWJi6PfSZMzG
 Y4r6ExvAmamRYigKID2hH+ppcGM0I98hMFdgspW6jO7NhUB0nfvZWSlqoUGM8JZa6A6H1x
 16Er7T3KH7oEHKI4B0G/qOjn9z4LOPI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XnhI3QNzOtylQ_1OS6DYdA-1; Fri, 23 Jun 2023 09:17:31 -0400
X-MC-Unique: XnhI3QNzOtylQ_1OS6DYdA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-514a6909c35so400149a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526249; x=1690118249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1TKWKdWTS3EIYTM+VUz4o7AGmp4YH25zCUbvYtLRVc=;
 b=PhPADDcm+4q02YbQy/cV/wvH/IxvJmItlCfv47M0iigpdl6d8fStROGgnvipU68u4M
 yI9ZJgauDWevrPieuYha7/I8l6XtZeYLld1WpHdjkFV5I6nN7Oz9dUgiBIgwdGvNSUNI
 4QuRUfBAgLyj+rnD/w9vxzn9qDFtU4oJSPBtlK5+j1KYjAsl3twgTDxYiggzhEtHJbcL
 eiXZQF2vHiCrOcgJ6zldakcBoMzOKt1lxjAdK+1Wx4h0jGxAl6luouK1p69fCTL8XKAH
 NfEBbTRg4UUsQKwnAJJe20BE/XnUQ2ooRPeZTDkh+kXU0rH4AZV+oWbXiw0lXNOswNh5
 Nbyw==
X-Gm-Message-State: AC+VfDyhaUIkulQBeavOPXxJQAmHgbkXUQmIsnB0S/6paIBmw6qBijoS
 Xvz9F4MrekKynZ+4tCTKJITVL+HkAJo3iIcDbsoAgG/5xf75oENtpp7W5LKQQ5yM4qWvNmLw0wc
 RmqQM+5uRn3KQZHRYX18CxOFEN0gXQQqabmtPpqjhTRH5SHVA2nW5Cmq2C0VuzcTQoynXlm54BU
 o=
X-Received: by 2002:a17:907:1b17:b0:96f:1f79:c0a6 with SMTP id
 mp23-20020a1709071b1700b0096f1f79c0a6mr17660508ejc.70.1687526249560; 
 Fri, 23 Jun 2023 06:17:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QBT0vPaxPoEHWSH48Uo14C++CaXyMMUEk9iMPlxNEhU62BtOyq+wK8TCcu+p/KvQat35fVA==
X-Received: by 2002:a17:907:1b17:b0:96f:1f79:c0a6 with SMTP id
 mp23-20020a1709071b1700b0096f1f79c0a6mr17660488ejc.70.1687526249226; 
 Fri, 23 Jun 2023 06:17:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 me16-20020a170906aed000b0098669cc16b2sm5939079ejb.83.2023.06.23.06.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 10/11] target/i386: implement RDPID in TCG
Date: Fri, 23 Jun 2023 15:17:10 +0200
Message-ID: <20230623131711.96775-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623131711.96775-1-pbonzini@redhat.com>
References: <20230623131711.96775-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Also try sched_getcpu(), which might be there on the BSDs.  If there is
no portable way to retrieve the current CPU id from userspace, return 0.

RDTSCP is reimplemented as RDTSC + RDPID ECX; the differences in terms
of serializability are not relevant to QEMU.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   |  2 ++
 target/i386/cpu.c             | 10 +++++++++-
 target/i386/helper.h          |  2 +-
 target/i386/tcg/misc_helper.c | 21 +++++++++++++++------
 target/i386/tcg/translate.c   | 24 +++++++++++++++++++-----
 5 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index 6ef78ea278b..3e3d38badb0 100644
--- a/meson.build
+++ b/meson.build
@@ -2232,6 +2232,8 @@ config_host_data.set('CONFIG_CLOCK_ADJTIME', cc.has_function('clock_adjtime'))
 config_host_data.set('CONFIG_DUP3', cc.has_function('dup3'))
 config_host_data.set('CONFIG_FALLOCATE', cc.has_function('fallocate'))
 config_host_data.set('CONFIG_POSIX_FALLOCATE', cc.has_function('posix_fallocate'))
+config_host_data.set('CONFIG_GETCPU', cc.has_function('getcpu', prefix: gnu_source_prefix))
+config_host_data.set('CONFIG_SCHED_GETCPU', cc.has_function('sched_getcpu', prefix: '#include <sched.h>'))
 # Note that we need to specify prefix: here to avoid incorrectly
 # thinking that Windows has posix_memalign()
 config_host_data.set('CONFIG_POSIX_MEMALIGN', cc.has_function('posix_memalign', prefix: '#include <stdlib.h>'))
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 978d24b5ec7..4d52e612ac7 100644
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
index 48609c210b1..c93c1d6c8f5 100644
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
index 5f7a3061ca5..868f36ab7f5 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -75,12 +75,6 @@ void helper_rdtsc(CPUX86State *env)
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
@@ -137,3 +131,18 @@ void helper_wrpkru(CPUX86State *env, uint32_t ecx, uint64_t val)
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
+#elif defined CONFIG_SCHED_GETCPU
+    return sched_getcpu();
+#else
+    return 0;
+#endif
+}
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 66800392bb9..a6c24241338 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3924,13 +3924,25 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_cmpxchg8b(s, env, modrm);
             break;
 
-        case 7: /* RDSEED */
+        case 7: /* RDSEED, RDPID with f3 prefix */
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
-                !(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_RDSEED)) {
+                (s->prefix & (PREFIX_LOCK | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
-            goto do_rdrand;
+            if (s->prefix & PREFIX_REPZ) {
+                if (!(s->cpuid_ext_features & CPUID_7_0_ECX_RDPID)) {
+                    goto illegal_op;
+                }
+                gen_helper_rdpid(s->T0, cpu_env);
+                rm = (modrm & 7) | REX_B(s);
+                gen_op_mov_reg_v(s, dflag, rm, s->T0);
+                break;
+            } else {
+                if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_RDSEED)) {
+                    goto illegal_op;
+                }
+                goto do_rdrand;
+            }
 
         case 6: /* RDRAND */
             if (mod != 3 ||
@@ -6125,7 +6137,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
2.41.0


