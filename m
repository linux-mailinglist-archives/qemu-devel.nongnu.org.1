Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571E79E79D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOg0-0000pN-4K; Wed, 13 Sep 2023 08:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfm-0000ir-MR
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfc-0002YN-48
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694606912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aN9k5zUDuNjjzyxNolQqBVnKvHeScWptj4QdERC1zd4=;
 b=LYOMklFJn89C7RRLyb+CnsvkcME+DGUcj9VIT2Eb2LOba1w87tn/NPeRNe1o9KOtDDuQFS
 mp/zXLzTZigG+VvM8cmjBjQ8jOp7+hoi8HAWidRhuZoq21VOH3wtK0GekF1k/Hxb/T1WNA
 qV0skoFZe2nT4CJCYTmcjp2Wjfj00cQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-9-h-v-a4M4WqzSn2IBzMhw-1; Wed, 13 Sep 2023 08:08:31 -0400
X-MC-Unique: 9-h-v-a4M4WqzSn2IBzMhw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so4422570f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694606909; x=1695211709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aN9k5zUDuNjjzyxNolQqBVnKvHeScWptj4QdERC1zd4=;
 b=VkzmmQxElXypNnN52s+NdkxDPRvgtBzEm4ERg/sgTnhKRphJprdGt63aML2os+jrcR
 T+deKc1ZXih27/hCBWdCRgtvUmdHaDG8l5iJ/oYXWxurQXbAoLakx0FdBco6qaaZfTdE
 /2CrqLmRMK5AqguuWGGP/7pKDaWf/3C7PN2ZUBY4x2z/E4UydULUD4BSma6XR81i1XER
 Ac0S4jP6zTGPep6vOJ8ZDceuFhDNrrKUGNVDVwuv7viMIety0wEqIo/0q2hcZx3158r8
 hoW1eTGTVy8UIiEORoeK2E85hw3csawPwAOnWWleEO/X4/BQ+h2wAIT+kYA4uY238vvQ
 y4UA==
X-Gm-Message-State: AOJu0YweEQolzERpUlLm79mWtleAfprYy8Y1s0xR9cJsyIpRZbMj5r8x
 4EFTFY2afU5iTFAwj9mRZuismS1BKyl+8U9aTNHq7i3vb46apw8dmM7IFwhXQHVJ8EOuJvv632K
 ot78BFwFQ5SlyDh1z7pkUtEwW6Nu0W02tMP3cqab89FW8G2nMtmHvjJWWJmNWfjEg7L2cFpLDpW
 Q=
X-Received: by 2002:adf:f60d:0:b0:31c:4c68:e73a with SMTP id
 t13-20020adff60d000000b0031c4c68e73amr1791858wrp.66.1694606909087; 
 Wed, 13 Sep 2023 05:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHftcnnIlKkB3duQsWjShwe8uQ245qFeP8KoJaxSG8OdErLr4QMJVOzeY6nogOaclkPsgXiMA==
X-Received: by 2002:adf:f60d:0:b0:31c:4c68:e73a with SMTP id
 t13-20020adff60d000000b0031c4c68e73amr1791841wrp.66.1694606908666; 
 Wed, 13 Sep 2023 05:08:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 j12-20020adfe50c000000b003176aa612b1sm15315147wrm.38.2023.09.13.05.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 05:08:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 4/4] target/i386: Call accel-agnostic
 x86_cpu_get_supported_cpuid()
Date: Wed, 13 Sep 2023 14:08:20 +0200
Message-ID: <20230913120820.969262-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913120820.969262-1-pbonzini@redhat.com>
References: <20230913120820.969262-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Message-ID: <20230913093009.83520-4-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 94b1ba0cf1a..b2a20365e10 100644
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


