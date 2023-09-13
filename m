Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C735779E3C3
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMCn-0001BH-I7; Wed, 13 Sep 2023 05:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCl-00017A-56
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCf-0002Fx-H1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401f68602a8so71489345e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694597431; x=1695202231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZR4T6NlMHpArLYrHIDyBj0HhdFN73kI81RfJc3c6SLI=;
 b=U0kVmcAyBcPfz8zmlCOxGeiDx+utKPLhh/aADnihlIvJLH5dA+vIEOewQkKrKhLcan
 jqkoZDYizJuuccbvRoEJj89nnSc6VhiGStwXuXbqDZHfZcdrMq1+bhmdarlLYA4ropYH
 SkwBiX9m6ha5TEGuwXqrEpgibyGKf12Rw5pMVJx2GrtYshfkbx0uHNIlWF/cGrZv4X4I
 bUh4oBbqlVtz9MoUcXmb+jeMvbS3TvioQ0vLo5qH++yepHVpQRJsQrsrkOIs+7YjTeEX
 D8Ceklef0p+aCYPZvufmFkCw0vJby4VELwYSsA6D564jhNlXQ70fTSpitT5TZiKv5qpH
 eZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694597431; x=1695202231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZR4T6NlMHpArLYrHIDyBj0HhdFN73kI81RfJc3c6SLI=;
 b=s1HUbrbn7t5wyNReFDarEHDqzJ4EfcuDMfQMbPkn3NZeeCncyFHGvogmndyoLvwjFI
 /yMnkfbhK6J0VM9i13xjvDZN+ZvCl7DDbInK+Uec3HVIJXlGrSzCKoXmJ5JAdz8qRxSR
 847kQGmmWiTQyJPapUEE19Dn/Dw22BQkfcr1Pdjyh0YGvc+LcI6lXOFO/hYlIwODhvaf
 obYzaI4ilc5espL49eHAzpYBTAAkZ+kyTQzyQtUucaAX1b4TEYTdr1UOUU4M1Ej0U2Dv
 UEUly03n13qxKMsXSD8kEAyRXK4Uod5XpklYITpgcEhu3GgDuhWmV9cn1z90tWYJ1A1Y
 0ohg==
X-Gm-Message-State: AOJu0YzzKrY4sb2dT1sVaGyPw21vEoDvI9hdN7hWPs0ld8ki5tizHEEl
 jBePYfnfyW67V1bxCyKH3EJu3aL3l/ATagoAzVg=
X-Google-Smtp-Source: AGHT+IEuMwkotR/4nuJtdSguECUmUFieAMVw4UlYscziVUebi6jxfT7Sful3RnFPx8QmcRQyElHHxA==
X-Received: by 2002:a1c:7212:0:b0:401:c636:8f4c with SMTP id
 n18-20020a1c7212000000b00401c6368f4cmr1628404wmc.3.1694597430942; 
 Wed, 13 Sep 2023 02:30:30 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-241.abo.bbox.fr. [176.131.211.241])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a05600c35c600b003fbe791a0e8sm1540652wmq.0.2023.09.13.02.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Sep 2023 02:30:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v5 3/6] target/i386: Call accel-agnostic
 x86_cpu_get_supported_cpuid()
Date: Wed, 13 Sep 2023 11:30:05 +0200
Message-ID: <20230913093009.83520-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913093009.83520-1-philmd@linaro.org>
References: <20230913093009.83520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

x86_cpu_get_supported_cpuid() is generic and handles the different
accelerators. Use it instead of kvm_arch_get_supported_cpuid().

That fixes a link failure introduced by commit 3adce820cf
("target/i386: Remove unused KVM stubs") when QEMU is configured
as:

  $ ./configure --cc=clang \
    --target-list=x86_64-linux-user,x86_64-softmmu \
    --enable-debug

We were getting:

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

For the record, this is because '--enable-debug' disables
optimizations (CFLAGS=-O0).

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

Clang does not (see commit 2140cfa51d "i386: Fix build by
providing stub kvm_arch_get_supported_cpuid()").

Cc: qemu-stable@nongnu.org
Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")
Reported-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 94b1ba0cf1..b2a20365e1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6154,6 +6154,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
         if (count == 0) {
+            uint32_t eax_0_unused, ebx_0, ecx_0, edx_0_unused;
+
             /* Maximum ECX value for sub-leaves */
             *eax = env->cpuid_level_func7;
             *ebx = env->features[FEAT_7_0_EBX]; /* Feature flags */
@@ -6168,17 +6170,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * support enabling SGX and/or SGX flexible launch control,
              * then we need to update the VM's CPUID values accordingly.
              */
-            if ((*ebx & CPUID_7_0_EBX_SGX) &&
-                (!kvm_enabled() ||
-                 !(kvm_arch_get_supported_cpuid(cs->kvm_state, 0x7, 0, R_EBX) &
-                    CPUID_7_0_EBX_SGX))) {
+            x86_cpu_get_supported_cpuid(0x7, 0,
+                                        &eax_0_unused, &ebx_0,
+                                        &ecx_0, &edx_0_unused);
+            if ((*ebx & CPUID_7_0_EBX_SGX) && !(ebx_0 & CPUID_7_0_EBX_SGX)) {
                 *ebx &= ~CPUID_7_0_EBX_SGX;
             }
 
-            if ((*ecx & CPUID_7_0_ECX_SGX_LC) &&
-                (!(*ebx & CPUID_7_0_EBX_SGX) || !kvm_enabled() ||
-                 !(kvm_arch_get_supported_cpuid(cs->kvm_state, 0x7, 0, R_ECX) &
-                    CPUID_7_0_ECX_SGX_LC))) {
+            if ((*ecx & CPUID_7_0_ECX_SGX_LC)
+                    && (!(*ebx & CPUID_7_0_EBX_SGX) || !(ecx_0 & CPUID_7_0_ECX_SGX_LC))) {
                 *ecx &= ~CPUID_7_0_ECX_SGX_LC;
             }
         } else if (count == 1) {
@@ -7150,14 +7150,14 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
-    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
-        kvm_enabled()) {
-        KVMState *s = CPU(cpu)->kvm_state;
-        uint32_t eax_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EAX);
-        uint32_t ebx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EBX);
-        uint32_t ecx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_ECX);
-        uint32_t eax_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EAX);
-        uint32_t ebx_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EBX);
+    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
+        uint32_t eax_0, ebx_0, ecx_0, edx_0_unused;
+        uint32_t eax_1, ebx_1, ecx_1_unused, edx_1_unused;
+
+        x86_cpu_get_supported_cpuid(0x14, 0,
+                                    &eax_0, &ebx_0, &ecx_0, &edx_0_unused);
+        x86_cpu_get_supported_cpuid(0x14, 1,
+                                    &eax_1, &ebx_1, &ecx_1_unused, &edx_1_unused);
 
         if (!eax_0 ||
            ((ebx_0 & INTEL_PT_MINIMAL_EBX) != INTEL_PT_MINIMAL_EBX) ||
-- 
2.41.0


