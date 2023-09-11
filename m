Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19C879A89D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 16:29:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfht4-0005Pq-T1; Mon, 11 Sep 2023 10:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfht3-0005Pd-7O
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:27:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfht0-0003NM-So
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:27:37 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52e828ad46bso5911502a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694442452; x=1695047252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y2u6ntARkJIvNRR76qoe5f9qgwmF82Gn0r5UusWtZxI=;
 b=GWSh3RwEH8NwW1d4F+Gvw2rk665I8D95UeEJYn0gDUNfgSEBPPWOoD/MZYm8tedIwV
 U4/ySOzrYmvmKhBIqSuVpI9Xt7wg3YDFm/sjji/l5Pw7NpiwAgnOGFQlIKnHdc3CAOdS
 6BfJPuqx1EfRh4m5NCxYSWKK+7+FxYd4bPdQ76ciCznsiUKrBUdMjxiwS25T1Eh0imbS
 cwvQZRWbRoIPKEKA1iR8/d3srDs3OKNs6SqA3hJ1MCc6ld5L6zle4KMPAQP2Dt4QbLtC
 eRToB/9Ick6dUM+agetQGUG5mch2Ij9zjCVhWTsobPz7Dw2qduxbHtZMKHl1e1Hxmevy
 eHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694442452; x=1695047252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y2u6ntARkJIvNRR76qoe5f9qgwmF82Gn0r5UusWtZxI=;
 b=F3CG1DzgXX3qv0JcvRcJjhi8fv6uEYfGSaNF5CRrtMRWSmMrIMRQl5AklIizgFF10d
 aqdDwwJVXo+WRANccfhf2oVgxt+of7HkUDB0f6bbAO44p9sIq9Qg5zH5vInuvjsmFyvf
 P/OPAxdnzcp9gBbQbcstzULRbYyoyyBUtJukItWyR4rmhB7VCYlJQ2S+Md/swfdWpLoS
 sH5oUFlC02K+kLn7u1dUs4m3JpH7EZ6CcAP3r8Mt7ecFL6Mqt54eFMYuy1c5gq22Tnj0
 xeYBv4e1xvwMxpWbCPGfV7QpGWuWkCtFSbHo8XskO7lsZbluR39n2bEzj5YIRD+wqFCF
 fqOA==
X-Gm-Message-State: AOJu0YyIRnthmiu3ia043P6f9+sL86nCdBvbPwU6h9i+lnk07crGQfDT
 XOAzbke5XOEJKU595dqnB/5kLEFFyERZGOKvUiw=
X-Google-Smtp-Source: AGHT+IE6EaLC3OIVPcB4+Vjhcm6RbMF4kh3NqMBKkSHliE2tkXbVcgIzIe+A4mYSR40xCMeyuua83Q==
X-Received: by 2002:a17:906:cc12:b0:9a1:e293:9882 with SMTP id
 ml18-20020a170906cc1200b009a1e2939882mr8487409ejb.63.1694442452656; 
 Mon, 11 Sep 2023 07:27:32 -0700 (PDT)
Received: from m1x-phil.lan (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 lx24-20020a170906af1800b0099cb349d570sm5430139ejb.185.2023.09.11.07.27.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Sep 2023 07:27:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v3] target/i386: Restrict system-specific features from user
 emulation
Date: Mon, 11 Sep 2023 16:27:29 +0200
Message-ID: <20230911142729.25548-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 24ee67b42d..83914d5d1b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6163,6 +6163,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
 
+#ifndef CONFIG_USER_ONLY
             /*
              * SGX cannot be emulated in software.  If hardware does not
              * support enabling SGX and/or SGX flexible launch control,
@@ -6181,6 +6182,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                     CPUID_7_0_ECX_SGX_LC))) {
                 *ecx &= ~CPUID_7_0_ECX_SGX_LC;
             }
+#endif
         } else if (count == 1) {
             *eax = env->features[FEAT_7_1_EAX];
             *edx = env->features[FEAT_7_1_EDX];
@@ -7152,6 +7154,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
+#ifndef CONFIG_USER_ONLY
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
         kvm_enabled()) {
         KVMState *s = CPU(cpu)->kvm_state;
@@ -7179,6 +7182,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
         }
     }
+#endif
 }
 
 static void x86_cpu_hyperv_realize(X86CPU *cpu)
-- 
2.41.0


