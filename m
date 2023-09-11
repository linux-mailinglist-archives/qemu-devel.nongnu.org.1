Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5B79A83B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:15:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfglG-0003V1-3t; Mon, 11 Sep 2023 09:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfgl3-0003Nc-EZ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:15:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfgl0-0003FP-5U
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:15:17 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so11838046a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694438111; x=1695042911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JTa1mjppJcFOyEO7rTUqbYp1VGc27zPh41oxE71ODV4=;
 b=CCWgzBuz6Gmm66xqlApUbUM747V0LS/mScmyf7uTsT1GmVy5bkRGpi49+sZ6D0y/ZO
 j7VI+JpKiy7rKJgkvLoaO/KfabWrxylOSSvvxxP5K7sWma1axcGvyDOKbKMWghBNfW9m
 xuPHzfY89RSXhpR5yEkafW08utlqJIgYzZ0Md3WoeTSo8FieBPoopVzCKK5a0ftQfs18
 u0n2hP8P0nK9fQlcRrfnKdZlh3UthgIPRNFgC/eEi2m6jbuQiR/kKR18UIwCa0tU/Mh5
 oKcVm12fhugsbEtAyctyiCZ8U3NBuLr/Z9iJNwi3RY5JP028brdDIZRvVZYb8a36rZ3B
 05yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694438111; x=1695042911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JTa1mjppJcFOyEO7rTUqbYp1VGc27zPh41oxE71ODV4=;
 b=SYrjmAyKVIXH2M015a98yi9Xhbe+d8A0ZFHiqjM01AqoiUsHldJzN6CSU3ggE5sgFc
 suXYZk6Bh7jnnbulmcIAnY+J2QRI6zqBWjtMBDDKGV2q9iUZ9IAobXESnPxpVU8u5/Ha
 cQHBckz2x9Phoav4xwsRfrD6Cc1NMzRn9pO2FqetxnuM3m2rgk1/k243iY8ITYkBK69X
 3V8QGpVBMpRAx929tsAhrDSszE9e/2ZYU4l+5Nm5CF4YIqslIfFCDHG6i8wQWcsao7D4
 up0CA5MCAnOTn57Zr6wkB4cfbAhfcqVPfI1d1icT4efgL4pCLR3aTp+50DH2s1ugra9N
 hEzA==
X-Gm-Message-State: AOJu0YxT4utdn7mwYVDe7ln/Sq4SGJdETH8ugDbTRGJYxrky2puZ0wv1
 MwtZpoCeWraOtd/IZtvWzLDsTGt7ijSkwEoF8As=
X-Google-Smtp-Source: AGHT+IEoyIRx087y6wclx8Jfh3GUmwcPQSFsRB22Oucd36jaRrPV+oJxu3au6m+AP8weLvwVd3b1lg==
X-Received: by 2002:a17:907:8a1c:b0:9a5:7dec:fab9 with SMTP id
 sc28-20020a1709078a1c00b009a57decfab9mr17789791ejc.9.1694438111054; 
 Mon, 11 Sep 2023 06:15:11 -0700 (PDT)
Received: from m1x-phil.lan (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 d16-20020a17090694d000b00982be08a9besm5397044ejy.172.2023.09.11.06.15.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Sep 2023 06:15:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] target/i386: Re-introduce few KVM stubs for Clang debug
 builds
Date: Mon, 11 Sep 2023 15:15:07 +0200
Message-ID: <20230911131507.24943-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Clang does not. This was previously documented in commit 2140cfa51d
("i386: Fix build by providing stub kvm_arch_get_supported_cpuid()").

Fix by partially reverting those commits, restoring a pair of stubs
for the unoptimized Clang builds.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")
Fixes: ef1cf6890f ("target/i386: Allow elision of kvm_hv_vpindex_settable()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/kvm-stub.c  | 31 +++++++++++++++++++++++++++++++
 target/i386/kvm/meson.build |  2 ++
 2 files changed, 33 insertions(+)
 create mode 100644 target/i386/kvm/kvm-stub.c

diff --git a/target/i386/kvm/kvm-stub.c b/target/i386/kvm/kvm-stub.c
new file mode 100644
index 0000000000..d3d4a238ce
--- /dev/null
+++ b/target/i386/kvm/kvm-stub.c
@@ -0,0 +1,31 @@
+/*
+ * QEMU KVM x86 specific function stubs
+ *
+ * Copyright Linaro Limited 2012
+ *
+ * Author: Peter Maydell <peter.maydell@linaro.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "kvm_i386.h"
+
+#ifndef __OPTIMIZE__
+/* This function is only called inside conditionals which we
+ * rely on the compiler to optimize out when CONFIG_KVM is not
+ * defined.
+ */
+uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
+                                      uint32_t index, int reg)
+{
+    abort();
+}
+#endif
+
+bool kvm_hv_vpindex_settable(void)
+{
+    return false;
+}
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 5d9174bbb5..40fbde96ca 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -1,3 +1,5 @@
+i386_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+
 i386_softmmu_kvm_ss = ss.source_set()
 
 i386_softmmu_kvm_ss.add(files(
-- 
2.41.0


