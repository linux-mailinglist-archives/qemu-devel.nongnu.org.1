Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEFB719C36
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hUx-00064T-0z; Thu, 01 Jun 2023 08:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4hUu-00063T-TJ; Thu, 01 Jun 2023 08:33:44 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4hUt-0002al-8t; Thu, 01 Jun 2023 08:33:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C3E1064405;
 Thu,  1 Jun 2023 12:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BDEC433D2;
 Thu,  1 Jun 2023 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685622821;
 bh=Altb9gx/izM5ctcWAjcLXu6Yyml5zlbxuXilVs0UmFo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GZOMIycMpsrQMgWQub7f7W5KecPa0htilzegtPRZVV7dX86TBWYfO8GC4k+7CVL1K
 fytcJcC2MRz42POdqP0eYPWYGVIiLyqMPOMR+qHc29odiSWy3gdHQn4oluwz/rvOIn
 kLeMxPxh4FbuGMYQvsYtoQUejIl+tE8MKuP0JruPTqt43HGA3ICuh9BZ4MNSOrQkeD
 CwBHBLmvmljrBQhx4bOxVdZQqcwANUtCXluwIThgkzG1BefRDcYgTLZL+zZ/BrIzbh
 GkU/weYMmjo8zO+dD80E9lFfGj60RALZjYCzRXj1InfI7qsfxCUhbspWhkJPhJ+GIe
 rW2UdIRZ4dVAA==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH 2/2] target/i386: Implement PCLMULQDQ using AArch64 PMULL
 instructions
Date: Thu,  1 Jun 2023 14:33:32 +0200
Message-Id: <20230601123332.3297404-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601123332.3297404-1-ardb@kernel.org>
References: <20230601123332.3297404-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3517; i=ardb@kernel.org;
 h=from:subject; bh=Altb9gx/izM5ctcWAjcLXu6Yyml5zlbxuXilVs0UmFo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaVigvj0tBJulgUChyb9Smtwzz1c0CnMWP7nX2Hjpv+rP
 uZzKN/pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZUM7wh0M5+PSp2EWLTqs+
 e/qF3Zs/9/aDTY9adUT3S4oKRE340cbwz2TO9Ak2e9/07FBraGhxmB+j3sbC01HyenqewiWLLsb
 v7AA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use the AArch64 PMULL{2}.P64 instructions to implement PCLMULQDQ instead
of emulating them in C code if the host supports this. This is used in
the implementation of GCM, which is widely used in IPsec VPN and HTTPS.

Somewhat surprising results: on my ThunderX2, enabling this on top of
the AES acceleration I sent out earlier, the speedup is substantial.

(1420 is a typical IPsec block size - in HTTPS, GCM operates on much
larger block sizes but the kernel mode benchmarks are not the best place
to measure its performance in this mode)

tcrypt: testing speed of rfc4106(gcm(aes)) (rfc4106-gcm-aesni) encryption

No acceleration
tcrypt: test 5 (160 bit key, 1420 byte blocks): 10046 operations in 1 seconds (14265320 bytes)

AES acceleration
tcrypt: test 5 (160 bit key, 1420 byte blocks): 13970 operations in 1 seconds (19837400 bytes)

AES + PMULL acceleration
tcrypt: test 5 (160 bit key, 1420 byte blocks): 24372 operations in 1 seconds (34608240 bytes)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 host/include/aarch64/host/cpuinfo.h |  1 +
 target/i386/ops_sse.h               | 24 ++++++++++++++++++++
 util/cpuinfo-aarch64.c              |  1 +
 3 files changed, 26 insertions(+)

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 05feeb4f4369fc19..da268dce1390cac0 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -10,6 +10,7 @@
 #define CPUINFO_LSE             (1u << 1)
 #define CPUINFO_LSE2            (1u << 2)
 #define CPUINFO_AES             (1u << 3)
+#define CPUINFO_PMULL           (1u << 4)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index db79132778efd211..d7e7bd8b733122a8 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2157,6 +2157,30 @@ void glue(helper_pclmulqdq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
     uint64_t a, b;
     int i;
 
+#ifdef __aarch64__
+    if (cpuinfo & CPUINFO_PMULL) {
+        aes_vec_t vv = *(aes_vec_t *)v, vs = *(aes_vec_t *)s;
+        aes_vec_t *vd = (aes_vec_t *)d;
+
+        switch (ctrl & 0x11) {
+        case 0x1:
+            asm("ext %0.16b, %0.16b, %0.16b, #8":"+w"(vv));
+            /* fallthrough */
+        case 0x0:
+            asm(".arch_extension aes\n"
+                "pmull %0.1q, %1.1d, %2.1d":"=w"(*vd):"w"(vv),"w"(vs));
+            break;
+        case 0x10:
+            asm("ext %0.16b, %0.16b, %0.16b, #8":"+w"(vv));
+            /* fallthrough */
+        case 0x11:
+            asm(".arch_extension aes\n"
+                "pmull2 %0.1q, %1.2d, %2.2d":"=w"(*vd):"w"(vv),"w"(vs));
+        }
+        return;
+    }
+#endif
+
     for (i = 0; i < 1 << SHIFT; i += 2) {
         a = v->Q(((ctrl & 1) != 0) + i);
         b = s->Q(((ctrl & 16) != 0) + i);
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 769cdfeb2fc32d5e..95ec1f4adfc829b9 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -57,6 +57,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
     info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
     info |= (hwcap & HWCAP_AES ? CPUINFO_AES : 0);
+    info |= (hwcap & HWCAP_PMULL ? CPUINFO_PMULL : 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
-- 
2.39.2


