Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A189079E3C8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMCx-0001H8-1L; Wed, 13 Sep 2023 05:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCv-0001Gk-Bu
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCs-0002Ky-5V
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31f4a286ae1so6199289f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694597444; x=1695202244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKbeAfeEWeYWq6ZMSQ2gP4OMkhbj3lmxF1/S1lGxkFI=;
 b=CHE19x6SBYVp28nEZ6D7kT6ITh4PMkcmBelUH8DsZgnjFb5s7kS0TmVoa66QkEwquE
 r37JlKtPfQVC6YEnqwAp4N5uJMrIBQGQA748c62L7inPkwy7Ze9QfikXEjdanjstak96
 4UvXTDciyedHazOsWDpKSKIeXyxMD8gw2+Kjf1eXKA2Rvfz4It62w0VC7NSIdPIZ8m6k
 nmbLml89r7NzpwmejN+ChOAkJ6vthdbaIjI5jbOvKcPkVnW0kF+kzjIlNl7Mu6zx9/1t
 IF65uFZfQRc2QMzx7LP9oqXAkB4I534SiLUVDJFFcFwb2/+DwftjPFZOD/ZN9fPQzget
 xG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694597444; x=1695202244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKbeAfeEWeYWq6ZMSQ2gP4OMkhbj3lmxF1/S1lGxkFI=;
 b=rQVbqhAHleW5yiXcwfQpI0Ksv0RiF1myS25wDxvEiRG5POdxzXxyVqm6a/gRJgKsBs
 NWXjJd96r3MMyJN/XcyuDaNaDvWGfp/UVAZueYiFFHfZBgBE86HTxx81COdnp6Ral4Pz
 FW3qO53cYZeJSV54KgmxbMUJvx8udTdbzQmK3nAsSY4z7gGy2boomnpfHoeixHndsaCy
 S36K4VKHKcqGy116el9Fx6j9h3jgyBdsJt9eTAMOHQ/nY1E95FXIZ2taC14F/0CJ9adR
 D6n71BlsAUkh1RMeOHc3d6/VJ+ysJnINxYCFlQOR28nOt/rCwb9f618pYGWT9XSJgj9j
 ZmAw==
X-Gm-Message-State: AOJu0Yz/c+nERp8I633xn9npAAT7eJ6BpPtilv7xqUshk/JIYeyum3D7
 zJBIuTiVTTj4xuSq2kZ5qeRbPrXb08aGH5ogfgk=
X-Google-Smtp-Source: AGHT+IFygu3BAr+7UcI3dOenQQ5WxeefjdnW+wv88rHPugEcR1Z+feWe0l1BCnKAc2a9M86WKXr2Zg==
X-Received: by 2002:adf:ebc8:0:b0:31a:e6c2:770d with SMTP id
 v8-20020adfebc8000000b0031ae6c2770dmr1565964wrn.36.1694597444117; 
 Wed, 13 Sep 2023 02:30:44 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-241.abo.bbox.fr. [176.131.211.241])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a5d6da4000000b0031fb91f23e9sm4107295wrs.43.2023.09.13.02.30.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Sep 2023 02:30:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 5/6] target/i386: Restrict system-specific code from
 user emulation
Date: Wed, 13 Sep 2023 11:30:07 +0200
Message-ID: <20230913093009.83520-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913093009.83520-1-philmd@linaro.org>
References: <20230913093009.83520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Restrict calls to:
 - kvm_arch_get_supported_cpuid()
 - kvm_arch_get_supported_msr_feature()
 - kvm_request_xsave_components()
 - kvm_hyperv_expand_features()
so we can remove restrict "kvm/kvm_i386.h" and all its
declarations to system emulation (see the next commit).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3df85a6347..c201ff26bd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5654,8 +5654,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-#endif /* !CONFIG_USER_ONLY */
-
 /*
  * Returns the set of feature flags that are supported and migratable by
  * QEMU, for a given FeatureWord.
@@ -5781,6 +5779,38 @@ static void x86_cpu_get_cache_cpuid(uint32_t func, uint32_t index,
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
@@ -6918,7 +6948,6 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
     int i;
     uint64_t mask;
-    static bool request_perm;
 
     if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
         env->features[FEAT_XSAVE_XCR0_LO] = 0;
@@ -6934,11 +6963,15 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
         }
     }
 
+#ifndef CONFIG_USER_ONLY
+    static bool request_perm;
+
     /* Only request permission for first vcpu */
     if (kvm_enabled() && !request_perm) {
         kvm_request_xsave_components(cpu, mask);
         request_perm = true;
     }
+#endif /* !CONFIG_USER_ONLY */
 
     env->features[FEAT_XSAVE_XCR0_LO] = mask & CPUID_XSTATE_XCR0_MASK;
     env->features[FEAT_XSAVE_XCR0_HI] = mask >> 32;
@@ -7119,9 +7152,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
 
+#ifndef CONFIG_USER_ONLY
     if (kvm_enabled() && !kvm_hyperv_expand_features(cpu, errp)) {
         return;
     }
+#endif /* !CONFIG_USER_ONLY */
 }
 
 /*
-- 
2.41.0


