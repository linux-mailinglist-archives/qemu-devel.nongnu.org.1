Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF4873DD31
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:20:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBv-0003Mg-J7; Mon, 26 Jun 2023 07:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBl-0003B7-J6
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBi-0000mt-59
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1TKWKdWTS3EIYTM+VUz4o7AGmp4YH25zCUbvYtLRVc=;
 b=UXCMYA3b1yme/AOSiH9c+1w/mEHtWiiQq6W93N/dNrRXJKvfIL9VcmapDMgYhnHGfWgJbs
 2GAC9V4NX17xuVKI+jnY9MlONLLZ0tKlZIJILYT2djfyGVp8jRYcPAwQaxjK2Rl7gwrcjF
 RIuO4vHbMggxGjbVbXFVTf+C24fEgbk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452--v27ZA91Oj-qn-dabH96Yg-1; Mon, 26 Jun 2023 07:15:12 -0400
X-MC-Unique: -v27ZA91Oj-qn-dabH96Yg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31290e36b6aso1724834f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778111; x=1690370111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1TKWKdWTS3EIYTM+VUz4o7AGmp4YH25zCUbvYtLRVc=;
 b=VSeNVENrVfuGT6TYL/3acqwpOlyBUYVw3GDoljQVjklvf/qiOupFhg3WVI7cuIjwOQ
 mDNM3SyfpxJM8d7lhkIZc7QbPtxNuSNnwCFZ/9g/400y+BW6tawYgqLuLNBtlVD1v7ku
 EzeIloVx4mNj4eagS7Tw7Ts0Bfo/ffSW4JSFBLIkaHpO9ofz3S/lsAagS4tY6Zie1rmg
 irvnEzGyjJDoC1trpnDgaNeVeiTQIZrwS3dB1Sg3507bNYlkadsnyhL7pnxG3TQYlm8U
 PQsx23vN07mgkAuEJorwHCFW3DY+cCea6rzssM5A9oG9cW+gNF7BwrUhdTLCLVbx5lc7
 06KA==
X-Gm-Message-State: AC+VfDxPKpLbm14PVsHrghhxmMNGEf2X5D3GjDGj+BE840ke+FC2PyBI
 AxffZmGYGoXVVuAP8rfpyNWOFnevOsWzQ/P2p/c2e84iTRcHMAnq0uGgrWhhE9OPPBi5ZVI28Gg
 mtUVqZjo1aP7fExNiA9ZxxA3qEpcHrL8jmKjI47t3WiptSt9m8BJ5Vh0yYu6YxFCy5qfCywBVNy
 A=
X-Received: by 2002:a05:6000:11cd:b0:313:eaac:f337 with SMTP id
 i13-20020a05600011cd00b00313eaacf337mr3588410wrx.53.1687778110937; 
 Mon, 26 Jun 2023 04:15:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Zbkau2sWvWlO2UdqISGCuajKV95NHMaTYLe3X4CGKtn5VkzyKfLD1oa1XU7KIW/ijZ9e1vA==
X-Received: by 2002:a05:6000:11cd:b0:313:eaac:f337 with SMTP id
 i13-20020a05600011cd00b00313eaacf337mr3588397wrx.53.1687778110659; 
 Mon, 26 Jun 2023 04:15:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a5d4ec6000000b0030ae849c70csm7070939wrv.37.2023.06.26.04.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/18] target/i386: implement RDPID in TCG
Date: Mon, 26 Jun 2023 13:14:43 +0200
Message-ID: <20230626111445.163573-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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


