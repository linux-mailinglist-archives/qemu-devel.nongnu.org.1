Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B6179AB76
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfoDz-0003dw-Uy; Mon, 11 Sep 2023 17:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfoDy-0003dl-Hi
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:13:38 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfoDv-0005CP-TB
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:13:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4cbso6191495a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694466813; x=1695071613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHvSEfFrQcxmWmTmnxddV4RlJUGQqaNdgjpuMQl5NIM=;
 b=jyM7MOUx1+bPlAGDC7O4WSn/9ntVn+1t3/LqNyRZaI+iLdMEJCvwgHDwXVJkVvR8Ee
 n5BxQxxiO86DGnczOYFVp+gfgD1LKlQN2IFppbyreuMym6NJoH8QuoNVGojzYa9/jh5t
 a2PZoqbkZFttU88uJrvTxE0GRSdhJHPxzngtpDMkaGsY/zK6gz9BD3MnYGC0hXV0dQIX
 U8sxuJoHOWTypoS1XwUGISoExBzEyrvIY3eepAFiLHV5yQE8VslS3P4eR8oClZDfZ5FS
 kFu6ZP/doGXyQAk7hsVoZTocg4xZgRtd99I/zHRYHsRld1RR67ai/HsEYgg6btxKm+Y9
 Vk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694466813; x=1695071613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHvSEfFrQcxmWmTmnxddV4RlJUGQqaNdgjpuMQl5NIM=;
 b=lifOjaAEAsFw3a4ibschAIIcK2j5yOF2fslo+opOliJihDxPffVl5GqWcCaWknd12d
 KCIbJvnUCSNDaCYEt+rprJHBx6Sbn5C5ZChZmQyGPJAOjqlSTbCawiTNqpqrxugIDMmi
 HaB9vPU6gw5nJYWjYXawNT3iBNkRoi9ycGSC66X2euWR1vDPHNXaQcuWFJb8Mq50ffsJ
 ZQCA0rOjTDSLKjAdKOPQwX9K8jxdx8WPx3pZ442eqvTfAHe8tosmi1oEjczvLcjREpjh
 FyoTS+Q8gTkNjKyXTEzaGLkOhmX8RCMDza9CHsiIB8eNG0XeLpuB1+E3ilu9WuRo03nw
 PoSQ==
X-Gm-Message-State: AOJu0YyN9o0YtKYK5PiUiPmwS0QAhy5bP025DjvD3YF7ims1eL78I5Xx
 bxLdQ2qkmx+oaHiLTFjJB3GCHDStO2SdedDK4fc=
X-Google-Smtp-Source: AGHT+IHlbEUdBzYSoedkHroPwt4AlkXyt7WAKtmPFviYLtFN5z7i4ltmDFHgoedOXFLkMQBoGsRLxA==
X-Received: by 2002:a17:906:74c7:b0:9a1:e758:fc6e with SMTP id
 z7-20020a17090674c700b009a1e758fc6emr9487589ejl.10.1694466813214; 
 Mon, 11 Sep 2023 14:13:33 -0700 (PDT)
Received: from m1x-phil.lan (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 hb19-20020a170906b89300b009a1fd22257fsm5820515ejb.207.2023.09.11.14.13.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Sep 2023 14:13:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [RFC PATCH v4 2/3] target/i386: Restrict system-specific features
 from user emulation
Date: Mon, 11 Sep 2023 23:13:16 +0200
Message-ID: <20230911211317.28773-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911211317.28773-1-philmd@linaro.org>
References: <20230911211317.28773-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since commits 3adce820cf ("target/i386: Remove unused KVM
stubs") and ef1cf6890f ("target/i386: Allow elision of
kvm_hv_vpindex_settable()"), when building on a x86 host
configured as:

  $ ./configure --cc=clang \
    --target-list=x86_64-linux-user,x86_64-softmmu \
    --enable-debug

we get:

  [71/71] Linking target qemu-x86_64
  FAILED: qemu-x86_64
  /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
  cpu.c:(.text+0x1374): undefined reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
  cpu.c:(.text+0x81c2): undefined reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: cpu.c:(.text+0x81da): undefined reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: cpu.c:(.text+0x81f2): undefined reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: cpu.c:(.text+0x820a): undefined reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:cpu.c:(.text+0x8225): more undefined references to `kvm_arch_get_supported_cpuid' follow
  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  ninja: build stopped: subcommand failed.

libqemu-x86_64-linux-user.fa is user emulation specific, so
having system emulation code called there is dubious.

'--enable-debug' disables optimizations (CFLAGS=-O0).

While at this (un)optimization level GCC eliminate the
following dead code (CPP output of mentioned build):

 static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
                                         uint32_t *eax, uint32_t *ebx,
                                         uint32_t *ecx, uint32_t *edx)
 {
     if ((0)) {
         *eax = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EAX);
         *ebx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EBX);
         *ecx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_ECX);
         *edx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EDX);
     } else if (0) {
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
     } else {
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
     }
 }

Clang does not.

Instead of trying to deal with compiler specific checks around
__OPTIMIZE__ (see commit 2140cfa51d "i386: Fix build by providing
stub kvm_arch_get_supported_cpuid()"), simply restrict code
belonging to system emulation, easing user emulation linking.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: I might have been overzealous in x86_cpu_expand_features(),
please double check.
---
 target/i386/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 760428d4dc..8b57708604 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1664,6 +1664,7 @@ static inline uint64_t x86_cpu_xsave_xss_components(X86CPU *cpu)
            cpu->env.features[FEAT_XSAVE_XSS_LO];
 }
 
+#ifndef CONFIG_USER_ONLY
 /*
  * Returns the set of feature flags that are supported and migratable by
  * QEMU, for a given FeatureWord.
@@ -1686,6 +1687,7 @@ static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
     }
     return r;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
@@ -5677,8 +5679,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-#endif /* !CONFIG_USER_ONLY */
-
 uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                             bool migratable_only)
 {
@@ -5781,6 +5781,38 @@ static void x86_cpu_get_cache_cpuid(uint32_t func, uint32_t index,
     }
 }
 
+#else /* CONFIG_USER_ONLY */
+
+uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
+                                            bool migratable_only)
+{
+    FeatureWordInfo *wi = &feature_word_info[w];
+
+    return wi->tcg_features;
+}
+
+static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
+                                        uint32_t *eax, uint32_t *ebx,
+                                        uint32_t *ecx, uint32_t *edx)
+{
+    *eax = 0;
+    *ebx = 0;
+    *ecx = 0;
+    *edx = 0;
+}
+
+static void x86_cpu_get_cache_cpuid(uint32_t func, uint32_t index,
+                                    uint32_t *eax, uint32_t *ebx,
+                                    uint32_t *ecx, uint32_t *edx)
+{
+    *eax = 0;
+    *ebx = 0;
+    *ecx = 0;
+    *edx = 0;
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
 /*
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
@@ -6163,6 +6195,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
 
+#ifndef CONFIG_USER_ONLY
             /*
              * SGX cannot be emulated in software.  If hardware does not
              * support enabling SGX and/or SGX flexible launch control,
@@ -6181,6 +6214,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                     CPUID_7_0_ECX_SGX_LC))) {
                 *ecx &= ~CPUID_7_0_ECX_SGX_LC;
             }
+#endif
         } else if (count == 1) {
             *eax = env->features[FEAT_7_1_EAX];
             *edx = env->features[FEAT_7_1_EDX];
@@ -6876,6 +6910,8 @@ static void mce_init(X86CPU *cpu)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static void x86_cpu_adjust_level(X86CPU *cpu, uint32_t *min, uint32_t value)
 {
     if (*min < value) {
@@ -6948,6 +6984,8 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     env->features[FEAT_XSAVE_XSS_HI] = mask >> 32;
 }
 
+#endif /* !CONFIG_USER_ONLY */
+
 /***** Steps involved on loading and filtering CPUID data
  *
  * When initializing and realizing a CPU object, the steps
@@ -7040,6 +7078,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+#ifndef CONFIG_USER_ONLY
     if (!kvm_enabled() || !cpu->expose_kvm) {
         env->features[FEAT_KVM] = 0;
     }
@@ -7111,6 +7150,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         return;
     }
 
+#endif /* !CONFIG_USER_ONLY */
+
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
     if (env->cpuid_level_func7 == UINT32_MAX) {
         env->cpuid_level_func7 = env->cpuid_min_level_func7;
@@ -7152,6 +7193,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
+#ifndef CONFIG_USER_ONLY
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
         kvm_enabled()) {
         KVMState *s = CPU(cpu)->kvm_state;
@@ -7179,6 +7221,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
         }
     }
+#endif
 }
 
 static void x86_cpu_hyperv_realize(X86CPU *cpu)
-- 
2.41.0


