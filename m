Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6279A754
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:39:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfeJX-0000gO-Qv; Mon, 11 Sep 2023 06:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfeJU-0000fu-Nn
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:38:40 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfeJS-0005up-8o
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:38:40 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so531316266b.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694428716; x=1695033516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YnEbICE5DmlevtBmaZnl3yDN8nVPjB9EnaMUokRPLHQ=;
 b=CHWbkoLmru0q3HFYB0v6L8jDCqbELU4CaaNSYvl1z/25+grCePsCm2yo1JYtHBwMkx
 ui7axeGBpuNMRhwoXTezc4BUfODwVItvei9oSt+PhI7GKPXetrlEc7OihMPilhTMFb4P
 MkA8jpEvIzCgp4TC1qPW9jo0z3nycFfYt5rmlUe41snltv1RJgiWIGtxt6rYQlKSZUj5
 Wu7ASeNoYpZrr7Is1pahHyoqqhxQd9dhERrISYlmwfd2M84oTCZwR0aRKxrZWQpGApl7
 GwxGaUKQyCuRjf0xvBfcY4zWxYizaGb3G12qQM85Ly3+tn6oo8siFjKHiipBoVo0A7dH
 WpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694428716; x=1695033516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YnEbICE5DmlevtBmaZnl3yDN8nVPjB9EnaMUokRPLHQ=;
 b=jnk5DofhCm4+9jS+AfFV9LEQ9WL0dfGYys5mhFdyWzWEilOSLAcQeBelQ6rNGMNANl
 FNLSMP/m7jlwfA+YxhGzOF630Bg/WTxE2RjMGV931PSwoe9n/1nHtpdWi8rCAF5witrN
 PaqmsDDwaeUNsN1QjuZ7VsP9QrjWYE45WJhUIdKuB3h6fvA/0p38VQGmWrOYBwyIuAJb
 5tm3hRyG9ovRPoVI2YV93kpqZBro1V7d6rb3h3ZltCZlrauDSQU7lBF94Zz2RtV5GyoM
 +4AgAGU+yoFXQlEVp4FNw8cPHRoe8EPfiI3jTVnDncgCUuwIjWrNkHIUbVrWnd99hpdC
 GigA==
X-Gm-Message-State: AOJu0YyFLBqK8Zp9JdZHq895Nb1UsfE+e7jORLYW0Pv2UgZeC3kFd1lC
 bWsRiIAcnpmXYC3dUm2SmoQ3TgiBdY9qG66wEz0=
X-Google-Smtp-Source: AGHT+IFjSvvB4G2eEZrSoIPby5ddCxAZgZdv/MfbxJTkw/wssjUUY8LR5XwpUXmGWATZtHgRAEhtsg==
X-Received: by 2002:a17:906:8251:b0:99b:d580:546c with SMTP id
 f17-20020a170906825100b0099bd580546cmr7687810ejx.23.1694428716135; 
 Mon, 11 Sep 2023 03:38:36 -0700 (PDT)
Received: from m1x-phil.lan (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 y22-20020a170906449600b0099bc8db97bcsm5125112ejo.131.2023.09.11.03.38.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Sep 2023 03:38:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] target/i386: Re-introduce few KVM stubs for Clang debug builds
Date: Mon, 11 Sep 2023 12:38:32 +0200
Message-ID: <20230911103832.23596-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Since commits 3adce820cf..ef1cf6890f, When building on
a x86 host configured as:

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

'--enable-debug' disables optimizations (CFLAGS=-O0).

While at this (un)optimization level GCC eliminate the
following dead code:

  if (0 && foo()) {
      ...
  }

Clang does not. Therefore restore a pair of stubs for
unoptimized Clang builds.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")
Fixes: ef1cf6890f ("target/i386: Allow elision of kvm_hv_vpindex_settable()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/kvm_i386.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 55d4e68c34..0b62ac628f 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -32,7 +32,6 @@
 
 bool kvm_has_smm(void);
 bool kvm_enable_x2apic(void);
-bool kvm_hv_vpindex_settable(void);
 bool kvm_has_pit_state2(void);
 
 bool kvm_enable_sgx_provisioning(KVMState *s);
@@ -41,8 +40,6 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
-uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
-                                      uint32_t index, int reg);
 uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
 
 void kvm_set_max_apic_id(uint32_t max_apic_id);
@@ -60,6 +57,10 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
 bool kvm_has_x2apic_api(void);
 bool kvm_has_waitpkg(void);
+bool kvm_hv_vpindex_settable(void);
+
+uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
+                                      uint32_t index, int reg);
 
 uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
@@ -76,6 +77,20 @@ typedef struct kvm_msr_handlers {
 bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                     QEMUWRMSRHandler *wrmsr);
 
+#elif defined(__clang__) && !defined(__OPTIMIZE__)
+
+static inline bool kvm_hv_vpindex_settable(void)
+{
+    g_assert_not_reached();
+}
+
+static inline uint32_t kvm_arch_get_supported_cpuid(KVMState *env,
+                                                    uint32_t function,
+                                                    uint32_t index, int reg)
+{
+    g_assert_not_reached();
+}
+
 #endif /* CONFIG_KVM */
 
 void kvm_pc_setup_irq_routing(bool pci_enabled);
-- 
2.41.0


